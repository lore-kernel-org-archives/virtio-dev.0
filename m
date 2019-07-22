Return-Path: virtio-dev-return-5871-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E88E498444A
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jul 2019 08:39:53 +0000 (UTC)
Date: Mon, 22 Jul 2019 04:39:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190722043707-mutt-send-email-mst@kernel.org>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719110852-mutt-send-email-mst@kernel.org>
 <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com>
Subject: [virtio-dev] Re: [External Email] Re: [PATCH v1 0/2] virtio-mmio: support
 multiple interrupt vectors
To: =?utf-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Fam Zheng <zhengfeiran@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 22, 2019 at 11:22:02AM +0800, 李菲 wrote:
> On Fri, Jul 19, 2019 at 11:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
> > > Hi,
> > >
> > > This patch series implements multiple interrupt vectors support for
> > > virtio-mmio device. This is especially useful for multiqueue vhost-net
> > > device when using firecracker micro-vms as the guest.
> > >
> > > Test result:
> > > With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs can
> > > receive 9 times more pps comparing with only one irq:
> > > - 564830.38 rxpck/s for 8 irqs on
> > > - 67665.06 rxpck/s for 1 irq on
> > >
> > > Please help to review, thanks!
> > >
> > > Have a nice day
> > > Fei
> >
> >
> > Interesting. The spec says though:
> >
> >         4.2.3.4
> >         Notifications From The Device
> >         The memory mapped virtio device is using a single, dedicated interrupt signal, which is asserted when at
> >         least one of the bits described in the description of InterruptStatus is set. This is how the device sends a
> >         used buffer notification or a configuration change notification to the device.
> >
> Yes, the spec needs to be updated if we want to use mult-irqs.
> >
> > So I'm guessing we need to change the host/guest interface?
> Just to confirm, does the "the host/guest interface" you mentioned mean how to
> pass the irq information from the user space tool to guest kernel?
> In this patch, we do this by passing the [irq_start, irq_end]
> interface via setting guest
> kernel command line, that is done in vm_cmdline_set().
> Also there is another way to do this: add two new registers describing irq info
> (irq_start & irq_end OR irq_start & irq_numbers) to the virtio config space.
> 
> Which one do you prefer?

I'm not sure - so far irq was passed on the command line, right?

The first step in implementing any spec change would be to update qemu
code to virtio 1. Which is not a huge project but so far no one
bothered.


> > If true pls cc virtio-dev.
> Sure.
> >
> > Also, do we need to update dt bindings documentation?
> You mean the following doc? Sure. :)
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/virtio/mmio.txt
> 
> Thanks for the review!
> 
> Have a nice day
> Fei
> 
> 
> >
> > >
> > > Fam Zheng (1):
> > >   virtio-mmio: Process vrings more proactively
> > >
> > > Fei Li (1):
> > >   virtio-mmio: support multiple interrupt vectors
> > >
> > >  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 196 insertions(+), 42 deletions(-)
> > >
> > > --
> > > 2.11.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

