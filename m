Return-Path: <virtio-dev-return-9010-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0850986254
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jan 2022 09:49:23 +0000 (UTC)
Date: Mon, 10 Jan 2022 09:49:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YdwBGYBdzfYxOvp4@stefanha-x1.localdomain>
References: <87lezrhd8p.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87lezrhd8p.fsf@linaro.org>
Subject: Re: [virtio-dev] Some thoughts on zero-copy between VM domains for
 discussion
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="myDvb8pTASWvohK2"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>, Tom Gall <tom.gall@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Christopher Clark <christopher.w.clark@gmail.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Trilok Soni <tsoni@quicinc.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Anmar Oueja <anmar.oueja@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--myDvb8pTASWvohK2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2022 at 05:03:38PM +0000, Alex Benn=E9e wrote:
>=20
> Hi,
>=20
> To start the new year I thought would dump some of my thoughts on
> zero-copy between VM domains. For project Stratos we've gamely avoided
> thinking too hard about this while we've been concentrating on solving
> more tractable problems. However we can't put it off forever so lets
> work through the problem.
>=20
> Memory Sharing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> For any zero-copy to work there has to be memory sharing between the
> domains. For traditional KVM this isn't a problem as the host kernel
> already has access to the whole address space of all it's guests.
> However type-1 setups (and now pKVM) are less promiscuous about sharing
> their address space across the domains.
>=20
> We've discussed options like dynamically sharing individual regions in
> the past (maybe via iommu hooks). However given the performance
> requirements I think that is ruled out in favour of sharing of
> appropriately sized blocks of memory. Either one of the two domains has
> to explicitly share a chunk of its memory with the other or the
> hypervisor has to allocate the memory and make it visible to both. What
> considerations do we have to take into account to do this?
>=20
>  * the actual HW device may only have the ability to DMA to certain
>    areas of the physical address space.
>  * there may be alignment requirements for HW to access structures (e.g.
>    GPU buffers/blocks)
>=20
> Which domain should do the sharing? The hypervisor itself likely doesn't
> have all the information to make the choice but in a distributed driver
> world it won't always be the Dom0/Host equivalent. While the domain with
> the HW driver in it will know what the HW needs it might not know if the
> GPA's being used are actually visible to the real PA it is mapped to.
>=20
> I think this means for useful memory sharing we need the allocation to
> be done by the HW domain but with support from the hypervisor to
> validate the region meets all the physical bus requirements.
>=20
> Buffer Allocation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Ultimately I think the majority of the work that will be needed comes
> down to how buffer allocation is handled in the kernels. This is also
> the area I'm least familiar with so I look forward to feedback from
> those with deeper kernel knowledge.
>=20
> For Linux there already exists the concept of DMA reachable regions that
> take into account the potentially restricted set of addresses that HW
> can DMA to. However we are now adding a second constraint which is where
> the data is eventually going to end up.
>=20
> For example the HW domain may be talking to network device but the
> packet data from that device might be going to two other domains. We
> wouldn't want to share a region for received network packets between
> both domains because that would leak information so the network driver
> needs knowledge of which shared region to allocate from and hope the HW
> allows us to filter the packets appropriately (maybe via VLAN tag). I
> suspect the pure HW solution of just splitting into two HW virtual
> functions directly into each domain is going to remain the preserve of
> expensive enterprise kit for some time.
>=20
> Should the work be divided up between sub-systems? Both the network and
> block device sub-systems have their own allocation strategies and would
> need some knowledge about the final destination for their data. What
> other driver sub-systems are going to need support for this sort of
> zero-copy forwarding? While it would be nice for every VM transaction to
> be zero-copy we don't really need to solve it for low speed transports.
>=20
> Transparent fallback and scaling
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> As we know memory is always a precious resource that we never have
> enough of. The more we start carving up memory regions for particular
> tasks the less flexibility the system has as a whole to make efficient
> use of it. We can almost guarantee whatever number we pick for given
> VM-to-VM conduit will be wrong. Any memory allocation system based on
> regions will have to be able to fall back graciously to using other
> memory in the HW domain and rely on traditional bounce buffering
> approaches while under heavy load. This will be a problem for VirtIO
> backends to understand when some data that needs to go to the FE domain
> needs this bounce buffer treatment. This will involve tracking
> destination domain metadata somewhere in the system so it can be queried
> quickly.
>=20
> Is there a cross-over here with the kernels existing support for NUMA
> architectures? It seems to me there are similar questions about the best
> place to put memory that perhaps we can treat multi-VM domains as
> different NUMA zones?
>=20
> Finally there is the question of scaling. While mapping individual
> transactions would be painfully slow we need to think about how dynamic
> a modern system is. For example do you size your shared network region
> to cope with a full HD video stream of data? Most of the time the
> user won't be doing anything nearly as network intensive.
>=20
> Of course adding the dynamic addition (and removal) of shared memory
> regions brings in more potential synchronisation problems of ensuring
> shared memory isn't accessed by either side when taken down. We would
> need some sort of assurance the sharee has finished with all the data in
> a given region before the sharer brings the share down.
>=20
> Conclusion
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This long text hasn't even attempted to come up with a zero-copy
> architecture for Linux VMs. I'm hoping as we discuss this we can capture
> all the various constraints any such system is going to need to deal
> with. So my final questions are:
>=20
>  - what other constraints we need to take into account?
>  - can we leverage existing sub-systems to build this support?
>=20
> I look forward to your thoughts ;-)

(Side note: Shared Virtual Addressing (https://lwn.net/Articles/747230/)
is an interesting IOMMU feature. It would be neat to have a CPU
equivalent where loads and stores from/to another address space could be
done cheaply with CPU support. I don't think this is possible today and
that's why software IOMMUs are slow for per-transaction page protection.
In other words, a virtio-net TX VM would set up a page table allowing
read access only to the TX buffers and vring and the virtual network
switch VM would have the capability to access the vring and buffers
through the TX VM's dedicated address space.)

Some storage and networking applications use buffered I/O where the
guest kernel owns the DMA buffer while others use zero-copy I/O where
guest userspace pages are pinned for DMA. I think both cases need to be
considered.

Are guest userspace-visible API changes allowed (e.g. making the
userspace application aware at buffer allocation time)? Ideally the
requirement would be that zero-copy must work for unmodified
applications, but I'm not sure if that's realistic.

By the way, VIRTIO 1.2 introduces Shared Memory Regions. These are
memory regions (e.g. PCI BAR ranges) that the guest driver can map. If
the host pages must come from a special pool then Shared Memory Regions
would be one way to configure the guest to use this special zero-copy
area for data buffers and even vrings. New VIRTIO feature bits and
transport-specific information may need to be added to do this.

Stefan

--myDvb8pTASWvohK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHcARkACgkQnKSrs4Gr
c8g1MAf+MlnL3ExyoCXROnbuJFmnxcWBPAz+5CE2kYzeIHpp8z8gNoyUTSGkAUjA
Y8qP3EmbcZfGEW3FYkQnGrvhgSzkdA1ZlHP0TPISSsjEnLNq3/Q/48QcFoAHxE9k
Z3AnqC+8wosTcNFg2a88iNhZnlN1ZpzXgRR6/WY4FuH30UDXKTvA1GDWoLqY89gx
9j//adwnRpcOlllylN910O7yAc/x4UZcUtQbW2w0joFylkBoARsWc42ETXiYIJFn
7q4SvW4phvDLozXq6PTxCsHq+VHjKJC/48r4kTXbDnXqJHf3OUtByNXWk1TqzRHu
0F+IFmm7+BJLr+feHoTBqVOKGux6sA==
=tvE4
-----END PGP SIGNATURE-----

--myDvb8pTASWvohK2--

