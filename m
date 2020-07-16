Return-Path: cdupontd@redhat.com
From: Christophe de Dinechin <cdupontd@redhat.com>
Message-ID: <55EF6822-2B1A-4564-ADF6-D06244DED0D8@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Date: Thu, 16 Jul 2020 16:31:47 +0200
In-Reply-To: <20200716141930.GA114428@stefanha-x1.localdomain>
References: <87r1tdydpz.fsf@linaro.org> <20200715114855.GF18817@stefanha-x1.localdomain>
 <877dv4ykin.fsf@linaro.org> <20200715154732.GC47883@stefanha-x1.localdomain>
 <871rlcybni.fsf@linaro.org> <20200716100051.GC85868@stefanha-x1.localdomain>
 <CDD16024-AAA9-4631-82A8-479C8579D737@redhat.com> <20200716141930.GA114428@stefanha-x1.localdomain>
Content-Type: multipart/alternative; boundary="Apple-Mail=_F0D894EB-17FA-4632-8E34-AA339BFC305F"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Cornelia Huck <cohuck@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_F0D894EB-17FA-4632-8E34-AA339BFC305F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8



> On 16 Jul 2020, at 16:19, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> On Thu, Jul 16, 2020 at 01:25:37PM +0200, Christophe de Dinechin wrote:
>>=20
>>=20
>>> On 16 Jul 2020, at 12:00, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>=20
>>> On Wed, Jul 15, 2020 at 05:40:33PM +0100, Alex Benn=C3=A9e wrote:
>>>>=20
>>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>>>=20
>>>>> On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=C3=A9e wrote:
>>>>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>>>>>> On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote:
>>>>>>>> Finally I'm curious if this is just a problem avoided by the s390
>>>>>>>> channel approach? Does the use of messages over a channel just avo=
id the
>>>>>>>> sort of bouncing back and forth that other hypervisors have to do =
when
>>>>>>>> emulating a device?
>>>>>>>=20
>>>>>>> What does "bouncing back and forth" mean exactly?
>>>>>>=20
>>>>>> Context switching between guest and hypervisor.
>>>>>=20
>>>>> I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
>>>>> request on s390 channel I/O.
>>>>=20
>>>> Thanks.
>>>>=20
>>>> I was also wondering about the efficiency of doorbells/notifications t=
he
>>>> other way. AFAIUI for both PCI and MMIO only a single write is require=
d
>>>> to the notify flag which causes a trap to the hypervisor and the rest =
of
>>>> the processing. The hypervisor doesn't have the cost multiple exits to
>>>> read the guest state although it obviously wants to be as efficient as
>>>> possible passing the data back up to what ever is handling the backend
>>>> of the device so it doesn't need to do multiple context switches.
>>>>=20
>>>> Has there been any investigation into other mechanisms for notifying t=
he
>>>> hypervisor of an event - for example using a HYP call or similar
>>>> mechanism?
>>>>=20
>>>> My gut tells me this probably doesn't make any difference as a trap to
>>>> the hypervisor is likely to cost the same either way because you still
>>>> need to save the guest context before actioning something but it would
>>>> be interesting to know if anyone has looked at it. Perhaps there is a
>>>> benefit in partitioned systems where core running the guest can return
>>>> straight away after initiating what it needs to internally in the
>>>> hypervisor to pass the notification to something that can deal with it=
?
>>>=20
>>> It's very architecture-specific. This is something Michael Tsirkin
>>> looked in in the past. He found that MMIO and PIO perform differently o=
n
>>> x86. VIRTIO supports both so the device can be configured optimally.
>>> There was an old discussion from 2013 here:
>>> https://lkml.org/lkml/2013/4/4/299 <https://lkml.org/lkml/2013/4/4/299>=
 <https://lkml.org/lkml/2013/4/4/299 <https://lkml.org/lkml/2013/4/4/299>>
>>>=20
>>> Without nested page tables MMIO was slower than PIO. But with nested
>>> page tables it was faster.
>>>=20
>>> Another option on x86 is using Model-Specific Registers (for hypercalls=
)
>>> but this doesn't fit into the PCI device model.
>>=20
>> (Warning: What I write below is based on experience with very different
>> architectures, both CPU and hypervisor; your mileage may vary)
>>=20
>> It looks to me like the discussion so far is mostly focused on a "synchr=
onous"
>> model where presumably the same CPU is switching context between
>> guest and (host) device emulation.
>>=20
>> However, I/O devices on real hardware are asynchronous by construction.
>> They do their thing while the CPU processes stuff. So at least theoretic=
ally,
>> there is no reason to context switch on the same CPU. You could very wel=
l
>> have an I/O thread on some other CPU doing its thing. This allows to
>> do something some of you may have heard me talk about, called
>> "interrupt coalescing".
>>=20
>> As Stefan noted, this is not always a win, as it may introduce latency.
>> There are at least two cases where this latency really hurts:
>>=20
>> 1. When the I/O thread is in some kind of deep sleep, e.g. because it
>> was not active recently. Everything from cache to TLB may hit you here,
>> but that normally happens when there isn't much I/O activity, so this ca=
se
>> in practice does not hurt that much, or rather it hurts in a case where
>> don't really care.
>>=20
>> 2. When the I/O thread is preempted, or not given enough cycles to do it=
s
>> stuff. This happens when the system is both CPU and I/O bound, and
>> addressing that is mostly a scheduling issue. A CPU thread could hand-of=
f
>> to a specific I/O thread, reducing that case to the kind of context swit=
ch
>> Alex was mentioning, but I'm not sure how feasible it is to implement
>> that on Linux / kvm.
>>=20
>> In such cases, you have to pay for context switch. I'm not sure if that
>> context switch is markedly more expensive than a "vmexit". On at least
>> that alien architecture I was familiar with, there was little difference=
 between
>> switching to "your" host CPU thread and switching to "another" host
>> I/O thread. But then the context switch was all in software, so we had
>> designed it that way.
>>=20
>> So let's assume now that you run your device emulation fully in an I/O
>> thread, which we will assume for simplicity sits mostly in host user-spa=
ce,
>> and your guest I/O code runs in a CPU thread, which we will assume
>> sits mostly in guest user/kernel space.
>>=20
>> It is possible to share two-way doorbells / IRQ queues on some memory
>> page, very similar to a virtqueue. When you want to "doorbell" your devi=
ce,
>> you simply write to that page. The device threads picks it up by reading
>> the same page, and posts I/O completions on the same page, with simple
>> memory writes.
>>=20
>> Consider this I/O exchange buffer as having (at least) a writer and read=
er
>> index for both doorbells and virtual interrupts. In the explanation
>> below, I will call them "dwi", "dri", "iwi", "iri" for doorbell / interr=
upt read
>> and write index. (Note that as a key optimization, you really
>> don't want dwi and dri to be in the same cache line, since different
>> CPUs are going to read and write them)
>>=20
>> You obviously still need to "kick" the I/O or CPU thread, and we are
>> talking about an IPI here since you don't know which CPU that other
>> thread is sitting on. But the interesting property is that you only need
>> to do that when dwi=3D=3Ddri or iwi=3D=3Diri, because if not, the other =
side
>> has already been "kicked" and will keep working, i.e. incrementing
>> dri or iri, until it reaches back that state.
>>=20
>> The real "interrupt coalescing" trick can happen here. In some
>> cases, you can decide to update your dwi or iwi without kicking,
>> as long as you know that you will need to kick later. That requires
>> some heavy cooperation from guest drivers, though, and is a
>> second-order optimization.
>>=20
>> With a scheme like this, you replace a systematic context switch
>> for each device interrupt with a memory write and a "fire and forget"
>> kick IPI that only happens when the system is not already busy
>> processing I/Os, so that it can be eliminated when the system is
>> most busy. With interrupt coalescing, you can send IPIs at a rate
>> much lower than the actual I/O rate.
>>=20
>> Not sure how difficult it is to adapt a scheme like this to the current
>> state of qemu / kvm, but I'm pretty sure it works well if you implement
>> it correctly ;-)
>>=20
>>>=20
>>> A bigger issue than vmexit latency is device emulation thread wakeup
>>> latency. There is a thread (QEMU, vhost-user, vhost, etc) monitoring th=
e
>>> ioeventfd but it may be descheduled. Its physical CPU may be in a low
>>> power state. I ran a benchmark late last year with QEMU's AioContext
>>> adaptive polling disabled so we can measure the wakeup latency:
>>>=20
>>>      CPU 0/KVM 26102 [000] 85626.737072:       kvm:kvm_fast_mmio:
>>> fast mmio at gpa 0xfde03000
>>>   IO iothread1 26099 [001] 85626.737076: syscalls:sys_exit_ppoll: 0x1
>>>                  4 microseconds ------^
>=20
> Hi Christophe,
> QEMU/KVM does something similar to what you described. In the perf
> output above the vmexit kvm_fast_mmio event occurs on physical CPU
> "[000]".  The IOThread wakes up on physical CPU "[001]". Physical CPU#0
> resumes guest execution immediately after marking the ioeventfd ready.
> There is no context switch to the IOThread or a return from
> ioctl(KVM_RUN) on CPU#0.

Oh, that's good.

But then the conclusion that the 4us delay limits us to 250kIOPS
is incorrect, no? Is there anything that would prevent multiple
I/O events (doorbell or interrupt) to be in flight at the same time?

>=20
> The IOThread reads the eventfd. An eventfd is a counter that is reset to
> 0 on read. Because it's a counter you get coalescing: if the guest
> performs multiple MMIO writes the ioeventfd counter increases but the
> IOThread only wakes up once and reads the ioeventfd.
>=20
> VIRTIO itself also has a mechanism for suppressing notifications called
> EVENT_IDX. It allows the driver to let the device know that it does not
> require interrupts, and the device to let the driver know it does not
> require virtqueue kicks. This reminds me a bit of the mitigation
> mechanism you described.
>=20
> Stefan


--Apple-Mail=_F0D894EB-17FA-4632-8E34-AA339BFC305F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 16 Jul 202=
0, at 16:19, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" cla=
ss=3D"">stefanha@redhat.com</a>&gt; wrote:</div><br class=3D"Apple-intercha=
nge-newline"><div class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: normal; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; disp=
lay: inline !important;" class=3D"">On Thu, Jul 16, 2020 at 01:25:37PM +020=
0, Christophe de Dinechin wrote:</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; font-varia=
nt-caps: normal; font-weight: normal; letter-spacing: normal; text-align: s=
tart; text-indent: 0px; text-transform: none; white-space: normal; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D=
""><blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: normal; let=
ter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; te=
xt-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -=
webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decorat=
ion: none;" class=3D""><br class=3D""><br class=3D""><blockquote type=3D"ci=
te" class=3D"">On 16 Jul 2020, at 12:00, Stefan Hajnoczi &lt;<a href=3D"mai=
lto:stefanha@redhat.com" class=3D"">stefanha@redhat.com</a>&gt; wrote:<br c=
lass=3D""><br class=3D"">On Wed, Jul 15, 2020 at 05:40:33PM +0100, Alex Ben=
n=C3=A9e wrote:<br class=3D""><blockquote type=3D"cite" class=3D""><br clas=
s=3D"">Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" class=3D"=
">stefanha@redhat.com</a>&gt; writes:<br class=3D""><br class=3D""><blockqu=
ote type=3D"cite" class=3D"">On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex=
 Benn=C3=A9e wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">Stef=
an Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" class=3D"">stefanha@=
redhat.com</a>&gt; writes:<br class=3D""><blockquote type=3D"cite" class=3D=
"">On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote:<br cla=
ss=3D""><blockquote type=3D"cite" class=3D"">Finally I'm curious if this is=
 just a problem avoided by the s390<br class=3D"">channel approach? Does th=
e use of messages over a channel just avoid the<br class=3D"">sort of bounc=
ing back and forth that other hypervisors have to do when<br class=3D"">emu=
lating a device?<br class=3D""></blockquote><br class=3D"">What does "bounc=
ing back and forth" mean exactly?<br class=3D""></blockquote><br class=3D""=
>Context switching between guest and hypervisor.<br class=3D""></blockquote=
><br class=3D"">I have CCed Cornelia Huck, who can explain the lifecycle of=
 an I/O<br class=3D"">request on s390 channel I/O.<br class=3D""></blockquo=
te><br class=3D"">Thanks.<br class=3D""><br class=3D"">I was also wondering=
 about the efficiency of doorbells/notifications the<br class=3D"">other wa=
y. AFAIUI for both PCI and MMIO only a single write is required<br class=3D=
"">to the notify flag which causes a trap to the hypervisor and the rest of=
<br class=3D"">the processing. The hypervisor doesn't have the cost multipl=
e exits to<br class=3D"">read the guest state although it obviously wants t=
o be as efficient as<br class=3D"">possible passing the data back up to wha=
t ever is handling the backend<br class=3D"">of the device so it doesn't ne=
ed to do multiple context switches.<br class=3D""><br class=3D"">Has there =
been any investigation into other mechanisms for notifying the<br class=3D"=
">hypervisor of an event - for example using a HYP call or similar<br class=
=3D"">mechanism?<br class=3D""><br class=3D"">My gut tells me this probably=
 doesn't make any difference as a trap to<br class=3D"">the hypervisor is l=
ikely to cost the same either way because you still<br class=3D"">need to s=
ave the guest context before actioning something but it would<br class=3D""=
>be interesting to know if anyone has looked at it. Perhaps there is a<br c=
lass=3D"">benefit in partitioned systems where core running the guest can r=
eturn<br class=3D"">straight away after initiating what it needs to interna=
lly in the<br class=3D"">hypervisor to pass the notification to something t=
hat can deal with it?<br class=3D""></blockquote><br class=3D"">It's very a=
rchitecture-specific. This is something Michael Tsirkin<br class=3D"">looke=
d in in the past. He found that MMIO and PIO perform differently on<br clas=
s=3D"">x86. VIRTIO supports both so the device can be configured optimally.=
<br class=3D"">There was an old discussion from 2013 here:<br class=3D""><a=
 href=3D"https://lkml.org/lkml/2013/4/4/299" class=3D"">https://lkml.org/lk=
ml/2013/4/4/299</a><span class=3D"Apple-converted-space">&nbsp;</span>&lt;<=
a href=3D"https://lkml.org/lkml/2013/4/4/299" class=3D"">https://lkml.org/l=
kml/2013/4/4/299</a>&gt;<br class=3D""><br class=3D"">Without nested page t=
ables MMIO was slower than PIO. But with nested<br class=3D"">page tables i=
t was faster.<br class=3D""><br class=3D"">Another option on x86 is using M=
odel-Specific Registers (for hypercalls)<br class=3D"">but this doesn't fit=
 into the PCI device model.<br class=3D""></blockquote><br class=3D"">(Warn=
ing: What I write below is based on experience with very different<br class=
=3D"">architectures, both CPU and hypervisor; your mileage may vary)<br cla=
ss=3D""><br class=3D"">It looks to me like the discussion so far is mostly =
focused on a "synchronous"<br class=3D"">model where presumably the same CP=
U is switching context between<br class=3D"">guest and (host) device emulat=
ion.<br class=3D""><br class=3D"">However, I/O devices on real hardware are=
 asynchronous by construction.<br class=3D"">They do their thing while the =
CPU processes stuff. So at least theoretically,<br class=3D"">there is no r=
eason to context switch on the same CPU. You could very well<br class=3D"">=
have an I/O thread on some other CPU doing its thing. This allows to<br cla=
ss=3D"">do something some of you may have heard me talk about, called<br cl=
ass=3D"">"interrupt coalescing".<br class=3D""><br class=3D"">As Stefan not=
ed, this is not always a win, as it may introduce latency.<br class=3D"">Th=
ere are at least two cases where this latency really hurts:<br class=3D""><=
br class=3D"">1. When the I/O thread is in some kind of deep sleep, e.g. be=
cause it<br class=3D"">was not active recently. Everything from cache to TL=
B may hit you here,<br class=3D"">but that normally happens when there isn'=
t much I/O activity, so this case<br class=3D"">in practice does not hurt t=
hat much, or rather it hurts in a case where<br class=3D"">don't really car=
e.<br class=3D""><br class=3D"">2. When the I/O thread is preempted, or not=
 given enough cycles to do its<br class=3D"">stuff. This happens when the s=
ystem is both CPU and I/O bound, and<br class=3D"">addressing that is mostl=
y a scheduling issue. A CPU thread could hand-off<br class=3D"">to a specif=
ic I/O thread, reducing that case to the kind of context switch<br class=3D=
"">Alex was mentioning, but I'm not sure how feasible it is to implement<br=
 class=3D"">that on Linux / kvm.<br class=3D""><br class=3D"">In such cases=
, you have to pay for context switch. I'm not sure if that<br class=3D"">co=
ntext switch is markedly more expensive than a "vmexit". On at least<br cla=
ss=3D"">that alien architecture I was familiar with, there was little diffe=
rence between<br class=3D"">switching to "your" host CPU thread and switchi=
ng to "another" host<br class=3D"">I/O thread. But then the context switch =
was all in software, so we had<br class=3D"">designed it that way.<br class=
=3D""><br class=3D"">So let's assume now that you run your device emulation=
 fully in an I/O<br class=3D"">thread, which we will assume for simplicity =
sits mostly in host user-space,<br class=3D"">and your guest I/O code runs =
in a CPU thread, which we will assume<br class=3D"">sits mostly in guest us=
er/kernel space.<br class=3D""><br class=3D"">It is possible to share two-w=
ay doorbells / IRQ queues on some memory<br class=3D"">page, very similar t=
o a virtqueue. When you want to "doorbell" your device,<br class=3D"">you s=
imply write to that page. The device threads picks it up by reading<br clas=
s=3D"">the same page, and posts I/O completions on the same page, with simp=
le<br class=3D"">memory writes.<br class=3D""><br class=3D"">Consider this =
I/O exchange buffer as having (at least) a writer and reader<br class=3D"">=
index for both doorbells and virtual interrupts. In the explanation<br clas=
s=3D"">below, I will call them "dwi", "dri", "iwi", "iri" for doorbell / in=
terrupt read<br class=3D"">and write index. (Note that as a key optimizatio=
n, you really<br class=3D"">don't want dwi and dri to be in the same cache =
line, since different<br class=3D"">CPUs are going to read and write them)<=
br class=3D""><br class=3D"">You obviously still need to "kick" the I/O or =
CPU thread, and we are<br class=3D"">talking about an IPI here since you do=
n't know which CPU that other<br class=3D"">thread is sitting on. But the i=
nteresting property is that you only need<br class=3D"">to do that when dwi=
=3D=3Ddri or iwi=3D=3Diri, because if not, the other side<br class=3D"">has=
 already been "kicked" and will keep working, i.e. incrementing<br class=3D=
"">dri or iri, until it reaches back that state.<br class=3D""><br class=3D=
"">The real "interrupt coalescing" trick can happen here. In some<br class=
=3D"">cases, you can decide to update your dwi or iwi without kicking,<br c=
lass=3D"">as long as you know that you will need to kick later. That requir=
es<br class=3D"">some heavy cooperation from guest drivers, though, and is =
a<br class=3D"">second-order optimization.<br class=3D""><br class=3D"">Wit=
h a scheme like this, you replace a systematic context switch<br class=3D""=
>for each device interrupt with a memory write and a "fire and forget"<br c=
lass=3D"">kick IPI that only happens when the system is not already busy<br=
 class=3D"">processing I/Os, so that it can be eliminated when the system i=
s<br class=3D"">most busy. With interrupt coalescing, you can send IPIs at =
a rate<br class=3D"">much lower than the actual I/O rate.<br class=3D""><br=
 class=3D"">Not sure how difficult it is to adapt a scheme like this to the=
 current<br class=3D"">state of qemu / kvm, but I'm pretty sure it works we=
ll if you implement<br class=3D"">it correctly ;-)<br class=3D""><br class=
=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">A bigger issue th=
an vmexit latency is device emulation thread wakeup<br class=3D"">latency. =
There is a thread (QEMU, vhost-user, vhost, etc) monitoring the<br class=3D=
"">ioeventfd but it may be descheduled. Its physical CPU may be in a low<br=
 class=3D"">power state. I ran a benchmark late last year with QEMU's AioCo=
ntext<br class=3D"">adaptive polling disabled so we can measure the wakeup =
latency:<br class=3D""><br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPU 0/K=
VM 26102 [000] 85626.737072: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kvm:kvm_fa=
st_mmio:<br class=3D"">fast mmio at gpa 0xfde03000<br class=3D"">&nbsp;&nbs=
p;IO iothread1 26099 [001] 85626.737076: syscalls:sys_exit_ppoll: 0x1<br cl=
ass=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4 microseconds ------^<br class=3D""></=
blockquote></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family=
: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal=
; font-weight: normal; letter-spacing: normal; text-align: start; text-inde=
nt: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none; float: none; display: inline !important;" class=3D"">Hi C=
hristophe,</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helve=
tica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-=
weight: normal; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"care=
t-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style:=
 normal; font-variant-caps: normal; font-weight: normal; letter-spacing: no=
rmal; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorati=
on: none; float: none; display: inline !important;" class=3D"">QEMU/KVM doe=
s something similar to what you described. In the perf</span><br style=3D"c=
aret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-sty=
le: normal; font-variant-caps: normal; font-weight: normal; letter-spacing:=
 normal; text-align: start; text-indent: 0px; text-transform: none; white-s=
pace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decor=
ation: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none; float: none; display:=
 inline !important;" class=3D"">output above the vmexit kvm_fast_mmio event=
 occurs on physical CPU</span><br style=3D"caret-color: rgb(0, 0, 0); font-=
family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" class=3D""=
>"[000]". &nbsp;The IOThread wakes up on physical CPU "[001]". Physical CPU=
#0</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none=
; float: none; display: inline !important;" class=3D"">resumes guest execut=
ion immediately after marking the ioeventfd ready.</span><br style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: nor=
mal; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoratio=
n: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family:=
 Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal;=
 font-weight: normal; letter-spacing: normal; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webk=
it-text-stroke-width: 0px; text-decoration: none; float: none; display: inl=
ine !important;" class=3D"">There is no context switch to the IOThread or a=
 return from</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Hel=
vetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"ca=
ret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-styl=
e: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decora=
tion: none; float: none; display: inline !important;" class=3D"">ioctl(KVM_=
RUN) on CPU#0.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: H=
elvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; f=
ont-weight: normal; letter-spacing: normal; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit=
-text-stroke-width: 0px; text-decoration: none;" class=3D""></div></blockqu=
ote><div><br class=3D""></div><div>Oh, that's good.</div><div><br class=3D"=
"></div><div>But then the conclusion that the 4us delay limits us to 250kIO=
PS</div><div>is incorrect, no? Is there anything that would prevent multipl=
e</div><div>I/O events (doorbell or interrupt) to be in flight at the same =
time?</div><br class=3D""><blockquote type=3D"cite" class=3D""><div class=
=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-=
size: 18px; font-style: normal; font-variant-caps: normal; font-weight: nor=
mal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wi=
dth: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rg=
b(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; fo=
nt-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-=
align: start; text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; f=
loat: none; display: inline !important;" class=3D"">The IOThread reads the =
eventfd. An eventfd is a counter that is reset to</span><br style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none; float: none; display: inli=
ne !important;" class=3D"">0 on read. Because it's a counter you get coales=
cing: if the guest</span><br style=3D"caret-color: rgb(0, 0, 0); font-famil=
y: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norma=
l; font-weight: normal; letter-spacing: normal; text-align: start; text-ind=
ent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -we=
bkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none; float: none; display: inline !important;" class=3D"">perf=
orms multiple MMIO writes the ioeventfd counter increases but the</span><br=
 style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18p=
x; font-style: normal; font-variant-caps: normal; font-weight: normal; lett=
er-spacing: normal; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0=
); font-family: Helvetica; font-size: 18px; font-style: normal; font-varian=
t-caps: normal; font-weight: normal; letter-spacing: normal; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: non=
e; display: inline !important;" class=3D"">IOThread only wakes up once and =
reads the ioeventfd.</span><br style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; dis=
play: inline !important;" class=3D"">VIRTIO itself also has a mechanism for=
 suppressing notifications called</span><br style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">EVENT_IDX. It allows the driver to let the device know that it=
 does not</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: nor=
mal; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoratio=
n: none; float: none; display: inline !important;" class=3D"">require inter=
rupts, and the device to let the driver know it does not</span><br style=3D=
"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-s=
tyle: normal; font-variant-caps: normal; font-weight: normal; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; text-decoration: none; float: none; displa=
y: inline !important;" class=3D"">require virtqueue kicks. This reminds me =
a bit of the mitigation</span><br style=3D"caret-color: rgb(0, 0, 0); font-=
family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" class=3D""=
>mechanism you described.</span><br style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 18px; font-style: normal; font-variant=
-caps: normal; font-weight: normal; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none=
; display: inline !important;" class=3D"">Stefan</span></div></blockquote><=
/div><br class=3D""></body></html>
--Apple-Mail=_F0D894EB-17FA-4632-8E34-AA339BFC305F--
