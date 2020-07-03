Return-Path: virtio-dev-return-7522-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A6E44986005
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Jul 2020 12:22:15 +0000 (UTC)
Date: Fri, 3 Jul 2020 13:22:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200703122200.GA191363@stefanha-x1.localdomain>
References: <87a7194kgt.fsf@linaro.org>
 <28614897-bfb7-b36c-6698-6c6942a87399@siemens.com>
 <20200618132958.GB2013520@stefanha-x1.localdomain>
 <2fe9e849-a93d-e3b0-30b9-0d7bef723813@siemens.com>
 <20200618105104-mutt-send-email-mst@kernel.org>
 <87cb818e-f9a5-67ff-8b78-94568e8b4e66@siemens.com>
 <20200618110218-mutt-send-email-mst@kernel.org>
 <91f501fc-b31c-f0e4-3f4d-b6f6d0181780@siemens.com>
 <20200618112833-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200618112833-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: Constraining where a guest may allocate virtio
 accessible resources
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 11:29:07AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 18, 2020 at 05:22:40PM +0200, Jan Kiszka wrote:
> > On 18.06.20 17:05, Michael S. Tsirkin wrote:
> > > On Thu, Jun 18, 2020 at 04:58:40PM +0200, Jan Kiszka wrote:
> > >>>>>>> Option 5 - Additional Device
> > >>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >>>>>>>
> > >>>>>>> The final approach would be to tie the allocation of virtqueues=
 to
> > >>>>>>> memory regions as defined by additional devices. For example th=
e
> > >>>>>>> proposed IVSHMEMv2 spec offers the ability for the hypervisor t=
o present
> > >>>>>>> a fixed non-mappable region of the address space. Other proposa=
ls like
> > >>>>>>> virtio-mem allow for hot plugging of "physical" memory into the=
 guest
> > >>>>>>> (conveniently treatable as separate shareable memory objects fo=
r QEMU
> > >>>>>>> ;-).
> > >>>>>>>
> > >>>>>>
> > >>>>>> I think you forgot one approach: virtual IOMMU. That is the adva=
nced
> > >>>>>> form of the grant table approach. The backend still "sees" the f=
ull
> > >>>>>> address space of the frontend, but it will not be able to access=
 all of
> > >>>>>> it and there might even be a translation going on. Well, like IO=
MMUs work.
> > >>>>>>
> > >>>>>> However, this implies dynamics that are under guest control, nam=
ely of
> > >>>>>> the frontend guest. And such dynamics can be counterproductive f=
or
> > >>>>>> certain scenarios. That's where this static windows of shared me=
mory
> > >>>>>> came up.
> > >>>>>
> > >>>>> Yes, I think IOMMU interfaces are worth investigating more too. I=
OMMUs
> > >>>>> are now widely implemented in Linux and virtualization software. =
That
> > >>>>> means guest modifications aren't necessary and unmodified guest
> > >>>>> applications will run.
> > >>>>>
> > >>>>> Applications that need the best performance can use a static mapp=
ing
> > >>>>> while applications that want the strongest isolation can map/unma=
p DMA
> > >>>>> buffers dynamically.
> > >>>>
> > >>>> I do not see yet that you can model with an IOMMU a static, not gu=
est
> > >>>> controlled window.
> > >>>
> > >>> Well basically the IOMMU will have as part of the
> > >>> topology description and range of addresses devices behind it
> > >>> are allowed to access. What's the problem with that?
> > >>>
> > >>
> > >> I didn't look at the detail of the vIOMMU from that perspective, but=
 our
> > >> requirement would be that it would just statically communicate to th=
e
> > >> guest where DMA windows are, rather than allowing the guest to confi=
gure
> > >> that (which is the normal usage of an IOMMU).
> > >=20
> > > Right, I got that - IOMMUs aren't necessarily fully configurable thou=
gh.
> > > E.g. some IOMMUs are restricted in the # of bits they can address.
> > >=20
> > >=20
> > >> In addition, it would only address the memory transfer topic. We wou=
ld
> > >> still be left with the current issue of virtio that the hypervisor's
> > >> device model needs to understand all supported device types.
> > >>
> > >> Jan
> > >=20
> > > I'd expect the DMA API would try to paper over that likely using
> > > bounce buffering. If you want to avoid copies, that's a harder
> > > problem generally.
> > >=20
> >=20
> > Here I was referring to the permutations of the control path in a devic=
e
> > model when switching from, say, a storage to a network virtio device.
> > With PCI and MMIO (didn't check Channel I/O, but that's not portable
> > anyway), you need to patch the "first-level" hypervisor when you want t=
o
> > add a brand-new virtio-sound device and the hypervisor is not yet aware
> > of it. For minimized setups, I would prefer to only reconfigure it and
> > just add a new backend service app or VM. Naturally, that model also
> > shrinks the logic the core hypervisor needs to provide for virtio.
> >=20
> > Jan
>=20
> Hmm that went woosh over my head a bit, sorry.
> If it's important for this discussion, a diagram might help.

Kernel VFIO and VFIO-over-socket provide this sort of interface where
it's possible to add new device types without modifying the hypervisor.

vhost-user is not (yet?) a full VIRTIO device so it requires code in the
VMM to set up the VIRTIO device that the guest sees. But recent
developments in vhost-user and vDPA seem to be moving closer to a full
VIRTIO device model and not just an offload for a subset of virtqueues.

Stefan

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7/IugACgkQnKSrs4Gr
c8j+/QgAr+OO5zoEQ6/OD69jN/RHuVzmx8d+uECv7KS5tbxfV6UHkbGvWxcDGsoV
xoMGU8j51Cd3NW/hwLKZuX3/BLySLh7zSpkQzNfHKBFije8GZ3rGYKwowtVCLxXU
Ftyg1rb8jwLUY3v6hJJTCtWa9UryPleEnn0mHzPGJOFT8NUvdZmqWLyKLYCBGHBy
9aN7baMnPWTMshDQN9oHEOSMYhAPWeiFBR2m+1L/H+hpX+4MO/UbYOYmOwl9kAno
8Pf2t287DxNrBu/YY55KWhzUMDDgeYO+CYGDFNmw5XslJ5ZagE6q5y50J/uQNfRz
ApggIyQ/qOFqDhQSm6qrKCgQMkpzZw==
=OtwA
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

