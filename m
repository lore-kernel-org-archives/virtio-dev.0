Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1666159341.0495708-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared memory device
Date: Wed, 19 Oct 2022 14:02:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666146893.4959266-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsS1no70rcg_YHip1UYt+sFF2nTOBahvvi-e_VqL-NgJw@mail.gmail.com>
 <1666152510.9531486-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvHXp+NPxWYeSp_J8PYCT72GD9-jL3wYT6yC-6QxhMKFw@mail.gmail.com>
In-Reply-To: <CACGkMEvHXp+NPxWYeSp_J8PYCT72GD9-jL3wYT6yC-6QxhMKFw@mail.gmail.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 19 Oct 2022 12:36:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Oct 19, 2022 at 12:22 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Wed, 19 Oct 2022 11:56:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Wed, Oct 19, 2022 at 10:42 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > >
> > > > Hi Jason,
> > > >
> > > > I think there may be some problems with the direction we are discussing.
> > >
> > > Probably not.
> > >
> > > As far as we are focusing on technology, there's nothing wrong from my
> > > perspective. And this is how the community works. Your idea needs to
> > > be justified and people are free to raise any technical questions
> > > especially considering you've posted a spec change with prototype
> > > codes but not only the idea.
> > >
> > > > Our
> > > > goal is to add an new ism device. As far as the spec is concerned, we are not
> > > > concerned with the implementation of the backend.
> > > >
> > > > The direction we should discuss is what is the difference between the ism device
> > > > and other devices such as virtio-net, and whether it is necessary to introduce
> > > > this new device.
> > >
> > > This is somehow what I want to ask, actually it's not a comparison
> > > with virtio-net but:
> > >
> > > - virtio-roce
> > > - virtio-vhost-user
> > > - virtio-(p)mem
> > >
> > > or whether we can simply add features to those devices to achieve what
> > > you want to do here.
> >
> >
> > Yes, this is my priority to discuss.
> >
> > At the moment, I think the most similar to ism is the Vhost-user Device Backend
> > of virtio-vhost-user.
> >
> > My understanding of it is to map any virtio device to another vm as a vvu
> > device.
>
> Yes, so a possible way is to have a device with memory zone/region
> provision and management then map it via virtio-vhost-user.


Yes, there is such a possibility. virtio-vhost-user makes me feel that what can
be shared is the function implementation of map.

But in the vm to provide the interface to the upper layer, I think this is the
work of ism.

But one of the reasons why I didn't use virtio-vhost-user directly is that in
another vm, the guest can operate the vvu device, which we hope that both sides
are equal to the ism device.

So I want to agree on a question first: who will provide the upper layer with
the ability to share the memory area?

Our answer is a new ism device. How does this device achieve memory sharing, I
think is the second question.


>
> >
> > From this design purpose, I think the two are different.
> >
> > Of course, you might want to extend it, it does have some similarities and uses
> > a lot of similar techniques.
>
> I don't have any preference so far. If you think your idea makes more
> sense, then try your best to justify it in the list.
>
> > So we can really discuss in this direction, whether
> > the vvu device can be extended to achieve the purpose of ism, or whether the
> > design goals can be agreed.
>
> I've added Stefan in the loop, let's hear from him.
>
> >
> > Or, in the direction of memory sharing in the backend, can ism and vvu be merged?
> > Should device/driver APIs remain independent?
>
> Btw, you mentioned that one possible user of ism is the smc, but I
> don't see how it connects to that with your prototype driver.

Yes, we originally had plans, but the virtio spec was considered for submission,
so this was not included. Maybe, we should have included this part @Tony

A brief introduction is that SMC currently has a corresponding
s390/net/ism_drv.c and we will replace this in the virtualization scenario.

Thanks.

>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > > How to share the backend with other deivce is another problem.
> > >
> > > Yes, anything that is used for your virito-ism prototype can be used
> > > for other devices.
> > >
> > > >
> > > > Our goal is to dynamically obtain a piece of memory to share with other vms.
> > >
> > > So at this level, I don't see the exact difference compared to
> > > virtio-vhost-user. Let's just focus on the API that carries on the
> > > semantic:
> > >
> > > - map/unmap
> > > - permission update
> > >
> > > The only missing piece is the per region notification.
> > >
> > > >
> > > > In a connection, this memory will be used repeatedly. As far as SMC is concerned,
> > > > it will use it as a ring. Of course, we also need a notify mechanism.
> > > >
> > > > That's what we're aiming for, so we should first discuss whether this
> > > > requirement is reasonable.
> > >
> > > So unless somebody said "no", it is fine until now.
> > >
> > > > I think it's a feature currently not supported by
> > > > other devices specified by the current virtio spce.
> > >
> > > Probably, but we've already had rfcs for roce and vhost-user.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > >
> >
>

