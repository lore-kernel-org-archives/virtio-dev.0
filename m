Return-Path: <virtio-dev-return-11965-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39949C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:51:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 722822B063
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:50:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CD7198640B
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:50:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 310759863E4; Tue,  4 Apr 2023 11:50:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E18B9863E5
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 11:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DbetvNRrPG6Kq1heaGMFMQ-1
Date: Tue, 4 Apr 2023 07:50:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404115053.GB428487@fedora>
References: <cover.1680533760.git.mst@redhat.com>
 <93b34ea59bedbff0671ede2b171cacc1078f30ff.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6gOonmclWDfcHl6x"
Content-Disposition: inline
In-Reply-To: <93b34ea59bedbff0671ede2b171cacc1078f30ff.1680533760.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Subject: [virtio-dev] Re: [PATCH v11 03/10] admin: introduce group administration commands

--6gOonmclWDfcHl6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 11:03:16AM -0400, Michael S. Tsirkin wrote:
> This introduces a general structure for group administration commands,
> used to control device groups through their owner.
>=20
> Following patches will introduce specific commands and an interface for
> submitting these commands to the owner.
>=20
> Note that the commands are focused on controlling device groups:
> this is why group related fields are in the generic part of
> the structure.
> Without this the admin vq would become a "whatever" vq which does not do
> anything specific at all, just a general transport like thing.
> I feel going this way opens the design space to the point where
> we no longer know what belongs in e.g. config space
> what in the control q and what in the admin q.
> As it is, whatever deals with groups is in the admin q; other
> things not in the admin q.
>=20
> There are specific exceptions such as query but that's an exception that
> proves the rule ;)
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> changes since v10:
> 	explain the role of status vs status_qualifier, addresses
> 		multiple comments
> 	add more status values and appropriate qualifiers,
> 		as suggested by Parav
> 	clarify reserved command opcodes as suggested by Stefan
> 	better formatting for ranges, comment by Jiri
> 	make sure command-specific-data is a multiple of qword,
> 	so things are aligned, suggested by Jiri
> 	add Q_OK qualifier for success
> ---
>  admin.tex        | 121 +++++++++++++++++++++++++++++++++++++++++++++++
>  introduction.tex |   3 ++
>  2 files changed, 124 insertions(+)

My thoughts on status/status_qualifier haven't changed, but it's a
question of taste:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6gOonmclWDfcHl6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQsDx0ACgkQnKSrs4Gr
c8iCYwgAonIKgocXrfg5GPiiG61Dv0Vx6loiw9NgAtaeAlD5B4E/C23C3wRkNo9N
5vlGvLUxcP5VoLWvfUKBLpfUS5C/v4/sZrWex1Jl18kVlbvAmqexnn7BCj99X6je
XbeBj1KdgTsdVuPZhY+AudeJLRN05UEYxJoj3XuJRu0Nwr84Q/6xc0Tyb96YzdPK
FJbz8lFILdz8qdtFKn3IL/w7XJcLhGtSwME7S1VeIINVR6hU5PbVz4lgIevjjYg7
IK7+Qamzal9j811pYjkBMGVNLmbxE5xTxNzUNnSuM6zv+THFAZNC0aWEjAL7XFL7
6bdw31ZuUzTD/DbCDkcxRWR0mSHSaw==
=qOK4
-----END PGP SIGNATURE-----

--6gOonmclWDfcHl6x--

