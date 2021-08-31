Return-Path: <virtio-dev-return-8615-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FB519864CA
	for <virtio-dev@lists.oasis-open.org>; Tue, 31 Aug 2021 15:56:12 +0000 (UTC)
Date: Tue, 31 Aug 2021 21:26:03 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20210831155603.GH9207@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20210831135753.GG9207@quicinc.com>
 <20210831103906-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210831103906-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v3] virtio-mmio: Specify wait needed in driver during
 reset
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, tsoni@quicinc.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Michael S. Tsirkin <mst@redhat.com> [2021-08-31 10:45:53]:

> On Tue, Aug 31, 2021 at 07:27:53PM +0530, Srivatsa Vaddagiri wrote:
> > Reset of a virtio-mmio device is initiated by writing 0 to its Status register.
> > In case of some devices, the reset operation itself may not be completed
> > by the time write instruction completes and hence such devices would require
> > drivers to wait on reset operation to complete before they proceed with
> > remaining steps of initialization.
> > 
> > Update the specification to indicate which devices would need driver to block on
> > reset completion.
> > 
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> 
> 
> I am still of two minds on whether we
> want such a drastic change as a version update for such a
> minor thing. Yes, we did it for PCI but then PCI did
> not break backwards compat like mmio did.
> 
> Let's see what needs to happen to make existing drivers work
> 1- reset starts the reset process
> 2- following writes into status are buffered by the device
>   until reset completes
> 3- read from features completes after reset is complete

Couple of scenarios which we discussed in this regard earlier:

1) What if device reset encounters a failure? What should it return for the
'features' read in that case?

2) For untrusted devices, like in our case [A], it would require hypervisor to
stall vcpu until the untrusted backend responds to the features read request,
which could take a long time.  In worst case, the VM may get reset due to
watchdog firing. Requiring drivers to poll will avoid that situation and allow
drivers to fail probe gracefully.

Ref A: https://lists.oasis-open.org/archives/virtio-dev/202108/msg00090.html

- vatsa

-- 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

