Return-Path: <virtio-dev-return-12409-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D91C77B71
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:55:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B18E029FC6
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:55:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A80E5986635
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:55:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9452398644B; Tue, 25 Apr 2023 13:55:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8109F986449
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 13:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DD5BL-AnPAqQRM1moupC3Q-1
Date: Tue, 25 Apr 2023 09:55:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: zhenwei pi <pizhenwei@bytedance.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, parav@nvidia.com,
	virtio-dev@lists.oasis-open.org,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
	houp@yusur.tech
Message-ID: <20230425135532.GA697094@fedora>
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R9BYTxXrwfQCph6A"
Content-Disposition: inline
In-Reply-To: <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Subject: [virtio-dev] Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

--R9BYTxXrwfQCph6A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 11:40:02AM +0800, Jason Wang wrote:
> On Sun, Apr 23, 2023 at 7:31=E2=80=AFPM zhenwei pi <pizhenwei@bytedance.c=
om> wrote:
> > "Virtio Over Fabrics" aims at "reuse virtio device specifications", and
> > provides network defined peripheral devices.
> > And this protocol also could be used in virtualization environment,
> > typically hypervisor(or vhost-user process) handles request from virtio
> > PCI/MMIO/CCW, remaps request and forwards to target by fabrics.
>=20
> This requires meditation in the datapath, isn't it?
>=20
> >
> > - Protocol
> > The detail protocol definition see:
> > https://github.com/pizhenwei/linux/blob/virtio-of-github/include/uapi/l=
inux/virtio_of.h
>=20
> I'd say a RFC patch for virtio spec is more suitable than the codes.

VIRTIO over TCP has long been anticipated but so far no one posted an
implementation. There are probably mentions of it from 10+ years ago.
I'm excited to see this!

Both the VIRTIO spec and the Linux drivers provide an abstraction that
allows fabrics (e.g. TCP) to fit in as a VIRTIO Transport. vrings are
not the only way to implement virtqueues.

Many VIRTIO devices will work fine over a message passing transport like
TCP. A few devices like the balloon device may not make sense. Shared
Memory Regions won't work.

Please define VIRTIO over Fabrics as a Transport in the VIRTIO spec so
that the integration with the VIRTIO device model is seamless. I look
forward to discussing spec patches.

Stefan

--R9BYTxXrwfQCph6A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRH29QACgkQnKSrs4Gr
c8izuQf/XwclTHOqOv4piNkg+s1UTM8HFwrYY3fWDLZXQvJNHFc+P+jpW5UVKvoO
/0nbjQKXRc9WL19145pdpMvu7vZVkHfvECyN16KiI5mCJWOi4lJrG4XMiti1Rt5i
M7EJ8su9JCENl1HhjRuHFKIhnZGaHRpsk+QQfYX2bcE6lS4uOCRsMsCjf/hP74kh
CpcosqY9Jc9/U0xjFGAU0Rp0CwxcJLKwcijxUtS1+gFvz+fCvkfA7G+0CTc9diYb
9X5Ov7b7BG1y17SgFBx/9K1POsM/4e+XJCuueucvvaEOPXUyk/GAoVrZjd3BevN+
mMmFQSnPNH+xY8vzkFob0txr9vM7Og==
=hnx7
-----END PGP SIGNATURE-----

--R9BYTxXrwfQCph6A--

