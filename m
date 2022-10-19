Return-Path: <virtio-dev-return-10060-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F69498656C
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Oct 2022 09:12:02 +0000 (UTC)
Message-ID: <1666170632.2841902-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 19 Oct 2022 17:10:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666009602.9397366-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
 <1666161802.3034256-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuXBzwfj1=hS2qz6US-dwfVw2jtR-f8z1F9+nNRfUcKzA@mail.gmail.com>
 <90A95AD3-DCC6-474C-A0E6-13347B13A2B3@linux.alibaba.com>
 <20221019082136.GA63658@linux.alibaba.com>
 <CACGkMEuCJhTSAwaVb=8APqFRCLZ7ws_u6gapOUQWKN0DuzhOeg@mail.gmail.com>
In-Reply-To: <CACGkMEuCJhTSAwaVb=8APqFRCLZ7ws_u6gapOUQWKN0DuzhOeg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared memory device
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Gerry <gerry@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, dust.li@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 19 Oct 2022 17:08:29 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Oct 19, 2022 at 4:21 PM Dust Li <dust.li@linux.alibaba.com> wrote=
:
> >
> > On Wed, Oct 19, 2022 at 04:03:42PM +0800, Gerry wrote:
> > >
> > >
> > >> 2022=E5=B9=B410=E6=9C=8819=E6=97=A5 16:01=EF=BC=8CJason Wang <jasowa=
ng@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> > >>
> > >> On Wed, Oct 19, 2022 at 3:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
> > >>>
> > >>> On Tue, 18 Oct 2022 14:54:22 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > >>>> On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> > >>>>>
> > >>>>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > >>>>>> Adding Stefan.
> > >>>>>>
> > >>>>>>
> > >>>>>> On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >>>>>>>
> > >>>>>>> Hello everyone,
> > >>>>>>>
> > >>>>>>> # Background
> > >>>>>>>
> > >>>>>>> Nowadays, there is a common scenario to accelerate communicatio=
n between
> > >>>>>>> different VMs and containers, including light weight virtual ma=
chine based
> > >>>>>>> containers. One way to achieve this is to colocate them on the =
same host.
> > >>>>>>> However, the performance of inter-VM communication through netw=
ork stack is not
> > >>>>>>> optimal and may also waste extra CPU cycles. This scenario has =
been discussed
> > >>>>>>> many times, but still no generic solution available [1] [2] [3]=
.
> > >>>>>>>
> > >>>>>>> With pci-ivshmem + SMC(Shared Memory Communications: [4]) based=
 PoC[5],
> > >>>>>>> We found that by changing the communication channel between VMs=
 from TCP to SMC
> > >>>>>>> with shared memory, we can achieve superior performance for a c=
ommon
> > >>>>>>> socket-based application[5]:
> > >>>>>>>  - latency reduced by about 50%
> > >>>>>>>  - throughput increased by about 300%
> > >>>>>>>  - CPU consumption reduced by about 50%
> > >>>>>>>
> > >>>>>>> Since there is no particularly suitable shared memory managemen=
t solution
> > >>>>>>> matches the need for SMC(See ## Comparison with existing techno=
logy), and virtio
> > >>>>>>> is the standard for communication in the virtualization world, =
we want to
> > >>>>>>> implement a virtio-ism device based on virtio, which can suppor=
t on-demand
> > >>>>>>> memory sharing across VMs, containers or VM-container. To match=
 the needs of SMC,
> > >>>>>>> the virtio-ism device need to support:
> > >>>>>>>
> > >>>>>>> 1. Dynamic provision: shared memory regions are dynamically all=
ocated and
> > >>>>>>>   provisioned.
> > >>>>>>> 2. Multi-region management: the shared memory is divided into r=
egions,
> > >>>>>>>   and a peer may allocate one or more regions from the same sha=
red memory
> > >>>>>>>   device.
> > >>>>>>> 3. Permission control: The permission of each region can be set=
 seperately.
> > >>>>>>
> > >>>>>> Looks like virtio-ROCE
> > >>>>>>
> > >>>>>> https://lore.kernel.org/all/20220511095900.343-1-xieyongji@byted=
ance.com/T/
> > >>>>>>
> > >>>>>> and virtio-vhost-user can satisfy the requirement?
> > >>>>>>
> > >>>>>>>
> > >>>>>>> # Virtio ism device
> > >>>>>>>
> > >>>>>>> ISM devices provide the ability to share memory between differe=
nt guests on a
> > >>>>>>> host. A guest's memory got from ism device can be shared with m=
ultiple peers at
> > >>>>>>> the same time. This shared relationship can be dynamically crea=
ted and released.
> > >>>>>>>
> > >>>>>>> The shared memory obtained from the device is divided into mult=
iple ism regions
> > >>>>>>> for share. ISM device provides a mechanism to notify other ism =
region referrers
> > >>>>>>> of content update events.
> > >>>>>>>
> > >>>>>>> # Usage (SMC as example)
> > >>>>>>>
> > >>>>>>> Maybe there is one of possible use cases:
> > >>>>>>>
> > >>>>>>> 1. SMC calls the interface ism_alloc_region() of the ism driver=
 to return the
> > >>>>>>>   location of a memory region in the PCI space and a token.
> > >>>>>>> 2. The ism driver mmap the memory region and return to SMC with=
 the token
> > >>>>>>> 3. SMC passes the token to the connected peer
> > >>>>>>> 3. the peer calls the ism driver interface ism_attach_region(to=
ken) to
> > >>>>>>>   get the location of the PCI space of the shared memory
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> # About hot plugging of the ism device
> > >>>>>>>
> > >>>>>>>   Hot plugging of devices is a heavier, possibly failed, time-c=
onsuming, and
> > >>>>>>>   less scalable operation. So, we don't plan to support it for =
now.
> > >>>>>>>
> > >>>>>>> # Comparison with existing technology
> > >>>>>>>
> > >>>>>>> ## ivshmem or ivshmem 2.0 of Qemu
> > >>>>>>>
> > >>>>>>>   1. ivshmem 1.0 is a large piece of memory that can be seen by=
 all devices that
> > >>>>>>>   use this VM, so the security is not enough.
> > >>>>>>>
> > >>>>>>>   2. ivshmem 2.0 is a shared memory belonging to a VM that can =
be read-only by all
> > >>>>>>>   other VMs that use the ivshmem 2.0 shared memory device, whic=
h also does not
> > >>>>>>>   meet our needs in terms of security.
> > >>>>>>>
> > >>>>>>> ## vhost-pci and virtiovhostuser
> > >>>>>>>
> > >>>>>>>   Does not support dynamic allocation and therefore not suitabl=
e for SMC.
> > >>>>>>
> > >>>>>> I think this is an implementation issue, we can support VHOST IO=
TLB
> > >>>>>> message then the regions could be added/removed on demand.
> > >>>>>
> > >>>>>
> > >>>>> 1. After the attacker connects with the victim, if the attacker d=
oes not
> > >>>>>   dereference memory, the memory will be occupied under virtiovho=
stuser. In the
> > >>>>>   case of ism devices, the victim can directly release the refere=
nce, and the
> > >>>>>   maliciously referenced region only occupies the attacker's reso=
urces
> > >>>>
> > >>>> Let's define the security boundary here. E.g do we trust the devic=
e or
> > >>>> not? If yes, in the case of virtiovhostuser, can we simple do
> > >>>> VHOST_IOTLB_UNMAP then we can safely release the memory from the
> > >>>> attacker.
> > >>>>
> > >>>>>
> > >>>>> 2. The ism device of a VM can be shared with multiple (1000+) VMs=
 at the same
> > >>>>>   time, which is a challenge for virtiovhostuser
> > >>>>
> > >>>> Please elaborate more the the challenges, anything make
> > >>>> virtiovhostuser different?
> > >>>
> > >>> I understand (please point out any mistakes), one vvu device corres=
ponds to one
> > >>> vm. If we share memory with 1000 vm, do we have 1000 vvu devices?
> > >>
> > >> There could be some misunderstanding here. With 1000 VM, you still
> > >> need 1000 virtio-sim devices I think.
> > >We are trying to achieve one virtio-ism device per vm instead of one v=
irtio-ism device per SMC connection.
>
> I wonder if we need something to identify a virtio-ism device since I
> guess there's still a chance to have multiple virtio-ism device per VM
> (different service chain etc).

Yes, there will be such a situation, a vm has multiple virtio-ism devices.

What exactly do you mean by "identify"?

Thanks.


>
> Thanks
>
> >
> > I think we must achieve this if we want to meet the requirements of SMC=
.
> > In SMC, a SMC socket(Corresponding to a TCP socket) need 2 memory
> > regions(1 for Tx and 1 for Rx). So if we have 1K TCP connections,
> > we'll need 2K share memory regions, and those memory regions are
> > dynamically allocated and freed with the TCP socket.
> >
> > >
> > >>
> > >>>
> > >>>
> > >>>>
> > >>>>>
> > >>>>> 3. The sharing relationship of ism is dynamically increased, and =
virtiovhostuser
> > >>>>>   determines the sharing relationship at startup.
> > >>>>
> > >>>> Not necessarily with IOTLB API?
> > >>>
> > >>> Unlike virtio-vhost-user, which shares the memory of a vm with anot=
her vm, we
> > >>> provide the same memory on the host to two vms. So the implementati=
on of this
> > >>> part will be much simpler. This is why we gave up virtio-vhost-user=
 at the
> > >>> beginning.
> > >>
> > >> Ok, just to make sure we're at the same page. From spec level,
> > >> virtio-vhost-user doesn't (can't) limit the backend to be implemente=
d
> > >> in another VM. So it should be ok to be used for sharing memory
> > >> between a guest and host.
> > >>
> > >> Thanks
> > >>
> > >>>
> > >>> Thanks.
> > >>>
> > >>>
> > >>>>
> > >>>>>
> > >>>>> 4. For security issues, the device under virtiovhostuser may mmap=
 more memory,
> > >>>>>   while ism only maps one region to other devices
> > >>>>
> > >>>> With VHOST_IOTLB_MAP, the map could be done per region.
> > >>>>
> > >>>> Thanks
> > >>>>
> > >>>>>
> > >>>>> Thanks.
> > >>>>>
> > >>>>>>
> > >>>>>> Thanks
> > >>>>>>
> > >>>>>>>
> > >>>>>>> # Design
> > >>>>>>>
> > >>>>>>>   This is a structure diagram based on ism sharing between two =
vms.
> > >>>>>>>
> > >>>>>>>    |-----------------------------------------------------------=
--------------------------------------------------|
> > >>>>>>>    | |------------------------------------------------|       |=
------------------------------------------------| |
> > >>>>>>>    | | Guest                                          |       |=
 Guest                                          | |
> > >>>>>>>    | |                                                |       |=
                                                | |
> > >>>>>>>    | |   ----------------                             |       |=
   ----------------                             | |
> > >>>>>>>    | |   |    driver    |     [M1]   [M2]   [M3]      |       |=
   |    driver    |             [M2]   [M3]     | |
> > >>>>>>>    | |   ----------------       |      |      |       |       |=
   ----------------               |      |      | |
> > >>>>>>>    | |    |cq|                  |map   |map   |map    |       |=
    |cq|                          |map   |map   | |
> > >>>>>>>    | |    |  |                  |      |      |       |       |=
    |  |                          |      |      | |
> > >>>>>>>    | |    |  |                -------------------     |       |=
    |  |                --------------------    | |
> > >>>>>>>    | |----|--|----------------|  device memory  |-----|       |=
----|--|----------------|  device memory   |----| |
> > >>>>>>>    | |    |  |                -------------------     |       |=
    |  |                --------------------    | |
> > >>>>>>>    | |                                |               |       |=
                               |                | |
> > >>>>>>>    | |                                |               |       |=
                               |                | |
> > >>>>>>>    | | Qemu                           |               |       |=
 Qemu                          |                | |
> > >>>>>>>    | |--------------------------------+---------------|       |=
-------------------------------+----------------| |
> > >>>>>>>    |                                  |                        =
                               |                  |
> > >>>>>>>    |                                  |                        =
                               |                  |
> > >>>>>>>    |                                  |------------------------=
------+------------------------|                  |
> > >>>>>>>    |                                                           =
      |                                           |
> > >>>>>>>    |                                                           =
      |                                           |
> > >>>>>>>    |                                                   --------=
------------------                                |
> > >>>>>>>    |                                                    | M1 | =
  | M2 |   | M3 |                                 |
> > >>>>>>>    |                                                   --------=
------------------                                |
> > >>>>>>>    |                                                           =
                                                  |
> > >>>>>>>    | HOST                                                      =
                                                  |
> > >>>>>>>    ------------------------------------------------------------=
---------------------------------------------------
> > >>>>>>>
> > >>>>>>> # POC code
> > >>>>>>>
> > >>>>>>>   Kernel: https://github.com/fengidri/linux-kernel-virtio-ism/c=
ommits/ism
> > >>>>>>>   Qemu:   https://github.com/fengidri/qemu/commits/ism
> > >>>>>>>
> > >>>>>>> If there are any problems, please point them out.
> > >>>>>>>
> > >>>>>>> Hope to hear from you, thank you.
> > >>>>>>>
> > >>>>>>> [1] https://projectacrn.github.io/latest/tutorials/enable_ivshm=
em.html
> > >>>>>>> [2] https://dl.acm.org/doi/10.1145/2847562
> > >>>>>>> [3] https://hal.archives-ouvertes.fr/hal-00368622/document
> > >>>>>>> [4] https://lwn.net/Articles/711071/
> > >>>>>>> [5] https://lore.kernel.org/netdev/20220720170048.20806-1-tonyl=
u@linux.alibaba.com/T/
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> Xuan Zhuo (2):
> > >>>>>>>  Reserve device id for ISM device
> > >>>>>>>  virtio-ism: introduce new device virtio-ism
> > >>>>>>>
> > >>>>>>> content.tex    |   3 +
> > >>>>>>> virtio-ism.tex | 340 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
> > >>>>>>> 2 files changed, 343 insertions(+)
> > >>>>>>> create mode 100644 virtio-ism.tex
> > >>>>>>>
> > >>>>>>> --
> > >>>>>>> 2.32.0.3.g01195cf9f
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> ---------------------------------------------------------------=
------
> > >>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open=
.org
> > >>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-op=
en.org
> > >>>>>>>
> > >>>>>>
> > >>>>>
> > >>>>> -----------------------------------------------------------------=
----
> > >>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.o=
rg
> > >>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open=
.org
> > >>>>>
> > >>>>
> > >>>
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

