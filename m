Return-Path: <virtio-dev-return-10061-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C229598656C
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Oct 2022 09:14:04 +0000 (UTC)
MIME-Version: 1.0
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666146893.4959266-1-xuanzhuo@linux.alibaba.com> <CACGkMEsS1no70rcg_YHip1UYt+sFF2nTOBahvvi-e_VqL-NgJw@mail.gmail.com>
 <1666152510.9531486-1-xuanzhuo@linux.alibaba.com> <CACGkMEvHXp+NPxWYeSp_J8PYCT72GD9-jL3wYT6yC-6QxhMKFw@mail.gmail.com>
 <1666159341.0495708-1-xuanzhuo@linux.alibaba.com> <Y0+wRQ59IoWTs7h0@TonyMac-Alibaba>
 <36c27c6b-e8b5-5597-d1b0-c7fd3c3388dd@redhat.com> <44E44B6B-F979-425E-A63D-95D1AAA14435@linux.alibaba.com>
In-Reply-To: <44E44B6B-F979-425E-A63D-95D1AAA14435@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Oct 2022 17:13:46 +0800
Message-ID: <CACGkMEvwqQJHRZhYC4puiUKOpPzaebePe1=MT-wyT_4fPT=kcw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gerry <gerry@linux.alibaba.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 19, 2022 at 5:10 PM Gerry <gerry@linux.alibaba.com> wrote:
>
>
>
> > 2022=E5=B9=B410=E6=9C=8819=E6=97=A5 17:04=EF=BC=8CJason Wang <jasowang@=
redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> > =E5=9C=A8 2022/10/19 16:07, Tony Lu =E5=86=99=E9=81=93:
> >> On Wed, Oct 19, 2022 at 02:02:21PM +0800, Xuan Zhuo wrote:
> >>> On Wed, 19 Oct 2022 12:36:35 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> >>>> On Wed, Oct 19, 2022 at 12:22 PM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
> >>>>> On Wed, 19 Oct 2022 11:56:52 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> >>>>>> On Wed, Oct 19, 2022 at 10:42 AM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >>>>>>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> Hi Jason,
> >>>>>>>
> >>>>>>> I think there may be some problems with the direction we are disc=
ussing.
> >>>>>> Probably not.
> >>>>>>
> >>>>>> As far as we are focusing on technology, there's nothing wrong fro=
m my
> >>>>>> perspective. And this is how the community works. Your idea needs =
to
> >>>>>> be justified and people are free to raise any technical questions
> >>>>>> especially considering you've posted a spec change with prototype
> >>>>>> codes but not only the idea.
> >>>>>>
> >>>>>>> Our
> >>>>>>> goal is to add an new ism device. As far as the spec is concerned=
, we are not
> >>>>>>> concerned with the implementation of the backend.
> >>>>>>>
> >>>>>>> The direction we should discuss is what is the difference between=
 the ism device
> >>>>>>> and other devices such as virtio-net, and whether it is necessary=
 to introduce
> >>>>>>> this new device.
> >>>>>> This is somehow what I want to ask, actually it's not a comparison
> >>>>>> with virtio-net but:
> >>>>>>
> >>>>>> - virtio-roce
> >>>>>> - virtio-vhost-user
> >>>>>> - virtio-(p)mem
> >>>>>>
> >>>>>> or whether we can simply add features to those devices to achieve =
what
> >>>>>> you want to do here.
> >>>>>
> >>>>> Yes, this is my priority to discuss.
> >>>>>
> >>>>> At the moment, I think the most similar to ism is the Vhost-user De=
vice Backend
> >>>>> of virtio-vhost-user.
> >>>>>
> >>>>> My understanding of it is to map any virtio device to another vm as=
 a vvu
> >>>>> device.
> >>>> Yes, so a possible way is to have a device with memory zone/region
> >>>> provision and management then map it via virtio-vhost-user.
> >>>
> >>> Yes, there is such a possibility. virtio-vhost-user makes me feel tha=
t what can
> >>> be shared is the function implementation of map.
> >>>
> >>> But in the vm to provide the interface to the upper layer, I think th=
is is the
> >>> work of ism.
> >>>
> >>> But one of the reasons why I didn't use virtio-vhost-user directly is=
 that in
> >>> another vm, the guest can operate the vvu device, which we hope that =
both sides
> >>> are equal to the ism device.
> >>>
> >>> So I want to agree on a question first: who will provide the upper la=
yer with
> >>> the ability to share the memory area?
> >>>
> >>> Our answer is a new ism device. How does this device achieve memory s=
haring, I
> >>> think is the second question.
> >>>
> >>>
> >>>>> From this design purpose, I think the two are different.
> >>>>>
> >>>>> Of course, you might want to extend it, it does have some similarit=
ies and uses
> >>>>> a lot of similar techniques.
> >>>> I don't have any preference so far. If you think your idea makes mor=
e
> >>>> sense, then try your best to justify it in the list.
> >>>>
> >>>>> So we can really discuss in this direction, whether
> >>>>> the vvu device can be extended to achieve the purpose of ism, or wh=
ether the
> >>>>> design goals can be agreed.
> >>>> I've added Stefan in the loop, let's hear from him.
> >>>>
> >>>>> Or, in the direction of memory sharing in the backend, can ism and =
vvu be merged?
> >>>>> Should device/driver APIs remain independent?
> >>>> Btw, you mentioned that one possible user of ism is the smc, but I
> >>>> don't see how it connects to that with your prototype driver.
> >>> Yes, we originally had plans, but the virtio spec was considered for =
submission,
> >>> so this was not included. Maybe, we should have included this part @T=
ony
> >>>
> >>> A brief introduction is that SMC currently has a corresponding
> >>> s390/net/ism_drv.c and we will replace this in the virtualization sce=
nario.
> >
> >
> > Ok, I see. So I think the goal is to implement something in virtio that=
 is functional equivalent to IBM ISM device.
> >
> >
> >>>
> >>> Thanks.
> >>>
> >> SMC is a network protocol which is modeled by shared memory rather tha=
n
> >> packet.
> >
> >
> > After reading more SMC from IBM website, I think you meant SMC-D here. =
And I wonder in order to have a complete SMC solution we still need virtio-=
ROCE for inter host communcation?
> Absolutely, a complete solution includes SMC-R remote peers and SMC-D for=
 local peers:)

Ok, great.

>
>
> >
> >>  Actually the basic required interfaces of SMC device are:
> >>
> >>   - alloc / free memory region, each connection peer has two memory
> >>      regions dynamically for sending and receiving ring buffer.
> >>   - attach / detach memory region, remote attaches local-allocated
> >>      sending region as receiving region, vice versa.
> >>   - notify, tell peer to read data and update cursor.
> >>
> >> Then the device can be registered as SMC ISM device. Of course, SMC
> >> also requires some modification to adapt it.
> >
> >
> > Looking at s390 ism driver it requires other stuffs like vlan add/remov=
e or gid query, do we need them as well?
> We plan to get rid of vlan support,

Please explain this in the changelog or cover letter.

> but we do need interface to query gid etc.

Ok, so let's add that in the next version.

> And the virtio-queue helps us much to implement a control communication c=
hannel to support those operations.

Right.

Thanks

>
> >
> > Thanks
> >
> >
> >>
> >> Cheers,
> >> Tony Lu
> >>
> >>>> Thanks
> >>>>
> >>>>> Thanks.
> >>>>>
> >>>>>
> >>>>>>> How to share the backend with other deivce is another problem.
> >>>>>> Yes, anything that is used for your virito-ism prototype can be us=
ed
> >>>>>> for other devices.
> >>>>>>
> >>>>>>> Our goal is to dynamically obtain a piece of memory to share with=
 other vms.
> >>>>>> So at this level, I don't see the exact difference compared to
> >>>>>> virtio-vhost-user. Let's just focus on the API that carries on the
> >>>>>> semantic:
> >>>>>>
> >>>>>> - map/unmap
> >>>>>> - permission update
> >>>>>>
> >>>>>> The only missing piece is the per region notification.
> >>>>>>
> >>>>>>> In a connection, this memory will be used repeatedly. As far as S=
MC is concerned,
> >>>>>>> it will use it as a ring. Of course, we also need a notify mechan=
ism.
> >>>>>>>
> >>>>>>> That's what we're aiming for, so we should first discuss whether =
this
> >>>>>>> requirement is reasonable.
> >>>>>> So unless somebody said "no", it is fine until now.
> >>>>>>
> >>>>>>> I think it's a feature currently not supported by
> >>>>>>> other devices specified by the current virtio spce.
> >>>>>> Probably, but we've already had rfcs for roce and vhost-user.
> >>>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>>> Thanks.
> >>>>>>>
> >>>>>>>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

