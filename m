Return-Path: <virtio-dev-return-12030-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE2EC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 19:23:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E6E5923D7B
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 19:23:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E17309865CF
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 19:23:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D76E99865AA; Wed,  5 Apr 2023 19:23:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C860F9865AB
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 19:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8Tg3HpUJOySWhoaK-lyGMw-1
Date: Wed, 5 Apr 2023 15:23:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230405192310.GB676473@fedora>
References: <87edoyqvnu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L8GB8amPuC5aG2xN"
Content-Disposition: inline
In-Reply-To: <87edoyqvnu.fsf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Subject: [virtio-dev] Re: [virtio] [RFC] virtio 1.3 schedule

--L8GB8amPuC5aG2xN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 03:57:09PM +0200, Cornelia Huck wrote:
> That said, let me propose the following timeline:
>=20
> - July 1st 2023: enter feature freeze; all proposed changes must at
>   least have an open github issue that refers to a proposal on-list
> - August 1st 2023: enter change freeze; everything needs to have been
>   voted upon (i.e. we can start with preparations for a release like
>   compiling the change log)
> - at the same time, fork virtio-next, which can be used for development
>   while we're working on the release
> - August/September 2023: prepare draft, initiate initial voting etc.
> - by September/October 2023: have the final 1.3 spec ready, voted upon,
>   and released
> - virtio-next can be merged into mainline, and we continue with business
>   as usual
>=20
> Thoughts? We might want to move things a tad earlier, but I don't think
> we should push the schedule out much further.

Sounds good to me. If the date is earlier then it will be necessary to
scrutinize the list of features for 1.3 and think hard about which ones
fit, but freezing on July 1st sounds realistic to me.

Stefan

--L8GB8amPuC5aG2xN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQtyp4ACgkQnKSrs4Gr
c8gS6Qf/fL6p+4rB81v4uNcCtl73p/jg7bZx71LE0Tb6/Yj+Kre43zhU+/SrLABk
MacQic+YbYwRH4foaLQWcizlTb+Bf3ckR5d75ZI5IceGiRlIFXKwAC89TqW+Xubz
jXVMVMSlEF/tVC7nndzWwJSwpJGVoI3Si306B6K6MfVkQzq4IMtBXF+s46xZYbre
/zVTWkZk24kpCK8CYuwH5wvrxRiPRGzxGLB0ZE/RPByIwW+RlfTs6f7KjhKK/znj
vWSZp3ubY9svn15GXgw0RsHBtVr7THpkSN555KgmhVCFbwSmZO4ORKKnBdLZPvIW
tFlG8huzuSv0bRlD0R/CtHh7bu9taA==
=3OYE
-----END PGP SIGNATURE-----

--L8GB8amPuC5aG2xN--

