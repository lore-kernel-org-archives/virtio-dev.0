Return-Path: <virtio-dev-return-11927-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76DDC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:11:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3F9922B125
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:11:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35EB5986400
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:11:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2A483986315; Mon,  3 Apr 2023 19:11:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AAF99863E4
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 19:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OlCDJKprNAe_TbHEt8Zoqw-1
Date: Mon, 3 Apr 2023 15:11:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com
Message-ID: <20230403191152.GB350467@fedora>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403134407-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gQYBR2MuFe6u/Yc2"
Content-Disposition: inline
In-Reply-To: <20230403134407-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device

--gQYBR2MuFe6u/Yc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 01:48:46PM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 03, 2023 at 10:53:29AM -0400, Parav Pandit wrote:
> > On 4/3/2023 10:45 AM, Stefan Hajnoczi wrote:
> > > On Fri, Mar 31, 2023 at 01:58:23AM +0300, Parav Pandit wrote:
> > > > 3. A hypervisor system prefers to have single stack regardless of
> > > >     virtio device type (net/blk) and be future compatible with a
> > > >     single vfio stack using SR-IOV or other scalable device
> > > >     virtualization technology to map PCI devices to the guest VM.
> > > >     (as transitional or otherwise)
> > >=20
> > > What does this paragraph mean?
> > >=20
> > It means regardless of a VF being transitional MMR VF or 1.x VF without=
 any
> > MMR extensions, there is single vfio virtio driver handling both type of
> > devices to map to the guest VM.
>=20
> I don't think this can be vfio. You need a host layer translating
> things such as device ID etc.

An mdev driver?

--gQYBR2MuFe6u/Yc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQrJPgACgkQnKSrs4Gr
c8ht5wf+MTeqnN68Lb1CPVdb4oknS4bZzf9Q7jFDU1vSSZdXyVFYQupN3iC5SJhW
cnD3lFElD1921fpHhVnuYtQhNy3n5AqsDi9XvFfF2WA+TgwGKgPlt1bfHGHU3Ts7
hbYFZHsNfxILIkJWSOEK2+72GcqrlVDj25Gzj0E4xvsP88xuFNWtrWGVIMB2saaN
QTexClmUYE3/27DCT2vNaMz024OTRJUR1zPmeFglODuowmH1B3rw/zhBvoHoi6ca
jevVE8F4NOdmUQitLct7qYDDbCfOSm1U/Ddjazv1thqbDLSBLrseCUkvs39xkB0v
0RYIHxyRHlB+vdqqS9J/A9BhohgtYA==
=nClj
-----END PGP SIGNATURE-----

--gQYBR2MuFe6u/Yc2--

