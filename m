Return-Path: <gerry@linux.alibaba.com>
From: Gerry <gerry@linux.alibaba.com>
Message-Id: <F492EC50-9477-45F9-891A-E2B662F0B377@linux.alibaba.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Date: Tue, 18 Oct 2022 16:33:13 +0800
In-Reply-To: <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666009602.9397366-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_DBB6E6D3-ABBD-4EA8-AECB-0AC29F8FB405"
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_DBB6E6D3-ABBD-4EA8-AECB-0AC29F8FB405
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2022=E5=B9=B410=E6=9C=8818=E6=97=A5 14:54=EF=BC=8CJason Wang <jasowang@re=
dhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com <ma=
ilto:xuanzhuo@linux.alibaba.com>> wrote:
>>=20
>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
>>> Adding Stefan.
>>>=20
>>>=20
>>> On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
>>>>=20
>>>> Hello everyone,
>>>>=20
>>>> # Background
>>>>=20
>>>> Nowadays, there is a common scenario to accelerate communication betwe=
en
>>>> different VMs and containers, including light weight virtual machine b=
ased
>>>> containers. One way to achieve this is to colocate them on the same ho=
st.
>>>> However, the performance of inter-VM communication through network sta=
ck is not
>>>> optimal and may also waste extra CPU cycles. This scenario has been di=
scussed
>>>> many times, but still no generic solution available [1] [2] [3].
>>>>=20
>>>> With pci-ivshmem + SMC(Shared Memory Communications: [4]) based PoC[5]=
,
>>>> We found that by changing the communication channel between VMs from T=
CP to SMC
>>>> with shared memory, we can achieve superior performance for a common
>>>> socket-based application[5]:
>>>>  - latency reduced by about 50%
>>>>  - throughput increased by about 300%
>>>>  - CPU consumption reduced by about 50%
>>>>=20
>>>> Since there is no particularly suitable shared memory management solut=
ion
>>>> matches the need for SMC(See ## Comparison with existing technology), =
and virtio
>>>> is the standard for communication in the virtualization world, we want=
 to
>>>> implement a virtio-ism device based on virtio, which can support on-de=
mand
>>>> memory sharing across VMs, containers or VM-container. To match the ne=
eds of SMC,
>>>> the virtio-ism device need to support:
>>>>=20
>>>> 1. Dynamic provision: shared memory regions are dynamically allocated =
and
>>>>   provisioned.
>>>> 2. Multi-region management: the shared memory is divided into regions,
>>>>   and a peer may allocate one or more regions from the same shared mem=
ory
>>>>   device.
>>>> 3. Permission control: The permission of each region can be set sepera=
tely.
>>>=20
>>> Looks like virtio-ROCE
>>>=20
>>> https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.co=
m/T/
>>>=20
>>> and virtio-vhost-user can satisfy the requirement?
>>>=20
>>>>=20
>>>> # Virtio ism device
>>>>=20
>>>> ISM devices provide the ability to share memory between different gues=
ts on a
>>>> host. A guest's memory got from ism device can be shared with multiple=
 peers at
>>>> the same time. This shared relationship can be dynamically created and=
 released.
>>>>=20
>>>> The shared memory obtained from the device is divided into multiple is=
m regions
>>>> for share. ISM device provides a mechanism to notify other ism region =
referrers
>>>> of content update events.
>>>>=20
>>>> # Usage (SMC as example)
>>>>=20
>>>> Maybe there is one of possible use cases:
>>>>=20
>>>> 1. SMC calls the interface ism_alloc_region() of the ism driver to ret=
urn the
>>>>   location of a memory region in the PCI space and a token.
>>>> 2. The ism driver mmap the memory region and return to SMC with the to=
ken
>>>> 3. SMC passes the token to the connected peer
>>>> 3. the peer calls the ism driver interface ism_attach_region(token) to
>>>>   get the location of the PCI space of the shared memory
>>>>=20
>>>>=20
>>>> # About hot plugging of the ism device
>>>>=20
>>>>   Hot plugging of devices is a heavier, possibly failed, time-consumin=
g, and
>>>>   less scalable operation. So, we don't plan to support it for now.
>>>>=20
>>>> # Comparison with existing technology
>>>>=20
>>>> ## ivshmem or ivshmem 2.0 of Qemu
>>>>=20
>>>>   1. ivshmem 1.0 is a large piece of memory that can be seen by all de=
vices that
>>>>   use this VM, so the security is not enough.
>>>>=20
>>>>   2. ivshmem 2.0 is a shared memory belonging to a VM that can be read=
-only by all
>>>>   other VMs that use the ivshmem 2.0 shared memory device, which also =
does not
>>>>   meet our needs in terms of security.
>>>>=20
>>>> ## vhost-pci and virtiovhostuser
>>>>=20
>>>>   Does not support dynamic allocation and therefore not suitable for S=
MC.
>>>=20
>>> I think this is an implementation issue, we can support VHOST IOTLB
>>> message then the regions could be added/removed on demand.
>>=20
>>=20
>> 1. After the attacker connects with the victim, if the attacker does not
>>   dereference memory, the memory will be occupied under virtiovhostuser.=
 In the
>>   case of ism devices, the victim can directly release the reference, an=
d the
>>   maliciously referenced region only occupies the attacker's resources
>=20
> Let's define the security boundary here. E.g do we trust the device or
> not? If yes, in the case of virtiovhostuser, can we simple do
> VHOST_IOTLB_UNMAP then we can safely release the memory from the
> attacker.
Thanks, Jason:)
In our the design, there are several roles involved:
1) a virtio-ism-smc front-end driver
2) a Virtio-ism backend device driver and its associated vmm
3) a global device manager
4) a group of remote/peer virtio-ism backend devices/vmms
5) a group of remote/peer virtio-ism-smc front-end drivers

Among which , we treat 1, 2 and 3 as trusted, 4 and 5 as untrusted.
Because 4 and 5 are trusted, we can=E2=80=99t guarantee that IOTLB Invalida=
te requests have been executed as expected.
Say when disconnecting an SMC connection, a malicious peer may ignore the I=
OTLB invalidation request and keep access the shared memory region.

We have considered the IOTLB based design but encountered several issues:
1) It depends on the way to provision guest vm memory. We need a memory res=
ource descriptor to support vhost-user IOTLB messages, thus can=E2=80=99t s=
upport anonymous memory based vm.
2) Lack of fine-grain access control of memory resource descriptor. When se=
nd a memory resource descriptor to an untrusted peer, we can=E2=80=99t enfo=
rce region based access control. Memfd supports file level seal operations,=
 but still lack of region based permission control. Hugetlbfs based fd does=
n=E2=80=99t support seal at all.
3) Lack of reliable way to reclaim granted access permissions from untruste=
d peers, as stated above.
4) How implement resource accounting. Say a vm has shared some memory regio=
ns from peers, and those peers exited unexpectedly, then those shared memor=
y will be accounted to the victim vm, and may cause unexpected OOM.

Based on the above consideration, we adopted another design and introduced =
the device manager to solve above issues:
1) the device manager is the owner of memory buffers.
2) the device manager creates a memfd for each memory buffer/region, and co=
nfigure SEALs according to requested access permissions.
3) When a guest vm reclaims a shared memory buffer, the device manager will=
 provision a new memfd to the guest vm. And it will take the responsibility=
 to reclaim the old buffer from peer and eventually release the old buffer.
4) Simplify the control communication channel. Every guest vm only needs to=
 talk with the device manager and no need to discover and communicate with =
other peers.

Thanks,
Gerry

>=20
>>=20
>> 2. The ism device of a VM can be shared with multiple (1000+) VMs at the=
 same
>>   time, which is a challenge for virtiovhostuser
>=20
> Please elaborate more the the challenges, anything make
> virtiovhostuser different?
>=20
>>=20
>> 3. The sharing relationship of ism is dynamically increased, and virtiov=
hostuser
>>   determines the sharing relationship at startup.
>=20
> Not necessarily with IOTLB API?
>=20
>>=20
>> 4. For security issues, the device under virtiovhostuser may mmap more m=
emory,
>>   while ism only maps one region to other devices
>=20
> With VHOST_IOTLB_MAP, the map could be done per region.
>=20
> Thanks
>=20
>>=20
>> Thanks.
>>=20
>>>=20
>>> Thanks
>>>=20
>>>>=20
>>>> # Design
>>>>=20
>>>>   This is a structure diagram based on ism sharing between two vms.
>>>>=20
>>>>    |------------------------------------------------------------------=
-------------------------------------------|
>>>>    | |------------------------------------------------|       |-------=
-----------------------------------------| |
>>>>    | | Guest                                          |       | Guest =
                                         | |
>>>>    | |                                                |       |       =
                                         | |
>>>>    | |   ----------------                             |       |   ----=
------------                             | |
>>>>    | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |   =
 driver    |             [M2]   [M3]     | |
>>>>    | |   ----------------       |      |      |       |       |   ----=
------------               |      |      | |
>>>>    | |    |cq|                  |map   |map   |map    |       |    |cq=
|                          |map   |map   | |
>>>>    | |    |  |                  |      |      |       |       |    |  =
|                          |      |      | |
>>>>    | |    |  |                -------------------     |       |    |  =
|                --------------------    | |
>>>>    | |----|--|----------------|  device memory  |-----|       |----|--=
|----------------|  device memory   |----| |
>>>>    | |    |  |                -------------------     |       |    |  =
|                --------------------    | |
>>>>    | |                                |               |       |       =
                        |                | |
>>>>    | |                                |               |       |       =
                        |                | |
>>>>    | | Qemu                           |               |       | Qemu  =
                        |                | |
>>>>    | |--------------------------------+---------------|       |-------=
------------------------+----------------| |
>>>>    |                                  |                               =
                        |                  |
>>>>    |                                  |                               =
                        |                  |
>>>>    |                                  |------------------------------+=
------------------------|                  |
>>>>    |                                                                 |=
                                           |
>>>>    |                                                                 |=
                                           |
>>>>    |                                                   ---------------=
-----------                                |
>>>>    |                                                    | M1 |   | M2 =
|   | M3 |                                 |
>>>>    |                                                   ---------------=
-----------                                |
>>>>    |                                                                  =
                                           |
>>>>    | HOST                                                             =
                                           |
>>>>    -------------------------------------------------------------------=
--------------------------------------------
>>>>=20
>>>> # POC code
>>>>=20
>>>>   Kernel: https://github.com/fengidri/linux-kernel-virtio-ism/commits/=
ism
>>>>   Qemu:   https://github.com/fengidri/qemu/commits/ism
>>>>=20
>>>> If there are any problems, please point them out.
>>>>=20
>>>> Hope to hear from you, thank you.
>>>>=20
>>>> [1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.html
>>>> [2] https://dl.acm.org/doi/10.1145/2847562
>>>> [3] https://hal.archives-ouvertes.fr/hal-00368622/document
>>>> [4] https://lwn.net/Articles/711071/
>>>> [5] https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@linux=
.alibaba.com/T/
>>>>=20
>>>>=20
>>>> Xuan Zhuo (2):
>>>>  Reserve device id for ISM device
>>>>  virtio-ism: introduce new device virtio-ism
>>>>=20
>>>> content.tex    |   3 +
>>>> virtio-ism.tex | 340 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>> 2 files changed, 343 insertions(+)
>>>> create mode 100644 virtio-ism.tex
>>>>=20
>>>> --
>>>> 2.32.0.3.g01195cf9f
>>>>=20
>>>>=20
>>>> ---------------------------------------------------------------------
>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>=20
>>>=20
>>=20
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org <mai=
lto:virtio-dev-unsubscribe@lists.oasis-open.org>
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org <m=
ailto:virtio-dev-help@lists.oasis-open.org>

--Apple-Mail=_DBB6E6D3-ABBD-4EA8-AECB-0AC29F8FB405
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">2022=E5=B9=B4=
10=E6=9C=8818=E6=97=A5 14:54=EF=BC=8CJason Wang &lt;<a href=3D"mailto:jasow=
ang@redhat.com" class=3D"">jasowang@redhat.com</a>&gt; =E5=86=99=E9=81=93=
=EF=BC=9A</div><br class=3D"Apple-interchange-newline"><div class=3D""><met=
a charset=3D"UTF-8" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fo=
nt-family: Helvetica; font-size: 18px; font-style: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; displ=
ay: inline !important;" class=3D"">On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhu=
o &lt;</span><a href=3D"mailto:xuanzhuo@linux.alibaba.com" style=3D"font-fa=
mily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: no=
rmal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; widows:=
 auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stro=
ke-width: 0px;" class=3D"">xuanzhuo@linux.alibaba.com</a><span style=3D"car=
et-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style=
: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none; float: none; display: inline !important;" class=3D"">&gt; wrote:</s=
pan><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-si=
ze: 18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none;" class=3D""><blockquote type=3D"cite" style=3D"=
font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-=
align: start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-te=
xt-stroke-width: 0px; text-decoration: none;" class=3D""><br class=3D"">On =
Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang &lt;<a href=3D"mailto:jasowang@=
redhat.com" class=3D"">jasowang@redhat.com</a>&gt; wrote:<br class=3D""><bl=
ockquote type=3D"cite" class=3D"">Adding Stefan.<br class=3D""><br class=3D=
""><br class=3D"">On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo &lt;<a href=3D"=
mailto:xuanzhuo@linux.alibaba.com" class=3D"">xuanzhuo@linux.alibaba.com</a=
>&gt; wrote:<br class=3D""><blockquote type=3D"cite" class=3D""><br class=
=3D"">Hello everyone,<br class=3D""><br class=3D""># Background<br class=3D=
""><br class=3D"">Nowadays, there is a common scenario to accelerate commun=
ication between<br class=3D"">different VMs and containers, including light=
 weight virtual machine based<br class=3D"">containers. One way to achieve =
this is to colocate them on the same host.<br class=3D"">However, the perfo=
rmance of inter-VM communication through network stack is not<br class=3D""=
>optimal and may also waste extra CPU cycles. This scenario has been discus=
sed<br class=3D"">many times, but still no generic solution available [1] [=
2] [3].<br class=3D""><br class=3D"">With pci-ivshmem + SMC(Shared Memory C=
ommunications: [4]) based PoC[5],<br class=3D"">We found that by changing t=
he communication channel between VMs from TCP to SMC<br class=3D"">with sha=
red memory, we can achieve superior performance for a common<br class=3D"">=
socket-based application[5]:<br class=3D"">&nbsp;- latency reduced by about=
 50%<br class=3D"">&nbsp;- throughput increased by about 300%<br class=3D""=
>&nbsp;- CPU consumption reduced by about 50%<br class=3D""><br class=3D"">=
Since there is no particularly suitable shared memory management solution<b=
r class=3D"">matches the need for SMC(See ## Comparison with existing techn=
ology), and virtio<br class=3D"">is the standard for communication in the v=
irtualization world, we want to<br class=3D"">implement a virtio-ism device=
 based on virtio, which can support on-demand<br class=3D"">memory sharing =
across VMs, containers or VM-container. To match the needs of SMC,<br class=
=3D"">the virtio-ism device need to support:<br class=3D""><br class=3D"">1=
. Dynamic provision: shared memory regions are dynamically allocated and<br=
 class=3D"">&nbsp;&nbsp;provisioned.<br class=3D"">2. Multi-region manageme=
nt: the shared memory is divided into regions,<br class=3D"">&nbsp;&nbsp;an=
d a peer may allocate one or more regions from the same shared memory<br cl=
ass=3D"">&nbsp;&nbsp;device.<br class=3D"">3. Permission control: The permi=
ssion of each region can be set seperately.<br class=3D""></blockquote><br =
class=3D"">Looks like virtio-ROCE<br class=3D""><br class=3D""><a href=3D"h=
ttps://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/"=
 class=3D"">https://lore.kernel.org/all/20220511095900.343-1-xieyongji@byte=
dance.com/T/</a><br class=3D""><br class=3D"">and virtio-vhost-user can sat=
isfy the requirement?<br class=3D""><br class=3D""><blockquote type=3D"cite=
" class=3D""><br class=3D""># Virtio ism device<br class=3D""><br class=3D"=
">ISM devices provide the ability to share memory between different guests =
on a<br class=3D"">host. A guest's memory got from ism device can be shared=
 with multiple peers at<br class=3D"">the same time. This shared relationsh=
ip can be dynamically created and released.<br class=3D""><br class=3D"">Th=
e shared memory obtained from the device is divided into multiple ism regio=
ns<br class=3D"">for share. ISM device provides a mechanism to notify other=
 ism region referrers<br class=3D"">of content update events.<br class=3D""=
><br class=3D""># Usage (SMC as example)<br class=3D""><br class=3D"">Maybe=
 there is one of possible use cases:<br class=3D""><br class=3D"">1. SMC ca=
lls the interface ism_alloc_region() of the ism driver to return the<br cla=
ss=3D"">&nbsp;&nbsp;location of a memory region in the PCI space and a toke=
n.<br class=3D"">2. The ism driver mmap the memory region and return to SMC=
 with the token<br class=3D"">3. SMC passes the token to the connected peer=
<br class=3D"">3. the peer calls the ism driver interface ism_attach_region=
(token) to<br class=3D"">&nbsp;&nbsp;get the location of the PCI space of t=
he shared memory<br class=3D""><br class=3D""><br class=3D""># About hot pl=
ugging of the ism device<br class=3D""><br class=3D"">&nbsp;&nbsp;Hot plugg=
ing of devices is a heavier, possibly failed, time-consuming, and<br class=
=3D"">&nbsp;&nbsp;less scalable operation. So, we don't plan to support it =
for now.<br class=3D""><br class=3D""># Comparison with existing technology=
<br class=3D""><br class=3D"">## ivshmem or ivshmem 2.0 of Qemu<br class=3D=
""><br class=3D"">&nbsp;&nbsp;1. ivshmem 1.0 is a large piece of memory tha=
t can be seen by all devices that<br class=3D"">&nbsp;&nbsp;use this VM, so=
 the security is not enough.<br class=3D""><br class=3D"">&nbsp;&nbsp;2. iv=
shmem 2.0 is a shared memory belonging to a VM that can be read-only by all=
<br class=3D"">&nbsp;&nbsp;other VMs that use the ivshmem 2.0 shared memory=
 device, which also does not<br class=3D"">&nbsp;&nbsp;meet our needs in te=
rms of security.<br class=3D""><br class=3D"">## vhost-pci and virtiovhostu=
ser<br class=3D""><br class=3D"">&nbsp;&nbsp;Does not support dynamic alloc=
ation and therefore not suitable for SMC.<br class=3D""></blockquote><br cl=
ass=3D"">I think this is an implementation issue, we can support VHOST IOTL=
B<br class=3D"">message then the regions could be added/removed on demand.<=
br class=3D""></blockquote><br class=3D""><br class=3D"">1. After the attac=
ker connects with the victim, if the attacker does not<br class=3D"">&nbsp;=
&nbsp;dereference memory, the memory will be occupied under virtiovhostuser=
. In the<br class=3D"">&nbsp;&nbsp;case of ism devices, the victim can dire=
ctly release the reference, and the<br class=3D"">&nbsp;&nbsp;maliciously r=
eferenced region only occupies the attacker's resources<br class=3D""></blo=
ckquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb=
(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float=
: none; display: inline !important;" class=3D"">Let's define the security b=
oundary here. E.g do we trust the device or</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal;=
 font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-=
align: start; text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica=
; font-size: 18px; font-style: normal; font-variant-caps: normal; font-weig=
ht: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; text-decoration: none; float: none; display: inline !importan=
t;" class=3D"">not? If yes, in the case of virtiovhostuser, can we simple d=
o</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb=
(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float=
: none; display: inline !important;" class=3D"">VHOST_IOTLB_UNMAP then we c=
an safely release the memory from the</span><br style=3D"caret-color: rgb(0=
, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-=
variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align:=
 start; text-indent: 0px; text-transform: none; white-space: normal; word-s=
pacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; text-decoration: none; float: none; display: inline !important;" c=
lass=3D"">attacker.</span><br style=3D"caret-color: rgb(0, 0, 0); font-fami=
ly: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webk=
it-text-stroke-width: 0px; text-decoration: none;" class=3D""></div></block=
quote><div>Thanks, Jason:)</div><div>In our the design, there are several r=
oles involved:</div><div>1) a virtio-ism-smc front-end driver</div><div>2) =
a Virtio-ism backend device driver and its associated vmm</div><div>3) a gl=
obal device manager</div><div>4) a group of remote/peer virtio-ism backend =
devices/vmms</div><div>5) a group of remote/peer virtio-ism-smc front-end d=
rivers</div><div><br class=3D""></div><div>Among which , we treat 1, 2 and =
3 as trusted, 4 and 5 as untrusted.</div><div>Because 4 and 5 are trusted, =
we can=E2=80=99t guarantee that IOTLB Invalidate requests have been execute=
d as expected.</div><div>Say when disconnecting an SMC connection, a malici=
ous peer may ignore the IOTLB invalidation request and keep access the shar=
ed memory region.</div><div><br class=3D""></div><div>We have considered th=
e IOTLB based design but encountered several issues:</div><div>1) It depend=
s on the way to provision guest vm memory. We need a memory resource descri=
ptor to support vhost-user IOTLB messages, thus can=E2=80=99t support anony=
mous memory based vm.</div><div>2) Lack of fine-grain access control of mem=
ory resource descriptor. When send a memory resource descriptor to an untru=
sted peer, we can=E2=80=99t enforce region based access control. Memfd supp=
orts file level seal operations, but still lack of region based permission =
control. Hugetlbfs based fd doesn=E2=80=99t support seal at all.</div><div>=
3) Lack of reliable way to reclaim granted access permissions from untruste=
d peers, as stated above.</div><div>4) How implement resource accounting. S=
ay a vm has shared some memory regions from peers, and those peers exited u=
nexpectedly, then those shared memory will be accounted to the victim vm, a=
nd may cause unexpected OOM.</div><div><br class=3D""></div><div>Based on t=
he above consideration, we adopted another design and introduced the device=
 manager to solve above issues:</div><div>1) the device manager is the owne=
r of memory buffers.</div><div>2) the device manager creates a memfd for ea=
ch memory buffer/region, and configure SEALs according to requested access =
permissions.</div><div>3) When a guest vm reclaims a shared memory buffer, =
the device manager will provision a new memfd to the guest vm. And it will =
take the responsibility to reclaim the old buffer from peer and eventually =
release the old buffer.</div><div>4) Simplify the control communication cha=
nnel. Every guest vm only needs to talk with the device manager and no need=
 to discover and communicate with other peers.</div><div><br class=3D""></d=
iv><div>Thanks,</div><div>Gerry</div><br class=3D""><blockquote type=3D"cit=
e" class=3D""><div class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-=
family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><blockquo=
te type=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; font-sty=
le: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: no=
rmal; orphans: auto; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-siz=
e-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" cla=
ss=3D""><br class=3D"">2. The ism device of a VM can be shared with multipl=
e (1000+) VMs at the same<br class=3D"">&nbsp;&nbsp;time, which is a challe=
nge for virtiovhostuser<br class=3D""></blockquote><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"=
 class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetic=
a; font-size: 18px; font-style: normal; font-variant-caps: normal; font-wei=
ght: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text=
-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; text-decoration: none; float: none; display: inline !importa=
nt;" class=3D"">Please elaborate more the the challenges, anything make</sp=
an><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-siz=
e: 18px; font-style: normal; font-variant-caps: normal; font-weight: 400; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0=
, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-var=
iant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: non=
e; display: inline !important;" class=3D"">virtiovhostuser different?</span=
><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:=
 18px; font-style: normal; font-variant-caps: normal; font-weight: 400; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 18px; font-style: normal; font-variant=
-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start;=
 text-indent: 0px; text-transform: none; white-space: normal; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><b=
lockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; f=
ont-style: normal; font-variant-caps: normal; font-weight: 400; letter-spac=
ing: normal; orphans: auto; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-t=
ext-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: non=
e;" class=3D""><br class=3D"">3. The sharing relationship of ism is dynamic=
ally increased, and virtiovhostuser<br class=3D"">&nbsp;&nbsp;determines th=
e sharing relationship at startup.<br class=3D""></blockquote><br style=3D"=
caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-st=
yle: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: n=
ormal; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorat=
ion: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-famil=
y: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norma=
l; font-weight: 400; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none; float: none; display: inli=
ne !important;" class=3D"">Not necessarily with IOTLB API?</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: 400; letter-spacing: normal; text-align: start; text-inde=
nt: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;" class=3D""><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; font-style:=
 normal; font-variant-caps: normal; font-weight: 400; letter-spacing: norma=
l; orphans: auto; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-a=
djust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><br class=3D"">4. For security issues, the device under virtiovhostus=
er may mmap more memory,<br class=3D"">&nbsp;&nbsp;while ism only maps one =
region to other devices<br class=3D""></blockquote><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"=
 class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetic=
a; font-size: 18px; font-style: normal; font-variant-caps: normal; font-wei=
ght: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text=
-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; text-decoration: none; float: none; display: inline !importa=
nt;" class=3D"">With VHOST_IOTLB_MAP, the map could be done per region.</sp=
an><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-siz=
e: 18px; font-style: normal; font-variant-caps: normal; font-weight: 400; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; font-varia=
nt-caps: normal; font-weight: 400; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">=
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 18px; font-style: normal; font-variant-caps: normal; font-weight: 400; le=
tter-spacing: normal; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0p=
x; text-decoration: none; float: none; display: inline !important;" class=
=3D"">Thanks</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Hel=
vetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fon=
t-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D""><br style=3D"caret-c=
olor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: no=
rmal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: nor=
mal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: no=
ne;" class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; font-weight=
: 400; letter-spacing: normal; orphans: auto; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; widows: auto; word-spaci=
ng: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; te=
xt-decoration: none;" class=3D""><br class=3D"">Thanks.<br class=3D""><br c=
lass=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Thanks<br cla=
ss=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">=
# Design<br class=3D""><br class=3D"">&nbsp;&nbsp;This is a structure diagr=
am based on ism sharing between two vms.<br class=3D""><br class=3D"">&nbsp=
;&nbsp;&nbsp;|-------------------------------------------------------------=
------------------------------------------------|<br class=3D"">&nbsp;&nbsp=
;&nbsp;| |------------------------------------------------| &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;|------------------------------------------------| |<b=
r class=3D"">&nbsp;&nbsp;&nbsp;| | Guest &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;| Guest &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nb=
sp;&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;=
---------------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;---------------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbs=
p;&nbsp;| | &nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;driver &nbsp;&nbsp;&nbsp;| &nbs=
p;&nbsp;&nbsp;&nbsp;[M1] &nbsp;&nbsp;[M2] &nbsp;&nbsp;[M3] &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;| &nbsp;&=
nbsp;&nbsp;driver &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[M2] &nbsp;&nbsp;[M3] &nbsp;&nbsp;&nbsp;=
&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;---------------- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;---------------- &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&n=
bsp;&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;|cq| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|map =
&nbsp;&nbsp;|map &nbsp;&nbsp;|map &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;|cq| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|map &nbsp;&nbsp;|map &nbsp;&nbsp;|=
 |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&=
nbsp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;------------------- &nbsp;&nbsp;&nbsp;&=
nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;-------------------- &nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp=
;&nbsp;&nbsp;| |----|--|----------------| &nbsp;device memory &nbsp;|-----|=
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|----|--|----------------| &nbsp;devic=
e memory &nbsp;&nbsp;|----| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nb=
sp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;------------------- &nbsp;&nbsp;&nbsp;&nb=
sp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;-------------------- &nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&=
nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
 |<br class=3D"">&nbsp;&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;&nbsp;| | Qemu &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| Qemu &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |=
<br class=3D"">&nbsp;&nbsp;&nbsp;| |--------------------------------+------=
---------| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|---------------------------=
----+----------------| |<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;|------------------------------+------------------------| &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---------------------=
----- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp=
;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;| M1 | &nbsp;&nbsp;| M2 | &nbsp;&nbsp;| M3 | &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;------------------=
-------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&n=
bsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp=
;&nbsp;&nbsp;| HOST &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;&nbsp;---=
---------------------------------------------------------------------------=
---------------------------------<br class=3D""><br class=3D""># POC code<b=
r class=3D""><br class=3D"">&nbsp;&nbsp;Kernel: <a href=3D"https://github.c=
om/fengidri/linux-kernel-virtio-ism/commits/ism" class=3D"">https://github.=
com/fengidri/linux-kernel-virtio-ism/commits/ism</a><br class=3D"">&nbsp;&n=
bsp;Qemu: &nbsp;&nbsp;<a href=3D"https://github.com/fengidri/qemu/commits/i=
sm" class=3D"">https://github.com/fengidri/qemu/commits/ism</a><br class=3D=
""><br class=3D"">If there are any problems, please point them out.<br clas=
s=3D""><br class=3D"">Hope to hear from you, thank you.<br class=3D""><br c=
lass=3D"">[1] <a href=3D"https://projectacrn.github.io/latest/tutorials/ena=
ble_ivshmem.html" class=3D"">https://projectacrn.github.io/latest/tutorials=
/enable_ivshmem.html</a><br class=3D"">[2] <a href=3D"https://dl.acm.org/do=
i/10.1145/2847562" class=3D"">https://dl.acm.org/doi/10.1145/2847562</a><br=
 class=3D"">[3] <a href=3D"https://hal.archives-ouvertes.fr/hal-00368622/do=
cument" class=3D"">https://hal.archives-ouvertes.fr/hal-00368622/document</=
a><br class=3D"">[4] <a href=3D"https://lwn.net/Articles/711071/" class=3D"=
">https://lwn.net/Articles/711071/</a><br class=3D"">[5] <a href=3D"https:/=
/lore.kernel.org/netdev/20220720170048.20806-1-tonylu@linux.alibaba.com/T/"=
 class=3D"">https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@li=
nux.alibaba.com/T/</a><br class=3D""><br class=3D""><br class=3D"">Xuan Zhu=
o (2):<br class=3D"">&nbsp;Reserve device id for ISM device<br class=3D"">&=
nbsp;virtio-ism: introduce new device virtio-ism<br class=3D""><br class=3D=
"">content.tex &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 +<br class=3D"">virtio-ism=
.tex | 340 +++++++++++++++++++++++++++++++++++++++++++++++++<br class=3D"">=
2 files changed, 343 insertions(+)<br class=3D"">create mode 100644 virtio-=
ism.tex<br class=3D""><br class=3D"">--<br class=3D"">2.32.0.3.g01195cf9f<b=
r class=3D""><br class=3D""><br class=3D"">--------------------------------=
-------------------------------------<br class=3D"">To unsubscribe, <a href=
=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org" class=3D"">e-mail: =
virtio-dev-unsubscribe@lists.oasis-open.org</a><br class=3D"">For additiona=
l commands, <a href=3D"mailto:virtio-dev-help@lists.oasis-open.org" class=
=3D"">e-mail: virtio-dev-help@lists.oasis-open.org</a><br class=3D""><br cl=
ass=3D""></blockquote><br class=3D""></blockquote><br class=3D"">----------=
-----------------------------------------------------------<br class=3D"">T=
o unsubscribe, e-mail:<span class=3D"Apple-converted-space">&nbsp;</span><a=
 href=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org" class=3D"">vir=
tio-dev-unsubscribe@lists.oasis-open.org</a><br class=3D"">For additional c=
ommands, e-mail:<span class=3D"Apple-converted-space">&nbsp;</span><a href=
=3D"mailto:virtio-dev-help@lists.oasis-open.org" class=3D"">virtio-dev-help=
@lists.oasis-open.org</a></blockquote></div></blockquote></div><br class=3D=
""></body></html>
--Apple-Mail=_DBB6E6D3-ABBD-4EA8-AECB-0AC29F8FB405--

