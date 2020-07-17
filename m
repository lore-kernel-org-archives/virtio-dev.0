Return-Path: virtio-dev-return-7578-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56353986096
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 08:42:31 +0000 (UTC)
Date: Fri, 17 Jul 2020 09:42:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200717084218.GA128195@stefanha-x1.localdomain>
References: <87r1tdydpz.fsf@linaro.org>
 <20200715114855.GF18817@stefanha-x1.localdomain>
 <877dv4ykin.fsf@linaro.org>
 <20200715154732.GC47883@stefanha-x1.localdomain>
 <871rlcybni.fsf@linaro.org>
 <20200716100051.GC85868@stefanha-x1.localdomain>
 <CDD16024-AAA9-4631-82A8-479C8579D737@redhat.com>
 <20200716141930.GA114428@stefanha-x1.localdomain>
 <2D260DC5-B2FF-4760-B6A4-BCCD04BD1066@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2D260DC5-B2FF-4760-B6A4-BCCD04BD1066@redhat.com>
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
To: Christophe de Dinechin <dinechin@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 04:34:04PM +0200, Christophe de Dinechin wrote:
>=20
>=20
> > On 16 Jul 2020, at 16:19, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >=20
> > On Thu, Jul 16, 2020 at 01:25:37PM +0200, Christophe de Dinechin wrote:
> >>=20
> >>=20
> >>> On 16 Jul 2020, at 12:00, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >>>=20
> >>> On Wed, Jul 15, 2020 at 05:40:33PM +0100, Alex Benn=E9e wrote:
> >>>>=20
> >>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >>>>=20
> >>>>> On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=E9e wrote:
> >>>>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >>>>>>> On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=E9e wrote:
> >>>>>>>> Finally I'm curious if this is just a problem avoided by the s39=
0
> >>>>>>>> channel approach? Does the use of messages over a channel just a=
void the
> >>>>>>>> sort of bouncing back and forth that other hypervisors have to d=
o when
> >>>>>>>> emulating a device?
> >>>>>>>=20
> >>>>>>> What does "bouncing back and forth" mean exactly?
> >>>>>>=20
> >>>>>> Context switching between guest and hypervisor.
> >>>>>=20
> >>>>> I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
> >>>>> request on s390 channel I/O.
> >>>>=20
> >>>> Thanks.
> >>>>=20
> >>>> I was also wondering about the efficiency of doorbells/notifications=
 the
> >>>> other way. AFAIUI for both PCI and MMIO only a single write is requi=
red
> >>>> to the notify flag which causes a trap to the hypervisor and the res=
t of
> >>>> the processing. The hypervisor doesn't have the cost multiple exits =
to
> >>>> read the guest state although it obviously wants to be as efficient =
as
> >>>> possible passing the data back up to what ever is handling the backe=
nd
> >>>> of the device so it doesn't need to do multiple context switches.
> >>>>=20
> >>>> Has there been any investigation into other mechanisms for notifying=
 the
> >>>> hypervisor of an event - for example using a HYP call or similar
> >>>> mechanism?
> >>>>=20
> >>>> My gut tells me this probably doesn't make any difference as a trap =
to
> >>>> the hypervisor is likely to cost the same either way because you sti=
ll
> >>>> need to save the guest context before actioning something but it wou=
ld
> >>>> be interesting to know if anyone has looked at it. Perhaps there is =
a
> >>>> benefit in partitioned systems where core running the guest can retu=
rn
> >>>> straight away after initiating what it needs to internally in the
> >>>> hypervisor to pass the notification to something that can deal with =
it?
> >>>=20
> >>> It's very architecture-specific. This is something Michael Tsirkin
> >>> looked in in the past. He found that MMIO and PIO perform differently=
 on
> >>> x86. VIRTIO supports both so the device can be configured optimally.
> >>> There was an old discussion from 2013 here:
> >>> https://lkml.org/lkml/2013/4/4/299 <https://lkml.org/lkml/2013/4/4/29=
9> <https://lkml.org/lkml/2013/4/4/299 <https://lkml.org/lkml/2013/4/4/299>=
>
> >>>=20
> >>> Without nested page tables MMIO was slower than PIO. But with nested
> >>> page tables it was faster.
> >>>=20
> >>> Another option on x86 is using Model-Specific Registers (for hypercal=
ls)
> >>> but this doesn't fit into the PCI device model.
> >>=20
> >> (Warning: What I write below is based on experience with very differen=
t
> >> architectures, both CPU and hypervisor; your mileage may vary)
> >>=20
> >> It looks to me like the discussion so far is mostly focused on a "sync=
hronous"
> >> model where presumably the same CPU is switching context between
> >> guest and (host) device emulation.
> >>=20
> >> However, I/O devices on real hardware are asynchronous by construction=
.
> >> They do their thing while the CPU processes stuff. So at least theoret=
ically,
> >> there is no reason to context switch on the same CPU. You could very w=
ell
> >> have an I/O thread on some other CPU doing its thing. This allows to
> >> do something some of you may have heard me talk about, called
> >> "interrupt coalescing".
> >>=20
> >> As Stefan noted, this is not always a win, as it may introduce latency=
.
> >> There are at least two cases where this latency really hurts:
> >>=20
> >> 1. When the I/O thread is in some kind of deep sleep, e.g. because it
> >> was not active recently. Everything from cache to TLB may hit you here=
,
> >> but that normally happens when there isn't much I/O activity, so this =
case
> >> in practice does not hurt that much, or rather it hurts in a case wher=
e
> >> don't really care.
> >>=20
> >> 2. When the I/O thread is preempted, or not given enough cycles to do =
its
> >> stuff. This happens when the system is both CPU and I/O bound, and
> >> addressing that is mostly a scheduling issue. A CPU thread could hand-=
off
> >> to a specific I/O thread, reducing that case to the kind of context sw=
itch
> >> Alex was mentioning, but I'm not sure how feasible it is to implement
> >> that on Linux / kvm.
> >>=20
> >> In such cases, you have to pay for context switch. I'm not sure if tha=
t
> >> context switch is markedly more expensive than a "vmexit". On at least
> >> that alien architecture I was familiar with, there was little differen=
ce between
> >> switching to "your" host CPU thread and switching to "another" host
> >> I/O thread. But then the context switch was all in software, so we had
> >> designed it that way.
> >>=20
> >> So let's assume now that you run your device emulation fully in an I/O
> >> thread, which we will assume for simplicity sits mostly in host user-s=
pace,
> >> and your guest I/O code runs in a CPU thread, which we will assume
> >> sits mostly in guest user/kernel space.
> >>=20
> >> It is possible to share two-way doorbells / IRQ queues on some memory
> >> page, very similar to a virtqueue. When you want to "doorbell" your de=
vice,
> >> you simply write to that page. The device threads picks it up by readi=
ng
> >> the same page, and posts I/O completions on the same page, with simple
> >> memory writes.
> >>=20
> >> Consider this I/O exchange buffer as having (at least) a writer and re=
ader
> >> index for both doorbells and virtual interrupts. In the explanation
> >> below, I will call them "dwi", "dri", "iwi", "iri" for doorbell / inte=
rrupt read
> >> and write index. (Note that as a key optimization, you really
> >> don't want dwi and dri to be in the same cache line, since different
> >> CPUs are going to read and write them)
> >>=20
> >> You obviously still need to "kick" the I/O or CPU thread, and we are
> >> talking about an IPI here since you don't know which CPU that other
> >> thread is sitting on. But the interesting property is that you only ne=
ed
> >> to do that when dwi=3D=3Ddri or iwi=3D=3Diri, because if not, the othe=
r side
> >> has already been "kicked" and will keep working, i.e. incrementing
> >> dri or iri, until it reaches back that state.
> >>=20
> >> The real "interrupt coalescing" trick can happen here. In some
> >> cases, you can decide to update your dwi or iwi without kicking,
> >> as long as you know that you will need to kick later. That requires
> >> some heavy cooperation from guest drivers, though, and is a
> >> second-order optimization.
> >>=20
> >> With a scheme like this, you replace a systematic context switch
> >> for each device interrupt with a memory write and a "fire and forget"
> >> kick IPI that only happens when the system is not already busy
> >> processing I/Os, so that it can be eliminated when the system is
> >> most busy. With interrupt coalescing, you can send IPIs at a rate
> >> much lower than the actual I/O rate.
> >>=20
> >> Not sure how difficult it is to adapt a scheme like this to the curren=
t
> >> state of qemu / kvm, but I'm pretty sure it works well if you implemen=
t
> >> it correctly ;-)
> >>=20
> >>>=20
> >>> A bigger issue than vmexit latency is device emulation thread wakeup
> >>> latency. There is a thread (QEMU, vhost-user, vhost, etc) monitoring =
the
> >>> ioeventfd but it may be descheduled. Its physical CPU may be in a low
> >>> power state. I ran a benchmark late last year with QEMU's AioContext
> >>> adaptive polling disabled so we can measure the wakeup latency:
> >>>=20
> >>>      CPU 0/KVM 26102 [000] 85626.737072:       kvm:kvm_fast_mmio:
> >>> fast mmio at gpa 0xfde03000
> >>>   IO iothread1 26099 [001] 85626.737076: syscalls:sys_exit_ppoll: 0x1
> >>>                  4 microseconds ------^
> >=20
> > Hi Christophe,
> > QEMU/KVM does something similar to what you described. In the perf
> > output above the vmexit kvm_fast_mmio event occurs on physical CPU
> > "[000]".  The IOThread wakes up on physical CPU "[001]". Physical CPU#0
> > resumes guest execution immediately after marking the ioeventfd ready.
> > There is no context switch to the IOThread or a return from
> > ioctl(KVM_RUN) on CPU#0.
> >=20
> Oh, that's good.
>=20
> But then the conclusion that the 4us delay limits us to 250kIOPS
> is incorrect, no? Is there anything that would prevent multiple
> I/O events (doorbell or interrupt) to be in flight at the same time?

The number I posted is a worst-case latency scenario:

1. Queue depth =3D 1. No batching. Workloads that want to achieve maximum
   IOPS typically queue more than 1 request at a time. When multiple
   requests are queued both submission and completion can be batched so
   that only a fraction of vmexits + interrupts are required to process
   N requests.

2. QEMU AioContext adaptive polling disabled. Polling skips ioeventfd
   and instead polls on the virtqueue ring index memory that the guest
   updates. Polling is on by default when -device
   virtio-blk-pci,iothread=3D is used but I disabled it for this test.

But if we stick with the worst-case scenario then we are really limited
to 250k IOPS per virtio-blk device because a single IOThread is
processing the virtqueue with a 4 microsecond wakeup latency.

Stefan

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8RZGoACgkQnKSrs4Gr
c8joWgf/RZMONm/cbmiJqis/iaCn3PDqgK2uoFkd6v0/QC4YJPaBZDO+Fv0qp8qo
CugryDtq789SUsCvRLWHCS6dnouPiNPa88uj0sivG4lroY12HBIK9ASPtyW68iKw
uCLKsbl2pF8As+OZw9j/RXreLFK7JoHTBT8f5B/avi+pjGos005DPp6aikpMbfdK
yNZRmr6ORRHyrszQ5H2HyD39VSWMPmZTYx58Mq6s5/8HHkT05SRz7lo2bH4UL/tB
y/uT6Sha12uZmMq7K/BYyaISPvrISEC1D+WlBuaom3Ig5KhRu4v2SW3S0mX4lb9u
g2CDqhK7VaUB78o2OB0elIjxcU3QoA==
=P/yD
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

