Return-Path: <virtio-dev-return-9943-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8679986584
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Sep 2022 16:05:18 +0000 (UTC)
Date: Fri, 9 Sep 2022 12:05:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YxtkNp66VCUzXVpk@fedora>
References: <6f4f611e95cf49b0b16b37efba6bf78a@HIMDWSMB01.ad.harman.com>
 <Ys1704UaN4/e3/Rf@stefanha-x1.localdomain>
 <1657894712677.5057@harman.com>
 <YtGayTbaFh9cbp/U@stefanha-x1.localdomain>
 <1662713522072.6550@harman.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+kNeTn/2z4RP5rvr"
Content-Disposition: inline
In-Reply-To: <1662713522072.6550@harman.com>
Subject: Re: [virtio-dev] VM memory protection and zero-copy transfers.
To: "Afsa, Baptiste" <Baptiste.Afsa@harman.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--+kNeTn/2z4RP5rvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2022 at 08:52:02AM +0000, Afsa, Baptiste wrote:
> Hello,
>=20
> I ran some benchmarks to compare the performances achieved by the swiotlb
> approach and our dynamic memory granting solution while using different b=
uffer
> sizes. Without any surprise, the swiotlb approach performs much better wh=
en the
> buffers are small. Actually for small buffers, the performances are on pa=
r with
> the original configuration where the entire memory is shared. Of course t=
hese
> results are specific to the platform I used and the system workload (e.g.=
 CPU
> utilization, caches utilization).
>=20
> At the moment we are not planning to add a mechanism that would take the
> decision between copying or granting the buffers dynamically based on the=
ir
> sizes, but this experience showed us that devices that uses small packets=
 would
> benefits from going through the swiotlb. So we are considering making this
> configurable on a per-device basis in our solution.
>=20
> We have also experimented with the use of a virtual IOMMU on the guest si=
de and
> we have a few concerns with this option.
>=20
> If we add a virtual IOMMU, we can see mapping commands being issued as vi=
rtio
> buffers are exchanged between the device and the driver. However the kern=
el
> controls the mappings from DMA addresses to physical addresses. In theory=
, we
> could remap the memory in the host address space to "implement" these map=
pings
> but we have some additional constraints that make this approach problemat=
ic.
>=20
> Our solution runs on systems where the physical IOMMU does not support ad=
dress
> translation. So we rely on having an identity mapping between the guest a=
ddress
> space and the physical address space to allow the guest OS to initiate DMA
> transactions. If the memory that we import for virtio buffers uses transl=
ated
> addresses, these buffers cannot be used in DMA transactions.
>=20
> We also have an issue with letting the driver control the exported memory
> through an IOMMU. If we do this, we need to consider what will happen if =
the
> guest unmaps a virtio buffer while it is in use on the device side.
>=20
> Although it looks possible to recover from such a scenario in the case of=
 a
> device doing CPU accesses to the shared memory, things get more complicat=
ed if
> we start considering that the buffer may be involved in a DMA transaction.
>=20
> In some previous projects, we have learned that the ability for the hardw=
are
> device and/or its associated driver to recover from an aborted transactio=
n is
> not something that we can rely upon in the general case.
>=20
> For this reason, in our typical memory granting scenarios, we usually "lo=
ck" the
> shared memory regions to prevent the exporter from revoking the mappings =
until
> the importer says it is ok to do so.
>=20
> Note that locking the mappings could be applied here as well. In this cas=
e, we
> would still use this concept of shadow virtqueues and the hypervisor woul=
d be
> responsible for locking/unlocking the virtio buffers as they cycle betwee=
n the
> device and the driver. This design is likely to be slower than the origin=
al
> implementation as the cost of locking the mappings is significant (i.e. a=
n extra
> page table walk to validate the memory regions).
>=20
> As we discussed in this thread, there are a few options available to enab=
le
> virtio in configurations where the VM address spaces are isolated. I thin=
k they
> all have different trade-offs. Our approach certainly have some drawbacks=
 but it
> also addresses some specific considerations that are relevant in our use
> case. Different configurations will probably require different solutions =
to this
> question.
>=20
> What would be the next steps to go forward with adding a new feature bit =
such as
> the one I discussed in my original email? Should we prepare a patch on the
> specification and post it here for further discussions?

Hi Baptiste,
Thanks for sharing your findings. As the next step please send your
VIRTIO spec change proposal to the mailing list so they can be discussed
in detail.

Example commands for sending spec patch emails are here:
https://github.com/oasis-tcs/virtio-spec#providing-feedback

Thanks,
Stefan

--+kNeTn/2z4RP5rvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMbZDYACgkQnKSrs4Gr
c8jA/Af9FcHW/DLUeOieuXipjBn0fIXCB+QLWbpRRbADMylYyVo68Q1P3jUe/Ed+
8HKIF77xC1DOIarRDXFReRLZeRYJt8KF5wbkzHULemOciKR3/He0HgVwZifaMzaq
VjeM7mWw5tGfW/yVssvDlbuxUp5PTh9559bUvqhy3buisbz9lKOiz222PJmwM3dB
eODxo6qnIWCJLWrEv+x2K/NlczdYyJ38GHnGoFeIYtldewWAskrfYmjEim3fcroy
DsRctFHmaJwj43ge7ph0GduKugVktGwEXWyvM5XySdAPtWR42xR/09QtXdxgDYor
Hc9DInEL7murAPfqPverSh6yj0Cs7g==
=k0cu
-----END PGP SIGNATURE-----

--+kNeTn/2z4RP5rvr--

