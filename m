Return-Path: virtio-dev-return-7550-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74866985E55
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jul 2020 11:49:01 +0000 (UTC)
Date: Wed, 15 Jul 2020 12:48:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200715114855.GF18817@stefanha-x1.localdomain>
References: <87r1tdydpz.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87r1tdydpz.fsf@linaro.org>
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=E9e wrote:
> I'm slightly confused by the MSI terminology because this only seems to
> be relevant for the PCI legacy interface and AFAICT only touch the
> outgoing path in setup and del_vq. Do incoming MSI interrupts just get
> mapped directly to the appropriate handler function to process the
> queues or the config?

When MSI is used the VIRTIO ISR register does not need to be read by the
guest interrupt handler.

> Finally I'm curious if this is just a problem avoided by the s390
> channel approach? Does the use of messages over a channel just avoid the
> sort of bouncing back and forth that other hypervisors have to do when
> emulating a device?

What does "bouncing back and forth" mean exactly?

Stefan

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8O7ScACgkQnKSrs4Gr
c8hEuQgAop36NaS2lIRkw3zhoKUKgopt6f8t35TnhvO6Abehb4mBHVWFyo1Rg/ga
K3vmsF/y4nuUVojAUjkpZXjmKQbCHmZYD9OBpCbl0cd/InUK0nQd7ArLpx2yVFdo
VBvtEwA6ClCAIByRVZRZvTL0Igy74+2xhJdvrPighO2T39D6uGTwJs0fnY6NPN9x
pxwn4YmS2frfLl4b2hNjk8GgcznUxEXQL7UY36GQ2djlA0HSVycRJBgcaoobU8N+
sTl1BHPjktaeSghrUXAyymgSzV81ZpdsQVkpy0OpnCrPUU51haJzj0JvBLr0dJAi
v5gO6KdVNQFGFgT9BHahJ+ek5dsCZQ==
=PEWc
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--

