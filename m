Return-Path: virtio-dev-return-5872-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A76E5985C6E
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jul 2019 13:43:31 +0000 (UTC)
MIME-Version: 1.0
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719110852-mutt-send-email-mst@kernel.org> <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com>
 <20190722043707-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190722043707-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Date: Mon, 22 Jul 2019 21:43:18 +0800
Message-ID: <CA+=e4K7ViADDq84i6ve1+F1=CrgfQJrY-O8LeBVV7eP4gUg21Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [External Email] Re: [PATCH v1 0/2] virtio-mmio: support multiple
 interrupt vectors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Fam Zheng <zhengfeiran@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 22, 2019 at 4:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 22, 2019 at 11:22:02AM +0800, =E6=9D=8E=E8=8F=B2 wrote:
> > On Fri, Jul 19, 2019 at 11:14 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > >
> > > On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
> > > > Hi,
> > > >
> > > > This patch series implements multiple interrupt vectors support for
> > > > virtio-mmio device. This is especially useful for multiqueue vhost-=
net
> > > > device when using firecracker micro-vms as the guest.
> > > >
> > > > Test result:
> > > > With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs c=
an
> > > > receive 9 times more pps comparing with only one irq:
> > > > - 564830.38 rxpck/s for 8 irqs on
> > > > - 67665.06 rxpck/s for 1 irq on
> > > >
> > > > Please help to review, thanks!
> > > >
> > > > Have a nice day
> > > > Fei
> > >
> > >
> > > Interesting. The spec says though:
> > >
> > >         4.2.3.4
> > >         Notifications From The Device
> > >         The memory mapped virtio device is using a single, dedicated =
interrupt signal, which is asserted when at
> > >         least one of the bits described in the description of Interru=
ptStatus is set. This is how the device sends a
> > >         used buffer notification or a configuration change notificati=
on to the device.
> > >
> > Yes, the spec needs to be updated if we want to use mult-irqs.
> > >
> > > So I'm guessing we need to change the host/guest interface?
> > Just to confirm, does the "the host/guest interface" you mentioned mean=
 how to
> > pass the irq information from the user space tool to guest kernel?
> > In this patch, we do this by passing the [irq_start, irq_end]
> > interface via setting guest
> > kernel command line, that is done in vm_cmdline_set().
> > Also there is another way to do this: add two new registers describing =
irq info
> > (irq_start & irq_end OR irq_start & irq_numbers) to the virtio config s=
pace.
> >
> > Which one do you prefer?
>
> I'm not sure - so far irq was passed on the command line, right?
Yes.
>
> The first step in implementing any spec change would be to update qemu
> code to virtio 1. Which is not a huge project but so far no one
> bothered.
Emm, actually I only did the test with using firecracker to start a
micro-vm, but without qemu.
To be honest, the reason why implementing multi-irq on virtio-mmio is
mainly because the
current firecracker using virtio-mmio device and it has no pci thing,
thus no msi/msix to
handle the interruptions.
On the other hand, considering pci is well supported in qemu, I am
wondering whether we
still need this. If needed, we would like to do this. :)

Have a nice day, thanks
Fei
>
>
> > > If true pls cc virtio-dev.
> > Sure.
> > >
> > > Also, do we need to update dt bindings documentation?
> > You mean the following doc? Sure. :)
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/virtio/mmio.txt
> >
> > Thanks for the review!
> >
> > Have a nice day
> > Fei
> >
> >
> > >
> > > >
> > > > Fam Zheng (1):
> > > >   virtio-mmio: Process vrings more proactively
> > > >
> > > > Fei Li (1):
> > > >   virtio-mmio: support multiple interrupt vectors
> > > >
> > > >  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++=
++++--------
> > > >  1 file changed, 196 insertions(+), 42 deletions(-)
> > > >
> > > > --
> > > > 2.11.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

