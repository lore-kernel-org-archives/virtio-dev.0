Return-Path: <virtio-dev-return-11430-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA839C678DB
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 00:03:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08AAA728A
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 00:03:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F21F29866C2
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 00:03:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E616A9865CF; Mon,  6 Mar 2023 00:03:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB3589866B5
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 00:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4EPeMQLdPTqsL1B4xc0kgw-1
Date: Sun, 5 Mar 2023 19:03:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230306000302.GA244754@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mCHdiLR19dCs2Ve7"
Content-Disposition: inline
In-Reply-To: <20230305043419-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

--mCHdiLR19dCs2Ve7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
> On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
> > What happens if a command takes 1 second to complete, is the device
> > allowed to process the next command from the virtqueue during this time,
> > possibly completing it before the first command?
> >=20
> > This requires additional clarification in the spec because "they are
> > processed by the device in the order in which they are queued" does not
> > explain whether commands block the virtqueue (in order completion) or
> > not (out of order completion).
>=20
> Oh I begin to see. Hmm how does e.g. virtio scsi handle this?

virtio-scsi, virtio-blk, and NVMe requests may complete out of order.
Several may be processed by the device at the same time.

They rely on multi-queue for abort operations:

In virtio-scsi the abort requests (VIRTIO_SCSI_T_TMF_ABORT_TASK) are
sent on the control virtqueue. The the request identifier namespace is
shared across all virtqueues so it's possible to abort a request that
was submitted to any command virtqueue.

NVMe also follows the same design where abort commands are sent on the
Admin Submission Queue instead of an I/O Submission Queue. It's possible
to identify NVMe requests by <Submission Queue ID, Command Identifier>.

virtio-blk doesn't support aborting requests.

I think the logic behind this design is that if a queue gets stuck
processing long-running requests, then the device should not be forced
to perform lookahead in the queue to find abort commands. A separate
control/admin queue is used for the abort requests.

Stefan

--mCHdiLR19dCs2Ve7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQFLbUACgkQnKSrs4Gr
c8h32wf/cjeMGB+JR6Q8Ad4Gyl7gGnbO+RxM695IV3sf8Zf/sO5XGEWEqaexUHXh
mXwi9zUWt3dhaqf6AmQocpVvFVSo+pZQctylfXARjg1eCX1fGM6SzGw2tII4Vpyi
w3jPdWavwAz9xQVLUlMfXhJ30LE8VBP7NysrQMoSyFTVkNNEl8/4wzGmJ51n+Qed
nJUpISN9hWsQufWHuK9zpeD7c9wnxV6cbPZmVc5xTXUOaYLyFSvQSjsAct0hFZ1T
sxQydUPnfLDJ2fa52MrCIEAE4qv3OF7ho6p5oBGJbMU+wwnkeUCfflu4cH4OHk3C
rx1rCZF2JXY/dkx4Id8LGwhPTC3Nwg==
=zxoT
-----END PGP SIGNATURE-----

--mCHdiLR19dCs2Ve7--

