Return-Path: virtio-dev-return-5742-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 770A8985E2A
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 May 2019 13:45:01 +0000 (UTC)
Date: Tue, 14 May 2019 14:44:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190514134448.GB6555@stefanha-x1.localdomain>
References: <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
 <20190510154824.GJ22311@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 05:13:26PM +0000, Anton Yakovlev wrote:
> > Shared memory isn't a native concept to VIRTIO.  The device and the
> > driver don't assume shared memory access in the general case (i.e.
> > virtqueue buffers could even be copied and virtio-blk, virtio-net, etc
> > would still work!).
> >
> > There is currently a spec extension on the mailing list to add Shared
> > Memory Resources to VIRTIO and new device types will use it.  However, I
> > don't think this is necessary for this use case.
>=20
> Yes, we are awared about VIRTIO and shared memory relationships. Our orig=
inal propose was to support classic way of communications by default. And, =
thanks to your comments, it can be further improved.
>=20
> But there's one issue. An audio device is a real-time device. It has expl=
icit hard deadline. And there're many factors helping an audio device to fa=
il to meet the deadline due to virtualization overhead. And in that sense a=
 virtual audio device differs from each and every other virtual devices. If=
 a block device becomes slower - not a big deal, if a network device become=
s slower - not a big deal, if a GPU device starts to skip frames - not very=
 nice, but also not a big deal. But if an audio device starts to skip frame=
s - it's a big problem, and device is nonfunctional as a matter of fact. Go=
od audio device implementation must met two criterias:
>=20
> 1. Low latency
> 2. No frame dropping at all
>=20
> All I want to say is that any queue-based approach can not guaranty corre=
ct functionality to an audio device for all possible use cases. Because a q=
ueue has its natural limitations: either in terms of additional latency due=
 to queue notifications, or due to queue limited size. And an audio device =
eventually will hit one of them for some application. It means, we can not =
support some cases, which works pretty fine in native operating systems. Bu=
t such limitations are artificial ones due, again, using a queue for data t=
ransfers. In case of shared memory such limitations are just gone.
>=20
> So, our proposal is to support classic way of communications by default a=
nd introduce shared memory based approach as either non-standard extension =
or part of future VIRTIO device types. And switch to this mode where it's p=
ossible or make sense. Like, all modern type-2 hypervisors usually have no =
problems with sharing memory between guest and host, so why not provide to =
user high quality virtual audio device?

virtqueues offer reliable delivery, so #2 isn't an issue.

Real-time is achievable and can be done with low latency.  Make the
receiver a real-time thread that polls the vring periodically (based on
the latency/buffer size requirement).  The vring supports lock-free
access so this is perfect for real-time.

When I say "receiver" I mean the driver's capture and device's playback
components.  Both of them have real-time requirements.

Does this approach meet your requirements?

If not, please explain the shared memory approach and how it is better.

Stefan

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzaxk8ACgkQnKSrs4Gr
c8gPGAf9GufnVe83Q0SDeOMGCr6+IkUjjhirmMXB52x+3tWXntFW1PSas9T0h+Q2
i/E/eCSQBdcR1N6cepmgHfTXUYWN0wDZwbwIR9kkRS90asVOpYs+E+0srg90i6qY
Uea6vf9/MMCYrQIP2YQNCTqC9VPTkkMLeZJFx+0lZ26hOd0CUCUJsyupFkbAcveQ
ouna0y5uwZgW5tBrkuA0gPC5frgwVfDHA0HqUbhsUJTIJB+n6n/0O7NAM+Rot+ai
vO/N+kr1fGzYywVKxkDXDCBEiQQgii/CP4RKoEUW7h5qbtbLsvIz17nTZyI0Kb3y
zVRSxA0xfYwgk56xdUiEjrMyAF+R5g==
=oxAN
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
