Return-Path: <virtio-dev-return-11567-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805DBC64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:35:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB81A2ACE4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:35:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F456986700
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:35:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 601739866C1; Thu,  9 Mar 2023 12:35:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C9A19866F3
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 12:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: alKttYp8POSmmmxoyIGINQ-1
Date: Thu, 9 Mar 2023 07:35:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	sgarzare@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230309123542.GC370169@fedora>
References: <20230306000302.GA244754@fedora>
 <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
 <20230306162538.GA56760@fedora>
 <e74483a4-38fa-99b5-86b8-785f0b98d029@nvidia.com>
 <20230308141317.GC299426@fedora>
 <18ddbf69-19a6-3c6b-9e42-aaae66e20bcf@nvidia.com>
 <20230308171523.GA320810@fedora>
 <20230308122017-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HeTp2zefbSvWImYL"
Content-Disposition: inline
In-Reply-To: <20230308122017-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

--HeTp2zefbSvWImYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 12:21:46PM -0500, Michael S. Tsirkin wrote:
> On Wed, Mar 08, 2023 at 12:15:23PM -0500, Stefan Hajnoczi wrote:
> > > > > > Or we could say that admin commands must complete within bounde=
d time,
> > > > > > but I'm not sure that is implementable for some device types li=
ke
> > > > > > virtio-blk, virtio-scsi, and virtiofs.
> > > > >=20
> > > > > No we can't.
> > > > > Some commands, for example FW upgrade can take 10 minutes and it'=
s perfectly
> > > > > fine. Other commands like setting feature bit will take 1 millise=
c.
> > > > > Each device implements commands in a different internal logic so =
we can't
> > > > > expect to complete after X time.
> > > >=20
> > > > When I say bounded time, I mean that it finishes in a finite amount=
 of
> > > > time. I'm not saying there is a specific time X that all device
> > > > implementations must satisfy. Unbounded means it might never finish.
> > >=20
> > > There might be a chance that any command for any virtio device type w=
ill
> > > never finish. Nothing new here in the adminq.
> > >=20
> > > what one can do is to set a timeout for himself and if this timeout e=
xpire -
> > > check the device status. If it needs_reset - do a reset. if status is=
 ok,
> > > then wait some more time.
> > > After X retries, unmap buffers or reset the adminq.
> >=20
> > Michael: What effect does resetting the group owner device have on group
> > member devices?
>=20
> virtio level reset? It's a good question. I'd expect them all to be
> reset no?
>=20
> > I'm concerned that this approach disrupts all group member devices. For
> > example, you try to add a new device but the command hangs. In order to
> > recover you now have to reset the group owner device and this breaks all
> > the group member devices.
>=20
>=20
> I agree. How about a VQ level reset though? Seems like exactly
> what's needed here?

Yes, a new virtqueue-level reset feature would take care of this case.

Stefan

--HeTp2zefbSvWImYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQJ0p4ACgkQnKSrs4Gr
c8hvWgf/ZjNllLK9ESEOW06/TpFlrBk+4+Fs1zd/PRj5kE6SZA8XLQEH8XKHUm2X
hESivGG4XeevaFxUYCUDO4ow7NDGn4kN8yt4b8KXI6g5LT+X3xhI2or3jiMEauHR
QFKb+vKGRqJvzugNZEYaOhAsigLzShkqSAWSCrjtu2txNOguqe+AURuTzeWZa2rB
JJTXKAw3VgcEwSk5hieoDHBrqWgBt8rvCMD2tci4dTrSiQH2Owv0tgeIRambTltW
thUZt/tgCcqyvGL6FmZsU4KARDzKDpXoPK603IG69PJKuLcpz/ZRnc1pO3wz14vP
lRbj1WLmJkRD+X1mHWuOLVOVoy6/Cw==
=I0Qh
-----END PGP SIGNATURE-----

--HeTp2zefbSvWImYL--

