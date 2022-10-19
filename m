Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666009602.9397366-1-xuanzhuo@linux.alibaba.com> <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
 <1666161802.3034256-2-xuanzhuo@linux.alibaba.com> <CACGkMEuXBzwfj1=hS2qz6US-dwfVw2jtR-f8z1F9+nNRfUcKzA@mail.gmail.com>
 <90A95AD3-DCC6-474C-A0E6-13347B13A2B3@linux.alibaba.com> <20221019082136.GA63658@linux.alibaba.com>
 <CACGkMEuCJhTSAwaVb=8APqFRCLZ7ws_u6gapOUQWKN0DuzhOeg@mail.gmail.com> <1666170632.2841902-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1666170632.2841902-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Oct 2022 17:15:23 +0800
Message-ID: <CACGkMEuhMgTjP2=i4+trOe8Bwi+ySii8tMkEyzVUu4xCpnWnfA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Gerry <gerry@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, dust.li@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 19, 2022 at 5:12 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Wed, 19 Oct 2022 17:08:29 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Oct 19, 2022 at 4:21 PM Dust Li <dust.li@linux.alibaba.com> wro=
te:
> > >
> > > On Wed, Oct 19, 2022 at 04:03:42PM +0800, Gerry wrote:
> > > >
> > > >
> > > >> 2022=E5=B9=B410=E6=9C=8819=E6=97=A5 16:01=EF=BC=8CJason Wang <jaso=
wang@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> > > >>
> > > >> On Wed, Oct 19, 2022 at 3:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> > > >>>
> > > >>> On Tue, 18 Oct 2022 14:54:22 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >>>> On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > > >>>>>
> > > >>>>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > >>>>>> Adding Stefan.
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > > >>>>>>>
> > > >>>>>>> Hello everyone,
> > > >>>>>>>
> > > >>>>>>> # Background
> > > >>>>>>>
> > > >>>>>>> Nowadays, there is a common scenario to accelerate communicat=
ion between
> > > >>>>>>> different VMs and containers, including light weight virtual =
machine based
> > > >>>>>>> containers. One way to achieve this is to colocate them on th=
e same host.
> > > >>>>>>> However, the performance of inter-VM communication through ne=
twork stack is not
> > > >>>>>>> optimal and may also waste extra CPU cycles. This scenario ha=
s been discussed
> > > >>>>>>> many times, but still no generic solution available [1] [2] [=
3].
> > > >>>>>>>
> > > >>>>>>> With pci-ivshmem + SMC(Shared Memory Communications: [4]) bas=
ed PoC[5],
> > > >>>>>>> We found that by changing the communication channel between V=
Ms from TCP to SMC
> > > >>>>>>> with shared memory, we can achieve superior performance for a=
 common
> > > >>>>>>> socket-based application[5]:
> > > >>>>>>>  - latency reduced by about 50%
> > > >>>>>>>  - throughput increased by about 300%
> > > >>>>>>>  - CPU consumption reduced by about 50%
> > > >>>>>>>
> > > >>>>>>> Since there is no particularly suitable shared memory managem=
ent solution
> > > >>>>>>> matches the need for SMC(See ## Comparison with existing tech=
nology), and virtio
> > > >>>>>>> is the standard for communication in the virtualization world=
, we want to
> > > >>>>>>> implement a virtio-ism device based on virtio, which can supp=
ort on-demand
> > > >>>>>>> memory sharing across VMs, containers or VM-container. To mat=
ch the needs of SMC,
> > > >>>>>>> the virtio-ism device need to support:
> > > >>>>>>>
> > > >>>>>>> 1. Dynamic provision: shared memory regions are dynamically a=
llocated and
> > > >>>>>>>   provisioned.
> > > >>>>>>> 2. Multi-region management: the shared memory is divided into=
 regions,
> > > >>>>>>>   and a peer may allocate one or more regions from the same s=
hared memory
> > > >>>>>>>   device.
> > > >>>>>>> 3. Permission control: The permission of each region can be s=
et seperately.
> > > >>>>>>
> > > >>>>>> Looks like virtio-ROCE
> > > >>>>>>
> > > >>>>>> https://lore.kernel.org/all/20220511095900.343-1-xieyongji@byt=
edance.com/T/
> > > >>>>>>
> > > >>>>>> and virtio-vhost-user can satisfy the requirement?
> > > >>>>>>
> > > >>>>>>>
> > > >>>>>>> # Virtio ism device
> > > >>>>>>>
> > > >>>>>>> ISM devices provide the ability to share memory between diffe=
rent guests on a
> > > >>>>>>> host. A guest's memory got from ism device can be shared with=
 multiple peers at
> > > >>>>>>> the same time. This shared relationship can be dynamically cr=
eated and released.
> > > >>>>>>>
> > > >>>>>>> The shared memory obtained from the device is divided into mu=
ltiple ism regions
> > > >>>>>>> for share. ISM device provides a mechanism to notify other is=
m region referrers
> > > >>>>>>> of content update events.
> > > >>>>>>>
> > > >>>>>>> # Usage (SMC as example)
> > > >>>>>>>
> > > >>>>>>> Maybe there is one of possible use cases:
> > > >>>>>>>
> > > >>>>>>> 1. SMC calls the interface ism_alloc_region() of the ism driv=
er to return the
> > > >>>>>>>   location of a memory region in the PCI space and a token.
> > > >>>>>>> 2. The ism driver mmap the memory region and return to SMC wi=
th the token
> > > >>>>>>> 3. SMC passes the token to the connected peer
> > > >>>>>>> 3. the peer calls the ism driver interface ism_attach_region(=
token) to
> > > >>>>>>>   get the location of the PCI space of the shared memory
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>> # About hot plugging of the ism device
> > > >>>>>>>
> > > >>>>>>>   Hot plugging of devices is a heavier, possibly failed, time=
-consuming, and
> > > >>>>>>>   less scalable operation. So, we don't plan to support it fo=
r now.
> > > >>>>>>>
> > > >>>>>>> # Comparison with existing technology
> > > >>>>>>>
> > > >>>>>>> ## ivshmem or ivshmem 2.0 of Qemu
> > > >>>>>>>
> > > >>>>>>>   1. ivshmem 1.0 is a large piece of memory that can be seen =
by all devices that
> > > >>>>>>>   use this VM, so the security is not enough.
> > > >>>>>>>
> > > >>>>>>>   2. ivshmem 2.0 is a shared memory belonging to a VM that ca=
n be read-only by all
> > > >>>>>>>   other VMs that use the ivshmem 2.0 shared memory device, wh=
ich also does not
> > > >>>>>>>   meet our needs in terms of security.
> > > >>>>>>>
> > > >>>>>>> ## vhost-pci and virtiovhostuser
> > > >>>>>>>
> > > >>>>>>>   Does not support dynamic allocation and therefore not suita=
ble for SMC.
> > > >>>>>>
> > > >>>>>> I think this is an implementation issue, we can support VHOST =
IOTLB
> > > >>>>>> message then the regions could be added/removed on demand.
> > > >>>>>
> > > >>>>>
> > > >>>>> 1. After the attacker connects with the victim, if the attacker=
 does not
> > > >>>>>   dereference memory, the memory will be occupied under virtiov=
hostuser. In the
> > > >>>>>   case of ism devices, the victim can directly release the refe=
rence, and the
> > > >>>>>   maliciously referenced region only occupies the attacker's re=
sources
> > > >>>>
> > > >>>> Let's define the security boundary here. E.g do we trust the dev=
ice or
> > > >>>> not? If yes, in the case of virtiovhostuser, can we simple do
> > > >>>> VHOST_IOTLB_UNMAP then we can safely release the memory from the
> > > >>>> attacker.
> > > >>>>
> > > >>>>>
> > > >>>>> 2. The ism device of a VM can be shared with multiple (1000+) V=
Ms at the same
> > > >>>>>   time, which is a challenge for virtiovhostuser
> > > >>>>
> > > >>>> Please elaborate more the the challenges, anything make
> > > >>>> virtiovhostuser different?
> > > >>>
> > > >>> I understand (please point out any mistakes), one vvu device corr=
esponds to one
> > > >>> vm. If we share memory with 1000 vm, do we have 1000 vvu devices?
> > > >>
> > > >> There could be some misunderstanding here. With 1000 VM, you still
> > > >> need 1000 virtio-sim devices I think.
> > > >We are trying to achieve one virtio-ism device per vm instead of one=
 virtio-ism device per SMC connection.
> >
> > I wonder if we need something to identify a virtio-ism device since I
> > guess there's still a chance to have multiple virtio-ism device per VM
> > (different service chain etc).
>
> Yes, there will be such a situation, a vm has multiple virtio-ism devices=
.
>
> What exactly do you mean by "identify"?

E.g we can differ two virtio-net through mac address, do we need
something similar for ism, or it's completely unncessary (e.g via
token or other) ?

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > I think we must achieve this if we want to meet the requirements of S=
MC.
> > > In SMC, a SMC socket(Corresponding to a TCP socket) need 2 memory
> > > regions(1 for Tx and 1 for Rx). So if we have 1K TCP connections,
> > > we'll need 2K share memory regions, and those memory regions are
> > > dynamically allocated and freed with the TCP socket.
> > >
> > > >
> > > >>
> > > >>>
> > > >>>
> > > >>>>
> > > >>>>>
> > > >>>>> 3. The sharing relationship of ism is dynamically increased, an=
d virtiovhostuser
> > > >>>>>   determines the sharing relationship at startup.
> > > >>>>
> > > >>>> Not necessarily with IOTLB API?
> > > >>>
> > > >>> Unlike virtio-vhost-user, which shares the memory of a vm with an=
other vm, we
> > > >>> provide the same memory on the host to two vms. So the implementa=
tion of this
> > > >>> part will be much simpler. This is why we gave up virtio-vhost-us=
er at the
> > > >>> beginning.
> > > >>
> > > >> Ok, just to make sure we're at the same page. From spec level,
> > > >> virtio-vhost-user doesn't (can't) limit the backend to be implemen=
ted
> > > >> in another VM. So it should be ok to be used for sharing memory
> > > >> between a guest and host.
> > > >>
> > > >> Thanks
> > > >>
> > > >>>
> > > >>> Thanks.
> > > >>>
> > > >>>
> > > >>>>
> > > >>>>>
> > > >>>>> 4. For security issues, the device under virtiovhostuser may mm=
ap more memory,
> > > >>>>>   while ism only maps one region to other devices
> > > >>>>
> > > >>>> With VHOST_IOTLB_MAP, the map could be done per region.
> > > >>>>
> > > >>>> Thanks
> > > >>>>
> > > >>>>>
> > > >>>>> Thanks.
> > > >>>>>
> > > >>>>>>
> > > >>>>>> Thanks
> > > >>>>>>
> > > >>>>>>>
> > > >>>>>>> # Design
> > > >>>>>>>
> > > >>>>>>>   This is a structure diagram based on ism sharing between tw=
o vms.
> > > >>>>>>>
> > > >>>>>>>    |---------------------------------------------------------=
----------------------------------------------------|
> > > >>>>>>>    | |------------------------------------------------|      =
 |------------------------------------------------| |
> > > >>>>>>>    | | Guest                                          |      =
 | Guest                                          | |
> > > >>>>>>>    | |                                                |      =
 |                                                | |
> > > >>>>>>>    | |   ----------------                             |      =
 |   ----------------                             | |
> > > >>>>>>>    | |   |    driver    |     [M1]   [M2]   [M3]      |      =
 |   |    driver    |             [M2]   [M3]     | |
> > > >>>>>>>    | |   ----------------       |      |      |       |      =
 |   ----------------               |      |      | |
> > > >>>>>>>    | |    |cq|                  |map   |map   |map    |      =
 |    |cq|                          |map   |map   | |
> > > >>>>>>>    | |    |  |                  |      |      |       |      =
 |    |  |                          |      |      | |
> > > >>>>>>>    | |    |  |                -------------------     |      =
 |    |  |                --------------------    | |
> > > >>>>>>>    | |----|--|----------------|  device memory  |-----|      =
 |----|--|----------------|  device memory   |----| |
> > > >>>>>>>    | |    |  |                -------------------     |      =
 |    |  |                --------------------    | |
> > > >>>>>>>    | |                                |               |      =
 |                               |                | |
> > > >>>>>>>    | |                                |               |      =
 |                               |                | |
> > > >>>>>>>    | | Qemu                           |               |      =
 | Qemu                          |                | |
> > > >>>>>>>    | |--------------------------------+---------------|      =
 |-------------------------------+----------------| |
> > > >>>>>>>    |                                  |                      =
                                 |                  |
> > > >>>>>>>    |                                  |                      =
                                 |                  |
> > > >>>>>>>    |                                  |----------------------=
--------+------------------------|                  |
> > > >>>>>>>    |                                                         =
        |                                           |
> > > >>>>>>>    |                                                         =
        |                                           |
> > > >>>>>>>    |                                                   ------=
--------------------                                |
> > > >>>>>>>    |                                                    | M1 =
|   | M2 |   | M3 |                                 |
> > > >>>>>>>    |                                                   ------=
--------------------                                |
> > > >>>>>>>    |                                                         =
                                                    |
> > > >>>>>>>    | HOST                                                    =
                                                    |
> > > >>>>>>>    ----------------------------------------------------------=
-----------------------------------------------------
> > > >>>>>>>
> > > >>>>>>> # POC code
> > > >>>>>>>
> > > >>>>>>>   Kernel: https://github.com/fengidri/linux-kernel-virtio-ism=
/commits/ism
> > > >>>>>>>   Qemu:   https://github.com/fengidri/qemu/commits/ism
> > > >>>>>>>
> > > >>>>>>> If there are any problems, please point them out.
> > > >>>>>>>
> > > >>>>>>> Hope to hear from you, thank you.
> > > >>>>>>>
> > > >>>>>>> [1] https://projectacrn.github.io/latest/tutorials/enable_ivs=
hmem.html
> > > >>>>>>> [2] https://dl.acm.org/doi/10.1145/2847562
> > > >>>>>>> [3] https://hal.archives-ouvertes.fr/hal-00368622/document
> > > >>>>>>> [4] https://lwn.net/Articles/711071/
> > > >>>>>>> [5] https://lore.kernel.org/netdev/20220720170048.20806-1-ton=
ylu@linux.alibaba.com/T/
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>> Xuan Zhuo (2):
> > > >>>>>>>  Reserve device id for ISM device
> > > >>>>>>>  virtio-ism: introduce new device virtio-ism
> > > >>>>>>>
> > > >>>>>>> content.tex    |   3 +
> > > >>>>>>> virtio-ism.tex | 340 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> > > >>>>>>> 2 files changed, 343 insertions(+)
> > > >>>>>>> create mode 100644 virtio-ism.tex
> > > >>>>>>>
> > > >>>>>>> --
> > > >>>>>>> 2.32.0.3.g01195cf9f
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>> -------------------------------------------------------------=
--------
> > > >>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-op=
en.org
> > > >>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-=
open.org
> > > >>>>>>>
> > > >>>>>>
> > > >>>>>
> > > >>>>> ---------------------------------------------------------------=
------
> > > >>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open=
.org
> > > >>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-op=
en.org
> > > >>>>>
> > > >>>>
> > > >>>
> > >
> >
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

