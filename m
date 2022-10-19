Return-Path: <gerry@linux.alibaba.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
From: Gerry <gerry@linux.alibaba.com>
In-Reply-To: <CACGkMEuXBzwfj1=hS2qz6US-dwfVw2jtR-f8z1F9+nNRfUcKzA@mail.gmail.com>
Date: Wed, 19 Oct 2022 16:03:42 +0800
Message-Id: <90A95AD3-DCC6-474C-A0E6-13347B13A2B3@linux.alibaba.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666009602.9397366-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
 <1666161802.3034256-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuXBzwfj1=hS2qz6US-dwfVw2jtR-f8z1F9+nNRfUcKzA@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> 2022=E5=B9=B410=E6=9C=8819=E6=97=A5 16:01=EF=BC=8CJason Wang <jasowang@re=
dhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Oct 19, 2022 at 3:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wr=
ote:
>>=20
>> On Tue, 18 Oct 2022 14:54:22 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
>>> On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
>>>>=20
>>>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
>>>>> Adding Stefan.
>>>>>=20
>>>>>=20
>>>>> On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
>>>>>>=20
>>>>>> Hello everyone,
>>>>>>=20
>>>>>> # Background
>>>>>>=20
>>>>>> Nowadays, there is a common scenario to accelerate communication bet=
ween
>>>>>> different VMs and containers, including light weight virtual machine=
 based
>>>>>> containers. One way to achieve this is to colocate them on the same =
host.
>>>>>> However, the performance of inter-VM communication through network s=
tack is not
>>>>>> optimal and may also waste extra CPU cycles. This scenario has been =
discussed
>>>>>> many times, but still no generic solution available [1] [2] [3].
>>>>>>=20
>>>>>> With pci-ivshmem + SMC(Shared Memory Communications: [4]) based PoC[=
5],
>>>>>> We found that by changing the communication channel between VMs from=
 TCP to SMC
>>>>>> with shared memory, we can achieve superior performance for a common
>>>>>> socket-based application[5]:
>>>>>>  - latency reduced by about 50%
>>>>>>  - throughput increased by about 300%
>>>>>>  - CPU consumption reduced by about 50%
>>>>>>=20
>>>>>> Since there is no particularly suitable shared memory management sol=
ution
>>>>>> matches the need for SMC(See ## Comparison with existing technology)=
, and virtio
>>>>>> is the standard for communication in the virtualization world, we wa=
nt to
>>>>>> implement a virtio-ism device based on virtio, which can support on-=
demand
>>>>>> memory sharing across VMs, containers or VM-container. To match the =
needs of SMC,
>>>>>> the virtio-ism device need to support:
>>>>>>=20
>>>>>> 1. Dynamic provision: shared memory regions are dynamically allocate=
d and
>>>>>>   provisioned.
>>>>>> 2. Multi-region management: the shared memory is divided into region=
s,
>>>>>>   and a peer may allocate one or more regions from the same shared m=
emory
>>>>>>   device.
>>>>>> 3. Permission control: The permission of each region can be set sepe=
rately.
>>>>>=20
>>>>> Looks like virtio-ROCE
>>>>>=20
>>>>> https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.=
com/T/
>>>>>=20
>>>>> and virtio-vhost-user can satisfy the requirement?
>>>>>=20
>>>>>>=20
>>>>>> # Virtio ism device
>>>>>>=20
>>>>>> ISM devices provide the ability to share memory between different gu=
ests on a
>>>>>> host. A guest's memory got from ism device can be shared with multip=
le peers at
>>>>>> the same time. This shared relationship can be dynamically created a=
nd released.
>>>>>>=20
>>>>>> The shared memory obtained from the device is divided into multiple =
ism regions
>>>>>> for share. ISM device provides a mechanism to notify other ism regio=
n referrers
>>>>>> of content update events.
>>>>>>=20
>>>>>> # Usage (SMC as example)
>>>>>>=20
>>>>>> Maybe there is one of possible use cases:
>>>>>>=20
>>>>>> 1. SMC calls the interface ism_alloc_region() of the ism driver to r=
eturn the
>>>>>>   location of a memory region in the PCI space and a token.
>>>>>> 2. The ism driver mmap the memory region and return to SMC with the =
token
>>>>>> 3. SMC passes the token to the connected peer
>>>>>> 3. the peer calls the ism driver interface ism_attach_region(token) =
to
>>>>>>   get the location of the PCI space of the shared memory
>>>>>>=20
>>>>>>=20
>>>>>> # About hot plugging of the ism device
>>>>>>=20
>>>>>>   Hot plugging of devices is a heavier, possibly failed, time-consum=
ing, and
>>>>>>   less scalable operation. So, we don't plan to support it for now.
>>>>>>=20
>>>>>> # Comparison with existing technology
>>>>>>=20
>>>>>> ## ivshmem or ivshmem 2.0 of Qemu
>>>>>>=20
>>>>>>   1. ivshmem 1.0 is a large piece of memory that can be seen by all =
devices that
>>>>>>   use this VM, so the security is not enough.
>>>>>>=20
>>>>>>   2. ivshmem 2.0 is a shared memory belonging to a VM that can be re=
ad-only by all
>>>>>>   other VMs that use the ivshmem 2.0 shared memory device, which als=
o does not
>>>>>>   meet our needs in terms of security.
>>>>>>=20
>>>>>> ## vhost-pci and virtiovhostuser
>>>>>>=20
>>>>>>   Does not support dynamic allocation and therefore not suitable for=
 SMC.
>>>>>=20
>>>>> I think this is an implementation issue, we can support VHOST IOTLB
>>>>> message then the regions could be added/removed on demand.
>>>>=20
>>>>=20
>>>> 1. After the attacker connects with the victim, if the attacker does n=
ot
>>>>   dereference memory, the memory will be occupied under virtiovhostuse=
r. In the
>>>>   case of ism devices, the victim can directly release the reference, =
and the
>>>>   maliciously referenced region only occupies the attacker's resources
>>>=20
>>> Let's define the security boundary here. E.g do we trust the device or
>>> not? If yes, in the case of virtiovhostuser, can we simple do
>>> VHOST_IOTLB_UNMAP then we can safely release the memory from the
>>> attacker.
>>>=20
>>>>=20
>>>> 2. The ism device of a VM can be shared with multiple (1000+) VMs at t=
he same
>>>>   time, which is a challenge for virtiovhostuser
>>>=20
>>> Please elaborate more the the challenges, anything make
>>> virtiovhostuser different?
>>=20
>> I understand (please point out any mistakes), one vvu device corresponds=
 to one
>> vm. If we share memory with 1000 vm, do we have 1000 vvu devices?
>=20
> There could be some misunderstanding here. With 1000 VM, you still
> need 1000 virtio-sim devices I think.
We are trying to achieve one virtio-ism device per vm instead of one virtio=
-ism device per SMC connection.

>=20
>>=20
>>=20
>>>=20
>>>>=20
>>>> 3. The sharing relationship of ism is dynamically increased, and virti=
ovhostuser
>>>>   determines the sharing relationship at startup.
>>>=20
>>> Not necessarily with IOTLB API?
>>=20
>> Unlike virtio-vhost-user, which shares the memory of a vm with another v=
m, we
>> provide the same memory on the host to two vms. So the implementation of=
 this
>> part will be much simpler. This is why we gave up virtio-vhost-user at t=
he
>> beginning.
>=20
> Ok, just to make sure we're at the same page. From spec level,
> virtio-vhost-user doesn't (can't) limit the backend to be implemented
> in another VM. So it should be ok to be used for sharing memory
> between a guest and host.
>=20
> Thanks
>=20
>>=20
>> Thanks.
>>=20
>>=20
>>>=20
>>>>=20
>>>> 4. For security issues, the device under virtiovhostuser may mmap more=
 memory,
>>>>   while ism only maps one region to other devices
>>>=20
>>> With VHOST_IOTLB_MAP, the map could be done per region.
>>>=20
>>> Thanks
>>>=20
>>>>=20
>>>> Thanks.
>>>>=20
>>>>>=20
>>>>> Thanks
>>>>>=20
>>>>>>=20
>>>>>> # Design
>>>>>>=20
>>>>>>   This is a structure diagram based on ism sharing between two vms.
>>>>>>=20
>>>>>>    |----------------------------------------------------------------=
---------------------------------------------|
>>>>>>    | |------------------------------------------------|       |-----=
-------------------------------------------| |
>>>>>>    | | Guest                                          |       | Gues=
t                                          | |
>>>>>>    | |                                                |       |     =
                                           | |
>>>>>>    | |   ----------------                             |       |   --=
--------------                             | |
>>>>>>    | |   |    driver    |     [M1]   [M2]   [M3]      |       |   | =
   driver    |             [M2]   [M3]     | |
>>>>>>    | |   ----------------       |      |      |       |       |   --=
--------------               |      |      | |
>>>>>>    | |    |cq|                  |map   |map   |map    |       |    |=
cq|                          |map   |map   | |
>>>>>>    | |    |  |                  |      |      |       |       |    |=
  |                          |      |      | |
>>>>>>    | |    |  |                -------------------     |       |    |=
  |                --------------------    | |
>>>>>>    | |----|--|----------------|  device memory  |-----|       |----|=
--|----------------|  device memory   |----| |
>>>>>>    | |    |  |                -------------------     |       |    |=
  |                --------------------    | |
>>>>>>    | |                                |               |       |     =
                          |                | |
>>>>>>    | |                                |               |       |     =
                          |                | |
>>>>>>    | | Qemu                           |               |       | Qemu=
                          |                | |
>>>>>>    | |--------------------------------+---------------|       |-----=
--------------------------+----------------| |
>>>>>>    |                                  |                             =
                          |                  |
>>>>>>    |                                  |                             =
                          |                  |
>>>>>>    |                                  |-----------------------------=
-+------------------------|                  |
>>>>>>    |                                                                =
 |                                           |
>>>>>>    |                                                                =
 |                                           |
>>>>>>    |                                                   -------------=
-------------                                |
>>>>>>    |                                                    | M1 |   | M=
2 |   | M3 |                                 |
>>>>>>    |                                                   -------------=
-------------                                |
>>>>>>    |                                                                =
                                             |
>>>>>>    | HOST                                                           =
                                             |
>>>>>>    -----------------------------------------------------------------=
----------------------------------------------
>>>>>>=20
>>>>>> # POC code
>>>>>>=20
>>>>>>   Kernel: https://github.com/fengidri/linux-kernel-virtio-ism/commit=
s/ism
>>>>>>   Qemu:   https://github.com/fengidri/qemu/commits/ism
>>>>>>=20
>>>>>> If there are any problems, please point them out.
>>>>>>=20
>>>>>> Hope to hear from you, thank you.
>>>>>>=20
>>>>>> [1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.ht=
ml
>>>>>> [2] https://dl.acm.org/doi/10.1145/2847562
>>>>>> [3] https://hal.archives-ouvertes.fr/hal-00368622/document
>>>>>> [4] https://lwn.net/Articles/711071/
>>>>>> [5] https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@lin=
ux.alibaba.com/T/
>>>>>>=20
>>>>>>=20
>>>>>> Xuan Zhuo (2):
>>>>>>  Reserve device id for ISM device
>>>>>>  virtio-ism: introduce new device virtio-ism
>>>>>>=20
>>>>>> content.tex    |   3 +
>>>>>> virtio-ism.tex | 340 +++++++++++++++++++++++++++++++++++++++++++++++=
++
>>>>>> 2 files changed, 343 insertions(+)
>>>>>> create mode 100644 virtio-ism.tex
>>>>>>=20
>>>>>> --
>>>>>> 2.32.0.3.g01195cf9f
>>>>>>=20
>>>>>>=20
>>>>>> --------------------------------------------------------------------=
-
>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.or=
g
>>>>>>=20
>>>>>=20
>>>>=20
>>>> ---------------------------------------------------------------------
>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>=20
>>>=20
>>=20

