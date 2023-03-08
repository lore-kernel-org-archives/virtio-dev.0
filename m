Return-Path: <virtio-dev-return-11526-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10122C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:13:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 43AB93E30F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:13:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 366F09866F9
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:13:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 29B439866EF; Wed,  8 Mar 2023 14:13:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15F539866F0
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 14:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: aRGAOW2wOIqItEhCBujyRg-1
Date: Wed, 8 Mar 2023 09:13:17 -0500
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
Message-ID: <20230308141317.GC299426@fedora>
References: <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
 <20230306162538.GA56760@fedora>
 <e74483a4-38fa-99b5-86b8-785f0b98d029@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5DVIKwcIJjHvSBzF"
Content-Disposition: inline
In-Reply-To: <e74483a4-38fa-99b5-86b8-785f0b98d029@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

--5DVIKwcIJjHvSBzF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 01:17:33PM +0200, Max Gurtovoy wrote:
>=20
>=20
> On 06/03/2023 18:25, Stefan Hajnoczi wrote:
> > On Mon, Mar 06, 2023 at 05:28:03PM +0200, Max Gurtovoy wrote:
> > >=20
> > >=20
> > > On 06/03/2023 13:20, Stefan Hajnoczi wrote:
> > > > On Mon, Mar 06, 2023 at 04:00:50PM +0800, Jason Wang wrote:
> > > > >=20
> > > > > =E5=9C=A8 2023/3/6 08:03, Stefan Hajnoczi =E5=86=99=E9=81=93:
> > > > > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wr=
ote:
> > > > > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wro=
te:
> > > > > > > > What happens if a command takes 1 second to complete, is th=
e device
> > > > > > > > allowed to process the next command from the virtqueue duri=
ng this time,
> > > > > > > > possibly completing it before the first command?
> > > > > > > >=20
> > > > > > > > This requires additional clarification in the spec because =
"they are
> > > > > > > > processed by the device in the order in which they are queu=
ed" does not
> > > > > > > > explain whether commands block the virtqueue (in order comp=
letion) or
> > > > > > > > not (out of order completion).
> > > > > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
> > > > > > virtio-scsi, virtio-blk, and NVMe requests may complete out of =
order.
> > > > > > Several may be processed by the device at the same time.
> > > > > >=20
> > > > > > They rely on multi-queue for abort operations:
> > > > > >=20
> > > > > > In virtio-scsi the abort requests (VIRTIO_SCSI_T_TMF_ABORT_TASK=
) are
> > > > > > sent on the control virtqueue. The the request identifier names=
pace is
> > > > > > shared across all virtqueues so it's possible to abort a reques=
t that
> > > > > > was submitted to any command virtqueue.
> > > > > >=20
> > > > > > NVMe also follows the same design where abort commands are sent=
 on the
> > > > > > Admin Submission Queue instead of an I/O Submission Queue. It's=
 possible
> > > > > > to identify NVMe requests by <Submission Queue ID, Command Iden=
tifier>.
> > > > > >=20
> > > > > > virtio-blk doesn't support aborting requests.
> > > > > >=20
> > > > > > I think the logic behind this design is that if a queue gets st=
uck
> > > > > > processing long-running requests, then the device should not be=
 forced
> > > > > > to perform lookahead in the queue to find abort commands. A sep=
arate
> > > > > > control/admin queue is used for the abort requests.
> > > > >=20
> > > > >=20
> > > > > Or device need mandate some kind of QOS here, e.g a request must =
be complete
> > > > > in some time. Otherwise we don't have sufficient reliability for =
using it as
> > > > > management task?
> > > >=20
> > > > Yes, if all commands can be executed in bounded time then a guarant=
ee is
> > > > possible.
> > > >=20
> > > > Here is an example where that's hard: imagine a virtio-blk device b=
acked
> > > > by network storage. When an admin queue command is used to delete a
> > > > group member, any of the group member's in-flight I/O requests need=
 to
> > > > be aborted. If the network hangs while the group member is being
> > > > deleted, then the device can't complete an orderly shutdown of I/O
> > > > requests in a reasonable time.
> > > >=20
> > > > That example shows a basic group admin command that I think Michael=
 is
> > > > about to propose. We can't avoid this problem by not making it a gr=
oup
> > > > admin command - it needs to be a group admin command. So I think it=
's
> > > > likely that there will be admin commands that take an unbounded amo=
unt
> > > > of time to complete. One way to achieve what you mentioned is timeo=
uts.
> > >=20
> > > I think that you're getting into device specific implementation detai=
ls and
> > > I'm not sure it's necessary.
> > >=20
> > > I don't think we need to abort admin commands. Admin commands can be
> > > flushed/aborted during the device reset phase.
> > > Only IO commands should have the possibility to being aborted as you
> > > mentioned in NVMe and SCSI (and potentially in virtio-blk).
> >=20
> > It's a general design issue that should be clarified now rather than
> > being left unspecified.
> >=20
> > I'm not saying that it must be possible to abort admin commands. There
> > are other options, like requiring the device itself to fail a command
> > after a timeout.
>=20
> do you have an example of timeout today for control vq ?

Do you mean the virtio-net control virtqueue? I don't think it has any
commands with an unbounded execution time.

> >=20
> > Or we could say that admin commands must complete within bounded time,
> > but I'm not sure that is implementable for some device types like
> > virtio-blk, virtio-scsi, and virtiofs.
>=20
> No we can't.
> Some commands, for example FW upgrade can take 10 minutes and it's perfec=
tly
> fine. Other commands like setting feature bit will take 1 millisec.
> Each device implements commands in a different internal logic so we can't
> expect to complete after X time.

When I say bounded time, I mean that it finishes in a finite amount of
time. I'm not saying there is a specific time X that all device
implementations must satisfy. Unbounded means it might never finish.

> Device can go to so FATAL state in case a command is stuck and causing
> internal errors in it.
>=20
> >=20
> > > For your example, stopping a member is possible even it there are some
> > > errors in the network. You can for example destroy all the connection=
s to
> > > the remote target and complete all the BIOS with some error.
> >=20
> > Forgetting about in-flight requests doesn't necessarily make them go
> > away. It creates a race between forgotten requests and reconnection. In
> > the worst case a forgotten write request takes effect after
> > reconnection, causing data corruption.
>=20
> For making it work without data corruption we need a cooperation of the
> target side for sure. But this is fine since the target in that case is p=
art
> of the "virtio-blk backend".
> One solution is that the target can decide it will flush all the requests=
 to
> the storage device before accepting new connections.

This solution shifts the unbounded time from disconnection to
connection. The Group Member Delete command will complete quickly but a
subsequent Group Member Create command for the same underlying storage
device would need to wait until the requests are done.

Therefore I think the admin queue must be designed under the assumption
that some commands take a very long time.

Stefan

--5DVIKwcIJjHvSBzF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQIl/0ACgkQnKSrs4Gr
c8j/hQf+LZgTlGjBd9/OJxRP2Dx7QREfuDp+i7i0huFppIeT+BFXzvOm09KDp7s5
gQdZCnWA8jY/KQmqCFjPKUGeZxuGQ4TWocoCojpquti9vmjTGi0bfiqh5vxmctji
us+SPY/XqBck1nL4Bhi3eZGGFdQb9stvqiWg+inDih858GrjbIK/yAsvq1+9EtnE
SsD0wdXy8iY1rKLDKW1XX3+UmM106KsOqXdKD6J5moXPHyIEo9po+JJCHdKKqkOl
Bb+afUjGzWWnJS7PrF+OfDCraH4OXAVd/wrcoV4iqrSWwbd7F8T229VjwupoMcMs
NpBJ9tFmRxMm6xI0gBalMsG8eTHijg==
=2uh3
-----END PGP SIGNATURE-----

--5DVIKwcIJjHvSBzF--

