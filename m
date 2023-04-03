Return-Path: <virtio-dev-return-11926-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A28C76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:10:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C3C6426A33
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:10:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5A499863FE
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:10:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 91479986315; Mon,  3 Apr 2023 19:10:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EA679863E4
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 19:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1YgJlwreMSm2Soro26La8Q-1
Date: Mon, 3 Apr 2023 15:10:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230403191014.GA350467@fedora>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dgc+T2934FOPeMV9"
Content-Disposition: inline
In-Reply-To: <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device

--Dgc+T2934FOPeMV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 10:53:29AM -0400, Parav Pandit wrote:
>=20
>=20
> On 4/3/2023 10:45 AM, Stefan Hajnoczi wrote:
> > On Fri, Mar 31, 2023 at 01:58:23AM +0300, Parav Pandit wrote:
> > > Overview:
> > > ---------
> > > The Transitional MMR device is a variant of the transitional PCI devi=
ce.
> >=20
> > What does "MMR" mean?
> >=20
> memory mapped registers.
> Explained below in the design section and also in relevant patches 6 to 1=
1.

Maybe call it "Memory-mapped Transitional"? That name would be easier to
understand.

> > Modern devices were added to Linux in 2014 and support SR-IOV.
>=20
> > Why is it
> > important to support Transitional (which really means Legacy devices,
> > otherwise Modern devices would be sufficient)?
> >=20
> To support guest VMs which only understand legacy devices and unfortunate=
ly
> they are still in much wider use by the users.

I wonder which guest software without Modern VIRTIO support will still
be supported by the time Transitional MMR software and hardware becomes
available. Are you aiming for particular guest software versions?

Stefan

--Dgc+T2934FOPeMV9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQrJJUACgkQnKSrs4Gr
c8iFSQgAhWO8PazKwzksUtMyaZfBrHM9d2ixyys8f82VUOXxZrzLF47MdydX9o9H
1xiw/OEHgOg8sRdX7lXQzVtqt0RJ8I/M57xDRFYXDLQpHUi/u68RVS2Ite+pTFIB
xoCcrCVw34hL+Yk35voBvKEGA2D2BzJjBuz0G0U5tqF6wTDcKaljMdjoXhGAcyt5
Vu0VqvXqCxb2OgrXAEbChNSGSpPsB8qVifTRN7Xu+JIlZ5giD8ac3DlAtOtaDNzD
MbAkUfc5Iudq73umkTohjOAHEnstV+W4rEdGSu8gsIWXKHHLTvNb1+czSNn7jo6o
SevC7xL9FBaGcc5GSZdEVsrt0DM/4Q==
=RK+t
-----END PGP SIGNATURE-----

--Dgc+T2934FOPeMV9--

