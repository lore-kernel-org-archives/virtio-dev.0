Return-Path: virtio-dev-return-6708-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49104985A56
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Feb 2020 16:09:26 +0000 (UTC)
Date: Mon, 10 Feb 2020 16:09:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200210160914.GB411895@stefanha-x1.localdomain>
References: <20200207182842.770bfb27@collabora.com>
 <20200210133856.cethya3kuzbagzw4@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200210133856.cethya3kuzbagzw4@sirius.home.kraxel.org>
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 02:38:56PM +0100, Gerd Hoffmann wrote:
> > #3 is pretty similar to #1 in its design except that, instead of using
> > the VSOCK infrastructure it's using a new type of virtio device. I
> > guess it has the same pros and cons #1 has, and the name should probabl=
y
> > be changed to reflect the fact that it can transmit any kind of data no=
t
> > just wayland.
>=20
> Even though vsock looks simple at first it isn't when you look at the
> details.  You'll want support more streams than virtqueues.  So you'll
> go multiplex.  You want good performance, but you also don't want allow
> streams to DoS the device by filling up the queue.
>=20
> Thats why I don't like the new virtio device idea much and would prefer
> vhost being reused, either directly (#1) or via proxy (#2).
>=20
> Note that vhost aims to be hypervisor-agnostic and we have (unless I
> missed something) three transports for it: virtio, vmware and hyperv.
> So extending that with virtio-only features might not be the best idea.

s/vsock/vhost/

> Also it is a fact that approach #1 didn't went anywhere so far but we
> have a working implementation of approach #3.  So I guess I wouldn't
> veto approach #3 if you pick it after evaluating the options on the
> table.
>=20
> Final note: We have a new kid on the block: virtio-fs.  I think
> virtio-fs with dax enabled should allow for shared file mappings between
> host and guest.  That is something a proxy (#2) might be able to make
> use of.

Yes, virtio-fs allows the guest to directly map files from the host.

Stefan

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5BgCoACgkQnKSrs4Gr
c8jbwAf+LKp3Gv/n8jH8Lvn5B2AN+SzbilnyF3xKdBpadp02YDKWEtzaTwD/JoqR
zqcQiJpNk88Mki3HJ8EoSxnLFZJ8FYDkURh/0WKayulDHXKFOSufu30YWQl6Yd0c
2g8fm8gcku9WqUZbI338gz3diSmtNxn1vNi60hbN8yRUJy8fL5zkv8kfqjI01KON
fUzhk8tvFasx9bkp6cVPnTasNFBCx23hKz6PIx+9TxyVS/xEbEd5ElTJ1PqhjWYV
2ZgjeXAyDTIykHOR054hCcRG3cTvxm/pobzUmBzfBi6mi7M/eO4X4CmnTZgh/JPB
nvJx7Wxm7RLo0wC62/YhQ+lO1OTw+w==
=j5Kx
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--

