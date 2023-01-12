Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
 <20221223081354.15026-2-xuanzhuo@linux.alibaba.com> <20230110233401.131cc97a.pasic@linux.ibm.com>
 <1673435333.1297436-1-xuanzhuo@linux.alibaba.com> <20230111161128.48e6d7e0.pasic@linux.ibm.com>
In-Reply-To: <20230111161128.48e6d7e0.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jan 2023 10:01:25 +0800
Message-ID: <CACGkMEuT5L2DH1ga+HOJb0DHdF04VmvC3viEoRPhraLxc7RCjg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device virtio-ism
Content-Type: text/plain; charset="UTF-8"
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 11, 2023 at 11:11 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 11 Jan 2023 19:08:53 +0800
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > > > +ISM(Internal Shared Memory) device provides the ability to share memory between
> > > > +different VMs launched from the same entity.
> > >
> > > Launched by instead of from? Maybe introduce a catchy name for the
> > > "entity that launched the VMs" and prevent oversimplification by
> > > explaining any shortcomings of the name if any in one place. Host would
> > > be one candidate, VMM another.
> >
> > Cornelia Huck wrote:
> >
> >       Is there a way to avoid the term "host" (throughout this document)?
> >       IIUC, you need the uniqueness within the scope of the entity that
> >       launches the different instances that get shared access to the regions
> >       (which could conceivably a unit of hardware?)
> >
> > And I think she is right, so I am trying to remove the term HOST.
> >
> > Do you have better opinions? I think VMM is not particularly suitable.
>
> Well I'm don't know what Connie's objective was with that. Maybe she can
> explain. My concern is calling it "the entity" is awfully vague and
> calling it "the entity that launched the VMs" is awfully long.
>
> Please notice that by being explicit about the launched entities being
> VMs, you already know that the entity launching the VMs is a (host)
> machine (which does not have to be a bare metal machine, but can be
> a VM, a container).
>
> From Wikipedia (https://en.wikipedia.org/wiki/Hypervisor): "A hypervisor
> (also known as a virtual machine monitor, VMM, or virtualizer) is a type
> of computer software, firmware or hardware that creates and runs virtual
> machines. A computer on which a hypervisor runs one or more virtual
> machines is called a host machine, and each virtual machine is called a
> guest machine."
>
> So I guess we could call it a host machine, a hypervisor instance.
>
> On the other hand if we want to not mention (and kind of scope down to)
> VMs either, we could try with something like originator or creator.
>
> Either way, I would really like to get some more opinions on this,
> especially Connie's.

My understanding is, since virtio is not necessarily used for the case
of virtualization, it might be better to use "driver/device" instead
of "guest/host" or "VM/VMM".

Thanks

>
> Regards,
> Halil
>
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

