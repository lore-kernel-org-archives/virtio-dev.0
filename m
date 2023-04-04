Return-Path: <virtio-dev-return-11969-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9906C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:57:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 217932AED2
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:57:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B70898640E
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:57:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E6AB39863E6; Tue,  4 Apr 2023 12:57:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D505C9863ED
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 12:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zzUAMbsRNQCDQlg2CkQicA-1
Date: Tue, 4 Apr 2023 08:57:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404125745.GE428487@fedora>
References: <cover.1680533760.git.mst@redhat.com>
 <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zl6ClIVqdl0KSyT"
Content-Disposition: inline
In-Reply-To: <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Subject: [virtio-dev] Re: [PATCH v11 08/10] admin: command list discovery

--4zl6ClIVqdl0KSyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 11:03:49AM -0400, Michael S. Tsirkin wrote:
> Add commands to find out which commands does each group support,
> as well as enable their use by driver.
> This will be especially useful once we have multiple group types.
>=20
> An alternative is per-type VQs. This is possible but will
> require more per-transport work. Discovery through the vq
> helps keep things contained.
>=20
> e.g. lack of support for some command can switch to a legacy mode
>=20
> note that commands are expected to be avolved by adding new
> fields to command specific data at the tail, so
> we generally do not need feature bits for compatibility.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ---
> dropped S.O.B by Max
> explain in commit log how commands will evolve, comment by Stefan
> replace will use with is capable of use, comment by Stefan
> typo fix reported by David and Lingshan
> rename cmds to cmd_opcodes suggested by Jiri
> list group_type explicitly in command description suggested by Jiri
> clarify how can device not support some commands
> always say group administration commands, comment by Jiri
> ---
>  admin.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4zl6ClIVqdl0KSyT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQsHskACgkQnKSrs4Gr
c8haAggAsm9y2VKM8FrRH2QnUxVeNK2uaQFNZrIAuqwe8zWk+60Ycakn75+OC+3t
n/Os2Xj70u261pvKoOqYOWDmAru9i1giWD/r/hDr+olq9lk4UeJL/LVlcCzOSsqX
IG46hnoQhfYRWoZMDB3+sASFyRrbohCZpATpR1g3YmxOMBj3d/ioMHyEVpZdx/cM
2M0x1+Gz3SqUEqYijr2qnR+lRrOq5SD7JGEGwPo+OfdqEhyOVuxYmNaGbPvG3wDT
hXRRyvbdL586mNYZcm475j/UOp1U/6HIHXsnPkxvzJdFm5nPz4H4LykQVHl4RZTg
X4Y5QovQrTBEuwftLWRD0PumszrR9Q==
=BpKV
-----END PGP SIGNATURE-----

--4zl6ClIVqdl0KSyT--

