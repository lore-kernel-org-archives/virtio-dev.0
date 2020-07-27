Return-Path: virtio-dev-return-7619-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A58AF985B4C
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Jul 2020 12:25:30 +0000 (UTC)
Date: Mon, 27 Jul 2020 13:25:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200727122521.GA386429@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com>
 <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <20200724103627-mutt-send-email-mst@kernel.org>
 <f6e7491b-127e-30e3-99ca-de1aa8c6527e@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <f6e7491b-127e-30e3-99ca-de1aa8c6527e@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 08:31:48PM +0300, Nikos Dragazis wrote:
> On 24/7/20 5:41 =CE=BC.=CE=BC., Michael S. Tsirkin wrote:
> > On Fri, Jul 17, 2020 at 10:26:35AM +0100, Stefan Hajnoczi wrote:
> > So how about XXX notifications for both of these things?
> > Where XXX explains what is the reason for triggering each
> > type of notification.
>=20
> I guess Stefan introduced the term "doorbell" because it is a widely
> used term (e.g., in NVMe devices) and I think it is a pretty good
> term. However, I agree that the vague term "notification" may cause
> confusion.
>=20
> Replacing "doorbells" and "notifications" with "XXX notifications"
> sounds good. I can't think of some good terms for XXX right now.
> Feel free to propose.

Device-specific notifications and device-specific doorbells?

I think these concepts should be part of the core VIRTIO device model so
that other devices can also define device-specific
notifications/doorbells in the future.

Stefan

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ex7EACgkQnKSrs4Gr
c8ibPQgAqaludFmg6QZ1nqiNi2JW87VuXaeZcFCRf3Uzl7L+t3hPkNj8qb9Wuq+x
dW4eri+Wf0auJsMDJX4gqZk8uKbffPnqMV36VodcszeRp/5qoRcdJbwGzgPsSJoi
eNjcTYUXxIKjnMG6vZvh1GD+PCojZxnbELMdY//myloGwG5NIwedCgkRBeNfAEOE
0Mhy13FzzEHgsqFz1Y80OQTh+4mo+XUnm20PpgVqNVqdLBWczhnkvTx+Zp98YEWA
3jPxSJENHRWNkD2t1dRyWpNqGeqF04WGYNLWx8RL6zb2pc7Lbfi0SABlCEs7mpMw
k7ImCk0KZFRc+498SVgc7FSUnuLRsg==
=893I
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

