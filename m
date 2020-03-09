Return-Path: virtio-dev-return-6904-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D65619848B9
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 15:46:49 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:46:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200309154637.GJ7668@stefanha-x1.localdomain>
References: <874kv15o4q.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <874kv15o4q.fsf@linaro.org>
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g3RkK9jYN81zD2N+"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--g3RkK9jYN81zD2N+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 06:33:57PM +0000, Alex Benn=E9e wrote:
> So the context of my question is what sort of common software layer is
> required to implement a virtio backend entirely in userspace?

Yes and no.

vhost-user is currently the most widely-used (cross-VMM) interface for
out-of-process VIRTIO device emulation.

However, it's not a library, just a protocol specification involving
UNIX domain sockets.  You mentioned the various implementations below:

> Currently most virtio backends are embedded directly in various VMMs
> which emulate a number of devices as well as deal with handling devices
> that are vhost aware and link with the host kernel. However there seems
> to be a growing interest in having backends implemented in separate
> processes, potentially even hosted in other guest VMs.
>=20
> As far as I can tell there is a lot of duplicated effort in handling the
> low level navigation of virt queues and buffers. QEMU has code in
> hw/virtio as well as contrib/libvhost-user which is used by the recent
> virtiofsd daemon. kvm-tool has a virtio subdirectory that implements a
> similar set of functionality for it's emulation. The Rust-vmm project
> has libraries for implementing the device traits.

You missed DPDK/SPDK.

The issue is that no single library would work for all of these users.

DPDK/SPDK does poll-mode device emulation.  Therefore the details are
slightly different from the eventfd-based approach that event-driven
implementations will use.

rust-vmm crates are written in Rust, so direct code sharing is not
possible.  Bindings for a C library are possible but is that desirable
(it defeats the point of using a safe language, it may be harder to add
features for developers mainly using Rust).

Unifying everything does not seem realistic for these sorts of reasons.
What we have today is that the Linux kernel uapi headers are shared, so
at least the struct and constant definitions don't need to be duplicated
by C/C++ projects.

> Another aspect to this is the growing interest in carrying virtio over
> other hypervisors. I'm wondering if there is enough abstraction possible
> to have a common library that is hypervisor agnostic? Can a device

That already exists today.  Pick a vhost-user device implementation from
QEMU, DPDK/SPDK, or rust-vmm and run it with your VMM of choice.

> backend be emulated purely with some shared memory and some sockets for
> passing messages/kicks from/to the VMM which then deals with the hypervis=
or
> specifics of the virtio-transport?

Yes, that is what vhost-user does.

Stefan

--g3RkK9jYN81zD2N+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5mZN0ACgkQnKSrs4Gr
c8iUDwf/R8KIkF+q3UIHjBIV2Cm0+NQfNrOgsVND6UBI7OBfKi0fz9jWMnhu4DMh
NowWV5grfqJOyRQn1g2i2CHwIl/h5OwnWbctzdU7hb3uE527ZKYp0ES0mSBR6HhB
3O3v/iDbzkpmjjWr1YmrzVaqRdeXLB1PBgBUmWqrVFM3wQWKc0FqxiBDb1ijU019
svXVNzVp92uVaOJDaDiDiRyJoStEh2ENvZb2Cy96HijFeZCniD/s3QgeAZQCkXxw
PZjO0Hqo0cIgJWyt3R8XSUv6G2LoqANbxRpXQF+N97305GWT34FcSSEFFNays4P2
tJ5JuJQbh4T5zswUyYSHyFwSDfydPQ==
=CpKZ
-----END PGP SIGNATURE-----

--g3RkK9jYN81zD2N+--

