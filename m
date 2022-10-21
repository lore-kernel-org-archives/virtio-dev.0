Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <CACGkMEvHXp+NPxWYeSp_J8PYCT72GD9-jL3wYT6yC-6QxhMKFw@mail.gmail.com>
 <1666159341.0495708-1-xuanzhuo@linux.alibaba.com> <Y0+wRQ59IoWTs7h0@TonyMac-Alibaba>
 <36c27c6b-e8b5-5597-d1b0-c7fd3c3388dd@redhat.com> <Y0/K9Fdv2JS9O935@TonyMac-Alibaba>
 <CACGkMEuA7n2C4cReHUiJznhiMrbf9ZdGqzFcU7MZ888f01ps0Q@mail.gmail.com>
 <Y1IMe0saQnOPd9rI@TonyMac-Alibaba> <CACGkMEszP2p3sxK_FCEt8G=jvQbf32UEYCL7_V6Rt_UfxrWhBg@mail.gmail.com>
 <Y1IXpusuUXtNtie9@TonyMac-Alibaba> <20221021045422.GC63658@linux.alibaba.com> <Y1IqX2uVpcD7cvRF@TonyMac-Alibaba>
In-Reply-To: <Y1IqX2uVpcD7cvRF@TonyMac-Alibaba>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Oct 2022 14:38:20 +0800
Message-ID: <CACGkMEvf5DUORV1g6+vfdvEi9ywe7RYXseyRuvi7nDgZo-M8YQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Tony Lu <tonylu@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 21, 2022 at 1:13 PM Tony Lu <tonylu@linux.alibaba.com> wrote:
>
> On Fri, Oct 21, 2022 at 12:54:22PM +0800, Dust Li wrote:
> > On Fri, Oct 21, 2022 at 11:53:10AM +0800, Tony Lu wrote:
> > >On Fri, Oct 21, 2022 at 11:09:19AM +0800, Jason Wang wrote:
> > >> On Fri, Oct 21, 2022 at 11:05 AM Tony Lu <tonylu@linux.alibaba.com> =
wrote:
> > >> >
> > >> > On Fri, Oct 21, 2022 at 10:47:29AM +0800, Jason Wang wrote:
> > >> > > On Wed, Oct 19, 2022 at 6:01 PM Tony Lu <tonylu@linux.alibaba.co=
m> wrote:
> > >> > > >
> > >> > > > On Wed, Oct 19, 2022 at 05:04:58PM +0800, Jason Wang wrote:
> > >> > > > >
> > >> > > > > =E5=9C=A8 2022/10/19 16:07, Tony Lu =E5=86=99=E9=81=93:
> > >> > > > > > On Wed, Oct 19, 2022 at 02:02:21PM +0800, Xuan Zhuo wrote:
> > >> > > > > > > On Wed, 19 Oct 2022 12:36:35 +0800, Jason Wang <jasowang=
@redhat.com> wrote:
> > >> > > > > > > > On Wed, Oct 19, 2022 at 12:22 PM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > >> > > > > > > > > On Wed, 19 Oct 2022 11:56:52 +0800, Jason Wang <jaso=
wang@redhat.com> wrote:
> > >> > > > > > > > > > On Wed, Oct 19, 2022 at 10:42 AM Xuan Zhuo <xuanzh=
uo@linux.alibaba.com> wrote:
> > >> > > > > > > > > > > On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <=
jasowang@redhat.com> wrote:
> > >> > > > > > > > > > >
> > >> > > > > > > > > > >
> > >> > > > > > > > > > > Hi Jason,
> > >> > > > > > > > > > >
> > >> > > > > > > > > > > I think there may be some problems with the dire=
ction we are discussing.
> > >> > > > > > > > > > Probably not.
> > >> > > > > > > > > >
> > >> > > > > > > > > > As far as we are focusing on technology, there's n=
othing wrong from my
> > >> > > > > > > > > > perspective. And this is how the community works. =
Your idea needs to
> > >> > > > > > > > > > be justified and people are free to raise any tech=
nical questions
> > >> > > > > > > > > > especially considering you've posted a spec change=
 with prototype
> > >> > > > > > > > > > codes but not only the idea.
> > >> > > > > > > > > >
> > >> > > > > > > > > > > Our
> > >> > > > > > > > > > > goal is to add an new ism device. As far as the =
spec is concerned, we are not
> > >> > > > > > > > > > > concerned with the implementation of the backend=
.
> > >> > > > > > > > > > >
> > >> > > > > > > > > > > The direction we should discuss is what is the d=
ifference between the ism device
> > >> > > > > > > > > > > and other devices such as virtio-net, and whethe=
r it is necessary to introduce
> > >> > > > > > > > > > > this new device.
> > >> > > > > > > > > > This is somehow what I want to ask, actually it's =
not a comparison
> > >> > > > > > > > > > with virtio-net but:
> > >> > > > > > > > > >
> > >> > > > > > > > > > - virtio-roce
> > >> > > > > > > > > > - virtio-vhost-user
> > >> > > > > > > > > > - virtio-(p)mem
> > >> > > > > > > > > >
> > >> > > > > > > > > > or whether we can simply add features to those dev=
ices to achieve what
> > >> > > > > > > > > > you want to do here.
> > >> > > > > > > > >
> > >> > > > > > > > > Yes, this is my priority to discuss.
> > >> > > > > > > > >
> > >> > > > > > > > > At the moment, I think the most similar to ism is th=
e Vhost-user Device Backend
> > >> > > > > > > > > of virtio-vhost-user.
> > >> > > > > > > > >
> > >> > > > > > > > > My understanding of it is to map any virtio device t=
o another vm as a vvu
> > >> > > > > > > > > device.
> > >> > > > > > > > Yes, so a possible way is to have a device with memory=
 zone/region
> > >> > > > > > > > provision and management then map it via virtio-vhost-=
user.
> > >> > > > > > >
> > >> > > > > > > Yes, there is such a possibility. virtio-vhost-user make=
s me feel that what can
> > >> > > > > > > be shared is the function implementation of map.
> > >> > > > > > >
> > >> > > > > > > But in the vm to provide the interface to the upper laye=
r, I think this is the
> > >> > > > > > > work of ism.
> > >> > > > > > >
> > >> > > > > > > But one of the reasons why I didn't use virtio-vhost-use=
r directly is that in
> > >> > > > > > > another vm, the guest can operate the vvu device, which =
we hope that both sides
> > >> > > > > > > are equal to the ism device.
> > >> > > > > > >
> > >> > > > > > > So I want to agree on a question first: who will provide=
 the upper layer with
> > >> > > > > > > the ability to share the memory area?
> > >> > > > > > >
> > >> > > > > > > Our answer is a new ism device. How does this device ach=
ieve memory sharing, I
> > >> > > > > > > think is the second question.
> > >> > > > > > >
> > >> > > > > > >
> > >> > > > > > > > >  From this design purpose, I think the two are diffe=
rent.
> > >> > > > > > > > >
> > >> > > > > > > > > Of course, you might want to extend it, it does have=
 some similarities and uses
> > >> > > > > > > > > a lot of similar techniques.
> > >> > > > > > > > I don't have any preference so far. If you think your =
idea makes more
> > >> > > > > > > > sense, then try your best to justify it in the list.
> > >> > > > > > > >
> > >> > > > > > > > > So we can really discuss in this direction, whether
> > >> > > > > > > > > the vvu device can be extended to achieve the purpos=
e of ism, or whether the
> > >> > > > > > > > > design goals can be agreed.
> > >> > > > > > > > I've added Stefan in the loop, let's hear from him.
> > >> > > > > > > >
> > >> > > > > > > > > Or, in the direction of memory sharing in the backen=
d, can ism and vvu be merged?
> > >> > > > > > > > > Should device/driver APIs remain independent?
> > >> > > > > > > > Btw, you mentioned that one possible user of ism is th=
e smc, but I
> > >> > > > > > > > don't see how it connects to that with your prototype =
driver.
> > >> > > > > > > Yes, we originally had plans, but the virtio spec was co=
nsidered for submission,
> > >> > > > > > > so this was not included. Maybe, we should have included=
 this part @Tony
> > >> > > > > > >
> > >> > > > > > > A brief introduction is that SMC currently has a corresp=
onding
> > >> > > > > > > s390/net/ism_drv.c and we will replace this in the virtu=
alization scenario.
> > >> > > > >
> > >> > > > >
> > >> > > > > Ok, I see. So I think the goal is to implement something in =
virtio that is
> > >> > > > > functional equivalent to IBM ISM device.
> > >> > > > >
> > >> > > >
> > >> > > > Yes, IBM ISM devices do something similar and it inspired this=
.
> > >> > >
> > >> > > Ok, it would be better to mention this in the cover letter of th=
e next
> > >> > > version. This can ease the reviewers (IBM has some good docs of =
those
> > >> > > from the website).
> > >> > >
> > >> >
> > >> > Yes, we will do it.
> > >>
> > >> Btw, I wonder about the plan to support live migration. E.g do we ne=
ed
> > >> to hot unplug the ism device before the migration then we can fallba=
ck
> > >> to TCP/IP ?
> > >>
> > >
> > >>From the point view of SMC, SMC-R maintains multiple link (RDMA QP), =
it
> > >can live migrate existed connections to new link.
> > >
> > >Currently, yes, for SMC-D.
> >
> > I think Jason means VM live migration from one Host to another. Am I
> > right, Jason ?

Yes.

> >
> > In that case, the share memory from the ISM device is no longer valid,
> > I think we have to hot unplug before the migration to notify SMC that
> > the SMC-D link is no longer usable.
>
> Yes, this is what I mean ;-) SMC-D needs to unplug the device.
>
> > IIUC, SMC-D doesn't support transparently fallback to TCP/IP in this ca=
se
> > now. But I think we could make that happen, since SMC already support l=
ink
> > migration between different RDMA devices.
>
> Yes, currently SMC-D doesn't support migration to another device or
> fallback. And SMC-R supports migration to another link, no fallback.

Ok. I see.

Thanks

>
> Cheers,
> Tony Lu
>
> > Thanks
> >
> > >
> > >Cheers,
> > >Tony Lu
> > >
> > >
> > >> Thanks
> > >>
> > >> >
> > >> > > >
> > >> > > > >
> > >> > > > > > >
> > >> > > > > > > Thanks.
> > >> > > > > > >
> > >> > > > > > SMC is a network protocol which is modeled by shared memor=
y rather than
> > >> > > > > > packet.
> > >> > > > >
> > >> > > > >
> > >> > > > > After reading more SMC from IBM website, I think you meant S=
MC-D here. And I
> > >> > > > > wonder in order to have a complete SMC solution we still nee=
d virtio-ROCE
> > >> > > > > for inter host communcation?
> > >> > > > >
> > >> > > >
> > >> > > > Mostly yes.
> > >> > > >
> > >> > > > SMC-D is the part of whole SMC solution. SMC supports multiple
> > >> > > > underlying device, -D means ISM device, -R means RDMA device. =
The key
> > >> > > > data model is shared memory, SMC uses RDMA (-R) or ISM(-D) to =
*share*
> > >> > > > memory between peers, and it will choose the suitable device o=
n demand
> > >> > > > during handshaking. If there was no suitable device, it would =
fall back
> > >> > > > to TCP. So virtio-ROCE is not required.
> > >> > >
> > >> > > So the commniting peers on the same host we need SMC-D, in the f=
uture
> > >> > > we need to use RDMA to offload the communication among the peers=
 of
> > >> > > different hosts. Then we can get fully transparent offload no ma=
tter
> > >> > > the peer is local or not.
> > >> > >
> > >> >
> > >> > Yes, this is what we want to do.
> > >> >
> > >> > > >
> > >> > > > >
> > >> > > > > >   Actually the basic required interfaces of SMC device are=
:
> > >> > > > > >
> > >> > > > > >    - alloc / free memory region, each connection peer has =
two memory
> > >> > > > > >     regions dynamically for sending and receiving ring buf=
fer.
> > >> > > > > >    - attach / detach memory region, remote attaches local-=
allocated
> > >> > > > > >     sending region as receiving region, vice versa.
> > >> > > > > >    - notify, tell peer to read data and update cursor.
> > >> > > > > >
> > >> > > > > > Then the device can be registered as SMC ISM device. Of co=
urse, SMC
> > >> > > > > > also requires some modification to adapt it.
> > >> > > > >
> > >> > > > >
> > >> > > > > Looking at s390 ism driver it requires other stuffs like vla=
n add/remove or
> > >> > > > > gid query, do we need them as well?
> > >> > > >
> > >> > > > vlan is not required in this use case. ISM uses gid to identif=
ied each
> > >> > > > others, maybe we could implement it in virtio ways.
> > >> > >
> > >> > > I'd suggest adding the codes to register the driver to SMC/ISM i=
n the
> > >> > > next version (instead of a simple procfs hooking). Then people c=
an
> > >> > > easily play or review.
> > >> > >
> > >> >
> > >> > Ok, I will add the codes in the next version.
> > >> >
> > >> > Cheers,
> > >> > Tony Lu
> > >> >
> > >> > > Thanks
> > >> > >
> > >> > > >
> > >> > > > To support virtio-ism smoothly, the interfaces of ISM driver s=
till need
> > >> > > > to be adjusted. I will put it on the table with IBM people.
> > >> > > >
> > >> > > > Cheers,
> > >> > > > Tony Lu
> > >> > > >
> > >> > > > >
> > >> > > > > Thanks
> > >> > > > >
> > >> > > > >
> > >> > > > > >
> > >> > > > > > Cheers,
> > >> > > > > > Tony Lu
> > >> > > > > >
> > >> > > > > > > > Thanks
> > >> > > > > > > >
> > >> > > > > > > > > Thanks.
> > >> > > > > > > > >
> > >> > > > > > > > >
> > >> > > > > > > > > > > How to share the backend with other deivce is an=
other problem.
> > >> > > > > > > > > > Yes, anything that is used for your virito-ism pro=
totype can be used
> > >> > > > > > > > > > for other devices.
> > >> > > > > > > > > >
> > >> > > > > > > > > > > Our goal is to dynamically obtain a piece of mem=
ory to share with other vms.
> > >> > > > > > > > > > So at this level, I don't see the exact difference=
 compared to
> > >> > > > > > > > > > virtio-vhost-user. Let's just focus on the API tha=
t carries on the
> > >> > > > > > > > > > semantic:
> > >> > > > > > > > > >
> > >> > > > > > > > > > - map/unmap
> > >> > > > > > > > > > - permission update
> > >> > > > > > > > > >
> > >> > > > > > > > > > The only missing piece is the per region notificat=
ion.
> > >> > > > > > > > > >
> > >> > > > > > > > > > > In a connection, this memory will be used repeat=
edly. As far as SMC is concerned,
> > >> > > > > > > > > > > it will use it as a ring. Of course, we also nee=
d a notify mechanism.
> > >> > > > > > > > > > >
> > >> > > > > > > > > > > That's what we're aiming for, so we should first=
 discuss whether this
> > >> > > > > > > > > > > requirement is reasonable.
> > >> > > > > > > > > > So unless somebody said "no", it is fine until now=
.
> > >> > > > > > > > > >
> > >> > > > > > > > > > > I think it's a feature currently not supported b=
y
> > >> > > > > > > > > > > other devices specified by the current virtio sp=
ce.
> > >> > > > > > > > > > Probably, but we've already had rfcs for roce and =
vhost-user.
> > >> > > > > > > > > >
> > >> > > > > > > > > > Thanks
> > >> > > > > > > > > >
> > >> > > > > > > > > > > Thanks.
> > >> > > > > > > > > > >
> > >> > > > > > > > > > >
> > >> > > >
> > >> >
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

