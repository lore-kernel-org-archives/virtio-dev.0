Return-Path: <virtio-dev-return-9652-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DE409864BF
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Jul 2022 13:49:15 +0000 (UTC)
Date: Tue, 12 Jul 2022 14:49:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Ys1704UaN4/e3/Rf@stefanha-x1.localdomain>
References: <6f4f611e95cf49b0b16b37efba6bf78a@HIMDWSMB01.ad.harman.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zODSeD4AzqUlBJa/"
Content-Disposition: inline
In-Reply-To: <6f4f611e95cf49b0b16b37efba6bf78a@HIMDWSMB01.ad.harman.com>
Subject: Re: [virtio-dev] VM memory protection and zero-copy transfers.
To: "Afsa, Baptiste" <Baptiste.Afsa@harman.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--zODSeD4AzqUlBJa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2022 at 01:56:31PM +0000, Afsa, Baptiste wrote:
> Hello everyone,
>=20
> The traditional virtio model relies on the ability for the host to access=
 the
> entire memory of the guest VM.

The VIRTIO device model (virtqueues, configuration space, feature
negotiation, etc) does not rely on shared memory access between the
device and the driver.

There is a shared memory resource in the device model that some devices
use, but that's the only thing that requires shared memory.

It's the virtio-pci, virtio-mmio, etc transports and their use of the
vring layout that requires shared memory access.

This might seem pedantic but there's a practical reason for making the
distinction. It should be possible to have a virtio-tcp or other message
passing transport for VIRTIO one day. Correctly layered drivers will
work regardless of whether the underlying transport relies on shared
memory or message passing.

> Virtio is also used in system configurations
> where the devices are not featured by the host (which may not exist as su=
ch in
> the case of a Type-1 hypervisor) but by another, unprivileged guest VM. I=
n such
> a configuration, the guest VM memory sharing requirement would raise secu=
rity
> concerns.

Guest drivers can use IOMMU functionality to restrict device access to
memory, if available from the transport. For example, a virtio-pci
driver implementation can program the IOMMU to allow read/write access
only to the vring and virtqueue buffer pages.

> The following proposal removes that requirement by introducing an alterna=
tive
> model where the interactions between the virtio driver and the virtio dev=
ice are
> mediated by the hypervisor. This concept is applicable to both Type-1 and=
 Type-2
> hypervisors. In the following write-up, the "host" thus refers either to =
the
> host OS or to the guest VM that executes the virtio device.
>=20
> The main objective is to keep the memory of the VM that runs the driver i=
solated
> from the memory that runs the device, while still allowing zero-copy tran=
sfers
> between the two domains. The operations that control the exchange of the =
virtio
> buffers are handled by hypervisor code that sits between the device and t=
he
> driver.
>=20
> As opposed to the regular virtio model, the virtqueues allocated by the d=
river
> are not shared with the device directly. Instead, the hypervisor allocate=
s a
> separate set of virtqueues that have the same sizes as the original ones =
and
> shares this second set with the device. These hypervisor-allocated virtqu=
eues
> are referred as the "shadow virtqueues".
>=20
> During device operation, the hypervisor copies the descriptors between the
> driver and the shadow virtqueues as the buffers cycle between the driver =
and the
> device.
>=20
> Whenever the driver adds some buffers to the available ring, the hypervis=
or
> validates the descriptors and dynamically grants the I/O buffers to the h=
ost or
> VM that runs the device. The hypervisor then copies these descriptors to =
the
> shadow virtqueue's available ring. At the other end, when the device retu=
rns
> buffers to the shadow virtqueue's used ring, the hypervisor unmaps these =
buffers
> from the host's address space and copy the descriptor to the driver's use=
d ring.
>=20
> Although the virtio buffers can be allocated anywhere in the guest memory=
 and
> are not necessarily page-aligned, the memory sharing granularity is const=
rained
> by the page size. So when a buffer is mapped to the host address space, t=
he
> hypervisor may end up sharing more memory that what is strictly needed.
>=20
> The cost of granting the memory dynamically as virtio transfers goes is
> significant, though. We measured up to 40% performance degradation when u=
sing
> this dynamic buffer granting mechanism.
>=20
> We also compared this solution to other approaches that we have seen else=
where.
> For instance, using the swiotlb mechanism along with the
> VIRTIO_F_ACCESS_PLATFORM feature bit to force a copy of the I/O buffers t=
o a
> statically shared memory region. In that case, the same set of benchmarks=
 shows
> an even bigger performance degradation, up to 60%, compared to the origin=
al
> virtio performance.

Did you try virtio-pci with an IOMMU? The advantage compared to both
your proposal and swiotlb is that workloads that reuse buffers have no
performance overhead because the IOMMU mappings remain in place across
virtqueue requests.

I have CCed Jean-Philippe Brucker <jean-philippe@linaro.org> who
designed the virtio-iommu device.

Using an IOMMU can be slower than the approach you are proposing when
each request requires new mappings. That's because your approach
combines the virtqueue kick processing with the page granting whereas
programming an IOMMU with map/unmap commands is a separate vmexit from
the virtqueue kick. It's probably easier to make your approach faster in
the dynamic mappings case for this reason.

A page-table based IOMMU (doesn't require explicit map/unamp commands
because it reads mappings on-demand from a page table structure) might
perform better than one that needs to be programmed for each each
map/unmap operation. It still needs a kick (vmexit) for invalidation but
it might be possible for a design of this type to avoid vmexits in the
common case.

>=20
> Although the shadow virtqueue concept looks fairly simple, there is still=
 one
> point that has not been covered yet: indirect descriptors.
>=20
> To support indirect descriptors, the following two options were considered
> initially:
>=20
>   1. Grant the indirect descriptor as-is to the host while it is on the u=
sed
>      ring. This introduces a security issue because a compromised guest O=
S can
>      modify the indirect descriptor after it has been pushed to the avail=
able
>      ring. This would cause the device to fault while trying to access any
>      arbitrary memory that was not actually granted.
>=20
>      Note that in the shadow virtqueue model, there is no need for the de=
vice to
>      validate the descriptors in the available rings, because the hypervi=
sor
>      already performed such checks before granting the memory.

Assuming that the driver can trust the device isn't possible in all use
cases. Hardware VIRTIO device implementations, VDUSE
(https://docs.kernel.org/userspace-api/vduse.html), and Confidential
Computing are 3 use cases where the device is untrusted. If you make the
assumption then it's important to clearly mark the code so it won't be
reused in a context where that would be a security problem.

>=20
>   2. Follow the same logic that is used for the "normal" descriptors and
>      introduce shadow indirect descriptors. This would require the hyperv=
isor to
>      provision a memory pool to allocate these shadow indirect descriptor=
s and
>      determining the size of this pool may not be trivial.
>=20
>      Additionally, indirect descriptors can be as large as the driver wan=
ts them
>      to be, something that can cause the hypervisor to copy an arbitrary =
large
>      amount of data.

I agree that it's unfortunate that indirect descriptors would require
some kind of dynamic memory in the hypervisor. However, the statement
about indirect descriptor size is incorrect. They are limited by Queue
Size:

  VIRTIO 1.2 2.7.5.3.1 Driver Requirements: Indirect Descriptors

  A driver MUST NOT create a descriptor chain longer than the Queue Size
  of the device.

>=20
> An alternative approach consists in introducing a new virtio feature bit.=
 This
> feature bit, when set by the device, instructs the driver to allocate ind=
irect
> descriptors using dedicated memory pages. These pages shall hold no other=
 data
> than the indirect descriptors. Since a correct virtio driver implementati=
on does
> not modify an indirect descriptor once it has been pushed to the device, =
the
> pages where the indirect descriptors lies can later on be remapped as rea=
d-only
> in the guest address space.
>=20
> This allows the hypervisor to validate the content of the indirect descri=
ptor,
> grant it to the host (along with all the buffers referenced by this descr=
iptor)
> and remap the indirect descriptor read-only in the guest address space as=
 long
> as it is granted to the host (i.e. until the indirect descriptor is retur=
ned
> through the used ring).

That sounds very slow (2 page table updates per request).

> The present proposal has some obvious drawbacks, but we believe that memo=
ry
> protection will not come for free. We know that there are other folks out=
 there
> which try to address this issue of memory sharing between VMs, so we woul=
d be
> pleased to hear what you guys think about this approach.
>=20
> Additionally, we would like to know whether a feature bit similar to the =
one
> that was discussed here could be considered for addition to the virtio st=
andard.

Memory isolation is hard to do efficiently. It would be great to discuss
your proposal more with the VIRTIO community and then send a spec patch
for detailed review and voting.

One thing I didn't see in your proposal was a copying vs zero-copy
threshold. Maybe it helps to look at the size of requests and copy data
instead of granting pages when descriptors are small? On the other hand,
a 4 KB page size means that many descriptors won't be larger than 4 KB
anyway due to guest physical memory fragmentation. This is basically
hybrid of swiotlb and your proposal - zero-copy when it pays off,
copying when it's cheap.

As I mentioned, I think IOMMUs are worth investigating, in particular
for the case where mappings are rarely changed. They are fast in that
case.

By the way, KVM Forum is coming up in September 2022 in Dublin, Ireland
where Linux Plumbers Conference, LinuxCon Europe, Open Source Summit
Europe, and other conferences are also taking place. That's a good venue
to meet with others interested in VIRTIO and discussing your idea.

Stefan

--zODSeD4AzqUlBJa/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmLNe9MACgkQnKSrs4Gr
c8jlAgf+MziDfCHt4wXdJMy2S7RwfiSfRcuiYcjri5XbcF9iNsm1FhTeoV20IZ7I
rUZuijj1K3SbLr+I3RfSSrLGrje1/6XAKBsQ216h7YKhoZv78xU7CrqsUxOOUnKI
W6bduJlOFt/B2D0FYPvqa+91B/6HqknAUcsQfyDzhzAzy8oDsZjV0AFRvBCh7Ys6
w+fuMVVnnjPh1VvAbwgAV7RmZyFv0C6GEh0ixAWttc3fuJhHydX5Z6L40XBNOqRn
ylA3PxIh9klDTeX1R8OPptVxCnbnwVBu6IX63iCiQi1wK6070RR8aWtq/hsPJD+c
t4e5fLq5M71q5Q7LfoCM51zhEafudw==
=MIfC
-----END PGP SIGNATURE-----

--zODSeD4AzqUlBJa/--

