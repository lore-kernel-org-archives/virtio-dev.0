Return-Path: <virtio-dev-return-8624-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E43AF9865C0
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Sep 2021 13:31:17 +0000 (UTC)
Date: Wed, 1 Sep 2021 19:01:09 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20210901133109.GI9207@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20210831135753.GG9207@quicinc.com>
 <20210831103906-mutt-send-email-mst@kernel.org>
 <20210831155603.GH9207@quicinc.com>
 <20210831211356-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210831211356-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-mmio: Specify wait needed in
 driver during reset
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, tsoni@quicinc.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Michael S. Tsirkin <mst@redhat.com> [2021-08-31 21:19:47]:

> On Tue, Aug 31, 2021 at 09:26:03PM +0530, Srivatsa Vaddagiri wrote:
> > * Michael S. Tsirkin <mst@redhat.com> [2021-08-31 10:45:53]:
> > 
> > > On Tue, Aug 31, 2021 at 07:27:53PM +0530, Srivatsa Vaddagiri wrote:
> > > > Reset of a virtio-mmio device is initiated by writing 0 to its Status register.
> > > > In case of some devices, the reset operation itself may not be completed
> > > > by the time write instruction completes and hence such devices would require
> > > > drivers to wait on reset operation to complete before they proceed with
> > > > remaining steps of initialization.
> > > > 
> > > > Update the specification to indicate which devices would need driver to block on
> > > > reset completion.
> > > > 
> > > > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> > > 
> > > 
> > > I am still of two minds on whether we
> > > want such a drastic change as a version update for such a
> > > minor thing. Yes, we did it for PCI but then PCI did
> > > not break backwards compat like mmio did.
> > > 
> > > Let's see what needs to happen to make existing drivers work
> > > 1- reset starts the reset process
> > > 2- following writes into status are buffered by the device
> > >   until reset completes
> > > 3- read from features completes after reset is complete
> > 
> > Couple of scenarios which we discussed in this regard earlier:
> > 
> > 1) What if device reset encounters a failure? What should it return for the
> > 'features' read in that case?
> 
> I'd say the main thing is to fail to set FEATURES_OK.

That would signal device does not support the features offered by driver, which
seems like very hackish way to fail probe in this case (when reset had actually
failed). Driver has no way to understand what happened - whether device did not
like the features offered or reset failed.

> > 2) For untrusted devices, like in our case [A], it would require hypervisor to
> > stall vcpu until the untrusted backend responds to the features read request,
> 
> Wait a second, this is fundamental to reads anyway. They can't bypass
> writes. E.g. this is the case when FEATURES_OK is written then read
> back.
> 
> > which could take a long time.
> 
> This last is a reasonable argument. so it's not about hardware it's for
> software where reset takes a long time and we do not
> want to stall the VCPU. That's a reasonable requirement but
> pls include it in the text though.

Sure will update commit text to indicate that better.

> And I wonder how you are handling
> other cases where reads are ordered with writes.
> Is there a reason to assume reset is special?

With what we have atm, which is working well for atleast block device,
hypervisor is able to handle read/writes on its own without needing synchronous
intervention from (untrusted) backend diver - except for reset that is.

Hypervisor is fed with virtio device configuration information even before VM
starts and in fact in our current prototype, reads don't even trap into
hypervisor. A config page is mapped as read-only into guest and so all
configuration information like device id, version etc can be read w/o causing a
trap. Writes are trapped and we have been able to have hypervisor handles all
writes (except reset) w/o needing synchronous intervention from backend driver.
For example, any write to driver features, QueueNumMax etc are cached within
hypervisor which is later passed to backend driver lazily - via some hypercall
interface - before it starts working on the first IO transaction.

Reset seems to be the only write that needs synchronous intervention from
backend, which we want to address by having guest loop on reset completion
(rather than stall vcpu until backend finishes reset handling).

Alternately, I could go by your suggestion and stall the vcpu for a certain
threshold period of time when reset is issued. If backend fails to ACK reset
within that threshold period, unblock vcpu and fail further initialization by
refusing to set FATURES_OK bit. Like I said before, that seems very
hackish way to fail probe - with no clear indication to driver on what failed.

How about merging a change like this to Linux driver w/o making any
spec changes for now?

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9..9db81e6 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -262,6 +262,9 @@ static void vm_reset(struct virtio_device *vdev)

        /* 0 status means a reset. */
        writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+
+       while (vm_get_status(vdev)) {
+		/* Bail after some timeout */
+               msleep(1);
+	}
 }

- vatsa


> > Ref A: https://lists.oasis-open.org/archives/virtio-dev/202108/msg00090.html



-- 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

