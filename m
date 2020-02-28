Return-Path: virtio-dev-return-6816-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CE69985ECF
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 11:09:14 +0000 (UTC)
Date: Fri, 28 Feb 2020 11:09:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200228110901.GB326000@stefanha-x1.localdomain>
References: <87mu93vwy2.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87mu93vwy2.fsf@linaro.org>
Subject: Re: [virtio-dev] VIRTIO adoption in other hypervisors
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, jan.kiszka@siemens.com, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-ID: <virtio-dev.lists.oasis-open.org>

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2020 at 10:16:21AM +0000, Alex Benn=E9e wrote:
> I'm currently trying to get my head around virtio and was wondering how
> widespread adoption of virtio is amongst the various hypervisors and
> emulators out there.
>=20
> Obviously I'm familiar with QEMU both via KVM and even when just doing
> plain emulation (although with some restrictions). As far as I'm aware
> the various Rust based VMMs have vary degrees of support for virtio
> devices over KVM as well. CrosVM specifically is embracing virtio for
> multi-process device emulation.
>=20
> I believe there has been some development work for supporting VIRTIO on
> Xen although it seems to have stalled according to:
>=20
>   https://wiki.xenproject.org/wiki/Virtio_On_Xen
>=20
> Recently at KVM Forum there was Jan's talk about Inter-VM shared memory
> which proposed ivshmemv2 as a VIRTIO transport:
>=20
>   https://events19.linuxfoundation.org/events/kvm-forum-2019/program/sche=
dule/
>=20
> As I understood it this would allow Xen (and other hypervisors) a simple
> way to be able to carry virtio traffic between guest and end point.
>=20
> So some questions:
>=20
>   - Am I missing anything out in that summary?

VirtualBox has virtio-net support:
https://www.virtualbox.org/manual/ch06.html

>   - How about HyperV and the OSX equivalent?

macOS has *guest* drivers for VIRTIO devices:
https://www.kraxel.org/blog/2019/06/macos-qemu-guest/

Stefan

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5Y9M0ACgkQnKSrs4Gr
c8gGwQf+PfpzqW9HhG0kQEVMOWxfC8rWQdXg5yEAwshyMsdbOIHqoQG4X3FlBWXK
nwtSHkasfTyAUh/pW988T1g2kA9WUSs6nOlt8XRUWquGqTzH9wAKMcvIEc9BORsH
gsM/txLsD1WLZskugxnPwSdgqQCeM4djIIowD+UbzBd8uKI/N5uT4mnNBJR3+GCk
xhO/fe3cKE63k1AX0vrlariLvUL50KcrKo2fED+bqu6TnvZidDC1L03KYtzQ8e+e
zPAbIkm1WI8X7eiirIohd/PfNhtlc8xekyldmI6LyABxKYYaxrVC8alXQC4AIoFv
q1jyylUHQgL9B4B0lH2/Y27SF6w0Ow==
=8rQ2
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

