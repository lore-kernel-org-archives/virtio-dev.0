Return-Path: cdupontd@redhat.com
From: Christophe de Dinechin <cdupontd@redhat.com>
Message-ID: <CDD16024-AAA9-4631-82A8-479C8579D737@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Date: Thu, 16 Jul 2020 13:25:37 +0200
In-Reply-To: <20200716100051.GC85868@stefanha-x1.localdomain>
References: <87r1tdydpz.fsf@linaro.org> <20200715114855.GF18817@stefanha-x1.localdomain>
 <877dv4ykin.fsf@linaro.org> <20200715154732.GC47883@stefanha-x1.localdomain>
 <871rlcybni.fsf@linaro.org> <20200716100051.GC85868@stefanha-x1.localdomain>
Content-Type: multipart/alternative; boundary="Apple-Mail=_91F4DD19-1EB7-4C8D-AF38-0F390772D1CD"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Cornelia Huck <cohuck@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_91F4DD19-1EB7-4C8D-AF38-0F390772D1CD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8



> On 16 Jul 2020, at 12:00, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> On Wed, Jul 15, 2020 at 05:40:33PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>>> On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=C3=A9e wrote:
>>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>>>> On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote:
>>>>>> Finally I'm curious if this is just a problem avoided by the s390
>>>>>> channel approach? Does the use of messages over a channel just avoid=
 the
>>>>>> sort of bouncing back and forth that other hypervisors have to do wh=
en
>>>>>> emulating a device?
>>>>>=20
>>>>> What does "bouncing back and forth" mean exactly?
>>>>=20
>>>> Context switching between guest and hypervisor.
>>>=20
>>> I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
>>> request on s390 channel I/O.
>>=20
>> Thanks.
>>=20
>> I was also wondering about the efficiency of doorbells/notifications the
>> other way. AFAIUI for both PCI and MMIO only a single write is required
>> to the notify flag which causes a trap to the hypervisor and the rest of
>> the processing. The hypervisor doesn't have the cost multiple exits to
>> read the guest state although it obviously wants to be as efficient as
>> possible passing the data back up to what ever is handling the backend
>> of the device so it doesn't need to do multiple context switches.
>>=20
>> Has there been any investigation into other mechanisms for notifying the
>> hypervisor of an event - for example using a HYP call or similar
>> mechanism?
>>=20
>> My gut tells me this probably doesn't make any difference as a trap to
>> the hypervisor is likely to cost the same either way because you still
>> need to save the guest context before actioning something but it would
>> be interesting to know if anyone has looked at it. Perhaps there is a
>> benefit in partitioned systems where core running the guest can return
>> straight away after initiating what it needs to internally in the
>> hypervisor to pass the notification to something that can deal with it?
>=20
> It's very architecture-specific. This is something Michael Tsirkin
> looked in in the past. He found that MMIO and PIO perform differently on
> x86. VIRTIO supports both so the device can be configured optimally.
> There was an old discussion from 2013 here:
> https://lkml.org/lkml/2013/4/4/299 <https://lkml.org/lkml/2013/4/4/299>
>=20
> Without nested page tables MMIO was slower than PIO. But with nested
> page tables it was faster.
>=20
> Another option on x86 is using Model-Specific Registers (for hypercalls)
> but this doesn't fit into the PCI device model.

(Warning: What I write below is based on experience with very different
architectures, both CPU and hypervisor; your mileage may vary)

It looks to me like the discussion so far is mostly focused on a "synchrono=
us"
model where presumably the same CPU is switching context between
guest and (host) device emulation.

However, I/O devices on real hardware are asynchronous by construction.
They do their thing while the CPU processes stuff. So at least theoreticall=
y,
there is no reason to context switch on the same CPU. You could very well
have an I/O thread on some other CPU doing its thing. This allows to
do something some of you may have heard me talk about, called
"interrupt coalescing".

As Stefan noted, this is not always a win, as it may introduce latency.
There are at least two cases where this latency really hurts:

1. When the I/O thread is in some kind of deep sleep, e.g. because it
was not active recently. Everything from cache to TLB may hit you here,
but that normally happens when there isn't much I/O activity, so this case
in practice does not hurt that much, or rather it hurts in a case where
don't really care.

2. When the I/O thread is preempted, or not given enough cycles to do its
stuff. This happens when the system is both CPU and I/O bound, and
addressing that is mostly a scheduling issue. A CPU thread could hand-off
to a specific I/O thread, reducing that case to the kind of context switch
Alex was mentioning, but I'm not sure how feasible it is to implement
that on Linux / kvm.

In such cases, you have to pay for context switch. I'm not sure if that
context switch is markedly more expensive than a "vmexit". On at least
that alien architecture I was familiar with, there was little difference be=
tween
switching to "your" host CPU thread and switching to "another" host
I/O thread. But then the context switch was all in software, so we had
designed it that way.

So let's assume now that you run your device emulation fully in an I/O
thread, which we will assume for simplicity sits mostly in host user-space,
and your guest I/O code runs in a CPU thread, which we will assume
sits mostly in guest user/kernel space.

It is possible to share two-way doorbells / IRQ queues on some memory
page, very similar to a virtqueue. When you want to "doorbell" your device,
you simply write to that page. The device threads picks it up by reading
the same page, and posts I/O completions on the same page, with simple
memory writes.

Consider this I/O exchange buffer as having (at least) a writer and reader
index for both doorbells and virtual interrupts. In the explanation
below, I will call them "dwi", "dri", "iwi", "iri" for doorbell / interrupt=
 read
and write index. (Note that as a key optimization, you really
don't want dwi and dri to be in the same cache line, since different
CPUs are going to read and write them)

You obviously still need to "kick" the I/O or CPU thread, and we are
talking about an IPI here since you don't know which CPU that other
thread is sitting on. But the interesting property is that you only need
to do that when dwi=3D=3Ddri or iwi=3D=3Diri, because if not, the other sid=
e
has already been "kicked" and will keep working, i.e. incrementing
dri or iri, until it reaches back that state.

The real "interrupt coalescing" trick can happen here. In some
cases, you can decide to update your dwi or iwi without kicking,
as long as you know that you will need to kick later. That requires
some heavy cooperation from guest drivers, though, and is a
second-order optimization.

With a scheme like this, you replace a systematic context switch
for each device interrupt with a memory write and a "fire and forget"
kick IPI that only happens when the system is not already busy
processing I/Os, so that it can be eliminated when the system is
most busy. With interrupt coalescing, you can send IPIs at a rate
much lower than the actual I/O rate.

Not sure how difficult it is to adapt a scheme like this to the current
state of qemu / kvm, but I'm pretty sure it works well if you implement
it correctly ;-)

>=20
> A bigger issue than vmexit latency is device emulation thread wakeup
> latency. There is a thread (QEMU, vhost-user, vhost, etc) monitoring the
> ioeventfd but it may be descheduled. Its physical CPU may be in a low
> power state. I ran a benchmark late last year with QEMU's AioContext
> adaptive polling disabled so we can measure the wakeup latency:
>=20
>       CPU 0/KVM 26102 [000] 85626.737072:       kvm:kvm_fast_mmio:
> fast mmio at gpa 0xfde03000
>    IO iothread1 26099 [001] 85626.737076: syscalls:sys_exit_ppoll: 0x1
>                   4 microseconds ------^
>=20
> (I did not manually configure physical CPU power states or use the
> idle=3Dpoll host kernel parameter.)
>=20
> Each virtqueue kick had 4 microseconds of latency before the device
> emulation thread had a chance to process the virtqueue. This means the
> maximum I/O Operations Per Second (IOPS) is capped at 250k before
> virtqueue processing has even begun!

This data is what prompted me to write the above. This 4us seems
really long to me.

I recall a benchmark where the technique above was reaching at least
400k IOPs for a single VM on a medium-size system (4CPUs (*)).=20
I remember the time I ran this benchmark quite well, because it was just
after VMware made a big splash about reaching 100k IOPs:
https://blogs.vmware.com/performance/2008/05/100000-io-opera.html.

(*) Yes, at the time, 4 CPUs was a medium size system. Don't laugh.

>=20
> QEMU AioContext adaptive polling helps here because we skip the vmexit
> entirely while the IOThread is polling the vring (for up to 32
> microseconds by default).
>=20
> It would be great if more people dig into this and optimize
> notifications further.
>=20
> Stefan


--Apple-Mail=_91F4DD19-1EB7-4C8D-AF38-0F390772D1CD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 16 Jul 202=
0, at 12:00, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" cla=
ss=3D"">stefanha@redhat.com</a>&gt; wrote:</div><br class=3D"Apple-intercha=
nge-newline"><div class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: normal; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; disp=
lay: inline !important;" class=3D"">On Wed, Jul 15, 2020 at 05:40:33PM +010=
0, Alex Benn=C3=A9e wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); fo=
nt-family: Helvetica; font-size: 18px; font-style: normal; font-variant-cap=
s: normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><bl=
ockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; fo=
nt-style: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; orphans: auto; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit=
-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: n=
one;" class=3D""><br class=3D"">Stefan Hajnoczi &lt;<a href=3D"mailto:stefa=
nha@redhat.com" class=3D"">stefanha@redhat.com</a>&gt; writes:<br class=3D"=
"><br class=3D""><blockquote type=3D"cite" class=3D"">On Wed, Jul 15, 2020 =
at 02:29:04PM +0100, Alex Benn=C3=A9e wrote:<br class=3D""><blockquote type=
=3D"cite" class=3D"">Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.=
com" class=3D"">stefanha@redhat.com</a>&gt; writes:<br class=3D""><blockquo=
te type=3D"cite" class=3D"">On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex =
Benn=C3=A9e wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">Final=
ly I'm curious if this is just a problem avoided by the s390<br class=3D"">=
channel approach? Does the use of messages over a channel just avoid the<br=
 class=3D"">sort of bouncing back and forth that other hypervisors have to =
do when<br class=3D"">emulating a device?<br class=3D""></blockquote><br cl=
ass=3D"">What does "bouncing back and forth" mean exactly?<br class=3D""></=
blockquote><br class=3D"">Context switching between guest and hypervisor.<b=
r class=3D""></blockquote><br class=3D"">I have CCed Cornelia Huck, who can=
 explain the lifecycle of an I/O<br class=3D"">request on s390 channel I/O.=
<br class=3D""></blockquote><br class=3D"">Thanks.<br class=3D""><br class=
=3D"">I was also wondering about the efficiency of doorbells/notifications =
the<br class=3D"">other way. AFAIUI for both PCI and MMIO only a single wri=
te is required<br class=3D"">to the notify flag which causes a trap to the =
hypervisor and the rest of<br class=3D"">the processing. The hypervisor doe=
sn't have the cost multiple exits to<br class=3D"">read the guest state alt=
hough it obviously wants to be as efficient as<br class=3D"">possible passi=
ng the data back up to what ever is handling the backend<br class=3D"">of t=
he device so it doesn't need to do multiple context switches.<br class=3D""=
><br class=3D"">Has there been any investigation into other mechanisms for =
notifying the<br class=3D"">hypervisor of an event - for example using a HY=
P call or similar<br class=3D"">mechanism?<br class=3D""><br class=3D"">My =
gut tells me this probably doesn't make any difference as a trap to<br clas=
s=3D"">the hypervisor is likely to cost the same either way because you sti=
ll<br class=3D"">need to save the guest context before actioning something =
but it would<br class=3D"">be interesting to know if anyone has looked at i=
t. Perhaps there is a<br class=3D"">benefit in partitioned systems where co=
re running the guest can return<br class=3D"">straight away after initiatin=
g what it needs to internally in the<br class=3D"">hypervisor to pass the n=
otification to something that can deal with it?<br class=3D""></blockquote>=
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0=
, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-var=
iant-caps: normal; font-weight: normal; letter-spacing: normal; text-align:=
 start; text-indent: 0px; text-transform: none; white-space: normal; word-s=
pacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: =
none; display: inline !important;" class=3D"">It's very architecture-specif=
ic. This is something Michael Tsirkin</span><br style=3D"caret-color: rgb(0=
, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-=
variant-caps: normal; font-weight: normal; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cla=
ss=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; text-decoration: none; float: none; display: inline !importan=
t;" class=3D"">looked in in the past. He found that MMIO and PIO perform di=
fferently on</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Hel=
vetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"ca=
ret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-styl=
e: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decora=
tion: none; float: none; display: inline !important;" class=3D"">x86. VIRTI=
O supports both so the device can be configured optimally.</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; dis=
play: inline !important;" class=3D"">There was an old discussion from 2013 =
here:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica;=
 font-size: 18px; font-style: normal; font-variant-caps: normal; font-weigh=
t: normal; letter-spacing: normal; text-align: start; text-indent: 0px; tex=
t-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; text-decoration: none;" class=3D""><a href=3D"https://lkml.=
org/lkml/2013/4/4/299" style=3D"font-family: Helvetica; font-size: 18px; fo=
nt-style: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; orphans: auto; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit=
-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" class=3D"">https:=
//lkml.org/lkml/2013/4/4/299</a><br style=3D"caret-color: rgb(0, 0, 0); fon=
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
; display: inline !important;" class=3D"">Without nested page tables MMIO w=
as slower than PIO. But with nested</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">page tables it was faster.</span><br style=3D"caret-color: rgb=
(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; fon=
t-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-a=
lign: start; text-indent: 0px; text-transform: none; white-space: normal; w=
ord-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" c=
lass=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: non=
e; float: none; display: inline !important;" class=3D"">Another option on x=
86 is using Model-Specific Registers (for hypercalls)</span><br style=3D"ca=
ret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-styl=
e: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decora=
tion: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-fami=
ly: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norm=
al; font-weight: normal; letter-spacing: normal; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -w=
ebkit-text-stroke-width: 0px; text-decoration: none; float: none; display: =
inline !important;" class=3D"">but this doesn't fit into the PCI device mod=
el.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; text-decoration: none;" class=3D""></div></blockquote><div><b=
r class=3D""></div>(Warning: What I write below is based on experience with=
 very different</div><div>architectures, both CPU and hypervisor; your mile=
age may vary)<br class=3D""><div><br class=3D""></div></div><div><div>It lo=
oks to me like the discussion so far is mostly focused on a "synchronous"</=
div><div>model where presumably the same CPU is switching context between</=
div><div>guest and (host) device emulation.</div><div><br class=3D""></div>=
<div>However, I/O devices on real hardware are asynchronous by construction=
=2E</div><div>They do their thing while the CPU processes stuff. So at leas=
t theoretically,</div><div>there is no reason to context switch on the same=
 CPU. You could very well</div><div>have an I/O thread on some other CPU do=
ing its thing. This allows to</div><div>do something some of you may have h=
eard me talk about, called</div><div>"interrupt coalescing".</div><div><br =
class=3D""></div><div>As Stefan noted, this is not always a win, as it may =
introduce latency.</div><div>There are at least two cases where this latenc=
y really hurts:</div><div><br class=3D""></div><div>1. When the I/O thread =
is in some kind of deep sleep, e.g. because it</div><div>was not active rec=
ently. Everything from cache to TLB may hit you here,</div><div>but that no=
rmally happens when there isn't much I/O activity, so this case</div><div>i=
n practice does not hurt that much, or rather it hurts in a case where</div=
><div>don't really care.</div><div><br class=3D""></div><div>2. When the I/=
O thread is preempted, or not given enough cycles to do its</div><div>stuff=
=2E This happens when the system is both CPU and I/O bound, and</div><div>a=
ddressing that is mostly a scheduling issue. A CPU thread could hand-off</d=
iv><div>to a specific I/O thread, reducing that case to the kind of context=
 switch</div><div>Alex was mentioning, but I'm not sure how feasible it is =
to implement</div><div>that on Linux / kvm.</div><div><br class=3D""></div>=
<div>In such cases, you have to pay for context switch. I'm not sure if tha=
t</div><div>context switch is markedly more expensive than a "vmexit". On a=
t least</div><div>that alien architecture I was familiar with, there was li=
ttle difference between</div><div>switching to "your" host CPU thread and s=
witching to "another" host</div><div>I/O thread. But then the context switc=
h was all in software, so we had</div><div>designed it that way.</div><div>=
<br class=3D""></div><div>So let's assume now that you run your device emul=
ation fully in an I/O</div><div>thread, which we will assume for simplicity=
 sits mostly in host user-space,</div><div>and your guest I/O code runs in =
a CPU thread, which we will assume</div><div>sits mostly in guest user/kern=
el space.</div><div><br class=3D""></div><div>It is possible to share two-w=
ay doorbells / IRQ queues on some memory</div><div>page, very similar to a =
virtqueue. When you want to "doorbell" your device,</div><div>you simply wr=
ite to that page. The device threads picks it up by reading</div><div>the s=
ame page, and posts I/O completions on the same page, with simple</div><div=
>memory writes.</div><div><br class=3D""></div><div>Consider this I/O excha=
nge buffer as having (at least) a writer and reader</div><div>index for bot=
h doorbells and virtual interrupts. In the explanation</div><div>below, I w=
ill call them "dwi", "dri", "iwi", "iri" for doorbell / interrupt read</div=
><div>and write index. (Note that as a key optimization, you really</div><d=
iv>don't want dwi and dri to be in the same cache line, since different</di=
v><div>CPUs are going to read and write them)</div><div><br class=3D""></di=
v><div>You obviously still need to "kick" the I/O or CPU thread, and we are=
</div><div>talking about an IPI here since you don't know which CPU that ot=
her</div><div>thread is sitting on. But the interesting property is that yo=
u only need</div><div>to do that when dwi=3D=3Ddri or iwi=3D=3Diri, because=
 if not, the other side</div><div>has already been "kicked" and will keep w=
orking, i.e. incrementing</div><div>dri or iri, until it reaches back that =
state.</div><div><br class=3D""></div><div>The real "interrupt coalescing" =
trick can happen here. In some</div><div>cases, you can decide to update yo=
ur dwi or iwi without kicking,</div><div>as long as you know that you will =
need to kick later. That requires</div><div>some heavy cooperation from gue=
st drivers, though, and is a</div><div>second-order optimization.</div><div=
><br class=3D""></div><div>With a scheme like this, you replace a systemati=
c context switch</div><div>for each device interrupt with a memory write an=
d a "fire and forget"</div><div>kick IPI that only happens when the system =
is not already busy</div><div>processing I/Os, so that it can be eliminated=
 when the system is</div><div>most busy. With interrupt coalescing, you can=
 send IPIs at a rate</div><div>much lower than the actual I/O rate.</div><d=
iv><br class=3D""></div><div>Not sure how difficult it is to adapt a scheme=
 like this to the current</div><div>state of qemu / kvm, but I'm pretty sur=
e it works well if you implement</div><div>it correctly ;-)</div><div><br c=
lass=3D""></div><blockquote type=3D"cite" class=3D""><div class=3D""><br st=
yle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; letter-=
spacing: normal; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; te=
xt-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-c=
aps: normal; font-weight: normal; letter-spacing: normal; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; word-spacing=
: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">A bigger issue than vmexit latency =
is device emulation thread wakeup</span><br style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">latency. There is a thread (QEMU, vhost-user, vhost, etc) moni=
toring the</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helve=
tica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-=
weight: normal; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"care=
t-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style:=
 normal; font-variant-caps: normal; font-weight: normal; letter-spacing: no=
rmal; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorati=
on: none; float: none; display: inline !important;" class=3D"">ioeventfd bu=
t it may be descheduled. Its physical CPU may be in a low</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; dis=
play: inline !important;" class=3D"">power state. I ran a benchmark late la=
st year with QEMU's AioContext</span><br style=3D"caret-color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 18px; font-style: normal; font-variant=
-caps: normal; font-weight: normal; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""=
><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-siz=
e: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal=
; letter-spacing: normal; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width=
: 0px; text-decoration: none; float: none; display: inline !important;" cla=
ss=3D"">adaptive polling disabled so we can measure the wakeup latency:</sp=
an><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-siz=
e: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal=
; letter-spacing: normal; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width=
: 0px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPU 0/KVM 26102 [000] 8562=
6.737072: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kvm:kvm_fast_mmio:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 18px; font-style: normal; font-variant=
-caps: normal; font-weight: normal; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none=
; display: inline !important;" class=3D"">fast mmio at gpa 0xfde03000</span=
><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:=
 18px; font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float:=
 none; display: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;IO iothrea=
d1 26099 [001] 85626.737076: syscalls:sys_exit_ppoll: 0x1</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; dis=
play: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4 mic=
roseconds ------^</span><br style=3D"caret-color: rgb(0, 0, 0); font-family=
: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal=
; font-weight: normal; letter-spacing: normal; text-align: start; text-inde=
nt: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br style=3D=
"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-s=
tyle: normal; font-variant-caps: normal; font-weight: normal; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; text-decoration: none; float: none; displa=
y: inline !important;" class=3D"">(I did not manually configure physical CP=
U power states or use the</span><br style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><spa=
n style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: normal; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; text-decoration: none; float: none; display: inline !important;" class=3D=
"">idle=3Dpoll host kernel parameter.)</span><br style=3D"caret-color: rgb(=
0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font=
-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cl=
ass=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none=
; float: none; display: inline !important;" class=3D"">Each virtqueue kick =
had 4 microseconds of latency before the device</span><br style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: He=
lvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; text-decoration: none; float: none; display: inline=
 !important;" class=3D"">emulation thread had a chance to process the virtq=
ueue. This means the</span><br style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span sty=
le=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; f=
ont-style: normal; font-variant-caps: normal; font-weight: normal; letter-s=
pacing: normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; tex=
t-decoration: none; float: none; display: inline !important;" class=3D"">ma=
ximum I/O Operations Per Second (IOPS) is capped at 250k before</span><br s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none;=
 display: inline !important;" class=3D"">virtqueue processing has even begu=
n!</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D""></div></blockquote><div><br=
 class=3D""></div><div>This data is what prompted me to write the above. Th=
is 4us seems</div><div>really long to me.</div><div><br class=3D""></div><d=
iv>I recall a benchmark where the technique above was reaching at least</di=
v><div>400k IOPs for a single VM on a medium-size system (4CPUs (*)).&nbsp;=
</div><div>I remember the time I ran this benchmark quite well, because it =
was just</div><div>after VMware made a big splash about reaching 100k IOPs:=
</div><div><a href=3D"https://blogs.vmware.com/performance/2008/05/100000-i=
o-opera.html" class=3D"">https://blogs.vmware.com/performance/2008/05/10000=
0-io-opera.html</a>.</div><div><br class=3D""></div><div>(*) Yes, at the ti=
me, 4 CPUs was a medium size system. Don't laugh.</div><div><br class=3D"">=
</div><blockquote type=3D"cite" class=3D""><div class=3D""><br style=3D"car=
et-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style=
: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: n=
ormal; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorat=
ion: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-famil=
y: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norma=
l; font-weight: normal; letter-spacing: normal; text-align: start; text-ind=
ent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -we=
bkit-text-stroke-width: 0px; text-decoration: none; float: none; display: i=
nline !important;" class=3D"">QEMU AioContext adaptive polling helps here b=
ecause we skip the vmexit</span><br style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><spa=
n style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: normal; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; text-decoration: none; float: none; display: inline !important;" class=3D=
"">entirely while the IOThread is polling the vring (for up to 32</span><br=
 style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18p=
x; font-style: normal; font-variant-caps: normal; font-weight: normal; lett=
er-spacing: normal; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0=
); font-family: Helvetica; font-size: 18px; font-style: normal; font-varian=
t-caps: normal; font-weight: normal; letter-spacing: normal; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: non=
e; display: inline !important;" class=3D"">microseconds by default).</span>=
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; font-varia=
nt-caps: normal; font-weight: normal; letter-spacing: normal; text-align: s=
tart; text-indent: 0px; text-transform: none; white-space: normal; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D=
""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-s=
ize: 18px; font-style: normal; font-variant-caps: normal; font-weight: norm=
al; letter-spacing: normal; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; text-decoration: none; float: none; display: inline !important;" c=
lass=3D"">It would be great if more people dig into this and optimize</span=
><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:=
 18px; font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float:=
 none; display: inline !important;" class=3D"">notifications further.</span=
><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:=
 18px; font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">Stefan</span></div></blockquote></div><br class=3D""></body></=
html>
--Apple-Mail=_91F4DD19-1EB7-4C8D-AF38-0F390772D1CD--
