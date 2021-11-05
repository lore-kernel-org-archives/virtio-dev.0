Return-Path: <virtio-dev-return-8923-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B086D986453
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Nov 2021 12:42:56 +0000 (UTC)
Date: Fri, 5 Nov 2021 18:12:49 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20211105124249.GB18377@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20211104170740.GA14929@quicinc.com>
 <CACGkMEunyxqg5+Q6DQ7qSA1W8x1ttg6CpTbUA4QeCAtpC9AJWg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEunyxqg5+Q6DQ7qSA1W8x1ttg6CpTbUA4QeCAtpC9AJWg@mail.gmail.com>
Subject: [virtio-dev] Re: Timing out virtio-pci config space access
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Jason Wang <jasowang@redhat.com> [2021-11-05 12:52:55]:

> On Fri, Nov 5, 2021 at 1:07 AM Srivatsa Vaddagiri
> <quic_svaddagi@quicinc.com> wrote:
> >
> > We are working on a virtio-pci implementation on a Type-1 hypervisor where
> > backend drivers are hosted in another VM and are considered untrusted. PCI is
> > the virtio transport used in this case.
> >
> > One issue that crops up is a read/write of config space can potentially block
> > forever, as the backend is untrusted and could be causing a denial-of-service of
> > sorts. This causes the vcpu to stall forever. I was wondering if we can timeout
> > in such case and have the hypervisor break the stall by letting read return
> > "error" (-1) along with setting DEVICE_NEEDS_RESET in status register.
> 
> Did you mean the timeout is done by the hypervisor and the hypervisor
> can guarantee that the status register will not be blocked by the
> untrusted device?

Yes

> 
> > Will that
> > allow Linux guest driver to gracefully fail its probe?
> 
> Note that the config read is not necessarily done in the path of
> probe: For pci, we may need to read ISR in the INTX interrupt handler:

Yes I was aware - we are dealing with MSI which I think does not read ISR in its
interrut handler?

> 
> static irqreturn_t vp_interrupt(int irq, void *opaque)
> {
>         struct virtio_pci_device *vp_dev = opaque;
>         u8 isr;
> 
>         /* reading the ISR has the effect of also clearing it so it's very
>          * important to save off the value. */
>         isr = ioread8(vp_dev->isr);
> }
> 
> And there are more places that device could DOS a driver:
> 
> 1) config space read and write after probe
> 2) control vq commands (we're busy waiting)
> 
> > I don't see where Linux
> > handles DEVICE_NEEDS_RESET currently and also am not sure if returning -1 will
> > lead to graceful failure of the driver alone (we don't want VM to come down or
> > panic because of a mis-behaving device).
> 
> We can probably make virtio_cread() to be able to fail by checking
> DEVICE_NEEDS_RESET after the config space access.

I think there are other paths during probe where ioread() are issued - like
virtio_pci_find_capability() for example. How do we handle stalls there (or
rather ioreads returning -1 to indicate something amiss for example)?

> And the control vq
> commands, it can be done by having a timeout in the driver.
> 
> An alternative is to use or introduce a transport that can fail
> explificty in config space access.
> 
> >
> > I saw some discussions in this regard for vDPA where similar solution seem to
> > have been discussed.
> >
> > https://lkml.org/lkml/2021/7/6/219
> >
> > Would that work for PCI transport also?
> 
> For config space read, I think yes:
> 
> Hypervisor can maintain the config space and make sure the config read
> is completed fast. Need a protocol (for VDUSE it's the
> VDUSE_SET_CONFIG)  for the device to set a new config space value to
> the hypervisor.
> 
> For config space writing, it needs more thoughts. (VDUSE only support
> read-only config space)

Can you shed some light on what complexity handling config-space writes will
require us to consider?  I think its mostly the notification register that's
written at runtime (beyond probe)? For notification writes, hypervisor can
inject an event into backend and unblock the guest vcpu immediately.

Thanks
vatsa

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

