Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666146893.4959266-1-xuanzhuo@linux.alibaba.com> <CACGkMEsS1no70rcg_YHip1UYt+sFF2nTOBahvvi-e_VqL-NgJw@mail.gmail.com>
 <1666153837.3470912-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1666153837.3470912-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Oct 2022 13:10:49 +0800
Message-ID: <CACGkMEuQRoBEbUEyeJTULfcqHhxkvUkeAovzukj0S77NiYTaPA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Content-Type: text/plain; charset="UTF-8"
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 19, 2022 at 12:35 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 19 Oct 2022 11:56:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Oct 19, 2022 at 10:42 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > >
> > > Hi Jason,
> > >
> > > I think there may be some problems with the direction we are discussing.
> >
> > Probably not.
> >
> > As far as we are focusing on technology, there's nothing wrong from my
> > perspective. And this is how the community works. Your idea needs to
> > be justified and people are free to raise any technical questions
> > especially considering you've posted a spec change with prototype
> > codes but not only the idea.
> >
> > > Our
> > > goal is to add an new ism device. As far as the spec is concerned, we are not
> > > concerned with the implementation of the backend.
> > >
> > > The direction we should discuss is what is the difference between the ism device
> > > and other devices such as virtio-net, and whether it is necessary to introduce
> > > this new device.
> >
> > This is somehow what I want to ask, actually it's not a comparison
> > with virtio-net but:
> >
> > - virtio-roce
> > - virtio-vhost-user
> > - virtio-(p)mem
> >
> > or whether we can simply add features to those devices to achieve what
> > you want to do here.
> >
> > > How to share the backend with other deivce is another problem.
> >
> > Yes, anything that is used for your virito-ism prototype can be used
> > for other devices.
> >
> > >
> > > Our goal is to dynamically obtain a piece of memory to share with other vms.
> >
> > So at this level, I don't see the exact difference compared to
> > virtio-vhost-user. Let's just focus on the API that carries on the
> > semantic:
> >
> > - map/unmap
> > - permission update
> >
> > The only missing piece is the per region notification.
>
>
>
> I want to know how we can share a region based on vvu:
>
> |---------|       |---------------|
> |         |       |               |
> |  -----  |       |  -------      |
> |  | ? |  |       |  | vvu |      |
> |---------|       |---------------|
>      |                  |
>      |                  |
>      |------------------|
>
> Can you describe this process in the vvu scenario you are considering?
>
>
> The flow of ism we consider is as follows:
>     1. SMC calls the interface ism_alloc_region() of the ism driver to return the
>        location of a memory region in the PCI space and a token.

Can virtio-vhost-user be backed on the memory you've used for ISM?
It's just a name of the command:

VHOST_IOTLB_UPDATE(or other) vs VIRTIO_ISM_CTRL_ALLOC.

Or we can consider the form another angle, can virtio-vhost-user be
built on top of ISM?

>     2. The ism driver mmap the memory region and return to SMC with the token

This part should be the same as long as we add token to a specific region.

>     3. SMC passes the token to the connected peer

Should be the same.

>     4. the peer calls the ism driver interface ism_attach_region(token) to
>        get the location of the PCI space of the shared memory

Ditto.

Thanks

>
> Thanks.
>
>
> >
> > >
> > > In a connection, this memory will be used repeatedly. As far as SMC is concerned,
> > > it will use it as a ring. Of course, we also need a notify mechanism.
> > >
> > > That's what we're aiming for, so we should first discuss whether this
> > > requirement is reasonable.
> >
> > So unless somebody said "no", it is fine until now.
> >
> > > I think it's a feature currently not supported by
> > > other devices specified by the current virtio spce.
> >
> > Probably, but we've already had rfcs for roce and vhost-user.
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> >
>

