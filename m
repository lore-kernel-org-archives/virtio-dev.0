Return-Path: <virtio-dev-return-9009-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 285B79864CC
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jan 2022 13:44:26 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 06 Jan 2022 17:03:38 +0000
Message-ID: <87lezrhd8p.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Some thoughts on zero-copy between VM domains for discussion
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>, Tom Gall <tom.gall@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Christopher Clark <christopher.w.clark@gmail.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Trilok Soni <tsoni@quicinc.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Anmar Oueja <anmar.oueja@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi,

To start the new year I thought would dump some of my thoughts on
zero-copy between VM domains. For project Stratos we've gamely avoided
thinking too hard about this while we've been concentrating on solving
more tractable problems. However we can't put it off forever so lets
work through the problem.

Memory Sharing
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

For any zero-copy to work there has to be memory sharing between the
domains. For traditional KVM this isn't a problem as the host kernel
already has access to the whole address space of all it's guests.
However type-1 setups (and now pKVM) are less promiscuous about sharing
their address space across the domains.

We've discussed options like dynamically sharing individual regions in
the past (maybe via iommu hooks). However given the performance
requirements I think that is ruled out in favour of sharing of
appropriately sized blocks of memory. Either one of the two domains has
to explicitly share a chunk of its memory with the other or the
hypervisor has to allocate the memory and make it visible to both. What
considerations do we have to take into account to do this?

 * the actual HW device may only have the ability to DMA to certain
   areas of the physical address space.
 * there may be alignment requirements for HW to access structures (e.g.
   GPU buffers/blocks)

Which domain should do the sharing? The hypervisor itself likely doesn't
have all the information to make the choice but in a distributed driver
world it won't always be the Dom0/Host equivalent. While the domain with
the HW driver in it will know what the HW needs it might not know if the
GPA's being used are actually visible to the real PA it is mapped to.

I think this means for useful memory sharing we need the allocation to
be done by the HW domain but with support from the hypervisor to
validate the region meets all the physical bus requirements.

Buffer Allocation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ultimately I think the majority of the work that will be needed comes
down to how buffer allocation is handled in the kernels. This is also
the area I'm least familiar with so I look forward to feedback from
those with deeper kernel knowledge.

For Linux there already exists the concept of DMA reachable regions that
take into account the potentially restricted set of addresses that HW
can DMA to. However we are now adding a second constraint which is where
the data is eventually going to end up.

For example the HW domain may be talking to network device but the
packet data from that device might be going to two other domains. We
wouldn't want to share a region for received network packets between
both domains because that would leak information so the network driver
needs knowledge of which shared region to allocate from and hope the HW
allows us to filter the packets appropriately (maybe via VLAN tag). I
suspect the pure HW solution of just splitting into two HW virtual
functions directly into each domain is going to remain the preserve of
expensive enterprise kit for some time.

Should the work be divided up between sub-systems? Both the network and
block device sub-systems have their own allocation strategies and would
need some knowledge about the final destination for their data. What
other driver sub-systems are going to need support for this sort of
zero-copy forwarding? While it would be nice for every VM transaction to
be zero-copy we don't really need to solve it for low speed transports.

Transparent fallback and scaling
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

As we know memory is always a precious resource that we never have
enough of. The more we start carving up memory regions for particular
tasks the less flexibility the system has as a whole to make efficient
use of it. We can almost guarantee whatever number we pick for given
VM-to-VM conduit will be wrong. Any memory allocation system based on
regions will have to be able to fall back graciously to using other
memory in the HW domain and rely on traditional bounce buffering
approaches while under heavy load. This will be a problem for VirtIO
backends to understand when some data that needs to go to the FE domain
needs this bounce buffer treatment. This will involve tracking
destination domain metadata somewhere in the system so it can be queried
quickly.

Is there a cross-over here with the kernels existing support for NUMA
architectures? It seems to me there are similar questions about the best
place to put memory that perhaps we can treat multi-VM domains as
different NUMA zones?

Finally there is the question of scaling. While mapping individual
transactions would be painfully slow we need to think about how dynamic
a modern system is. For example do you size your shared network region
to cope with a full HD video stream of data? Most of the time the
user won't be doing anything nearly as network intensive.

Of course adding the dynamic addition (and removal) of shared memory
regions brings in more potential synchronisation problems of ensuring
shared memory isn't accessed by either side when taken down. We would
need some sort of assurance the sharee has finished with all the data in
a given region before the sharer brings the share down.

Conclusion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This long text hasn't even attempted to come up with a zero-copy
architecture for Linux VMs. I'm hoping as we discuss this we can capture
all the various constraints any such system is going to need to deal
with. So my final questions are:

 - what other constraints we need to take into account?
 - can we leverage existing sub-systems to build this support?

I look forward to your thoughts ;-)

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

