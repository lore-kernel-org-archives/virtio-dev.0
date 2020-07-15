Return-Path: virtio-dev-return-7552-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AB78985E7E
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jul 2020 15:47:40 +0000 (UTC)
Date: Wed, 15 Jul 2020 16:47:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200715154732.GC47883@stefanha-x1.localdomain>
References: <87r1tdydpz.fsf@linaro.org>
 <20200715114855.GF18817@stefanha-x1.localdomain>
 <877dv4ykin.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <877dv4ykin.fsf@linaro.org>
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=E9e wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=E9e wrote:
> >> Finally I'm curious if this is just a problem avoided by the s390
> >> channel approach? Does the use of messages over a channel just avoid t=
he
> >> sort of bouncing back and forth that other hypervisors have to do when
> >> emulating a device?
> >
> > What does "bouncing back and forth" mean exactly?
>=20
> Context switching between guest and hypervisor.

I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
request on s390 channel I/O.

Stefan

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8PJRQACgkQnKSrs4Gr
c8izhgf/XKIEHNxlhuYFC3NxAcu27JsTuZrxdWggjjObKrVGhwo/fTZNcJhpBrl1
nAE3oBk5eSdZmYv/nvjkfq7ZXC6+MCKngCyZVGxNe8KzkZeGpekzmStTcGhPx5+u
MyChEDkAQdr0vh6xCIY/qxos1nSRcLOp+DzVthD8La68Hl5tB7gLKR3oJe7H34Qm
8IHW790mHOJ7qTssH6YzKYqRp8kzfWLtXZTqRab5ID5LlPHuXrQMJvMxC6Nf7Tah
SWnINOftj0x9Y6L1X8mVQV6r2/nQZRalMsJ24sL3lmQfr9+TTNqpV148VWB96UNQ
9jSLfEKZBs/vxSlYCx4HwzxI+71Yvg==
=3kE0
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

