Return-Path: <virtio-dev-return-11450-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B56CC6FA99
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:25:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7709D26A2A
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:25:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 727489866C8
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:25:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 67CB89866BA; Mon,  6 Mar 2023 16:25:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5499A9866B8
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 16:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: w3wFPM3LNNO86sqauQbPRQ-1
Date: Mon, 6 Mar 2023 11:25:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	sgarzare@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230306162538.GA56760@fedora>
References: <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3VKYeueoFpx5N6/u"
Content-Disposition: inline
In-Reply-To: <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

--3VKYeueoFpx5N6/u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 05:28:03PM +0200, Max Gurtovoy wrote:
>=20
>=20
> On 06/03/2023 13:20, Stefan Hajnoczi wrote:
> > On Mon, Mar 06, 2023 at 04:00:50PM +0800, Jason Wang wrote:
> > >=20
> > > =E5=9C=A8 2023/3/6 08:03, Stefan Hajnoczi =E5=86=99=E9=81=93:
> > > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
> > > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
> > > > > > What happens if a command takes 1 second to complete, is the de=
vice
> > > > > > allowed to process the next command from the virtqueue during t=
his time,
> > > > > > possibly completing it before the first command?
> > > > > >=20
> > > > > > This requires additional clarification in the spec because "the=
y are
> > > > > > processed by the device in the order in which they are queued" =
does not
> > > > > > explain whether commands block the virtqueue (in order completi=
on) or
> > > > > > not (out of order completion).
> > > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
> > > > virtio-scsi, virtio-blk, and NVMe requests may complete out of orde=
r.
> > > > Several may be processed by the device at the same time.
> > > >=20
> > > > They rely on multi-queue for abort operations:
> > > >=20
> > > > In virtio-scsi the abort requests (VIRTIO_SCSI_T_TMF_ABORT_TASK) are
> > > > sent on the control virtqueue. The the request identifier namespace=
 is
> > > > shared across all virtqueues so it's possible to abort a request th=
at
> > > > was submitted to any command virtqueue.
> > > >=20
> > > > NVMe also follows the same design where abort commands are sent on =
the
> > > > Admin Submission Queue instead of an I/O Submission Queue. It's pos=
sible
> > > > to identify NVMe requests by <Submission Queue ID, Command Identifi=
er>.
> > > >=20
> > > > virtio-blk doesn't support aborting requests.
> > > >=20
> > > > I think the logic behind this design is that if a queue gets stuck
> > > > processing long-running requests, then the device should not be for=
ced
> > > > to perform lookahead in the queue to find abort commands. A separate
> > > > control/admin queue is used for the abort requests.
> > >=20
> > >=20
> > > Or device need mandate some kind of QOS here, e.g a request must be c=
omplete
> > > in some time. Otherwise we don't have sufficient reliability for usin=
g it as
> > > management task?
> >=20
> > Yes, if all commands can be executed in bounded time then a guarantee is
> > possible.
> >=20
> > Here is an example where that's hard: imagine a virtio-blk device backed
> > by network storage. When an admin queue command is used to delete a
> > group member, any of the group member's in-flight I/O requests need to
> > be aborted. If the network hangs while the group member is being
> > deleted, then the device can't complete an orderly shutdown of I/O
> > requests in a reasonable time.
> >=20
> > That example shows a basic group admin command that I think Michael is
> > about to propose. We can't avoid this problem by not making it a group
> > admin command - it needs to be a group admin command. So I think it's
> > likely that there will be admin commands that take an unbounded amount
> > of time to complete. One way to achieve what you mentioned is timeouts.
>=20
> I think that you're getting into device specific implementation details a=
nd
> I'm not sure it's necessary.
>=20
> I don't think we need to abort admin commands. Admin commands can be
> flushed/aborted during the device reset phase.
> Only IO commands should have the possibility to being aborted as you
> mentioned in NVMe and SCSI (and potentially in virtio-blk).

It's a general design issue that should be clarified now rather than
being left unspecified.

I'm not saying that it must be possible to abort admin commands. There
are other options, like requiring the device itself to fail a command
after a timeout.

Or we could say that admin commands must complete within bounded time,
but I'm not sure that is implementable for some device types like
virtio-blk, virtio-scsi, and virtiofs.

> For your example, stopping a member is possible even it there are some
> errors in the network. You can for example destroy all the connections to
> the remote target and complete all the BIOS with some error.

Forgetting about in-flight requests doesn't necessarily make them go
away. It creates a race between forgotten requests and reconnection. In
the worst case a forgotten write request takes effect after
reconnection, causing data corruption.

Stefan

--3VKYeueoFpx5N6/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQGFAEACgkQnKSrs4Gr
c8jrpggAtK1zv0/ctSHqqV5ITxvSkVPiZorc9KrVwreNSEySX5r20I/WIhIR91D9
p+DgNvG77wxon8qU6rseWUEcGfPaDH9LotK7NL9pv5cdlzFROsT7ZPAZDuoC1DvJ
c3TS1VU/lTp3rwbaQo4USYnazPb/T4lMORGu4TA1Cj2SP9uysmPKv+kzvWToaxUs
rJtt+mKdjtemWk011uIp8XQpaRklmu0/m84G1PcC9ccWZNBu47zXwUtdLd/QzALt
Cl5VQPRtjpXMeztEJuucrO5YWUNWxD6ngEjqroEI81pZMPgnPbCcy6RnkNN82bFc
W1cnybwtvksfRuLyTEsYZahusdD7wA==
=xUat
-----END PGP SIGNATURE-----

--3VKYeueoFpx5N6/u--

