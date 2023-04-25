Return-Path: <virtio-dev-return-12410-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A18AC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 14:10:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EDFB93E320
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 14:10:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C64E898646A
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 14:10:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A0626986449; Tue, 25 Apr 2023 14:10:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 838559866CC
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 14:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4v4pYJwnNF-JN4a7B3kTXg-1
Date: Tue, 25 Apr 2023 10:09:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: zhenwei pi <pizhenwei@bytedance.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, parav@nvidia.com,
	virtio-dev@lists.oasis-open.org,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
	houp@yusur.tech
Message-ID: <20230425140942.GB697094@fedora>
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sOWzMF8PgDSle/pD"
Content-Disposition: inline
In-Reply-To: <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

--sOWzMF8PgDSle/pD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 11:40:02AM +0800, Jason Wang wrote:
> On Sun, Apr 23, 2023 at 7:31=E2=80=AFPM zhenwei pi <pizhenwei@bytedance.c=
om> wrote:
> > I develop an kernel initiator(unstable, WIP version, currently TCP/RDMA
> > supported):
> > https://github.com/pizhenwei/linux/tree/virtio-of-github
>=20
> A quick glance at the code told me it's a mediation layer that convert
> descriptors in the vring to the fabric specific packet. This is the
> vDPA way.
>
> If we agree virtio of fabic is useful, we need invent facilities to
> allow building packet directly without bothering the virtqueue (the
> API is layout independent anyhow).

I agree. vrings makes sense for RDMA, but I think virtio_fabrics.c
should not be dependent on vrings.

Linux struct virtqueue is independent of vrings but the implementation
currently lives in virtio_ring.c because there has never been a
non-vring transport before.

It would be nice to implement virtqueue_add_sgs() specifically for
virtio_tcp.c without the use of vrings. Is a new struct
virtqueue_ops needed with with .add_sgs() and related callbacks?

Luckily the <linux/virtio.h> API already supports this abstraction and
changes to existing device drivers should be unnecessary or minimal.

Stefan

--sOWzMF8PgDSle/pD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRH3yYACgkQnKSrs4Gr
c8glGQgAyHNMxA0CLKzkiNCPiFfIGs9j95peVLn+iN1vYppj7p91elb8ts8chRdD
w27oBCAFAGIKi10MzI4p6lGEt/GwNOadKWdN7pMqc+kxnlYzR9s//mcTbe47Beb6
uE8f0+uE8z7wz5xGmWy5Cs7tXR0RNAWm7+jGU+fS0Zv9EgFdU3CCtBqZKQrrcasx
MZHkq3IQkfihDXsDpccI3QVB2XjyK67afiDbHkvfbdwTzT8L9fHArxkhw5WDiZbm
4WF1H2x2szF2tm+++VnO+tmQzIEAu+mpmrINKh2HkEcu+g2dNT7gzuk+ChDGi+Z4
M9aR4A5KhARTyOCQKxrmcaQsoduhQw==
=HTPF
-----END PGP SIGNATURE-----

--sOWzMF8PgDSle/pD--

