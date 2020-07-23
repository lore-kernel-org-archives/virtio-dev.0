Return-Path: virtio-dev-return-7614-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C195C985DD7
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Jul 2020 06:32:31 +0000 (UTC)
Date: Thu, 23 Jul 2020 07:32:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200723063222.GD268427@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-10-ndragazis@arrikto.com>
 <20200717095720.GI128195@stefanha-x1.localdomain>
 <e74eb30a-3086-b843-958b-e49863182fe4@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <e74eb30a-3086-b843-958b-e49863182fe4@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 09/10] vhost-user: intercept slave's
 reply to VHOST_USER_GET_PROTOCOL_FEATURES
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 06:37:11PM +0300, Nikos Dragazis wrote:
> On 17/7/20 12:57 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
> > On Mon, May 18, 2020 at 11:37:20PM +0300, Nikos Dragazis wrote:
> > Why does the virtio-vhost-user device implementation need to silently
> > clear those feature bits? Is there a security impact or some other
> > reason why the VIRTIO spec should specify this behavior?
>=20
> In our setup, the slave cannot pass file descriptors to the master.
> The easiest way to enforce this restriction is during feature
> negotiation. The virtio-vhost-user device will mask the unsupported
> feature bits and, therefore, the master will not enable these feature
> bits on the slave.

I see. It stood out because the spec could simply forbid using those
bits instead of mandating that they be silently clearer at runtime.

I think there's no harm in clearing them at runtime and it may make
device emulation slightly simpler. So this sounds fine.

Thanks,
Stefan

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZLvYACgkQnKSrs4Gr
c8gVaggAiTrr9Y6ZIprUyEIO4Bjnecx6Yq4npmVV+iwFkKDnvhmRAUsGLmy9Wkyi
X2XnTvyWd3Sdz/fOmaWET8g/c8iZNTrkHPnh/ol6wzrxPFf8pH0dCWlnpmcvl/BT
hJKvDbBd8YyB9fOq+DpQ0+/GuKzh2TuoxAbg5rzQvljrfbxQkyxcKbIG20knh/ZS
rMlngBerD1ejWpl54eMWY9adSF5B70epnOzTheoNCIcihzaEdzRyg0EZHre2qhTJ
QwbKHipBowXqNufH8g0a8PwtsBrzIUEtEYFnBlkg5GWhnX9kyRr2Kf5s8VOwI1XA
N+IpvZ9gvPoLPR9tvsPykydsj1ZRQQ==
=rD/2
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--

