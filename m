Return-Path: <virtio-dev-return-8922-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69E42986453
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Nov 2021 12:29:51 +0000 (UTC)
Date: Fri, 5 Nov 2021 17:59:43 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20211105122943.GA18377@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20211104170740.GA14929@quicinc.com>
 <20211105033354-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211105033354-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Timing out virtio-pci config space access
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Michael S. Tsirkin <mst@redhat.com> [2021-11-05 03:38:39]:

> On Thu, Nov 04, 2021 at 10:37:40PM +0530, Srivatsa Vaddagiri wrote:
> > We are working on a virtio-pci implementation on a Type-1 hypervisor where
> > backend drivers are hosted in another VM and are considered untrusted. PCI is
> > the virtio transport used in this case.
> > 
> > One issue that crops up is a read/write of config space can potentially block
> > forever, as the backend is untrusted and could be causing a denial-of-service of
> > sorts. This causes the vcpu to stall forever. I was wondering if we can timeout
> > in such case and have the hypervisor break the stall by letting read return
> > "error" (-1) along with setting DEVICE_NEEDS_RESET in status register. Will that
> > allow Linux guest driver to gracefully fail its probe? I don't see where Linux
> > handles DEVICE_NEEDS_RESET currently and also am not sure if returning -1 will
> > lead to graceful failure of the driver alone (we don't want VM to come down or
> > panic because of a mis-behaving device). 
> 
> DEVICE_NEEDS_RESET isn't handled ATM. the point of it in any case
> is a recoverable error, with a malicious backend this is
> not the case.
> 
> 
> Once thing you can do that will work a bit better is implementing
> surprise-removal in this case.

My layman understanding of surprise removal is that it requires the PCI
controller to interrupt OS and convey which device is removed, so that the PCI
subsystem can mark it "removed"? Is that possible for the generic controller
("pci-host-ecam-generic") that virtio pci devices use?

> So hypervisor detects a timeout
> (presumably it knows what to expect of the device) and then pretends to
> guest device is gone, unmapping it completely from guest.

Can you elaborate on what unmapping means? I think the reads should
return -1 and writes to be dropped in such case - beyond that what would unmap
entail?

Thanks
vatsa

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

