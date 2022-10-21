Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666146893.4959266-1-xuanzhuo@linux.alibaba.com> <CACGkMEsS1no70rcg_YHip1UYt+sFF2nTOBahvvi-e_VqL-NgJw@mail.gmail.com>
 <1666152510.9531486-1-xuanzhuo@linux.alibaba.com> <CACGkMEvHXp+NPxWYeSp_J8PYCT72GD9-jL3wYT6yC-6QxhMKFw@mail.gmail.com>
 <1666159341.0495708-1-xuanzhuo@linux.alibaba.com> <Y0+wRQ59IoWTs7h0@TonyMac-Alibaba>
 <36c27c6b-e8b5-5597-d1b0-c7fd3c3388dd@redhat.com> <Y0/K9Fdv2JS9O935@TonyMac-Alibaba>
 <CACGkMEuA7n2C4cReHUiJznhiMrbf9ZdGqzFcU7MZ888f01ps0Q@mail.gmail.com> <Y1IMe0saQnOPd9rI@TonyMac-Alibaba>
In-Reply-To: <Y1IMe0saQnOPd9rI@TonyMac-Alibaba>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Oct 2022 11:07:27 +0800
Message-ID: <CACGkMEv1iocS3iKjPkLwqnvye4HWj_A-bBr9M5uHEMxf5nf5fw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Tony Lu <tonylu@linux.alibaba.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 21, 2022 at 11:05 AM Tony Lu <tonylu@linux.alibaba.com> wrote:
>
> On Fri, Oct 21, 2022 at 10:47:29AM +0800, Jason Wang wrote:
> > On Wed, Oct 19, 2022 at 6:01 PM Tony Lu <tonylu@linux.alibaba.com> wrot=
e:
> > >
> > > On Wed, Oct 19, 2022 at 05:04:58PM +0800, Jason Wang wrote:
> > > >
> > > > =E5=9C=A8 2022/10/19 16:07, Tony Lu =E5=86=99=E9=81=93:
> > > > > On Wed, Oct 19, 2022 at 02:02:21PM +0800, Xuan Zhuo wrote:
> > > > > > On Wed, 19 Oct 2022 12:36:35 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Wed, Oct 19, 2022 at 12:22 PM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > > > > > > On Wed, 19 Oct 2022 11:56:52 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Wed, Oct 19, 2022 at 10:42 AM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > > > > > > On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Hi Jason,
> > > > > > > > > >
> > > > > > > > > > I think there may be some problems with the direction w=
e are discussing.
> > > > > > > > > Probably not.
> > > > > > > > >
> > > > > > > > > As far as we are focusing on technology, there's nothing =
wrong from my
> > > > > > > > > perspective. And this is how the community works. Your id=
ea needs to
> > > > > > > > > be justified and people are free to raise any technical q=
uestions
> > > > > > > > > especially considering you've posted a spec change with p=
rototype
> > > > > > > > > codes but not only the idea.
> > > > > > > > >
> > > > > > > > > > Our
> > > > > > > > > > goal is to add an new ism device. As far as the spec is=
 concerned, we are not
> > > > > > > > > > concerned with the implementation of the backend.
> > > > > > > > > >
> > > > > > > > > > The direction we should discuss is what is the differen=
ce between the ism device
> > > > > > > > > > and other devices such as virtio-net, and whether it is=
 necessary to introduce
> > > > > > > > > > this new device.
> > > > > > > > > This is somehow what I want to ask, actually it's not a c=
omparison
> > > > > > > > > with virtio-net but:
> > > > > > > > >
> > > > > > > > > - virtio-roce
> > > > > > > > > - virtio-vhost-user
> > > > > > > > > - virtio-(p)mem
> > > > > > > > >
> > > > > > > > > or whether we can simply add features to those devices to=
 achieve what
> > > > > > > > > you want to do here.
> > > > > > > >
> > > > > > > > Yes, this is my priority to discuss.
> > > > > > > >
> > > > > > > > At the moment, I think the most similar to ism is the Vhost=
-user Device Backend
> > > > > > > > of virtio-vhost-user.
> > > > > > > >
> > > > > > > > My understanding of it is to map any virtio device to anoth=
er vm as a vvu
> > > > > > > > device.
> > > > > > > Yes, so a possible way is to have a device with memory zone/r=
egion
> > > > > > > provision and management then map it via virtio-vhost-user.
> > > > > >
> > > > > > Yes, there is such a possibility. virtio-vhost-user makes me fe=
el that what can
> > > > > > be shared is the function implementation of map.
> > > > > >
> > > > > > But in the vm to provide the interface to the upper layer, I th=
ink this is the
> > > > > > work of ism.
> > > > > >
> > > > > > But one of the reasons why I didn't use virtio-vhost-user direc=
tly is that in
> > > > > > another vm, the guest can operate the vvu device, which we hope=
 that both sides
> > > > > > are equal to the ism device.
> > > > > >
> > > > > > So I want to agree on a question first: who will provide the up=
per layer with
> > > > > > the ability to share the memory area?
> > > > > >
> > > > > > Our answer is a new ism device. How does this device achieve me=
mory sharing, I
> > > > > > think is the second question.
> > > > > >
> > > > > >
> > > > > > > >  From this design purpose, I think the two are different.
> > > > > > > >
> > > > > > > > Of course, you might want to extend it, it does have some s=
imilarities and uses
> > > > > > > > a lot of similar techniques.
> > > > > > > I don't have any preference so far. If you think your idea ma=
kes more
> > > > > > > sense, then try your best to justify it in the list.
> > > > > > >
> > > > > > > > So we can really discuss in this direction, whether
> > > > > > > > the vvu device can be extended to achieve the purpose of is=
m, or whether the
> > > > > > > > design goals can be agreed.
> > > > > > > I've added Stefan in the loop, let's hear from him.
> > > > > > >
> > > > > > > > Or, in the direction of memory sharing in the backend, can =
ism and vvu be merged?
> > > > > > > > Should device/driver APIs remain independent?
> > > > > > > Btw, you mentioned that one possible user of ism is the smc, =
but I
> > > > > > > don't see how it connects to that with your prototype driver.
> > > > > > Yes, we originally had plans, but the virtio spec was considere=
d for submission,
> > > > > > so this was not included. Maybe, we should have included this p=
art @Tony
> > > > > >
> > > > > > A brief introduction is that SMC currently has a corresponding
> > > > > > s390/net/ism_drv.c and we will replace this in the virtualizati=
on scenario.
> > > >
> > > >
> > > > Ok, I see. So I think the goal is to implement something in virtio =
that is
> > > > functional equivalent to IBM ISM device.
> > > >
> > >
> > > Yes, IBM ISM devices do something similar and it inspired this.
> >
> > Ok, it would be better to mention this in the cover letter of the next
> > version. This can ease the reviewers (IBM has some good docs of those
> > from the website).
> >
>
> Yes, we will do it.
>
> > >
> > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > SMC is a network protocol which is modeled by shared memory rathe=
r than
> > > > > packet.
> > > >
> > > >
> > > > After reading more SMC from IBM website, I think you meant SMC-D he=
re. And I
> > > > wonder in order to have a complete SMC solution we still need virti=
o-ROCE
> > > > for inter host communcation?
> > > >
> > >
> > > Mostly yes.
> > >
> > > SMC-D is the part of whole SMC solution. SMC supports multiple
> > > underlying device, -D means ISM device, -R means RDMA device. The key
> > > data model is shared memory, SMC uses RDMA (-R) or ISM(-D) to *share*
> > > memory between peers, and it will choose the suitable device on deman=
d
> > > during handshaking. If there was no suitable device, it would fall ba=
ck
> > > to TCP. So virtio-ROCE is not required.
> >
> > So the commniting peers on the same host we need SMC-D, in the future
> > we need to use RDMA to offload the communication among the peers of
> > different hosts. Then we can get fully transparent offload no matter
> > the peer is local or not.
> >
>
> Yes, this is what we want to do.

Great, Yong Ji posted a ROCE proposal[1], it would be appreciated if
you can review and give feedback.

[1] https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.co=
m/T/

Thanks

>
> > >
> > > >
> > > > >   Actually the basic required interfaces of SMC device are:
> > > > >
> > > > >    - alloc / free memory region, each connection peer has two mem=
ory
> > > > >     regions dynamically for sending and receiving ring buffer.
> > > > >    - attach / detach memory region, remote attaches local-allocat=
ed
> > > > >     sending region as receiving region, vice versa.
> > > > >    - notify, tell peer to read data and update cursor.
> > > > >
> > > > > Then the device can be registered as SMC ISM device. Of course, S=
MC
> > > > > also requires some modification to adapt it.
> > > >
> > > >
> > > > Looking at s390 ism driver it requires other stuffs like vlan add/r=
emove or
> > > > gid query, do we need them as well?
> > >
> > > vlan is not required in this use case. ISM uses gid to identified eac=
h
> > > others, maybe we could implement it in virtio ways.
> >
> > I'd suggest adding the codes to register the driver to SMC/ISM in the
> > next version (instead of a simple procfs hooking). Then people can
> > easily play or review.
> >
>
> Ok, I will add the codes in the next version.
>
> Cheers,
> Tony Lu
>
> > Thanks
> >
> > >
> > > To support virtio-ism smoothly, the interfaces of ISM driver still ne=
ed
> > > to be adjusted. I will put it on the table with IBM people.
> > >
> > > Cheers,
> > > Tony Lu
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > > Cheers,
> > > > > Tony Lu
> > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > >
> > > > > > > > > > How to share the backend with other deivce is another p=
roblem.
> > > > > > > > > Yes, anything that is used for your virito-ism prototype =
can be used
> > > > > > > > > for other devices.
> > > > > > > > >
> > > > > > > > > > Our goal is to dynamically obtain a piece of memory to =
share with other vms.
> > > > > > > > > So at this level, I don't see the exact difference compar=
ed to
> > > > > > > > > virtio-vhost-user. Let's just focus on the API that carri=
es on the
> > > > > > > > > semantic:
> > > > > > > > >
> > > > > > > > > - map/unmap
> > > > > > > > > - permission update
> > > > > > > > >
> > > > > > > > > The only missing piece is the per region notification.
> > > > > > > > >
> > > > > > > > > > In a connection, this memory will be used repeatedly. A=
s far as SMC is concerned,
> > > > > > > > > > it will use it as a ring. Of course, we also need a not=
ify mechanism.
> > > > > > > > > >
> > > > > > > > > > That's what we're aiming for, so we should first discus=
s whether this
> > > > > > > > > > requirement is reasonable.
> > > > > > > > > So unless somebody said "no", it is fine until now.
> > > > > > > > >
> > > > > > > > > > I think it's a feature currently not supported by
> > > > > > > > > > other devices specified by the current virtio spce.
> > > > > > > > > Probably, but we've already had rfcs for roce and vhost-u=
ser.
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > >
> > >
>

