Return-Path: <gerry@linux.alibaba.com>
From: Gerry <gerry@linux.alibaba.com>
Message-Id: <506143AD-A775-4CC5-B92C-B58E14948E3C@linux.alibaba.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Date: Fri, 21 Oct 2022 10:53:57 +0800
In-Reply-To: <CACGkMEvhyDXN0tvOj7EZ633tk0DwSwEQDaKnA5DAU=KeWWX1cQ@mail.gmail.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666009602.9397366-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
 <1666161802.3034256-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuXBzwfj1=hS2qz6US-dwfVw2jtR-f8z1F9+nNRfUcKzA@mail.gmail.com>
 <90A95AD3-DCC6-474C-A0E6-13347B13A2B3@linux.alibaba.com>
 <20221019082136.GA63658@linux.alibaba.com>
 <CACGkMEuCJhTSAwaVb=8APqFRCLZ7ws_u6gapOUQWKN0DuzhOeg@mail.gmail.com>
 <1666170632.2841902-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuhMgTjP2=i4+trOe8Bwi+ySii8tMkEyzVUu4xCpnWnfA@mail.gmail.com>
 <1666171438.2142851-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEvhyDXN0tvOj7EZ633tk0DwSwEQDaKnA5DAU=KeWWX1cQ@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_7D30CBDF-D33A-460A-9492-D27FEBF7238F"
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, dust.li@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_7D30CBDF-D33A-460A-9492-D27FEBF7238F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2022=E5=B9=B410=E6=9C=8821=E6=97=A5 10:41=EF=BC=8CJason Wang <jasowang@re=
dhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Oct 19, 2022 at 5:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com <ma=
ilto:xuanzhuo@linux.alibaba.com>> wrote:
>>=20
>> On Wed, 19 Oct 2022 17:15:23 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
>>> On Wed, Oct 19, 2022 at 5:12 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
>>>>=20
>>>> On Wed, 19 Oct 2022 17:08:29 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
>>>>> On Wed, Oct 19, 2022 at 4:21 PM Dust Li <dust.li@linux.alibaba.com> w=
rote:
>>>>>>=20
>>>>>> On Wed, Oct 19, 2022 at 04:03:42PM +0800, Gerry wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> 2022=E5=B9=B410=E6=9C=8819=E6=97=A5 16:01=EF=BC=8CJason Wang <jaso=
wang@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>>=20
>>>>>>>> On Wed, Oct 19, 2022 at 3:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>>>>>>>>>=20
>>>>>>>>> On Tue, 18 Oct 2022 14:54:22 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
>>>>>>>>>> On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
>>>>>>>>>>>> Adding Stefan.
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Hello everyone,
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # Background
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Nowadays, there is a common scenario to accelerate communicat=
ion between
>>>>>>>>>>>>> different VMs and containers, including light weight virtual =
machine based
>>>>>>>>>>>>> containers. One way to achieve this is to colocate them on th=
e same host.
>>>>>>>>>>>>> However, the performance of inter-VM communication through ne=
twork stack is not
>>>>>>>>>>>>> optimal and may also waste extra CPU cycles. This scenario ha=
s been discussed
>>>>>>>>>>>>> many times, but still no generic solution available [1] [2] [=
3].
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> With pci-ivshmem + SMC(Shared Memory Communications: [4]) bas=
ed PoC[5],
>>>>>>>>>>>>> We found that by changing the communication channel between V=
Ms from TCP to SMC
>>>>>>>>>>>>> with shared memory, we can achieve superior performance for a=
 common
>>>>>>>>>>>>> socket-based application[5]:
>>>>>>>>>>>>> - latency reduced by about 50%
>>>>>>>>>>>>> - throughput increased by about 300%
>>>>>>>>>>>>> - CPU consumption reduced by about 50%
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Since there is no particularly suitable shared memory managem=
ent solution
>>>>>>>>>>>>> matches the need for SMC(See ## Comparison with existing tech=
nology), and virtio
>>>>>>>>>>>>> is the standard for communication in the virtualization world=
, we want to
>>>>>>>>>>>>> implement a virtio-ism device based on virtio, which can supp=
ort on-demand
>>>>>>>>>>>>> memory sharing across VMs, containers or VM-container. To mat=
ch the needs of SMC,
>>>>>>>>>>>>> the virtio-ism device need to support:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> 1. Dynamic provision: shared memory regions are dynamically a=
llocated and
>>>>>>>>>>>>>  provisioned.
>>>>>>>>>>>>> 2. Multi-region management: the shared memory is divided into=
 regions,
>>>>>>>>>>>>>  and a peer may allocate one or more regions from the same sh=
ared memory
>>>>>>>>>>>>>  device.
>>>>>>>>>>>>> 3. Permission control: The permission of each region can be s=
et seperately.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Looks like virtio-ROCE
>>>>>>>>>>>>=20
>>>>>>>>>>>> https://lore.kernel.org/all/20220511095900.343-1-xieyongji@byt=
edance.com/T/
>>>>>>>>>>>>=20
>>>>>>>>>>>> and virtio-vhost-user can satisfy the requirement?
>>>>>>>>>>>>=20
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # Virtio ism device
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> ISM devices provide the ability to share memory between diffe=
rent guests on a
>>>>>>>>>>>>> host. A guest's memory got from ism device can be shared with=
 multiple peers at
>>>>>>>>>>>>> the same time. This shared relationship can be dynamically cr=
eated and released.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> The shared memory obtained from the device is divided into mu=
ltiple ism regions
>>>>>>>>>>>>> for share. ISM device provides a mechanism to notify other is=
m region referrers
>>>>>>>>>>>>> of content update events.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # Usage (SMC as example)
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Maybe there is one of possible use cases:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> 1. SMC calls the interface ism_alloc_region() of the ism driv=
er to return the
>>>>>>>>>>>>>  location of a memory region in the PCI space and a token.
>>>>>>>>>>>>> 2. The ism driver mmap the memory region and return to SMC wi=
th the token
>>>>>>>>>>>>> 3. SMC passes the token to the connected peer
>>>>>>>>>>>>> 3. the peer calls the ism driver interface ism_attach_region(=
token) to
>>>>>>>>>>>>>  get the location of the PCI space of the shared memory
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # About hot plugging of the ism device
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>  Hot plugging of devices is a heavier, possibly failed, time-=
consuming, and
>>>>>>>>>>>>>  less scalable operation. So, we don't plan to support it for=
 now.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # Comparison with existing technology
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> ## ivshmem or ivshmem 2.0 of Qemu
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>  1. ivshmem 1.0 is a large piece of memory that can be seen b=
y all devices that
>>>>>>>>>>>>>  use this VM, so the security is not enough.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>  2. ivshmem 2.0 is a shared memory belonging to a VM that can=
 be read-only by all
>>>>>>>>>>>>>  other VMs that use the ivshmem 2.0 shared memory device, whi=
ch also does not
>>>>>>>>>>>>>  meet our needs in terms of security.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> ## vhost-pci and virtiovhostuser
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>  Does not support dynamic allocation and therefore not suitab=
le for SMC.
>>>>>>>>>>>>=20
>>>>>>>>>>>> I think this is an implementation issue, we can support VHOST =
IOTLB
>>>>>>>>>>>> message then the regions could be added/removed on demand.
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> 1. After the attacker connects with the victim, if the attacker=
 does not
>>>>>>>>>>>  dereference memory, the memory will be occupied under virtiovh=
ostuser. In the
>>>>>>>>>>>  case of ism devices, the victim can directly release the refer=
ence, and the
>>>>>>>>>>>  maliciously referenced region only occupies the attacker's res=
ources
>>>>>>>>>>=20
>>>>>>>>>> Let's define the security boundary here. E.g do we trust the dev=
ice or
>>>>>>>>>> not? If yes, in the case of virtiovhostuser, can we simple do
>>>>>>>>>> VHOST_IOTLB_UNMAP then we can safely release the memory from the
>>>>>>>>>> attacker.
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> 2. The ism device of a VM can be shared with multiple (1000+) V=
Ms at the same
>>>>>>>>>>>  time, which is a challenge for virtiovhostuser
>>>>>>>>>>=20
>>>>>>>>>> Please elaborate more the the challenges, anything make
>>>>>>>>>> virtiovhostuser different?
>>>>>>>>>=20
>>>>>>>>> I understand (please point out any mistakes), one vvu device corr=
esponds to one
>>>>>>>>> vm. If we share memory with 1000 vm, do we have 1000 vvu devices?
>>>>>>>>=20
>>>>>>>> There could be some misunderstanding here. With 1000 VM, you still
>>>>>>>> need 1000 virtio-sim devices I think.
>>>>>>> We are trying to achieve one virtio-ism device per vm instead of on=
e virtio-ism device per SMC connection.
>>>>>=20
>>>>> I wonder if we need something to identify a virtio-ism device since I
>>>>> guess there's still a chance to have multiple virtio-ism device per V=
M
>>>>> (different service chain etc).
>>>>=20
>>>> Yes, there will be such a situation, a vm has multiple virtio-ism devi=
ces.
>>>>=20
>>>> What exactly do you mean by "identify"?
>>>=20
>>> E.g we can differ two virtio-net through mac address, do we need
>>> something similar for ism, or it's completely unncessary (e.g via
>>> token or other) ?
>>=20
>> Currently, we have not encountered such a request.
>>=20
>> It is conceivable that all physical shared memory ism regions are indexe=
d by
>> tokens. virtio-ism is a way to obtain these ism regions, so there is no =
need to
>> distinguish multiple virtio-ism devices under one vm on the host.
>=20
> So consider a case:
>=20
> VM1 shares ism1 with VM2
> VM1 shares ism2 with VM3
>=20
> How do application/smc address the different ism device in this case?
> E.g if VM1 want to talk with VM3 it needs to populate regions in ism2,
> but how can application or protocol knows this and how can a specific
> device to be addressed (via BDF?)
It works in this way:
1) VM1/VM2/VM3 has one ISM device, and each ISM has an crypt-secure random =
host id associated.
2) when VM1 try to create a TCP connection with VM2, the associated host id=
 will be passed to VM2 through TCP options.
3) when VM2 found  the host id matches, it assumes VM1/VM2 are on the same =
physical server.
3) then VM2 allocates a memory buffer from the device manager,=20
4) the device manager returns a buffer with an associated token.
4) VM2 sends back the buffer token through TCP options.
5) VM1 issues an attach memory buffer command to the device manager with th=
e returned buffer token.
6) now VM1 and VM2 have access to the same shared memory buffer.

If VM1 wants to build a new TCP connections with VM3, it goes through the s=
ame process through the same ISM device, and got another memory buffer shar=
ed by VM1 and VM3 only.


>=20
> Thanks
>=20
>>=20
>> Thanks.
>>=20
>>=20
>>>=20
>>> Thanks
>>>=20
>>>>=20
>>>> Thanks.
>>>>=20
>>>>=20
>>>>>=20
>>>>> Thanks
>>>>>=20
>>>>>>=20
>>>>>> I think we must achieve this if we want to meet the requirements of =
SMC.
>>>>>> In SMC, a SMC socket(Corresponding to a TCP socket) need 2 memory
>>>>>> regions(1 for Tx and 1 for Rx). So if we have 1K TCP connections,
>>>>>> we'll need 2K share memory regions, and those memory regions are
>>>>>> dynamically allocated and freed with the TCP socket.
>>>>>>=20
>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> 3. The sharing relationship of ism is dynamically increased, an=
d virtiovhostuser
>>>>>>>>>>>  determines the sharing relationship at startup.
>>>>>>>>>>=20
>>>>>>>>>> Not necessarily with IOTLB API?
>>>>>>>>>=20
>>>>>>>>> Unlike virtio-vhost-user, which shares the memory of a vm with an=
other vm, we
>>>>>>>>> provide the same memory on the host to two vms. So the implementa=
tion of this
>>>>>>>>> part will be much simpler. This is why we gave up virtio-vhost-us=
er at the
>>>>>>>>> beginning.
>>>>>>>>=20
>>>>>>>> Ok, just to make sure we're at the same page. From spec level,
>>>>>>>> virtio-vhost-user doesn't (can't) limit the backend to be implemen=
ted
>>>>>>>> in another VM. So it should be ok to be used for sharing memory
>>>>>>>> between a guest and host.
>>>>>>>>=20
>>>>>>>> Thanks
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Thanks.
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> 4. For security issues, the device under virtiovhostuser may mm=
ap more memory,
>>>>>>>>>>>  while ism only maps one region to other devices
>>>>>>>>>>=20
>>>>>>>>>> With VHOST_IOTLB_MAP, the map could be done per region.
>>>>>>>>>>=20
>>>>>>>>>> Thanks
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> Thanks.
>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> Thanks
>>>>>>>>>>>>=20
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # Design
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>  This is a structure diagram based on ism sharing between two=
 vms.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>   |----------------------------------------------------------=
---------------------------------------------------|
>>>>>>>>>>>>>   | |------------------------------------------------|       =
|------------------------------------------------| |
>>>>>>>>>>>>>   | | Guest                                          |       =
| Guest                                          | |
>>>>>>>>>>>>>   | |                                                |       =
|                                                | |
>>>>>>>>>>>>>   | |   ----------------                             |       =
|   ----------------                             | |
>>>>>>>>>>>>>   | |   |    driver    |     [M1]   [M2]   [M3]      |       =
|   |    driver    |             [M2]   [M3]     | |
>>>>>>>>>>>>>   | |   ----------------       |      |      |       |       =
|   ----------------               |      |      | |
>>>>>>>>>>>>>   | |    |cq|                  |map   |map   |map    |       =
|    |cq|                          |map   |map   | |
>>>>>>>>>>>>>   | |    |  |                  |      |      |       |       =
|    |  |                          |      |      | |
>>>>>>>>>>>>>   | |    |  |                -------------------     |       =
|    |  |                --------------------    | |
>>>>>>>>>>>>>   | |----|--|----------------|  device memory  |-----|       =
|----|--|----------------|  device memory   |----| |
>>>>>>>>>>>>>   | |    |  |                -------------------     |       =
|    |  |                --------------------    | |
>>>>>>>>>>>>>   | |                                |               |       =
|                               |                | |
>>>>>>>>>>>>>   | |                                |               |       =
|                               |                | |
>>>>>>>>>>>>>   | | Qemu                           |               |       =
| Qemu                          |                | |
>>>>>>>>>>>>>   | |--------------------------------+---------------|       =
|-------------------------------+----------------| |
>>>>>>>>>>>>>   |                                  |                       =
                                |                  |
>>>>>>>>>>>>>   |                                  |                       =
                                |                  |
>>>>>>>>>>>>>   |                                  |-----------------------=
-------+------------------------|                  |
>>>>>>>>>>>>>   |                                                          =
       |                                           |
>>>>>>>>>>>>>   |                                                          =
       |                                           |
>>>>>>>>>>>>>   |                                                   -------=
-------------------                                |
>>>>>>>>>>>>>   |                                                    | M1 |=
   | M2 |   | M3 |                                 |
>>>>>>>>>>>>>   |                                                   -------=
-------------------                                |
>>>>>>>>>>>>>   |                                                          =
                                                   |
>>>>>>>>>>>>>   | HOST                                                     =
                                                   |
>>>>>>>>>>>>>   -----------------------------------------------------------=
----------------------------------------------------
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> # POC code
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>  Kernel: https://github.com/fengidri/linux-kernel-virtio-ism/=
commits/ism
>>>>>>>>>>>>>  Qemu:   https://github.com/fengidri/qemu/commits/ism
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> If there are any problems, please point them out.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Hope to hear from you, thank you.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> [1] https://projectacrn.github.io/latest/tutorials/enable_ivs=
hmem.html
>>>>>>>>>>>>> [2] https://dl.acm.org/doi/10.1145/2847562
>>>>>>>>>>>>> [3] https://hal.archives-ouvertes.fr/hal-00368622/document
>>>>>>>>>>>>> [4] https://lwn.net/Articles/711071/
>>>>>>>>>>>>> [5] https://lore.kernel.org/netdev/20220720170048.20806-1-ton=
ylu@linux.alibaba.com/T/
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Xuan Zhuo (2):
>>>>>>>>>>>>> Reserve device id for ISM device
>>>>>>>>>>>>> virtio-ism: introduce new device virtio-ism
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> content.tex    |   3 +
>>>>>>>>>>>>> virtio-ism.tex | 340 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>>>>>>>>>>> 2 files changed, 343 insertions(+)
>>>>>>>>>>>>> create mode 100644 virtio-ism.tex
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> --
>>>>>>>>>>>>> 2.32.0.3.g01195cf9f
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> -------------------------------------------------------------=
--------
>>>>>>>>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-op=
en.org
>>>>>>>>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-=
open.org
>>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> ---------------------------------------------------------------=
------
>>>>>>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open=
.org
>>>>>>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-op=
en.org
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>=20
>>>>>=20
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

--Apple-Mail=_7D30CBDF-D33A-460A-9492-D27FEBF7238F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">2022=E5=B9=B4=
10=E6=9C=8821=E6=97=A5 10:41=EF=BC=8CJason Wang &lt;<a href=3D"mailto:jasow=
ang@redhat.com" class=3D"">jasowang@redhat.com</a>&gt; =E5=86=99=E9=81=93=
=EF=BC=9A</div><br class=3D"Apple-interchange-newline"><div class=3D""><met=
a charset=3D"UTF-8" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fo=
nt-family: Helvetica; font-size: 18px; font-style: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; displ=
ay: inline !important;" class=3D"">On Wed, Oct 19, 2022 at 5:27 PM Xuan Zhu=
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
Wed, 19 Oct 2022 17:15:23 +0800, Jason Wang &lt;<a href=3D"mailto:jasowang@=
redhat.com" class=3D"">jasowang@redhat.com</a>&gt; wrote:<br class=3D""><bl=
ockquote type=3D"cite" class=3D"">On Wed, Oct 19, 2022 at 5:12 PM Xuan Zhuo=
 &lt;<a href=3D"mailto:xuanzhuo@linux.alibaba.com" class=3D"">xuanzhuo@linu=
x.alibaba.com</a>&gt; wrote:<br class=3D""><blockquote type=3D"cite" class=
=3D""><br class=3D"">On Wed, 19 Oct 2022 17:08:29 +0800, Jason Wang &lt;<a =
href=3D"mailto:jasowang@redhat.com" class=3D"">jasowang@redhat.com</a>&gt; =
wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">On Wed, Oct 19, 2=
022 at 4:21 PM Dust Li &lt;<a href=3D"mailto:dust.li@linux.alibaba.com" cla=
ss=3D"">dust.li@linux.alibaba.com</a>&gt; wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D""><br class=3D"">On Wed, Oct 19, 2022 at 04:03:42PM =
+0800, Gerry wrote:<br class=3D""><blockquote type=3D"cite" class=3D""><br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">2022=E5=B9=
=B410=E6=9C=8819=E6=97=A5 16:01=EF=BC=8CJason Wang &lt;<a href=3D"mailto:ja=
sowang@redhat.com" class=3D"">jasowang@redhat.com</a>&gt; =E5=86=99=E9=81=
=93=EF=BC=9A<br class=3D""><br class=3D"">On Wed, Oct 19, 2022 at 3:00 PM X=
uan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linux.alibaba.com" class=3D"">xuanz=
huo@linux.alibaba.com</a>&gt; wrote:<br class=3D""><blockquote type=3D"cite=
" class=3D""><br class=3D"">On Tue, 18 Oct 2022 14:54:22 +0800, Jason Wang =
&lt;<a href=3D"mailto:jasowang@redhat.com" class=3D"">jasowang@redhat.com</=
a>&gt; wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">On Mon, Oc=
t 17, 2022 at 8:31 PM Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linux.alibab=
a.com" class=3D"">xuanzhuo@linux.alibaba.com</a>&gt; wrote:<br class=3D""><=
blockquote type=3D"cite" class=3D""><br class=3D"">On Mon, 17 Oct 2022 16:1=
7:31 +0800, Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" class=3D"=
">jasowang@redhat.com</a>&gt; wrote:<br class=3D""><blockquote type=3D"cite=
" class=3D"">Adding Stefan.<br class=3D""><br class=3D""><br class=3D"">On =
Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linux=
.alibaba.com" class=3D"">xuanzhuo@linux.alibaba.com</a>&gt; wrote:<br class=
=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Hello everyone,<b=
r class=3D""><br class=3D""># Background<br class=3D""><br class=3D"">Nowad=
ays, there is a common scenario to accelerate communication between<br clas=
s=3D"">different VMs and containers, including light weight virtual machine=
 based<br class=3D"">containers. One way to achieve this is to colocate the=
m on the same host.<br class=3D"">However, the performance of inter-VM comm=
unication through network stack is not<br class=3D"">optimal and may also w=
aste extra CPU cycles. This scenario has been discussed<br class=3D"">many =
times, but still no generic solution available [1] [2] [3].<br class=3D""><=
br class=3D"">With pci-ivshmem + SMC(Shared Memory Communications: [4]) bas=
ed PoC[5],<br class=3D"">We found that by changing the communication channe=
l between VMs from TCP to SMC<br class=3D"">with shared memory, we can achi=
eve superior performance for a common<br class=3D"">socket-based applicatio=
n[5]:<br class=3D"">- latency reduced by about 50%<br class=3D"">- throughp=
ut increased by about 300%<br class=3D"">- CPU consumption reduced by about=
 50%<br class=3D""><br class=3D"">Since there is no particularly suitable s=
hared memory management solution<br class=3D"">matches the need for SMC(See=
 ## Comparison with existing technology), and virtio<br class=3D"">is the s=
tandard for communication in the virtualization world, we want to<br class=
=3D"">implement a virtio-ism device based on virtio, which can support on-d=
emand<br class=3D"">memory sharing across VMs, containers or VM-container. =
To match the needs of SMC,<br class=3D"">the virtio-ism device need to supp=
ort:<br class=3D""><br class=3D"">1. Dynamic provision: shared memory regio=
ns are dynamically allocated and<br class=3D"">&nbsp;provisioned.<br class=
=3D"">2. Multi-region management: the shared memory is divided into regions=
,<br class=3D"">&nbsp;and a peer may allocate one or more regions from the =
same shared memory<br class=3D"">&nbsp;device.<br class=3D"">3. Permission =
control: The permission of each region can be set seperately.<br class=3D""=
></blockquote><br class=3D"">Looks like virtio-ROCE<br class=3D""><br class=
=3D""><a href=3D"https://lore.kernel.org/all/20220511095900.343-1-xieyongji=
@bytedance.com/T/" class=3D"">https://lore.kernel.org/all/20220511095900.34=
3-1-xieyongji@bytedance.com/T/</a><br class=3D""><br class=3D"">and virtio-=
vhost-user can satisfy the requirement?<br class=3D""><br class=3D""><block=
quote type=3D"cite" class=3D""><br class=3D""># Virtio ism device<br class=
=3D""><br class=3D"">ISM devices provide the ability to share memory betwee=
n different guests on a<br class=3D"">host. A guest's memory got from ism d=
evice can be shared with multiple peers at<br class=3D"">the same time. Thi=
s shared relationship can be dynamically created and released.<br class=3D"=
"><br class=3D"">The shared memory obtained from the device is divided into=
 multiple ism regions<br class=3D"">for share. ISM device provides a mechan=
ism to notify other ism region referrers<br class=3D"">of content update ev=
ents.<br class=3D""><br class=3D""># Usage (SMC as example)<br class=3D""><=
br class=3D"">Maybe there is one of possible use cases:<br class=3D""><br c=
lass=3D"">1. SMC calls the interface ism_alloc_region() of the ism driver t=
o return the<br class=3D"">&nbsp;location of a memory region in the PCI spa=
ce and a token.<br class=3D"">2. The ism driver mmap the memory region and =
return to SMC with the token<br class=3D"">3. SMC passes the token to the c=
onnected peer<br class=3D"">3. the peer calls the ism driver interface ism_=
attach_region(token) to<br class=3D"">&nbsp;get the location of the PCI spa=
ce of the shared memory<br class=3D""><br class=3D""><br class=3D""># About=
 hot plugging of the ism device<br class=3D""><br class=3D"">&nbsp;Hot plug=
ging of devices is a heavier, possibly failed, time-consuming, and<br class=
=3D"">&nbsp;less scalable operation. So, we don't plan to support it for no=
w.<br class=3D""><br class=3D""># Comparison with existing technology<br cl=
ass=3D""><br class=3D"">## ivshmem or ivshmem 2.0 of Qemu<br class=3D""><br=
 class=3D"">&nbsp;1. ivshmem 1.0 is a large piece of memory that can be see=
n by all devices that<br class=3D"">&nbsp;use this VM, so the security is n=
ot enough.<br class=3D""><br class=3D"">&nbsp;2. ivshmem 2.0 is a shared me=
mory belonging to a VM that can be read-only by all<br class=3D"">&nbsp;oth=
er VMs that use the ivshmem 2.0 shared memory device, which also does not<b=
r class=3D"">&nbsp;meet our needs in terms of security.<br class=3D""><br c=
lass=3D"">## vhost-pci and virtiovhostuser<br class=3D""><br class=3D"">&nb=
sp;Does not support dynamic allocation and therefore not suitable for SMC.<=
br class=3D""></blockquote><br class=3D"">I think this is an implementation=
 issue, we can support VHOST IOTLB<br class=3D"">message then the regions c=
ould be added/removed on demand.<br class=3D""></blockquote><br class=3D"">=
<br class=3D"">1. After the attacker connects with the victim, if the attac=
ker does not<br class=3D"">&nbsp;dereference memory, the memory will be occ=
upied under virtiovhostuser. In the<br class=3D"">&nbsp;case of ism devices=
, the victim can directly release the reference, and the<br class=3D"">&nbs=
p;maliciously referenced region only occupies the attacker's resources<br c=
lass=3D""></blockquote><br class=3D"">Let's define the security boundary he=
re. E.g do we trust the device or<br class=3D"">not? If yes, in the case of=
 virtiovhostuser, can we simple do<br class=3D"">VHOST_IOTLB_UNMAP then we =
can safely release the memory from the<br class=3D"">attacker.<br class=3D"=
"><br class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">2. The=
 ism device of a VM can be shared with multiple (1000+) VMs at the same<br =
class=3D"">&nbsp;time, which is a challenge for virtiovhostuser<br class=3D=
""></blockquote><br class=3D"">Please elaborate more the the challenges, an=
ything make<br class=3D"">virtiovhostuser different?<br class=3D""></blockq=
uote><br class=3D"">I understand (please point out any mistakes), one vvu d=
evice corresponds to one<br class=3D"">vm. If we share memory with 1000 vm,=
 do we have 1000 vvu devices?<br class=3D""></blockquote><br class=3D"">The=
re could be some misunderstanding here. With 1000 VM, you still<br class=3D=
"">need 1000 virtio-sim devices I think.<br class=3D""></blockquote>We are =
trying to achieve one virtio-ism device per vm instead of one virtio-ism de=
vice per SMC connection.<br class=3D""></blockquote></blockquote><br class=
=3D"">I wonder if we need something to identify a virtio-ism device since I=
<br class=3D"">guess there's still a chance to have multiple virtio-ism dev=
ice per VM<br class=3D"">(different service chain etc).<br class=3D""></blo=
ckquote><br class=3D"">Yes, there will be such a situation, a vm has multip=
le virtio-ism devices.<br class=3D""><br class=3D"">What exactly do you mea=
n by "identify"?<br class=3D""></blockquote><br class=3D"">E.g we can diffe=
r two virtio-net through mac address, do we need<br class=3D"">something si=
milar for ism, or it's completely unncessary (e.g via<br class=3D"">token o=
r other) ?<br class=3D""></blockquote><br class=3D"">Currently, we have not=
 encountered such a request.<br class=3D""><br class=3D"">It is conceivable=
 that all physical shared memory ism regions are indexed by<br class=3D"">t=
okens. virtio-ism is a way to obtain these ism regions, so there is no need=
 to<br class=3D"">distinguish multiple virtio-ism devices under one vm on t=
he host.<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-=
caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><sp=
an style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 1=
8px; font-style: normal; font-variant-caps: normal; font-weight: 400; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" class=3D""=
>So consider a case:</span><br style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: 400; letter-spacing: normal; text-align: start; text-inde=
nt: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br style=3D=
"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-s=
tyle: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decora=
tion: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-fami=
ly: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webk=
it-text-stroke-width: 0px; text-decoration: none; float: none; display: inl=
ine !important;" class=3D"">VM1 shares ism1 with VM2</span><br style=3D"car=
et-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style=
: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none; float: none; display: inline =
!important;" class=3D"">VM1 shares ism2 with VM3</span><br style=3D"caret-c=
olor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: no=
rmal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: nor=
mal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: no=
ne;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-w=
eight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; te=
xt-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-st=
roke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: non=
e; float: none; display: inline !important;" class=3D"">How do application/=
smc address the different ism device in this case?</span><br style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: He=
lvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none; float: none; display: inline !i=
mportant;" class=3D"">E.g if VM1 want to talk with VM3 it needs to populate=
 regions in ism2,</span><br style=3D"caret-color: rgb(0, 0, 0); font-family=
: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal=
; font-weight: 400; letter-spacing: normal; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit=
-text-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"=
caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-st=
yle: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: n=
ormal; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorat=
ion: none; float: none; display: inline !important;" class=3D"">but how can=
 application or protocol knows this and how can a specific</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: 400; letter-spacing: normal; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -w=
ebkit-text-stroke-width: 0px; text-decoration: none; float: none; display: =
inline !important;" class=3D"">device to be addressed (via BDF?)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-s=
pacing: normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; tex=
t-decoration: none;" class=3D""></div></blockquote><div>It works in this wa=
y:</div><div>1) VM1/VM2/VM3 has one ISM device, and each ISM has an crypt-s=
ecure random host id associated.</div><div>2) when VM1 try to create a TCP =
connection with VM2, the associated host id will be passed to VM2 through T=
CP options.</div><div>3) when VM2 found &nbsp;the host id matches, it assum=
es VM1/VM2 are on the same physical server.</div><div>3) then VM2 allocates=
 a memory buffer from the device manager,&nbsp;</div><div>4) the device man=
ager returns a buffer with an associated token.</div><div>4) VM2 sends back=
 the buffer token through TCP options.</div><div>5) VM1 issues an attach me=
mory buffer command to the device manager with the returned buffer token.</=
div><div>6) now VM1 and VM2 have access to the same shared memory buffer.</=
div><div><br class=3D""></div><div>If VM1 wants to build a new TCP connecti=
ons with VM3, it goes through the same process through the same ISM device,=
 and got another memory buffer shared by VM1 and VM3 only.</div><div><br cl=
ass=3D""></div><br class=3D""><blockquote type=3D"cite" class=3D""><div cla=
ss=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb=
(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float=
: none; display: inline !important;" class=3D"">Thanks</span><br style=3D"c=
aret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-sty=
le: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: no=
rmal; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorati=
on: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none;" class=3D""><blockquote type=
=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; o=
rphans: auto; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjus=
t: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""=
><br class=3D"">Thanks.<br class=3D""><br class=3D""><br class=3D""><blockq=
uote type=3D"cite" class=3D""><br class=3D"">Thanks<br class=3D""><br class=
=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Thanks.<br class=
=3D""><br class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><b=
r class=3D"">Thanks<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">I think we must achieve this if we want to meet t=
he requirements of SMC.<br class=3D"">In SMC, a SMC socket(Corresponding to=
 a TCP socket) need 2 memory<br class=3D"">regions(1 for Tx and 1 for Rx). =
So if we have 1K TCP connections,<br class=3D"">we'll need 2K share memory =
regions, and those memory regions are<br class=3D"">dynamically allocated a=
nd freed with the TCP socket.<br class=3D""><br class=3D""><blockquote type=
=3D"cite" class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><b=
r class=3D""><blockquote type=3D"cite" class=3D""><br class=3D""><br class=
=3D""><blockquote type=3D"cite" class=3D""><br class=3D""><blockquote type=
=3D"cite" class=3D""><br class=3D"">3. The sharing relationship of ism is d=
ynamically increased, and virtiovhostuser<br class=3D"">&nbsp;determines th=
e sharing relationship at startup.<br class=3D""></blockquote><br class=3D"=
">Not necessarily with IOTLB API?<br class=3D""></blockquote><br class=3D""=
>Unlike virtio-vhost-user, which shares the memory of a vm with another vm,=
 we<br class=3D"">provide the same memory on the host to two vms. So the im=
plementation of this<br class=3D"">part will be much simpler. This is why w=
e gave up virtio-vhost-user at the<br class=3D"">beginning.<br class=3D""><=
/blockquote><br class=3D"">Ok, just to make sure we're at the same page. Fr=
om spec level,<br class=3D"">virtio-vhost-user doesn't (can't) limit the ba=
ckend to be implemented<br class=3D"">in another VM. So it should be ok to =
be used for sharing memory<br class=3D"">between a guest and host.<br class=
=3D""><br class=3D"">Thanks<br class=3D""><br class=3D""><blockquote type=
=3D"cite" class=3D""><br class=3D"">Thanks.<br class=3D""><br class=3D""><b=
r class=3D""><blockquote type=3D"cite" class=3D""><br class=3D""><blockquot=
e type=3D"cite" class=3D""><br class=3D"">4. For security issues, the devic=
e under virtiovhostuser may mmap more memory,<br class=3D"">&nbsp;while ism=
 only maps one region to other devices<br class=3D""></blockquote><br class=
=3D"">With VHOST_IOTLB_MAP, the map could be done per region.<br class=3D""=
><br class=3D"">Thanks<br class=3D""><br class=3D""><blockquote type=3D"cit=
e" class=3D""><br class=3D"">Thanks.<br class=3D""><br class=3D""><blockquo=
te type=3D"cite" class=3D""><br class=3D"">Thanks<br class=3D""><br class=
=3D""><blockquote type=3D"cite" class=3D""><br class=3D""># Design<br class=
=3D""><br class=3D"">&nbsp;This is a structure diagram based on ism sharing=
 between two vms.<br class=3D""><br class=3D"">&nbsp;&nbsp;|---------------=
---------------------------------------------------------------------------=
-------------------|<br class=3D"">&nbsp;&nbsp;| |-------------------------=
-----------------------| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-------------=
-----------------------------------| |<br class=3D"">&nbsp;&nbsp;| | Guest =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| Guest &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;=
&nbsp;| | &nbsp;&nbsp;---------------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;---------------- &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br=
 class=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;driver &nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;[M1] &nbsp;&nbsp;[M2] &nbsp;&nbsp;[M3] =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp=
;&nbsp;| &nbsp;&nbsp;&nbsp;driver &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[M2] &nbsp;&nbsp;[M3] &n=
bsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp;-------=
--------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;---------------- &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br cla=
ss=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;|cq| &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
map &nbsp;&nbsp;|map &nbsp;&nbsp;|map &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;|cq| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|map &nbsp;&nbsp;|map &nbsp;&nb=
sp;| |<br class=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp;&nb=
sp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;------------------- &nbsp;&nbsp;&nbsp;&nbsp;| &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;-------------------- &nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;|=
 |----|--|----------------| &nbsp;device memory &nbsp;|-----| &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;|----|--|----------------| &nbsp;device memory &nbsp=
;&nbsp;|----| |<br class=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp;&nbsp;| &nbsp;| &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;------------------- &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;| &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---------=
----------- &nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;| | &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nb=
sp;| | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br cl=
ass=3D"">&nbsp;&nbsp;| | Qemu &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| Qemu &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| |<br class=3D"">&nbsp;&nbsp;| |--------=
------------------------+---------------| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;|-------------------------------+----------------| |<br class=3D"">&nbsp=
;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;|------------------------------+--------------------=
----| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--------------------------=
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
M1 | &nbsp;&nbsp;| M2 | &nbsp;&nbsp;| M3 | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-------------------------- &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br class=3D"">&nbsp;&nbsp;| HOST &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;|<br class=3D"">&nbsp;&nbsp;--------------------------------------=
-------------------------------------------------------------------------<b=
r class=3D""><br class=3D""># POC code<br class=3D""><br class=3D"">&nbsp;K=
ernel: <a href=3D"https://github.com/fengidri/linux-kernel-virtio-ism/commi=
ts/ism" class=3D"">https://github.com/fengidri/linux-kernel-virtio-ism/comm=
its/ism</a><br class=3D"">&nbsp;Qemu: &nbsp;&nbsp;<a href=3D"https://github=
.com/fengidri/qemu/commits/ism" class=3D"">https://github.com/fengidri/qemu=
/commits/ism</a><br class=3D""><br class=3D"">If there are any problems, pl=
ease point them out.<br class=3D""><br class=3D"">Hope to hear from you, th=
ank you.<br class=3D""><br class=3D"">[1] <a href=3D"https://projectacrn.gi=
thub.io/latest/tutorials/enable_ivshmem.html" class=3D"">https://projectacr=
n.github.io/latest/tutorials/enable_ivshmem.html</a><br class=3D"">[2] <a h=
ref=3D"https://dl.acm.org/doi/10.1145/2847562" class=3D"">https://dl.acm.or=
g/doi/10.1145/2847562</a><br class=3D"">[3] <a href=3D"https://hal.archives=
-ouvertes.fr/hal-00368622/document" class=3D"">https://hal.archives-ouverte=
s.fr/hal-00368622/document</a><br class=3D"">[4] <a href=3D"https://lwn.net=
/Articles/711071/" class=3D"">https://lwn.net/Articles/711071/</a><br class=
=3D"">[5] <a href=3D"https://lore.kernel.org/netdev/20220720170048.20806-1-=
tonylu@linux.alibaba.com/T/" class=3D"">https://lore.kernel.org/netdev/2022=
0720170048.20806-1-tonylu@linux.alibaba.com/T/</a><br class=3D""><br class=
=3D""><br class=3D"">Xuan Zhuo (2):<br class=3D"">Reserve device id for ISM=
 device<br class=3D"">virtio-ism: introduce new device virtio-ism<br class=
=3D""><br class=3D"">content.tex &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 +<br cla=
ss=3D"">virtio-ism.tex | 340 ++++++++++++++++++++++++++++++++++++++++++++++=
+++<br class=3D"">2 files changed, 343 insertions(+)<br class=3D"">create m=
ode 100644 virtio-ism.tex<br class=3D""><br class=3D"">--<br class=3D"">2.3=
2.0.3.g01195cf9f<br class=3D""><br class=3D""><br class=3D"">--------------=
-------------------------------------------------------<br class=3D"">To un=
subscribe, <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org" c=
lass=3D"">e-mail: virtio-dev-unsubscribe@lists.oasis-open.org</a><br class=
=3D"">For additional commands, <a href=3D"mailto:virtio-dev-help@lists.oasi=
s-open.org" class=3D"">e-mail: virtio-dev-help@lists.oasis-open.org</a><br =
class=3D""><br class=3D""></blockquote><br class=3D""></blockquote><br clas=
s=3D"">--------------------------------------------------------------------=
-<br class=3D"">To unsubscribe, <a href=3D"mailto:virtio-dev-unsubscribe@li=
sts.oasis-open.org" class=3D"">e-mail: virtio-dev-unsubscribe@lists.oasis-o=
pen.org</a><br class=3D"">For additional commands, <a href=3D"mailto:virtio=
-dev-help@lists.oasis-open.org" class=3D"">e-mail: virtio-dev-help@lists.oa=
sis-open.org</a><br class=3D""><br class=3D""></blockquote><br class=3D""><=
/blockquote><br class=3D""></blockquote></blockquote></blockquote><br class=
=3D""></blockquote><br class=3D""></blockquote><br class=3D"">-------------=
--------------------------------------------------------<br class=3D"">To u=
nsubscribe, <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org" =
class=3D"">e-mail: virtio-dev-unsubscribe@lists.oasis-open.org</a><br class=
=3D"">For additional commands, <a href=3D"mailto:virtio-dev-help@lists.oasi=
s-open.org" class=3D"">e-mail: virtio-dev-help@lists.oasis-open.org</a><br =
class=3D""><br class=3D""></blockquote><br class=3D""></blockquote><br clas=
s=3D"">--------------------------------------------------------------------=
-<br class=3D"">To unsubscribe, e-mail:<span class=3D"Apple-converted-space=
">&nbsp;</span><a href=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.or=
g" class=3D"">virtio-dev-unsubscribe@lists.oasis-open.org</a><br class=3D""=
>For additional commands, e-mail:<span class=3D"Apple-converted-space">&nbs=
p;</span><a href=3D"mailto:virtio-dev-help@lists.oasis-open.org" class=3D""=
>virtio-dev-help@lists.oasis-open.org</a></blockquote></div></blockquote></=
div><br class=3D""></body></html>
--Apple-Mail=_7D30CBDF-D33A-460A-9492-D27FEBF7238F--

