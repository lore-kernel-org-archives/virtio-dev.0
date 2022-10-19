Return-Path: <gerry@linux.alibaba.com>
From: Gerry <gerry@linux.alibaba.com>
Message-Id: <ED4D022B-081B-4C7B-99E8-6ABCCC9A3CB4@linux.alibaba.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Date: Wed, 19 Oct 2022 13:29:32 +0800
In-Reply-To: <361c918e-b628-2428-2219-e2fa58ce3645@redhat.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666009602.9397366-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
 <F492EC50-9477-45F9-891A-E2B662F0B377@linux.alibaba.com>
 <361c918e-b628-2428-2219-e2fa58ce3645@redhat.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_235BC977-D379-4BFA-A2EC-F3DC7FB5D296"
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_235BC977-D379-4BFA-A2EC-F3DC7FB5D296
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2022=E5=B9=B410=E6=9C=8819=E6=97=A5 11:55=EF=BC=8CJason Wang <jasowang@re=
dhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> =E5=9C=A8 2022/10/18 16:33, Gerry =E5=86=99=E9=81=93:
>>=20
>>=20
>>> 2022=E5=B9=B410=E6=9C=8818=E6=97=A5 14:54=EF=BC=8CJason Wang <jasowang@=
redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
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
>> Thanks, Jason:)
>> In our the design, there are several roles involved:
>> 1) a virtio-ism-smc front-end driver
>> 2) a Virtio-ism backend device driver and its associated vmm
>> 3) a global device manager
>> 4) a group of remote/peer virtio-ism backend devices/vmms
>> 5) a group of remote/peer virtio-ism-smc front-end drivers
>>=20
>> Among which , we treat 1, 2 and 3 as trusted, 4 and 5 as untrusted.
>=20
>=20
> It looks to me VIRTIO_ISM_PERM_MANAGE violates what you've described here=
. E.g what happens if 1 grant this permission to 5?

My mistake, missed some background information.
We split the communication into control plain and data plain. The above thr=
ead model is for control plain. Once a peer has been granted permissions to=
 access a memory region, it becomes trusted to read/write the memory region=
.

>=20
>=20
>> Because 4 and 5 are trusted, we can=E2=80=99t guarantee that IOTLB Inval=
idate requests have been executed as expected.
>=20
>=20
> Interesting, I wonder how this is guaranteed by ISM. Anything that can wo=
rk for ISM but not IOTLB? Note that the only difference for me is the devic=
e API. We can hook anything that works for ISM to IOTLB.
The difference is who is the resource owner.
For IOTLB based design, guest vm is the resource owner, so it could only re=
claim a shared memory region from peers.
For our design, the device manager is the resource owner, guest vm allocate=
/free memory region from the device manager. So for each SMC connection, a =
new memory region is allocated/freed, a memory region won=E2=80=99t be reus=
ed for SMCs connections with different (local, peer) pairs.

>=20
>=20
>> Say when disconnecting an SMC connection, a malicious peer may ignore th=
e IOTLB invalidation request and keep access the shared memory region.
>>=20
>> We have considered the IOTLB based design but encountered several issues=
:
>> 1) It depends on the way to provision guest vm memory. We need a memory =
resource descriptor to support vhost-user IOTLB messages, thus can=E2=80=99=
t support anonymous memory based vm.
>=20
>=20
> Hypervisor (Qemu) is free to hook IOTLB message to any kind of memory bac=
kend, isn't? E.g Qemu can choose to implement IOTLB by its own instead of f=
orwarding it to another VM.
A memory resource file descriptor is needed to share a memory region among =
VMs. If the guest memory is provisioned by anonymous mapped memory, it can=
=E2=80=99t be shared to other VMs.
In other words, vhost may work with process virtual address, ghost-user alw=
ays works with file descriptors. =20

>=20
>=20
>> 2) Lack of fine-grain access control of memory resource descriptor. When=
 send a memory resource descriptor to an untrusted peer, we can=E2=80=99t e=
nforce region based access control. Memfd supports file level seal operatio=
ns, but still lack of region based permission control. Hugetlbfs based fd d=
oesn=E2=80=99t support seal at all.
>=20
>=20
> So in the above, you said 4 and 5 are untrusted. If yes how you can enfor=
ce regioned based access control (the memory is still mapped by the untrsut=
ed VMM)? And again, virtio-vhost-user is not limited to memfd/hugetlbfs, it=
 can do want you've done in your protoype (hooking to /dev/shm).
Let=E2=80=99s take an example. Say vmm provisions 1GB memory to guest A thr=
ough a memfd, among which 1MB is allocated by guest A as shared memory and =
want to share it with vm B.
We lack of technologies to share the memfd to guest B and restrict guest B =
to only access the shared 1MB region.=20

>=20
>=20
>> 3) Lack of reliable way to reclaim granted access permissions from untru=
sted peers, as stated above.
>=20
>=20
> It would be better to explain how this "reclaim" works.
>=20
>=20
>> 4) How implement resource accounting. Say a vm has shared some memory re=
gions from peers, and those peers exited unexpectedly, then those shared me=
mory will be accounted to the victim vm, and may cause unexpected OOM.
>>=20
>> Based on the above consideration, we adopted another design and introduc=
ed the device manager to solve above issues:
>> 1) the device manager is the owner of memory buffers.
>=20
>=20
> I don't see the definition "device manager" in your proposal, this needs =
to be clarified in both the spec and the changelog or the cover letter.
We will add the description about =E2=80=9Cdevice manager=E2=80=9D in next =
version.

>=20
>=20
>> 2) the device manager creates a memfd for each memory buffer/region, and=
 configure SEALs according to requested access permissions.
>=20
>=20
> Ok, but this seems not what you've implemented in your qemu prototype?
Not yet, we are still working on it.
BTW, is rust/golang based prototype acceptable to Qemu community? Or it mus=
t be written in C?

>=20
>=20
>> 3) When a guest vm reclaims a shared memory buffer, the device manager w=
ill provision a new memfd to the guest vm.
>=20
>=20
> How can this be done for the untrusted peers?
Please refer to above explanations:)

>=20
>=20
>> And it will take the responsibility to reclaim the old buffer from peer =
and eventually release the old buffer.
>> 4) Simplify the control communication channel. Every guest vm only needs=
 to talk with the device manager and no need to discover and communicate wi=
th other peers.
>=20
>=20
> Not sure but it's better not mandate any model in the application layer.
Made another mistake here, it should be stated as

Every backend device driver only needs to talk with the device manager and =
no need to discover and communicate with other peers.

It may help to give more information about the design goal we want to achie=
ve:
1) extend pci-ivshmem v1/v2 to support more complex usage scenarios like SM=
C.
2) virtio-ism is a generic shmem device and should support pci-ivshmem v1/v=
2 usage scenarios.=20
3) SMC is the first/example usage scenario.
4) support communications among vm<=E2=80=94>vm, vm<=E2=80=94>run container=
, runC container<=E2=80=94>runC container.=20

Design goal 4 forces us to design virtio-ism instead of pci-ivshmem v2/v3.=
=20
The virtio/vDPA/vDUSE stack provides us a perfect way to implement userspac=
e shmem device to support runC containers.
And currently there=E2=80=99s no way to emulate PCI devices in userspace.=
=20


>=20
> Thanks
>=20
>=20
>>=20
>> Thanks,
>> Gerry
>>=20
>>>=20
>>>>=20
>>>> 2. The ism device of a VM can be shared with multiple (1000+) VMs at t=
he same
>>>>   time, which is a challenge for virtiovhostuser
>>>=20
>>> Please elaborate more the the challenges, anything make
>>> virtiovhostuser different?
>>>=20
>>>>=20
>>>> 3. The sharing relationship of ism is dynamically increased, and virti=
ovhostuser
>>>>   determines the sharing relationship at startup.
>>>=20
>>> Not necessarily with IOTLB API?
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
>>>>>>   Qemu: https://github.com/fengidri/qemu/commits/ism
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
>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org =
<mailto:virtio-dev-unsubscribe@lists.oasis-open.org> <mailto:virtio-dev-uns=
ubscribe@lists.oasis-open.org <mailto:virtio-dev-unsubscribe@lists.oasis-op=
en.org>>
>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.or=
g <mailto:virtio-dev-help@lists.oasis-open.org> <mailto:virtio-dev-help@lis=
ts.oasis-open.org <mailto:virtio-dev-help@lists.oasis-open.org>>
>>>>>>=20
>>>>>=20
>>>>=20
>>>> ---------------------------------------------------------------------
>>>> To unsubscribe, e-mail:virtio-dev-unsubscribe@lists.oasis-open.org <ma=
ilto:virtio-dev-unsubscribe@lists.oasis-open.org>
>>>> For additional commands, e-mail:virtio-dev-help@lists.oasis-open.org <=
mailto:virtio-dev-help@lists.oasis-open.org>

--Apple-Mail=_235BC977-D379-4BFA-A2EC-F3DC7FB5D296
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">2022=E5=B9=B4=
10=E6=9C=8819=E6=97=A5 11:55=EF=BC=8CJason Wang &lt;<a href=3D"mailto:jasow=
ang@redhat.com" class=3D"">jasowang@redhat.com</a>&gt; =E5=86=99=E9=81=93=
=EF=BC=9A</div><br class=3D"Apple-interchange-newline"><div class=3D""><met=
a charset=3D"UTF-8" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: 400; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span st=
yle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none; float: none; display: inline !important;" class=3D"">=E5=
=9C=A8 2022/10/18 16:33, Gerry =E5=86=99=E9=81=93:</span><br style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica=
; font-size: 18px; font-style: normal; font-variant-caps: normal; font-weig=
ht: 400; letter-spacing: normal; orphans: auto; text-align: start; text-ind=
ent: 0px; text-transform: none; white-space: normal; widows: auto; word-spa=
cing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br class=3D""><br class=3D""><blockquot=
e type=3D"cite" class=3D"">2022=E5=B9=B410=E6=9C=8818=E6=97=A5 14:54=EF=BC=
=8CJason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" class=3D"">jasowan=
g@redhat.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A<br class=3D""><br class=3D=
"">On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo=
@linux.alibaba.com" class=3D"">xuanzhuo@linux.alibaba.com</a>&gt; wrote:<br=
 class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">On Mon, 17 =
Oct 2022 16:17:31 +0800, Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.c=
om" class=3D"">jasowang@redhat.com</a>&gt; wrote:<br class=3D""><blockquote=
 type=3D"cite" class=3D"">Adding Stefan.<br class=3D""><br class=3D""><br c=
lass=3D"">On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo &lt;<a href=3D"mailto:x=
uanzhuo@linux.alibaba.com" class=3D"">xuanzhuo@linux.alibaba.com</a>&gt; wr=
ote:<br class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Hell=
o everyone,<br class=3D""><br class=3D""># Background<br class=3D""><br cla=
ss=3D"">Nowadays, there is a common scenario to accelerate communication be=
tween<br class=3D"">different VMs and containers, including light weight vi=
rtual machine based<br class=3D"">containers. One way to achieve this is to=
 colocate them on the same host.<br class=3D"">However, the performance of =
inter-VM communication through network stack is not<br class=3D"">optimal a=
nd may also waste extra CPU cycles. This scenario has been discussed<br cla=
ss=3D"">many times, but still no generic solution available [1] [2] [3].<br=
 class=3D""><br class=3D"">With pci-ivshmem + SMC(Shared Memory Communicati=
ons: [4]) based PoC[5],<br class=3D"">We found that by changing the communi=
cation channel between VMs from TCP to SMC<br class=3D"">with shared memory=
, we can achieve superior performance for a common<br class=3D"">socket-bas=
ed application[5]:<br class=3D"">&nbsp;- latency reduced by about 50%<br cl=
ass=3D"">&nbsp;- throughput increased by about 300%<br class=3D"">&nbsp;- C=
PU consumption reduced by about 50%<br class=3D""><br class=3D"">Since ther=
e is no particularly suitable shared memory management solution<br class=3D=
"">matches the need for SMC(See ## Comparison with existing technology), an=
d virtio<br class=3D"">is the standard for communication in the virtualizat=
ion world, we want to<br class=3D"">implement a virtio-ism device based on =
virtio, which can support on-demand<br class=3D"">memory sharing across VMs=
, containers or VM-container. To match the needs of SMC,<br class=3D"">the =
virtio-ism device need to support:<br class=3D""><br class=3D"">1. Dynamic =
provision: shared memory regions are dynamically allocated and<br class=3D"=
">&nbsp;&nbsp;provisioned.<br class=3D"">2. Multi-region management: the sh=
ared memory is divided into regions,<br class=3D"">&nbsp;&nbsp;and a peer m=
ay allocate one or more regions from the same shared memory<br class=3D"">&=
nbsp;&nbsp;device.<br class=3D"">3. Permission control: The permission of e=
ach region can be set seperately.<br class=3D""></blockquote><br class=3D""=
>Looks like virtio-ROCE<br class=3D""><br class=3D""><a href=3D"https://lor=
e.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/" class=3D"=
">https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/=
T/</a><br class=3D""><br class=3D"">and virtio-vhost-user can satisfy the r=
equirement?<br class=3D""><br class=3D""><blockquote type=3D"cite" class=3D=
""><br class=3D""># Virtio ism device<br class=3D""><br class=3D"">ISM devi=
ces provide the ability to share memory between different guests on a<br cl=
ass=3D"">host. A guest's memory got from ism device can be shared with mult=
iple peers at<br class=3D"">the same time. This shared relationship can be =
dynamically created and released.<br class=3D""><br class=3D"">The shared m=
emory obtained from the device is divided into multiple ism regions<br clas=
s=3D"">for share. ISM device provides a mechanism to notify other ism regio=
n referrers<br class=3D"">of content update events.<br class=3D""><br class=
=3D""># Usage (SMC as example)<br class=3D""><br class=3D"">Maybe there is =
one of possible use cases:<br class=3D""><br class=3D"">1. SMC calls the in=
terface ism_alloc_region() of the ism driver to return the<br class=3D"">&n=
bsp;&nbsp;location of a memory region in the PCI space and a token.<br clas=
s=3D"">2. The ism driver mmap the memory region and return to SMC with the =
token<br class=3D"">3. SMC passes the token to the connected peer<br class=
=3D"">3. the peer calls the ism driver interface ism_attach_region(token) t=
o<br class=3D"">&nbsp;&nbsp;get the location of the PCI space of the shared=
 memory<br class=3D""><br class=3D""><br class=3D""># About hot plugging of=
 the ism device<br class=3D""><br class=3D"">&nbsp;&nbsp;Hot plugging of de=
vices is a heavier, possibly failed, time-consuming, and<br class=3D"">&nbs=
p;&nbsp;less scalable operation. So, we don't plan to support it for now.<b=
r class=3D""><br class=3D""># Comparison with existing technology<br class=
=3D""><br class=3D"">## ivshmem or ivshmem 2.0 of Qemu<br class=3D""><br cl=
ass=3D"">&nbsp;&nbsp;1. ivshmem 1.0 is a large piece of memory that can be =
seen by all devices that<br class=3D"">&nbsp;&nbsp;use this VM, so the secu=
rity is not enough.<br class=3D""><br class=3D"">&nbsp;&nbsp;2. ivshmem 2.0=
 is a shared memory belonging to a VM that can be read-only by all<br class=
=3D"">&nbsp;&nbsp;other VMs that use the ivshmem 2.0 shared memory device, =
which also does not<br class=3D"">&nbsp;&nbsp;meet our needs in terms of se=
curity.<br class=3D""><br class=3D"">## vhost-pci and virtiovhostuser<br cl=
ass=3D""><br class=3D"">&nbsp;&nbsp;Does not support dynamic allocation and=
 therefore not suitable for SMC.<br class=3D""></blockquote><br class=3D"">=
I think this is an implementation issue, we can support VHOST IOTLB<br clas=
s=3D"">message then the regions could be added/removed on demand.<br class=
=3D""></blockquote><br class=3D""><br class=3D"">1. After the attacker conn=
ects with the victim, if the attacker does not<br class=3D"">&nbsp;&nbsp;de=
reference memory, the memory will be occupied under virtiovhostuser. In the=
<br class=3D"">&nbsp;&nbsp;case of ism devices, the victim can directly rel=
ease the reference, and the<br class=3D"">&nbsp;&nbsp;maliciously reference=
d region only occupies the attacker's resources<br class=3D""></blockquote>=
<br class=3D"">Let's define the security boundary here. E.g do we trust the=
 device or<br class=3D"">not? If yes, in the case of virtiovhostuser, can w=
e simple do<br class=3D"">VHOST_IOTLB_UNMAP then we can safely release the =
memory from the<br class=3D"">attacker.<br class=3D""></blockquote>Thanks, =
Jason:)<br class=3D"">In our the design, there are several roles involved:<=
br class=3D"">1) a virtio-ism-smc front-end driver<br class=3D"">2) a Virti=
o-ism backend device driver and its associated vmm<br class=3D"">3) a globa=
l device manager<br class=3D"">4) a group of remote/peer virtio-ism backend=
 devices/vmms<br class=3D"">5) a group of remote/peer virtio-ism-smc front-=
end drivers<br class=3D""><br class=3D"">Among which , we treat 1, 2 and 3 =
as trusted, 4 and 5 as untrusted.<br class=3D""></blockquote><br style=3D"c=
aret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-sty=
le: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: no=
rmal; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorati=
on: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"ca=
ret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-styl=
e: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: nor=
mal; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoratio=
n: none; float: none; display: inline !important;" class=3D"">It looks to m=
e VIRTIO_ISM_PERM_MANAGE violates what you've described here. E.g what happ=
ens if 1 grant this permission to 5?</span><br style=3D"caret-color: rgb(0,=
 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-v=
ariant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""></div></blockquote><div><br class=3D""></div><div>My mistake, missed =
some background information.</div><div>We split the communication into cont=
rol plain and data plain. The above thread model is for control plain. Once=
 a peer has been granted permissions to access a memory region, it becomes =
trusted to read/write the memory region.</div><br class=3D""><blockquote ty=
pe=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; font-varia=
nt-caps: normal; font-weight: 400; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">=
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; lett=
er-spacing: normal; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 text-decoration: none;" class=3D""><blockquote type=3D"cite" style=3D"font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; wido=
ws: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-s=
troke-width: 0px; text-decoration: none;" class=3D"">Because 4 and 5 are tr=
usted, we can=E2=80=99t guarantee that IOTLB Invalidate requests have been =
executed as expected.<br class=3D""></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-a=
lign: start; text-indent: 0px; text-transform: none; white-space: normal; w=
ord-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" c=
lass=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: r=
gb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; f=
ont-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; flo=
at: none; display: inline !important;" class=3D"">Interesting, I wonder how=
 this is guaranteed by ISM. Anything that can work for ISM but not IOTLB? N=
ote that the only difference for me is the device API. We can hook anything=
 that works for ISM to IOTLB.</span><br style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-=
caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""></d=
iv></blockquote><div>The difference is who is the resource owner.</div><div=
>For IOTLB based design, guest vm is the resource owner, so it could only r=
eclaim a shared memory region from peers.</div><div>For our design, the dev=
ice manager is the resource owner, guest vm allocate/free memory region fro=
m the device manager. So for each SMC connection, a new memory region is al=
located/freed, a memory region won=E2=80=99t be reused for SMCs connections=
 with different (local, peer) pairs.</div><br class=3D""><blockquote type=
=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 18px; font-style: normal; font-variant=
-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start;=
 text-indent: 0px; text-transform: none; white-space: normal; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><b=
r style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none;" class=3D""><blockquote type=3D"cite" style=3D"font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align:=
 start; text-indent: 0px; text-transform: none; white-space: normal; widows=
: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-str=
oke-width: 0px; text-decoration: none;" class=3D"">Say when disconnecting a=
n SMC connection, a malicious peer may ignore the IOTLB invalidation reques=
t and keep access the shared memory region.<br class=3D""><br class=3D"">We=
 have considered the IOTLB based design but encountered several issues:<br =
class=3D"">1) It depends on the way to provision guest vm memory. We need a=
 memory resource descriptor to support vhost-user IOTLB messages, thus can=
=E2=80=99t support anonymous memory based vm.<br class=3D""></blockquote><b=
r style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 18px; font-style: normal; font-variant-ca=
ps: normal; font-weight: 400; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span=
 style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18p=
x; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-=
spacing: normal; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; te=
xt-decoration: none; float: none; display: inline !important;" class=3D"">H=
ypervisor (Qemu) is free to hook IOTLB message to any kind of memory backen=
d, isn't? E.g Qemu can choose to implement IOTLB by its own instead of forw=
arding it to another VM.</span><br style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: 400; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""></div></=
blockquote><div>A memory resource file descriptor is needed to share a memo=
ry region among VMs. If the guest memory is provisioned by anonymous mapped=
 memory, it can=E2=80=99t be shared to other VMs.</div><div>In other words,=
 vhost may work with process virtual address, ghost-user always works with =
file descriptors. &nbsp;</div><div><br class=3D""></div><blockquote type=3D=
"cite" class=3D""><div class=3D""><br style=3D"caret-color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 18px; font-style: normal; font-variant-ca=
ps: normal; font-weight: 400; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px;=
 font-style: normal; font-variant-caps: normal; font-weight: 400; letter-sp=
acing: normal; text-align: start; text-indent: 0px; text-transform: none; w=
hite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text=
-decoration: none;" class=3D""><blockquote type=3D"cite" style=3D"font-fami=
ly: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; widows: a=
uto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D"">2) Lack of fine-grain acces=
s control of memory resource descriptor. When send a memory resource descri=
ptor to an untrusted peer, we can=E2=80=99t enforce region based access con=
trol. Memfd supports file level seal operations, but still lack of region b=
ased permission control. Hugetlbfs based fd doesn=E2=80=99t support seal at=
 all.<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); fo=
nt-family: Helvetica; font-size: 18px; font-style: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br st=
yle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: 400; letter-spacing: normal; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; text-decoration: none; float: none; displa=
y: inline !important;" class=3D"">So in the above, you said 4 and 5 are unt=
rusted. If yes how you can enforce regioned based access control (the memor=
y is still mapped by the untrsuted VMM)? And again, virtio-vhost-user is no=
t limited to memfd/hugetlbfs, it can do want you've done in your protoype (=
hooking to /dev/shm).</span><br style=3D"caret-color: rgb(0, 0, 0); font-fa=
mily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: no=
rmal; font-weight: 400; letter-spacing: normal; text-align: start; text-ind=
ent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -we=
bkit-text-stroke-width: 0px; text-decoration: none;" class=3D""></div></blo=
ckquote><div>Let=E2=80=99s take an example. Say vmm provisions 1GB memory t=
o guest A through a memfd, among which 1MB is allocated by guest A as share=
d memory and want to share it with vm B.</div><div>We lack of technologies =
to share the memfd to guest B and restrict guest B to only access the share=
d 1MB region.&nbsp;</div><br class=3D""><blockquote type=3D"cite" class=3D"=
"><div class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helv=
etica; font-size: 18px; font-style: normal; font-variant-caps: normal; font=
-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-=
stroke-width: 0px; text-decoration: none;" class=3D""><br style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: non=
e;" class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; widows: auto; word-spacin=
g: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; tex=
t-decoration: none;" class=3D"">3) Lack of reliable way to reclaim granted =
access permissions from untrusted peers, as stated above.<br class=3D""></b=
lockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb=
(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" clas=
s=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
400; letter-spacing: normal; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wi=
dth: 0px; text-decoration: none; float: none; display: inline !important;" =
class=3D"">It would be better to explain how this "reclaim" works.</span><b=
r style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 18px; font-style: normal; font-variant-ca=
ps: normal; font-weight: 400; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px;=
 font-style: normal; font-variant-caps: normal; font-weight: 400; letter-sp=
acing: normal; text-align: start; text-indent: 0px; text-transform: none; w=
hite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text=
-decoration: none;" class=3D""><blockquote type=3D"cite" style=3D"font-fami=
ly: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; widows: a=
uto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D"">4) How implement resource a=
ccounting. Say a vm has shared some memory regions from peers, and those pe=
ers exited unexpectedly, then those shared memory will be accounted to the =
victim vm, and may cause unexpected OOM.<br class=3D""><br class=3D"">Based=
 on the above consideration, we adopted another design and introduced the d=
evice manager to solve above issues:<br class=3D"">1) the device manager is=
 the owner of memory buffers.<br class=3D""></blockquote><br style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helv=
etica; font-size: 18px; font-style: normal; font-variant-caps: normal; font=
-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-=
stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal;=
 text-align: start; text-indent: 0px; text-transform: none; white-space: no=
rmal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: n=
one; float: none; display: inline !important;" class=3D"">I don't see the d=
efinition "device manager" in your proposal, this needs to be clarified in =
both the spec and the changelog or the cover letter.</span><br style=3D"car=
et-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style=
: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D""></div></blockquote><div>We will add the description abo=
ut =E2=80=9Cdevice manager=E2=80=9D in next version.</div><br class=3D""><b=
lockquote type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"=
 class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica;=
 font-size: 18px; font-style: normal; font-variant-caps: normal; font-weigh=
t: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D""><blockquote type=3D"cite" s=
tyle=3D"font-family: Helvetica; font-size: 18px; font-style: normal; font-v=
ariant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: aut=
o; text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -w=
ebkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">2) the dev=
ice manager creates a memfd for each memory buffer/region, and configure SE=
ALs according to requested access permissions.<br class=3D""></blockquote><=
br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 1=
8px; font-style: normal; font-variant-caps: normal; font-weight: 400; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><spa=
n style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none; float: none; display: inline !important;" class=3D"">=
Ok, but this seems not what you've implemented in your qemu prototype?</spa=
n><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 18px; font-style: normal; font-variant-caps: normal; font-weight: 400; le=
tter-spacing: normal; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0p=
x; text-decoration: none;" class=3D""></div></blockquote>Not yet, we are st=
ill working on it.</div><div>BTW, is rust/golang based prototype acceptable=
 to Qemu community? Or it must be written in C?</div><div><br class=3D""><b=
lockquote type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"=
 class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica;=
 font-size: 18px; font-style: normal; font-variant-caps: normal; font-weigh=
t: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D""><blockquote type=3D"cite" s=
tyle=3D"font-family: Helvetica; font-size: 18px; font-style: normal; font-v=
ariant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: aut=
o; text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -w=
ebkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">3) When a =
guest vm reclaims a shared memory buffer, the device manager will provision=
 a new memfd to the guest vm.<br class=3D""></blockquote><br style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helv=
etica; font-size: 18px; font-style: normal; font-variant-caps: normal; font=
-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-=
stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal;=
 text-align: start; text-indent: 0px; text-transform: none; white-space: no=
rmal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: n=
one; float: none; display: inline !important;" class=3D"">How can this be d=
one for the untrusted peers?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""></di=
v></blockquote>Please refer to above explanations:)</div><div><br class=3D"=
"><blockquote type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-c=
olor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: no=
rmal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: nor=
mal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: no=
ne;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-w=
eight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; te=
xt-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-st=
roke-width: 0px; text-decoration: none;" class=3D""><blockquote type=3D"cit=
e" style=3D"font-family: Helvetica; font-size: 18px; font-style: normal; fo=
nt-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans:=
 auto; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">And it=
 will take the responsibility to reclaim the old buffer from peer and event=
ually release the old buffer.<br class=3D"">4) Simplify the control communi=
cation channel. Every guest vm only needs to talk with the device manager a=
nd no need to discover and communicate with other peers.<br class=3D""></bl=
ockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
400; letter-spacing: normal; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wi=
dth: 0px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(=
0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; text-decoration: none; float: none; display: inline !important;" c=
lass=3D"">Not sure but it's better not mandate any model in the application=
 layer.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetic=
a; font-size: 18px; font-style: normal; font-variant-caps: normal; font-wei=
ght: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text=
-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; text-decoration: none;" class=3D""></div></blockquote>Made a=
nother mistake here, it should be stated as</div><div><br class=3D""></div>=
<div>Every backend device driver only needs to talk with the device manager=
 and no need to discover and communicate with other peers.</div><div><br cl=
ass=3D""></div><div>It may help to give more information about the design g=
oal we want to achieve:</div><div>1) extend pci-ivshmem v1/v2 to support mo=
re complex usage scenarios like SMC.</div><div>2) virtio-ism is a generic s=
hmem device and should support pci-ivshmem v1/v2 usage scenarios.&nbsp;</di=
v><div>3) SMC is the first/example usage scenario.</div><div>4) support com=
munications among vm&lt;=E2=80=94&gt;vm, vm&lt;=E2=80=94&gt;run container, =
runC container&lt;=E2=80=94&gt;runC container.&nbsp;</div><div><br class=3D=
""></div><div>Design goal 4 forces us to design virtio-ism instead of pci-i=
vshmem v2/v3.&nbsp;</div><div>The virtio/vDPA/vDUSE stack provides us a per=
fect way to implement userspace shmem device to support runC containers.</d=
iv><div>And currently there=E2=80=99s no way to emulate PCI devices in user=
space.&nbsp;</div><div><br class=3D""></div><div><br class=3D""><blockquote=
 type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: s=
tart; text-indent: 0px; text-transform: none; white-space: normal; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D=
""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-s=
ize: 18px; font-style: normal; font-variant-caps: normal; font-weight: 400;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Thanks</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: He=
lvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;" class=3D""><br style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal;=
 text-align: start; text-indent: 0px; text-transform: none; white-space: no=
rmal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: n=
one;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helve=
tica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-=
weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; t=
ext-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-s=
troke-width: 0px; text-decoration: none;" class=3D""><blockquote type=3D"ci=
te" style=3D"font-family: Helvetica; font-size: 18px; font-style: normal; f=
ont-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans=
: auto; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: aut=
o; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br c=
lass=3D"">Thanks,<br class=3D"">Gerry<br class=3D""><br class=3D""><blockqu=
ote type=3D"cite" class=3D""><br class=3D""><blockquote type=3D"cite" class=
=3D""><br class=3D"">2. The ism device of a VM can be shared with multiple =
(1000+) VMs at the same<br class=3D"">&nbsp;&nbsp;time, which is a challeng=
e for virtiovhostuser<br class=3D""></blockquote><br class=3D"">Please elab=
orate more the the challenges, anything make<br class=3D"">virtiovhostuser =
different?<br class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"=
"><br class=3D"">3. The sharing relationship of ism is dynamically increase=
d, and virtiovhostuser<br class=3D"">&nbsp;&nbsp;determines the sharing rel=
ationship at startup.<br class=3D""></blockquote><br class=3D"">Not necessa=
rily with IOTLB API?<br class=3D""><br class=3D""><blockquote type=3D"cite"=
 class=3D""><br class=3D"">4. For security issues, the device under virtiov=
hostuser may mmap more memory,<br class=3D"">&nbsp;&nbsp;while ism only map=
s one region to other devices<br class=3D""></blockquote><br class=3D"">Wit=
h VHOST_IOTLB_MAP, the map could be done per region.<br class=3D""><br clas=
s=3D"">Thanks<br class=3D""><br class=3D""><blockquote type=3D"cite" class=
=3D""><br class=3D"">Thanks.<br class=3D""><br class=3D""><blockquote type=
=3D"cite" class=3D""><br class=3D"">Thanks<br class=3D""><br class=3D""><bl=
ockquote type=3D"cite" class=3D""><br class=3D""># Design<br class=3D""><br=
 class=3D"">&nbsp;&nbsp;This is a structure diagram based on ism sharing be=
tween two vms.<br class=3D""><br class=3D"">&nbsp;&nbsp;&nbsp;|------------=
---------------------------------------------------------------------------=
----------------------|<br class=3D"">&nbsp;&nbsp;&nbsp;| |----------------=
--------------------------------| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|----=
--------------------------------------------| |<br class=3D"">&nbsp;&nbsp;&=
nbsp;| | Guest &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
 Guest &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |=
<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;---------------- &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;--------------=
-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;driver &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;[M1] &=
nbsp;&nbsp;[M2] &nbsp;&nbsp;[M3] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;driver &nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;[M2] &nbsp;&nbsp;[M3] &nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&n=
bsp;&nbsp;&nbsp;| | &nbsp;&nbsp;---------------- &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
| &nbsp;&nbsp;---------------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;=
&nbsp;&nbsp;|cq| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|map &nbsp;&nbsp;|map &nbsp;&nb=
sp;|map &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nb=
sp;&nbsp;|cq| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;|map &nbsp;&nbsp;|map &nbsp;&nbsp;| |<br class=3D"">&nbsp;&nb=
sp;&nbsp;| | &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nb=
sp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;------------------- &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-------------=
------- &nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| |----|--|--=
--------------| &nbsp;device memory &nbsp;|-----| &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;|----|--|----------------| &nbsp;device memory &nbsp;&nbsp;|----=
| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;------------------- &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---------------=
----- &nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nb=
sp;&nbsp;| | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |=
<br class=3D"">&nbsp;&nbsp;&nbsp;| | Qemu &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| Qemu &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp=
;&nbsp;| |--------------------------------+---------------| &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;|-------------------------------+----------------| |<b=
r class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"=
">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nb=
sp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|---------------=
---------------+------------------------| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br c=
lass=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br cl=
ass=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br cla=
ss=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;-------------------------- &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| M1 | &nbsp;&nbs=
p;| M2 | &nbsp;&nbsp;| M3 | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br =
class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-------------------------- &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| HOST &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;-----------------------------=
---------------------------------------------------------------------------=
-------<br class=3D""><br class=3D""># POC code<br class=3D""><br class=3D"=
">&nbsp;&nbsp;Kernel: <a href=3D"https://github.com/fengidri/linux-kernel-v=
irtio-ism/commits/ism" class=3D"">https://github.com/fengidri/linux-kernel-=
virtio-ism/commits/ism</a><br class=3D"">&nbsp;&nbsp;Qemu: <a href=3D"https=
://github.com/fengidri/qemu/commits/ism" class=3D"">https://github.com/feng=
idri/qemu/commits/ism</a><br class=3D""><br class=3D"">If there are any pro=
blems, please point them out.<br class=3D""><br class=3D"">Hope to hear fro=
m you, thank you.<br class=3D""><br class=3D"">[1] <a href=3D"https://proje=
ctacrn.github.io/latest/tutorials/enable_ivshmem.html" class=3D"">https://p=
rojectacrn.github.io/latest/tutorials/enable_ivshmem.html</a><br class=3D""=
>[2] <a href=3D"https://dl.acm.org/doi/10.1145/2847562" class=3D"">https://=
dl.acm.org/doi/10.1145/2847562</a><br class=3D"">[3] <a href=3D"https://hal=
.archives-ouvertes.fr/hal-00368622/document" class=3D"">https://hal.archive=
s-ouvertes.fr/hal-00368622/document</a><br class=3D"">[4] <a href=3D"https:=
//lwn.net/Articles/711071/" class=3D"">https://lwn.net/Articles/711071/</a>=
<br class=3D"">[5] <a href=3D"https://lore.kernel.org/netdev/20220720170048=
.20806-1-tonylu@linux.alibaba.com/T/" class=3D"">https://lore.kernel.org/ne=
tdev/20220720170048.20806-1-tonylu@linux.alibaba.com/T/</a><br class=3D""><=
br class=3D""><br class=3D"">Xuan Zhuo (2):<br class=3D"">&nbsp;Reserve dev=
ice id for ISM device<br class=3D"">&nbsp;virtio-ism: introduce new device =
virtio-ism<br class=3D""><br class=3D"">content.tex &nbsp;&nbsp;&nbsp;| &nb=
sp;&nbsp;3 +<br class=3D"">virtio-ism.tex | 340 +++++++++++++++++++++++++++=
++++++++++++++++++++++<br class=3D"">2 files changed, 343 insertions(+)<br =
class=3D"">create mode 100644 virtio-ism.tex<br class=3D""><br class=3D"">-=
-<br class=3D"">2.32.0.3.g01195cf9f<br class=3D""><br class=3D""><br class=
=3D"">---------------------------------------------------------------------=
<br class=3D"">To unsubscribe, e-mail:<span class=3D"Apple-converted-space"=
>&nbsp;</span><a href=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org=
" class=3D"">virtio-dev-unsubscribe@lists.oasis-open.org</a><span class=3D"=
Apple-converted-space">&nbsp;</span>&lt;<a href=3D"mailto:virtio-dev-unsubs=
cribe@lists.oasis-open.org" class=3D"">mailto:virtio-dev-unsubscribe@lists.=
oasis-open.org</a>&gt;<br class=3D"">For additional commands, e-mail:<span =
class=3D"Apple-converted-space">&nbsp;</span><a href=3D"mailto:virtio-dev-h=
elp@lists.oasis-open.org" class=3D"">virtio-dev-help@lists.oasis-open.org</=
a><span class=3D"Apple-converted-space">&nbsp;</span>&lt;<a href=3D"mailto:=
virtio-dev-help@lists.oasis-open.org" class=3D"">mailto:virtio-dev-help@lis=
ts.oasis-open.org</a>&gt;<br class=3D""><br class=3D""></blockquote><br cla=
ss=3D""></blockquote><br class=3D"">---------------------------------------=
------------------------------<br class=3D"">To unsubscribe, e-mail:<a href=
=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org" class=3D"">virtio-d=
ev-unsubscribe@lists.oasis-open.org</a><br class=3D"">For additional comman=
ds, e-mail:<a href=3D"mailto:virtio-dev-help@lists.oasis-open.org" class=3D=
"">virtio-dev-help@lists.oasis-open.org</a></blockquote></blockquote></bloc=
kquote></div></blockquote></div><br class=3D""></body></html>
--Apple-Mail=_235BC977-D379-4BFA-A2EC-F3DC7FB5D296--

