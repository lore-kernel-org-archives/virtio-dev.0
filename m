Return-Path: <virtio-dev-return-8545-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7A409863E2
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Aug 2021 12:58:16 +0000 (UTC)
Date: Tue, 17 Aug 2021 11:41:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YRuSPT9075NuWRYS@stefanha-x1.localdomain>
References: <87v94ldrqq.fsf@linaro.org>
 <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
Subject: [virtio-dev] Re: Enabling hypervisor agnosticism for VirtIO backends
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MtdJiD33XPKc+AKR"
Content-Disposition: inline
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Wei.Chen@arm.com, olekstysh@gmail.com, Oleksandr_Tyshchenko@epam.com, Bertrand.Marquis@arm.com, Artem_Mygaiev@epam.com, julien@xen.org, jgross@suse.com, paul@xen.org, xen-devel@lists.xen.org
List-ID: <virtio-dev.lists.oasis-open.org>

--MtdJiD33XPKc+AKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 12:20:01PM -0700, Stefano Stabellini wrote:
> > Could we consider the kernel internally converting IOREQ messages from
> > the Xen hypervisor to eventfd events? Would this scale with other kerne=
l
> > hypercall interfaces?
> >=20
> > So any thoughts on what directions are worth experimenting with?
> =20
> One option we should consider is for each backend to connect to Xen via
> the IOREQ interface. We could generalize the IOREQ interface and make it
> hypervisor agnostic. The interface is really trivial and easy to add.
> The only Xen-specific part is the notification mechanism, which is an
> event channel. If we replaced the event channel with something else the
> interface would be generic. See:
> https://gitlab.com/xen-project/xen/-/blob/staging/xen/include/public/hvm/=
ioreq.h#L52

There have been experiments with something kind of similar in KVM
recently (see struct ioregionfd_cmd):
https://lore.kernel.org/kvm/dad3d025bcf15ece11d9df0ff685e8ab0a4f2edd.161382=
8727.git.eafanasova@gmail.com/

> There is also another problem. IOREQ is probably not be the only
> interface needed. Have a look at
> https://marc.info/?l=3Dxen-devel&m=3D162373754705233&w=3D2. Don't we also=
 need
> an interface for the backend to inject interrupts into the frontend? And
> if the backend requires dynamic memory mappings of frontend pages, then
> we would also need an interface to map/unmap domU pages.
>=20
> These interfaces are a lot more problematic than IOREQ: IOREQ is tiny
> and self-contained. It is easy to add anywhere. A new interface to
> inject interrupts or map pages is more difficult to manage because it
> would require changes scattered across the various emulators.

Something like ioreq is indeed necessary to implement arbitrary devices,
but if you are willing to restrict yourself to VIRTIO then other
interfaces are possible too because the VIRTIO device model is different
from the general purpose x86 PIO/MMIO that Xen's ioreq seems to support.

Stefan

--MtdJiD33XPKc+AKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEbkj0ACgkQnKSrs4Gr
c8jIgAf/ZpT5ZF/StADSes4RfNq0J1UFOgql3jeVsqkD7q9bPZaIvtADoVdSduiw
zDiBNp5q/LkIIhE+rfRjAO2nA3rpYrp6fWlmRh6hmRHiCAFKIQ1lsmi39noeDTe4
IPm7VASzJ0VRtMxJ88a/pS4HldM2pQZLU2q4f2gtXuGD7Kj5VLn/6LfEE6tzU98h
jpGxjZlx/zrc37X9Wk2tL8Zg6PJpug7B308KpaJFB5jHOzSww27+ETTPBV4LKHsf
zMnevfYRDTH3wJObd+FMmzDsD25EHs/hf1VC6yghoNjgkQP//5FYyoN4csg1tAfK
zPFuCYSZ4qMY83x5bbL6i6rqK2jz1g==
=Ehb+
-----END PGP SIGNATURE-----

--MtdJiD33XPKc+AKR--

