Return-Path: <virtio-dev-return-11457-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D2BC64EC4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 20:18:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1F2CA44352
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 20:18:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CCBA9866C9
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 20:18:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 00B05983C2D; Mon,  6 Mar 2023 20:18:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7F549866C0
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 20:18:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NFKd1cZLMemx--czfAJM4g-1
Date: Mon, 6 Mar 2023 15:17:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230306201759.GA78491@fedora>
References: <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KA7q7YtT7K3QUpzA"
Content-Disposition: inline
In-Reply-To: <20230306133525-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

--KA7q7YtT7K3QUpzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 01:37:31PM -0500, Michael S. Tsirkin wrote:
> On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
> > On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
> > > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
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
> > > > >=20
> > > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
> > > >=20
> > > > virtio-scsi, virtio-blk, and NVMe requests may complete out of orde=
r.
> > > > Several may be processed by the device at the same time.
> > >=20
> > > Let's say I submit a write followed by read - is read
> > > guaranteed to return an up to date info?
> >=20
> > In general, no. The driver must wait for the write completion before
> > submitting the read if it wants consistency.
> >=20
> > Stefan
>=20
> I see.  I think it's a good design to follow then.
>=20
> I'll just copy
> 	The driver queues requests to an arbitrary request queue, and
> 	they are used by the device on that same queue. It is the
> 	responsibility of the driver to ensure strict request ordering
> 	for commands placed on different queues, because they will be
> 	consumed with no order constraints.
>=20
> replacing "request" with "admin".

That sounds like it's only about multi-queue because it says "... for
commands placed on different queues". What I mentioned about a write
followed by a read quest also applies within a single queue.

Can you clarify the semantics in the single queue case?

Stefan

--KA7q7YtT7K3QUpzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQGSncACgkQnKSrs4Gr
c8hnjQf/c+chHGbHvkocqbSFseheyYAfch0jVL3RruR5YIu4tNtkY9GarDYM0EaC
fWVnOtKzYCfT2yzctNClrvkLdoxNj7N18H2J5YdFlIyyl40IoNu/DIwiP/dmjGY1
7ItSCZFytX5jtpNFbSu7Qxg17etpdtLTCajt9Pszw7PMSRvXY961QOkEzU1TsiwR
6qwE+eMA7ra5rP/z7wLSz4aqL7x+HZuTdZy9i3co+nTyHWTEbK38Qb91L0g25J0f
Y6dGwCf/C/jVaxBgOva3wefgQJMPGlO1NLe5aW+p/ijkk6uCQqfoPtenFgKS7MB7
JjyNA1R7ugd4iRIH02z5mtJ2lXvOtw==
=OQ+c
-----END PGP SIGNATURE-----

--KA7q7YtT7K3QUpzA--

