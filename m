Return-Path: virtio-dev-return-6934-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F2F1985FD9
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 17:28:58 +0000 (UTC)
Date: Wed, 11 Mar 2020 17:28:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200311172849.GH281087@stefanha-x1.localdomain>
References: <874kv15o4q.fsf@linaro.org>
 <20200309154637.GJ7668@stefanha-x1.localdomain>
 <CAMHO8so2zuDS5BjATchFpYk_4Qy4aG76L51qmCg7qkPPfNwmFA@mail.gmail.com>
 <87v9ndifw0.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87v9ndifw0.fsf@linaro.org>
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Srivatsa Vaddagiri <vatsa.ml@gmail.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 05:42:39PM +0000, Alex Benn=E9e wrote:
>=20
> Srivatsa Vaddagiri <vatsa.ml@gmail.com> writes:
>=20
> > On Mon, Mar 9, 2020 at 9:16 PM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >>
> >> That already exists today.  Pick a vhost-user device implementation fr=
om
> >> QEMU, DPDK/SPDK, or rust-vmm and run it with your VMM of choice.
> >>
> >> > backend be emulated purely with some shared memory and some sockets =
for
> >> > passing messages/kicks from/to the VMM which then deals with the hyp=
ervisor
> >> > specifics of the virtio-transport?
> >>
> >> Yes, that is what vhost-user does.
> >
> > Are there vhost-user based backends that emulates block and console dev=
ices?
> >
> > From my quick read, vhost-user seems to depend on having backend comple=
te access
> > to front-end's memory. Is that true? We are looking for a backend solut=
ion that
> > does not assume access to whole of front-end memory. Only the memory re=
gions
> > hosting IO buffers need to be ideally shared between the two VMs.
>=20
> I think it currently is true because generally the pointers passed in
> the virtqueues are directly into the various internal structures of the
> kernel (e.g. pagecache, skb etc.).
>=20
> Now for linux the are ways of declaring particular buffers to be in
> specific locations - ostensibly for things like DMA-ability. But AFAICT
> there is no mechanism to communicate the particular locations to be used
> to the VMM and backend daemon.

Yes, the problem is that guest userspace memory buffers could be
anywhere and the virtqueue DMA memory managed by the guest drivers is
also not allocated from a specific memory range.

When the guest cooperates (e.g. DPDK applications that use a fixed
memory range for virtio-net packet buffers), then it's possible to
reduce the shared memory region to not expose all of guest RAM.

> > Also the
> > mechanism of memory sharing and signalling between VMs could be very
> > hypervisor specific.
> > Does vhost-user allow for such hyp-specific memory sharing and
> > signalling interfaces?
>=20
> The daemons I've looked at so far are passed a shm fd and a control fd
> from the VMM. From their point of view it's just posix shared memory and
> a event queue via a socket. Setting that up is the VMMs problem.

Yes, although I don't think there is any assumption that the fd is POSIX
shared memory.  The fd just needs to support mmap(2).

Stefan

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5pH9EACgkQnKSrs4Gr
c8jThwf/cHHEN0zlORo1aKkCOHR+EV9sOknhCiBVFUEeYFWEDYTeQNGzfvSW6iYe
aZtLsjUWsysQKacAGw2QEaLFYKvI97NN4GIR0P5faX/DYUlcbrg6owaPDbzjUrbh
PbWXerMTp44QMFxXsyKGJZXp38ZgEbowp7apKHOsR+JJW72p2/1HmisbA1qdPd//
uTiUnHQJZjZAzI9hVqg4/U9pfIZNSzbFQZqJDjzPvW2nVkvnH+pGSBtZ+UZXJ8Uq
lqzdAN6vhujoud/LBxicECj7+OyB/0mPm5P5PQZL7wzX+ujSikcZZxE/zvzRcu48
M6PArXpHMZzhAuuBT/rZVw5HyQSWsw==
=uBMT
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--

