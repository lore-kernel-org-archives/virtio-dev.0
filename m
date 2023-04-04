Return-Path: <virtio-dev-return-11972-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29C2C761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 14:30:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA6002AEEA
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 14:30:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A054F98658A
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 14:30:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 82EF498640B; Tue,  4 Apr 2023 14:30:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EDAB98640E
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 14:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7DuoxkUmPJK8A5-WX7Q5eg-1
Date: Tue, 4 Apr 2023 10:30:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230404143007.GK428487@fedora>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403191014.GA350467@fedora>
 <PH0PR12MB54819A725015CC49952D3CC3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xm0BEpG2tJGn7zBg"
Content-Disposition: inline
In-Reply-To: <PH0PR12MB54819A725015CC49952D3CC3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device

--Xm0BEpG2tJGn7zBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 08:27:28PM +0000, Parav Pandit wrote:
>=20
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Monday, April 3, 2023 3:10 PM
>=20
>=20
> > Maybe call it "Memory-mapped Transitional"? That name would be easier to
> > understand.
> >
> Sounds fine to me.
> =20
> > > > Modern devices were added to Linux in 2014 and support SR-IOV.
> > >
> > > > Why is it
> > > > important to support Transitional (which really means Legacy
> > > > devices, otherwise Modern devices would be sufficient)?
> > > >
> > > To support guest VMs which only understand legacy devices and
> > > unfortunately they are still in much wider use by the users.
> >=20
> > I wonder which guest software without Modern VIRTIO support will still =
be
> > supported by the time Transitional MMR software and hardware becomes
> > available. Are you aiming for particular guest software versions?
>=20
> Transitional MMR hardware is available almost now.
> Transitional MMR software is also WIP to be available as soon as we ratif=
y the spec via tvq or via mmr or both.
> This will be support the guest sw version such as 2.6.32.754 kernel.

That is a RHEL 6 kernel. RHEL 6 entered Extended Life Cycle Support on
November 30, 2020 (https://access.redhat.com/articles/4665701).

I would use existing software emulation for really old guests, but if
you see an opportunity for hardware passthrough, then why not.

Stefan

--Xm0BEpG2tJGn7zBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQsNG8ACgkQnKSrs4Gr
c8gvIAf/XYUtTAD2Z+s5mgRfScbZ7+QMVjqATl01F4xRKkQtaUSPjXyLWplTa9V7
J1Xx9Qn14fFvJSoPWcLwygxnNDxp2pRSJPdICSHOs/iOz8xE+i5mDldrJPDHzYO8
yTHwWWAxHYUw8rPTcCvKKAJGeo09FrJ9lbt7F6dHP6clfv71FxcAdzVj5I1j9fdV
Fvy85CL42Bd0030281BSMjgZHg0qXnEn2IKU5jEEHfCaa/Tv+tX4c8IcUqn1pIdJ
t0+cWUpf5+XX2W8rLmTeWAV7+A2dHDWyG1gBY/Udw2SDg1udx4jOcrQGsNrmuwlM
7Tcw4CQomGi6yR+XBDNEg8cYFaophw==
=LtXH
-----END PGP SIGNATURE-----

--Xm0BEpG2tJGn7zBg--

