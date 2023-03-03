Return-Path: <virtio-dev-return-11418-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA04AC678D4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:17:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F3F7960088
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:17:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0CCA9867AA
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:17:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE6119867A1; Fri,  3 Mar 2023 13:17:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABC819867A3
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 13:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ydj0-cOIMSmKKrVSP1lFAw-1
Date: Fri, 3 Mar 2023 08:17:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
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
Message-ID: <20230303131703.GB2866370@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fmZlZDN9JY/kcEBO"
Content-Disposition: inline
In-Reply-To: <20230302185803-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

--fmZlZDN9JY/kcEBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 07:01:56PM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 02, 2023 at 03:19:12PM -0500, Stefan Hajnoczi wrote:
> > On Thu, Mar 02, 2023 at 06:40:29PM +0000, Parav Pandit wrote:
> > >=20
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, March 2, 2023 8:05 AM
> > >=20
> > > > +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qiali=
fier}
> > > > +is reserved and set to zero by the device.
> > > > +
> > > s/status_qialifier/status_qualifier
> > > Missed from v10 of Feb.
> > >=20
> > > > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following t=
able
> > > > +describes possible \field{status_qialifier} values:
> > > s/status_qialifier/status_qualifier
> > >=20
> > > Can you please add other useful error codes in addition to the EINVAL?
> > > Few that we are needed EAGAIN, ENOMEM, EBUSY, ENODEV.
> >=20
> > Please define a unique constant for each error condition that can occur
> > instead of sharing catch-all errno constants between multiple error
> > conditions. If a driver wants to squash them together into an errno,
> > that's fine, but I think doing this at the hardware interface level is
> > just propagating the mistakes of errnos.
> >=20
> > Only status_qualifier is needed and the vague status field can be
> > dropped. It's not clear to me why adding EAGAIN, ENOMEM, EBUSY, and
> > ENODEV is useful. They have no meaning to the driver, only the
> > status_qualifier really indicates what is going on.
>=20
> At a high level at the moment we have only two cases:
> - ok
> - invalid input supplied by driver
>=20
> maybe we will have more reasons for a failure - remains to
> be seen.
>=20
>=20
>=20
>=20
>=20
> >=20
> > I'm sure you guys have discussed this previously, but please provide
> > rationale in the spec because it looks weird to someone with fresh eyes.
> >=20
> > Stefan
>=20
> Really most drivers just want to propagate errno to userspace.
> All the detailed reporting is for sure well intentional but
> in the end it is at best printed into log - end to end
> people just end up with a switch statement
> converting these to errno codes.
> So we are passing them from device and this way there will be
> some uniformity.

Please clarify the rationale in the spec. I don't agree with it, as
explained in my earlier email, but as long as its documented, people can
try to follow it.

Stefan

--fmZlZDN9JY/kcEBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQB808ACgkQnKSrs4Gr
c8j1uwf+IVWO7qI/G/FYps5trebuCM9OhDQo5CgTJnv2cu0eR93fYANSku68FQb0
3XOKyV2bv3ce9WhU5vYt1rXrA1oDscuyzbeKJm2m9c2YtzbGYGL/4c8uzp2X0VSh
kxUqpuI59Y+e1Zj2QM0FWLPnm+6VycXfK1fMtC7mvBjwtgWxDxf1zALiTtuQbLqD
nKo1Jy7O3NINB3eG1YHkW7jWI4HBwtGfwtWGNrxz7ECvcW8fJRR90lDMtwEkIV4y
B6uW8rUHTS+JV3if1FiBPEI8SBqjN5VB5vA98Hr1pfvYiBBHrq7EwtuJ5Ynp2ZXt
on4OWcSww0l9vTE/Wg9ebHaXofWHlQ==
=AL+F
-----END PGP SIGNATURE-----

--fmZlZDN9JY/kcEBO--

