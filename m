Return-Path: <virtio-dev-return-9051-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3FB0986510
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Jan 2022 17:16:38 +0000 (UTC)
Date: Fri, 14 Jan 2022 17:16:13 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <YeGv3TTS0vz/yIaB@myrica>
References: <87lezrhd8p.fsf@linaro.org>
 <YdwBGYBdzfYxOvp4@stefanha-x1.localdomain>
 <87r19a8jub.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87r19a8jub.fsf@linaro.org>
Subject: Re: [virtio-dev] Some thoughts on zero-copy between VM domains for
 discussion
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>, Tom Gall <tom.gall@linaro.org>, Christopher Clark <christopher.w.clark@gmail.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Trilok Soni <tsoni@quicinc.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Anmar Oueja <anmar.oueja@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 14, 2022 at 02:28:11PM +0000, Alex Benn=C3=A9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > [[PGP Signed Part:Undecided]]
> > On Thu, Jan 06, 2022 at 05:03:38PM +0000, Alex Benn=C3=A9e wrote:
> >>=20
> >> Hi,
> >>=20
> >> To start the new year I thought would dump some of my thoughts on
> >> zero-copy between VM domains. For project Stratos we've gamely avoided
> >> thinking too hard about this while we've been concentrating on solving
> >> more tractable problems. However we can't put it off forever so lets
> >> work through the problem.
> >>=20
> >> Memory Sharing
> <snip>
> >> Buffer Allocation
> <snip>
> >> Transparent fallback and scaling
> <snip>
> >>=20
> >>  - what other constraints we need to take into account?
> >>  - can we leverage existing sub-systems to build this support?
> >>=20
> >> I look forward to your thoughts ;-)
> >
> > (Side note: Shared Virtual Addressing (https://lwn.net/Articles/747230/=
)
> > is an interesting IOMMU feature. It would be neat to have a CPU
> > equivalent where loads and stores from/to another address space could b=
e
> > done cheaply with CPU support. I don't think this is possible today and
> > that's why software IOMMUs are slow for per-transaction page protection=
.
> > In other words, a virtio-net TX VM would set up a page table allowing
> > read access only to the TX buffers and vring and the virtual network
> > switch VM would have the capability to access the vring and buffers
> > through the TX VM's dedicated address space.)
>=20
> Does binding a device to an address space mean the driver allocations
> will be automatically done from the address space or do the drivers need
> modifying to take advantage of that? Jean-Phillipe?

The drivers do need modifying and the APIs are very different: with SVA
you're assigning partitions of devices (for example virtqueues) to
different applications. So the kernel driver only does management and
userspace takes care of the data path. A device partition accesses the
whole address space of the process it is assigned to, so there is no
explicit DMA allocation.

Note that it also requires special features from the device (multiple
address spaces with PCIe PASID, recoverable DMA page faults with PRI).
And the concept doesn't necessarily fit nicely with all device classes -
you probably don't want to load a full network stack in any application
that needs to send a couple of packets. One that demonstrates the concept
well in my opinion is the crypto/compression accelerators that use SVA in
Linux [1]: any application that needs fast compression or encryption on
some of its memory can open a queue in the accelerator, submit jobs with
pointers to input and output buffers and wait for completion while doing
something else. It is several orders of magnitude faster than letting the
CPU do this work and only the core mm deals with memory management.

Anyway this seems mostly off-topic. As Stefan said what would be useful
for our problem is help from the CPUs to share bits of address space
without disclosing the whole VM memory. At the moment any vIOMMU mapping
needs to be shadowed by the hypervisor somehow. Unless we use static
shared memory regions, frontend VM needs to tell the hypervisor which
pages it chooses to share with backend VM, and the hypervisor to map then
unmap that into backend VM's stage-2. I think that operation requires two
context switches to the hypervisor any way we look at it.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/1579097568-17542-1-git-send-email-z=
hangfei.gao@linaro.org/

>=20
> > Some storage and networking applications use buffered I/O where the
> > guest kernel owns the DMA buffer while others use zero-copy I/O where
> > guest userspace pages are pinned for DMA. I think both cases need to be
> > considered.
> >
> > Are guest userspace-visible API changes allowed (e.g. making the
> > userspace application aware at buffer allocation time)?
>=20
> I assume you mean enhanced rather than breaking APIs here? I don't see
> why not. Certainly for the vhost-user backends we are writing we aren't
> beholden to sticking to an old API.
>=20
> > Ideally the
> > requirement would be that zero-copy must work for unmodified
> > applications, but I'm not sure if that's realistic.
> >
> > By the way, VIRTIO 1.2 introduces Shared Memory Regions. These are
> > memory regions (e.g. PCI BAR ranges) that the guest driver can map. If
> > the host pages must come from a special pool then Shared Memory Regions
> > would be one way to configure the guest to use this special zero-copy
> > area for data buffers and even vrings. New VIRTIO feature bits and
> > transport-specific information may need to be added to do this.
>=20
> Are these fixed sizes or could be accommodate a growing/shrinking region?
>=20
> Thanks for the pointers.
>=20
> --=20
> Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

