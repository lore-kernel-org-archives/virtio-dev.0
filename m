Return-Path: <virtio-dev-return-11510-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2906C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:58:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 313D541A1C
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:58:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28E0B9866F8
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:58:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1BF859866EE; Wed,  8 Mar 2023 11:58:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AE899866F0
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 11:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: CNPGXWtKMTeynzdrlZgf4g-1
Date: Wed, 8 Mar 2023 06:58:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308115846.GA299426@fedora>
References: <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307143911.GC124259@fedora>
 <ZAdTSiVJGSrRIqZ3@nanopsycho>
 <20230307190347.GA153228@fedora>
 <PH0PR12MB5481B78E6408C1A7C04FDABFDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvn+o1aJnyaWN58gxU6Y-xA3okkWYKcwfmg7ExdhOmv1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bCvMbrKxEWQnk7z0"
Content-Disposition: inline
In-Reply-To: <CACGkMEvn+o1aJnyaWN58gxU6Y-xA3okkWYKcwfmg7ExdhOmv1g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [virtio] RE: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10]
 admin: introduce virtio admin virtqueues

--bCvMbrKxEWQnk7z0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 01:17:44PM +0800, Jason Wang wrote:
> On Wed, Mar 8, 2023 at 3:09=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
> >
> >
> >
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > Sent: Tuesday, March 7, 2023 2:04 PM
> >
> > > An alternative is unconditional out-of-order completion, where there =
are no
> > > per-command ordering rules. The driver must wait for a command to com=
plete
> > > if it relies on the results of that command for its next command. I l=
ike this
> > > approach because it's less complex in the spec and for device impleme=
nters,
> > > while the burden on the driver implementer is still reasonable.
> > +1.
>=20
> Note that this is the way current ctrl virtqueue works.
>=20
> > This has best of both.
> > 1. Command ordering knowledge and hence the decision left to the one wh=
ich issues them. (driver).
> > 2. Ability to execute multiple unrelated commands using a single AQ.
> > 3. stateless device in AQ command execution
>=20
> Does this mean if we want to migrate AQ (not use AQ to migrate), we
> need to wait for the AQ command to be completed?

It depends. Today, if the AQ is emulated by the VMM then it might be
possible to migrate while there is a command in-flight. If the AQ is
handled by the device then no because VIRTIO currently does not support
device state migration.

In the future, device state migration will probably be added to
vhost-user and vDPA. In that case a device can migrate in-flight AQ
activity - assuming it's possible to pause it, serialize state,
deserialize it, and resume it. Otherwise it's still necessary to wait.

To be clear, I'm just taking about AQ commands that are currently in the
process of executing. Commands that are in the virtqueue but have not
yet been started by the device can be easily migrated using the existing
virtqueue migration infrastructure.

Stefan

--bCvMbrKxEWQnk7z0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQIeHYACgkQnKSrs4Gr
c8h0rwgAgwENDlgT+MPoC2es+E2CZlJ0F/K7CmHhWeirrlsTjaK0vJv7eSGb+/VC
sH0Te6xY5U5QJ6Mxtvj0A/mUwfAxnUYfIovUeh5O6Lj4vCN/ZFMCPdZwpUekQKJ5
IEoy9fIeEgxC2AxhAENcWrw/ajPdLrJrPuzit6O6wlLeWhn2HcheVWcgbCMsqq0M
57FUh8M1LorCg7s430gATN7N/Sy+mjgZiJDjct8NI4+l+jBcv8H0yuMREPwH17oe
hSiLjZ1X0dn2D2PzWvUbhSkFjo69fSoQu1IgwKfhxeJ2tbvqKZm6/43NF9D7GmtU
84hKuAH4DD7qycHKMPAMX1oMLwbhDg==
=EQF7
-----END PGP SIGNATURE-----

--bCvMbrKxEWQnk7z0--

