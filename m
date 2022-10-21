Return-Path: <virtio-dev-return-10077-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3265498633B
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Oct 2022 03:53:18 +0000 (UTC)
Date: Fri, 21 Oct 2022 11:53:10 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
Message-ID: <Y1IXpusuUXtNtie9@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <CACGkMEsS1no70rcg_YHip1UYt+sFF2nTOBahvvi-e_VqL-NgJw@mail.gmail.com>
 <1666152510.9531486-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvHXp+NPxWYeSp_J8PYCT72GD9-jL3wYT6yC-6QxhMKFw@mail.gmail.com>
 <1666159341.0495708-1-xuanzhuo@linux.alibaba.com>
 <Y0+wRQ59IoWTs7h0@TonyMac-Alibaba>
 <36c27c6b-e8b5-5597-d1b0-c7fd3c3388dd@redhat.com>
 <Y0/K9Fdv2JS9O935@TonyMac-Alibaba>
 <CACGkMEuA7n2C4cReHUiJznhiMrbf9ZdGqzFcU7MZ888f01ps0Q@mail.gmail.com>
 <Y1IMe0saQnOPd9rI@TonyMac-Alibaba>
 <CACGkMEszP2p3sxK_FCEt8G=jvQbf32UEYCL7_V6Rt_UfxrWhBg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEszP2p3sxK_FCEt8G=jvQbf32UEYCL7_V6Rt_UfxrWhBg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 21, 2022 at 11:09:19AM +0800, Jason Wang wrote:
> On Fri, Oct 21, 2022 at 11:05 AM Tony Lu <tonylu@linux.alibaba.com> wrote=
:
> >
> > On Fri, Oct 21, 2022 at 10:47:29AM +0800, Jason Wang wrote:
> > > On Wed, Oct 19, 2022 at 6:01 PM Tony Lu <tonylu@linux.alibaba.com> wr=
ote:
> > > >
> > > > On Wed, Oct 19, 2022 at 05:04:58PM +0800, Jason Wang wrote:
> > > > >
> > > > > =D4=DA 2022/10/19 16:07, Tony Lu =D0=B4=B5=C0:
> > > > > > On Wed, Oct 19, 2022 at 02:02:21PM +0800, Xuan Zhuo wrote:
> > > > > > > On Wed, 19 Oct 2022 12:36:35 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Wed, Oct 19, 2022 at 12:22 PM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > > > > > > On Wed, 19 Oct 2022 11:56:52 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Wed, Oct 19, 2022 at 10:42 AM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> > > > > > > > > > > On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasow=
ang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Hi Jason,
> > > > > > > > > > >
> > > > > > > > > > > I think there may be some problems with the direction=
 we are discussing.
> > > > > > > > > > Probably not.
> > > > > > > > > >
> > > > > > > > > > As far as we are focusing on technology, there's nothin=
g wrong from my
> > > > > > > > > > perspective. And this is how the community works. Your =
idea needs to
> > > > > > > > > > be justified and people are free to raise any technical=
 questions
> > > > > > > > > > especially considering you've posted a spec change with=
 prototype
> > > > > > > > > > codes but not only the idea.
> > > > > > > > > >
> > > > > > > > > > > Our
> > > > > > > > > > > goal is to add an new ism device. As far as the spec =
is concerned, we are not
> > > > > > > > > > > concerned with the implementation of the backend.
> > > > > > > > > > >
> > > > > > > > > > > The direction we should discuss is what is the differ=
ence between the ism device
> > > > > > > > > > > and other devices such as virtio-net, and whether it =
is necessary to introduce
> > > > > > > > > > > this new device.
> > > > > > > > > > This is somehow what I want to ask, actually it's not a=
 comparison
> > > > > > > > > > with virtio-net but:
> > > > > > > > > >
> > > > > > > > > > - virtio-roce
> > > > > > > > > > - virtio-vhost-user
> > > > > > > > > > - virtio-(p)mem
> > > > > > > > > >
> > > > > > > > > > or whether we can simply add features to those devices =
to achieve what
> > > > > > > > > > you want to do here.
> > > > > > > > >
> > > > > > > > > Yes, this is my priority to discuss.
> > > > > > > > >
> > > > > > > > > At the moment, I think the most similar to ism is the Vho=
st-user Device Backend
> > > > > > > > > of virtio-vhost-user.
> > > > > > > > >
> > > > > > > > > My understanding of it is to map any virtio device to ano=
ther vm as a vvu
> > > > > > > > > device.
> > > > > > > > Yes, so a possible way is to have a device with memory zone=
/region
> > > > > > > > provision and management then map it via virtio-vhost-user.
> > > > > > >
> > > > > > > Yes, there is such a possibility. virtio-vhost-user makes me =
feel that what can
> > > > > > > be shared is the function implementation of map.
> > > > > > >
> > > > > > > But in the vm to provide the interface to the upper layer, I =
think this is the
> > > > > > > work of ism.
> > > > > > >
> > > > > > > But one of the reasons why I didn't use virtio-vhost-user dir=
ectly is that in
> > > > > > > another vm, the guest can operate the vvu device, which we ho=
pe that both sides
> > > > > > > are equal to the ism device.
> > > > > > >
> > > > > > > So I want to agree on a question first: who will provide the =
upper layer with
> > > > > > > the ability to share the memory area?
> > > > > > >
> > > > > > > Our answer is a new ism device. How does this device achieve =
memory sharing, I
> > > > > > > think is the second question.
> > > > > > >
> > > > > > >
> > > > > > > > >  From this design purpose, I think the two are different.
> > > > > > > > >
> > > > > > > > > Of course, you might want to extend it, it does have some=
 similarities and uses
> > > > > > > > > a lot of similar techniques.
> > > > > > > > I don't have any preference so far. If you think your idea =
makes more
> > > > > > > > sense, then try your best to justify it in the list.
> > > > > > > >
> > > > > > > > > So we can really discuss in this direction, whether
> > > > > > > > > the vvu device can be extended to achieve the purpose of =
ism, or whether the
> > > > > > > > > design goals can be agreed.
> > > > > > > > I've added Stefan in the loop, let's hear from him.
> > > > > > > >
> > > > > > > > > Or, in the direction of memory sharing in the backend, ca=
n ism and vvu be merged?
> > > > > > > > > Should device/driver APIs remain independent?
> > > > > > > > Btw, you mentioned that one possible user of ism is the smc=
, but I
> > > > > > > > don't see how it connects to that with your prototype drive=
r.
> > > > > > > Yes, we originally had plans, but the virtio spec was conside=
red for submission,
> > > > > > > so this was not included. Maybe, we should have included this=
 part @Tony
> > > > > > >
> > > > > > > A brief introduction is that SMC currently has a correspondin=
g
> > > > > > > s390/net/ism_drv.c and we will replace this in the virtualiza=
tion scenario.
> > > > >
> > > > >
> > > > > Ok, I see. So I think the goal is to implement something in virti=
o that is
> > > > > functional equivalent to IBM ISM device.
> > > > >
> > > >
> > > > Yes, IBM ISM devices do something similar and it inspired this.
> > >
> > > Ok, it would be better to mention this in the cover letter of the nex=
t
> > > version. This can ease the reviewers (IBM has some good docs of those
> > > from the website).
> > >
> >
> > Yes, we will do it.
>=20
> Btw, I wonder about the plan to support live migration. E.g do we need
> to hot unplug the ism device before the migration then we can fallback
> to TCP/IP ?
>=20

From the point view of SMC, SMC-R maintains multiple link (RDMA QP), it
can live migrate existed connections to new link.

Currently, yes, for SMC-D.

Cheers,
Tony Lu


> Thanks
>=20
> >
> > > >
> > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > SMC is a network protocol which is modeled by shared memory rat=
her than
> > > > > > packet.
> > > > >
> > > > >
> > > > > After reading more SMC from IBM website, I think you meant SMC-D =
here. And I
> > > > > wonder in order to have a complete SMC solution we still need vir=
tio-ROCE
> > > > > for inter host communcation?
> > > > >
> > > >
> > > > Mostly yes.
> > > >
> > > > SMC-D is the part of whole SMC solution. SMC supports multiple
> > > > underlying device, -D means ISM device, -R means RDMA device. The k=
ey
> > > > data model is shared memory, SMC uses RDMA (-R) or ISM(-D) to *shar=
e*
> > > > memory between peers, and it will choose the suitable device on dem=
and
> > > > during handshaking. If there was no suitable device, it would fall =
back
> > > > to TCP. So virtio-ROCE is not required.
> > >
> > > So the commniting peers on the same host we need SMC-D, in the future
> > > we need to use RDMA to offload the communication among the peers of
> > > different hosts. Then we can get fully transparent offload no matter
> > > the peer is local or not.
> > >
> >
> > Yes, this is what we want to do.
> >
> > > >
> > > > >
> > > > > >   Actually the basic required interfaces of SMC device are:
> > > > > >
> > > > > >    - alloc / free memory region, each connection peer has two m=
emory
> > > > > >     regions dynamically for sending and receiving ring buffer.
> > > > > >    - attach / detach memory region, remote attaches local-alloc=
ated
> > > > > >     sending region as receiving region, vice versa.
> > > > > >    - notify, tell peer to read data and update cursor.
> > > > > >
> > > > > > Then the device can be registered as SMC ISM device. Of course,=
 SMC
> > > > > > also requires some modification to adapt it.
> > > > >
> > > > >
> > > > > Looking at s390 ism driver it requires other stuffs like vlan add=
/remove or
> > > > > gid query, do we need them as well?
> > > >
> > > > vlan is not required in this use case. ISM uses gid to identified e=
ach
> > > > others, maybe we could implement it in virtio ways.
> > >
> > > I'd suggest adding the codes to register the driver to SMC/ISM in the
> > > next version (instead of a simple procfs hooking). Then people can
> > > easily play or review.
> > >
> >
> > Ok, I will add the codes in the next version.
> >
> > Cheers,
> > Tony Lu
> >
> > > Thanks
> > >
> > > >
> > > > To support virtio-ism smoothly, the interfaces of ISM driver still =
need
> > > > to be adjusted. I will put it on the table with IBM people.
> > > >
> > > > Cheers,
> > > > Tony Lu
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > > Cheers,
> > > > > > Tony Lu
> > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > > How to share the backend with other deivce is another=
 problem.
> > > > > > > > > > Yes, anything that is used for your virito-ism prototyp=
e can be used
> > > > > > > > > > for other devices.
> > > > > > > > > >
> > > > > > > > > > > Our goal is to dynamically obtain a piece of memory t=
o share with other vms.
> > > > > > > > > > So at this level, I don't see the exact difference comp=
ared to
> > > > > > > > > > virtio-vhost-user. Let's just focus on the API that car=
ries on the
> > > > > > > > > > semantic:
> > > > > > > > > >
> > > > > > > > > > - map/unmap
> > > > > > > > > > - permission update
> > > > > > > > > >
> > > > > > > > > > The only missing piece is the per region notification.
> > > > > > > > > >
> > > > > > > > > > > In a connection, this memory will be used repeatedly.=
 As far as SMC is concerned,
> > > > > > > > > > > it will use it as a ring. Of course, we also need a n=
otify mechanism.
> > > > > > > > > > >
> > > > > > > > > > > That's what we're aiming for, so we should first disc=
uss whether this
> > > > > > > > > > > requirement is reasonable.
> > > > > > > > > > So unless somebody said "no", it is fine until now.
> > > > > > > > > >
> > > > > > > > > > > I think it's a feature currently not supported by
> > > > > > > > > > > other devices specified by the current virtio spce.
> > > > > > > > > > Probably, but we've already had rfcs for roce and vhost=
-user.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > > Thanks.
> > > > > > > > > > >
> > > > > > > > > > >
> > > >
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

