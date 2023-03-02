Return-Path: <virtio-dev-return-11392-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FAAC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:20:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A4CDA87CD7
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:20:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E8F79867EF
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:20:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BDFA39866D7; Thu,  2 Mar 2023 20:20:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20B5E9866AC
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 20:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _s6BoMNRPey5q_THrDLQSg-1
Date: Thu, 2 Mar 2023 15:19:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
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
Message-ID: <20230302201912.GC2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V13T1Z5gYhTjYFsS"
Content-Disposition: inline
In-Reply-To: <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

--V13T1Z5gYhTjYFsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 06:40:29PM +0000, Parav Pandit wrote:
>=20
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, March 2, 2023 8:05 AM
>=20
> > +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
> > +is reserved and set to zero by the device.
> > +
> s/status_qialifier/status_qualifier
> Missed from v10 of Feb.
>=20
> > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
> > +describes possible \field{status_qialifier} values:
> s/status_qialifier/status_qualifier
>=20
> Can you please add other useful error codes in addition to the EINVAL?
> Few that we are needed EAGAIN, ENOMEM, EBUSY, ENODEV.

Please define a unique constant for each error condition that can occur
instead of sharing catch-all errno constants between multiple error
conditions. If a driver wants to squash them together into an errno,
that's fine, but I think doing this at the hardware interface level is
just propagating the mistakes of errnos.

Only status_qualifier is needed and the vague status field can be
dropped. It's not clear to me why adding EAGAIN, ENOMEM, EBUSY, and
ENODEV is useful. They have no meaning to the driver, only the
status_qualifier really indicates what is going on.

I'm sure you guys have discussed this previously, but please provide
rationale in the spec because it looks weird to someone with fresh eyes.

Stefan

--V13T1Z5gYhTjYFsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBBMAACgkQnKSrs4Gr
c8j2WggAjXOReT+NIEXH63VfImrnwe+WRQOqepZ0EZNywv6oR7SyB32YiR9+dCC+
HqrLUlRRL5y0yITrLMYbILqMKLlijO0V4OpMHdc3atbDs9Nf+Bfe/xDKOBA1qXAd
qErcWrTfSe9uUAsAvCwyjAwd2VKsS8N+E52d2On+efKyeyl4wOuz9u8zr9hh77Qc
yKxZMx+Qtf486BAM7XlYRo0zrbZ9lWIJSxTw09tKv5hbb10XwuL39TIdROrkA9My
HKAy68fd3tgct5ccy0OT1XdlmbJ9gpLTabCDmC3IYixEGHaicdSLgTUvjpu598Fq
KU2hcDW3S7ZQ8W77MRkVk03NDuDvYw==
=R8hB
-----END PGP SIGNATURE-----

--V13T1Z5gYhTjYFsS--

