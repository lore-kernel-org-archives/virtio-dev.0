Return-Path: <virtio-dev-return-11542-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F878C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:15:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5C3422A82B
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:15:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42CF39866FE
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:15:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 32E809866F3; Wed,  8 Mar 2023 17:15:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 204499866F4
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 17:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: O6gEP9_bPiWd77dB-Cs-cg-1
Date: Wed, 8 Mar 2023 12:15:23 -0500
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
Message-ID: <20230308171523.GA320810@fedora>
References: <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
 <20230306162538.GA56760@fedora>
 <e74483a4-38fa-99b5-86b8-785f0b98d029@nvidia.com>
 <20230308141317.GC299426@fedora>
 <18ddbf69-19a6-3c6b-9e42-aaae66e20bcf@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uDzw6gx4hMMRqpPH"
Content-Disposition: inline
In-Reply-To: <18ddbf69-19a6-3c6b-9e42-aaae66e20bcf@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

--uDzw6gx4hMMRqpPH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 06:19:41PM +0200, Max Gurtovoy wrote:
>=20
>=20
> On 08/03/2023 16:13, Stefan Hajnoczi wrote:
> > On Wed, Mar 08, 2023 at 01:17:33PM +0200, Max Gurtovoy wrote:
> > >=20
> > >=20
> > > On 06/03/2023 18:25, Stefan Hajnoczi wrote:
> > > > On Mon, Mar 06, 2023 at 05:28:03PM +0200, Max Gurtovoy wrote:
> > > > >=20
> > > > >=20
> > > > > On 06/03/2023 13:20, Stefan Hajnoczi wrote:
> > > > > > On Mon, Mar 06, 2023 at 04:00:50PM +0800, Jason Wang wrote:
> > > > > > >=20
> > > > > > > =E5=9C=A8 2023/3/6 08:03, Stefan Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirki=
n wrote:
> > > > > > > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi=
 wrote:
> > > > > > > > > > What happens if a command takes 1 second to complete, i=
s the device
> > > > > > > > > > allowed to process the next command from the virtqueue =
during this time,
> > > > > > > > > > possibly completing it before the first command?
> > > > > > > > > >=20
> > > > > > > > > > This requires additional clarification in the spec beca=
use "they are
> > > > > > > > > > processed by the device in the order in which they are =
queued" does not
> > > > > > > > > > explain whether commands block the virtqueue (in order =
completion) or
> > > > > > > > > > not (out of order completion).
> > > > > > > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle t=
his?
> > > > > > > > virtio-scsi, virtio-blk, and NVMe requests may complete out=
 of order.
> > > > > > > > Several may be processed by the device at the same time.
> > > > > > > >=20
> > > > > > > > They rely on multi-queue for abort operations:
> > > > > > > >=20
> > > > > > > > In virtio-scsi the abort requests (VIRTIO_SCSI_T_TMF_ABORT_=
TASK) are
> > > > > > > > sent on the control virtqueue. The the request identifier n=
amespace is
> > > > > > > > shared across all virtqueues so it's possible to abort a re=
quest that
> > > > > > > > was submitted to any command virtqueue.
> > > > > > > >=20
> > > > > > > > NVMe also follows the same design where abort commands are =
sent on the
> > > > > > > > Admin Submission Queue instead of an I/O Submission Queue. =
It's possible
> > > > > > > > to identify NVMe requests by <Submission Queue ID, Command =
Identifier>.
> > > > > > > >=20
> > > > > > > > virtio-blk doesn't support aborting requests.
> > > > > > > >=20
> > > > > > > > I think the logic behind this design is that if a queue get=
s stuck
> > > > > > > > processing long-running requests, then the device should no=
t be forced
> > > > > > > > to perform lookahead in the queue to find abort commands. A=
 separate
> > > > > > > > control/admin queue is used for the abort requests.
> > > > > > >=20
> > > > > > >=20
> > > > > > > Or device need mandate some kind of QOS here, e.g a request m=
ust be complete
> > > > > > > in some time. Otherwise we don't have sufficient reliability =
for using it as
> > > > > > > management task?
> > > > > >=20
> > > > > > Yes, if all commands can be executed in bounded time then a gua=
rantee is
> > > > > > possible.
> > > > > >=20
> > > > > > Here is an example where that's hard: imagine a virtio-blk devi=
ce backed
> > > > > > by network storage. When an admin queue command is used to dele=
te a
> > > > > > group member, any of the group member's in-flight I/O requests =
need to
> > > > > > be aborted. If the network hangs while the group member is being
> > > > > > deleted, then the device can't complete an orderly shutdown of =
I/O
> > > > > > requests in a reasonable time.
> > > > > >=20
> > > > > > That example shows a basic group admin command that I think Mic=
hael is
> > > > > > about to propose. We can't avoid this problem by not making it =
a group
> > > > > > admin command - it needs to be a group admin command. So I thin=
k it's
> > > > > > likely that there will be admin commands that take an unbounded=
 amount
> > > > > > of time to complete. One way to achieve what you mentioned is t=
imeouts.
> > > > >=20
> > > > > I think that you're getting into device specific implementation d=
etails and
> > > > > I'm not sure it's necessary.
> > > > >=20
> > > > > I don't think we need to abort admin commands. Admin commands can=
 be
> > > > > flushed/aborted during the device reset phase.
> > > > > Only IO commands should have the possibility to being aborted as =
you
> > > > > mentioned in NVMe and SCSI (and potentially in virtio-blk).
> > > >=20
> > > > It's a general design issue that should be clarified now rather than
> > > > being left unspecified.
> > > >=20
> > > > I'm not saying that it must be possible to abort admin commands. Th=
ere
> > > > are other options, like requiring the device itself to fail a comma=
nd
> > > > after a timeout.
> > >=20
> > > do you have an example of timeout today for control vq ?
> >=20
> > Do you mean the virtio-net control virtqueue? I don't think it has any
> > commands with an unbounded execution time.
>=20
> Correct. So why introducing it now ?

The examples I've given are the create and delete group member
operations. I think those operations will take unbounded time in some
device implementations.

>=20
> >=20
> > > >=20
> > > > Or we could say that admin commands must complete within bounded ti=
me,
> > > > but I'm not sure that is implementable for some device types like
> > > > virtio-blk, virtio-scsi, and virtiofs.
> > >=20
> > > No we can't.
> > > Some commands, for example FW upgrade can take 10 minutes and it's pe=
rfectly
> > > fine. Other commands like setting feature bit will take 1 millisec.
> > > Each device implements commands in a different internal logic so we c=
an't
> > > expect to complete after X time.
> >=20
> > When I say bounded time, I mean that it finishes in a finite amount of
> > time. I'm not saying there is a specific time X that all device
> > implementations must satisfy. Unbounded means it might never finish.
>=20
> There might be a chance that any command for any virtio device type will
> never finish. Nothing new here in the adminq.
>=20
> what one can do is to set a timeout for himself and if this timeout expir=
e -
> check the device status. If it needs_reset - do a reset. if status is ok,
> then wait some more time.
> After X retries, unmap buffers or reset the adminq.

Michael: What effect does resetting the group owner device have on group
member devices?

I'm concerned that this approach disrupts all group member devices. For
example, you try to add a new device but the command hangs. In order to
recover you now have to reset the group owner device and this breaks all
the group member devices.

> >=20
> > > Device can go to so FATAL state in case a command is stuck and causing
> > > internal errors in it.
> > >=20
> > > >=20
> > > > > For your example, stopping a member is possible even it there are=
 some
> > > > > errors in the network. You can for example destroy all the connec=
tions to
> > > > > the remote target and complete all the BIOS with some error.
> > > >=20
> > > > Forgetting about in-flight requests doesn't necessarily make them go
> > > > away. It creates a race between forgotten requests and reconnection=
=2E In
> > > > the worst case a forgotten write request takes effect after
> > > > reconnection, causing data corruption.
> > >=20
> > > For making it work without data corruption we need a cooperation of t=
he
> > > target side for sure. But this is fine since the target in that case =
is part
> > > of the "virtio-blk backend".
> > > One solution is that the target can decide it will flush all the requ=
ests to
> > > the storage device before accepting new connections.
> >=20
> > This solution shifts the unbounded time from disconnection to
> > connection. The Group Member Delete command will complete quickly but a
> > subsequent Group Member Create command for the same underlying storage
> > device would need to wait until the requests are done.
> >=20
> > Therefore I think the admin queue must be designed under the assumption
> > that some commands take a very long time.
>=20
> For sure an admin command may take long time. FW upgrade can take 10 minu=
tes
> for example.
> But each device is free to implement internal logic as he choose.
>=20
> Same for live migration, when we stop/quiesce a device we must make sure =
it
> doesn't master any DMA operations. Thus, in some implementations we need =
to
> wait for all inflights to end fast. In others, we can invalidate the acce=
ss
> to host/guest memory and wait for completions until the freeze state.
>=20
> Bottom line, this is device implementation specific consideration.

What I'm asking is that the spec clarifies the command completion order
semantics (in-order or out-of-order), whether there is a mechanism to
abort commands, etc.

Device implementers can then take advantage of those aspects to
implement devices that don't hang (e.g. health monitoring becomes
unavailable when there is a long running command).

If the spec doesn't cover this, then device implementers will not be
able to work around it when implementing standard commands like
create/delete group member.

Does that make sense?

Stefan

--uDzw6gx4hMMRqpPH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQIwqsACgkQnKSrs4Gr
c8hAfQf9GHQVF5s1DZ4zhPLFvZ53U4xNd/J3sDDTYiTdEqG1WFzNqIHr+uOnGyjr
ikxyqsRJ6QySH8n/m1Wq97tRJZQXGPwuaecRKC0amCXHlKE04OqoG4rcNZop5lNn
aFXoAtdtE6WDcWdDNLVuB+TDnzNwARKP5qe7txVg8Jd+POn36styd3Z52VjSXpKj
NBMx68J1HgFquw1eln5JXug8hnC8M8U/XtaZ/hGA/lcXJB1R9IA4bg08OfMWQ5FW
z3+Lc2xQPsr6bmnhdvMNRwtn/aiPvFkEHTYLP2VIdiumrGuPdQO0tLJc6TcI8Y2p
yQgIOSYL7i3BP5hPk+ROcnPeDaleqA==
=LEvz
-----END PGP SIGNATURE-----

--uDzw6gx4hMMRqpPH--

