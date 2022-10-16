Return-Path: <virtio-dev-return-10022-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51BC098620E
	for <virtio-dev@lists.oasis-open.org>; Sun, 16 Oct 2022 22:16:53 +0000 (UTC)
Date: Sun, 16 Oct 2022 18:16:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Y0yCy4fULmG8cwz9@fedora>
References: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
 <20221016034127.330942-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WrxOcra4N/hDC62u"
Content-Disposition: inline
In-Reply-To: <20221016034127.330942-2-dmitry.fomichev@wdc.com>
Subject: Re: [virtio-dev] [PATCH v2 1/2] virtio-blk: use a helper to handle
 request queuing errors
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--WrxOcra4N/hDC62u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 15, 2022 at 11:41:26PM -0400, Dmitry Fomichev wrote:
> Define a new helper function, virtblk_fail_to_queue(), to
> clean up the error handling code in virtio_queue_rq().
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WrxOcra4N/hDC62u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNMgssACgkQnKSrs4Gr
c8j3Qgf/SjnLG+UDK6hdHghUkZpxR+GNWEQgjI4su181tWMDF1xvIHUsLvd0VkhB
RrRaOzGHjYtGToFjZ3bghA+YS9t5LjfltXEC52sBo2CckkWJjdVPXFrUlGVcVgnk
m/Hzq6ZNsI1/DDFw2Cl1LTeKWM6yRba91pbhPfSU6FB3qcuc7QUcY+oDP51nRKNB
0fzfyRlYk8XKSj5wb98CTL8lCTqEU5tUwrJuWeV7bax2weERBXZR4x6Sar3LxV5i
rKf7q9WjPASRUHXV+etaW4CPjp4qDlWWpbuVy161gLl0cm47CGcfXI0al4taj/ZR
UXSxjPeiyBuLIYVVkKLNA4Viip/LMg==
=73yJ
-----END PGP SIGNATURE-----

--WrxOcra4N/hDC62u--

