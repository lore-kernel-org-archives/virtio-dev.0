Return-Path: <virtio-dev-return-11518-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188D5C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:44:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 49BAB3E308
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:44:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 448DD986701
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:44:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 363E59866F6; Wed,  8 Mar 2023 12:44:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AD589866F1
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 12:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fIlJEwtSNPOuklvApBxNdQ-1
Date: Wed, 8 Mar 2023 07:44:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308124418.GB299426@fedora>
References: <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307143911.GC124259@fedora>
 <ZAdTSiVJGSrRIqZ3@nanopsycho>
 <20230307190347.GA153228@fedora>
 <ZAhgv21Nnex6vbDf@nanopsycho>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="haTDp70MznFQk8/8"
Content-Disposition: inline
In-Reply-To: <ZAhgv21Nnex6vbDf@nanopsycho>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

--haTDp70MznFQk8/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 11:17:35AM +0100, Jiri Pirko wrote:
> Tue, Mar 07, 2023 at 08:03:47PM CET, stefanha@redhat.com wrote:
> >On Tue, Mar 07, 2023 at 04:07:54PM +0100, Jiri Pirko wrote:
> >> Tue, Mar 07, 2023 at 03:39:11PM CET, stefanha@redhat.com wrote:
> >> >On Tue, Mar 07, 2023 at 09:03:18AM +0100, Jiri Pirko wrote:
> >> >> Mon, Mar 06, 2023 at 07:37:31PM CET, mst@redhat.com wrote:
> >> >> >On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
> >> >> >> On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wro=
te:
> >> >> >> > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrot=
e:
> >> >> >> > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin=
 wrote:
> >> >> >> > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi =
wrote:
> >> >> >> > > > > What happens if a command takes 1 second to complete, is=
 the device
> >> >> >> > > > > allowed to process the next command from the virtqueue d=
uring this time,
> >> >> >> > > > > possibly completing it before the first command?
> >> >> >> > > > >=20
> >> >> >> > > > > This requires additional clarification in the spec becau=
se "they are
> >> >> >> > > > > processed by the device in the order in which they are q=
ueued" does not
> >> >> >> > > > > explain whether commands block the virtqueue (in order c=
ompletion) or
> >> >> >> > > > > not (out of order completion).
> >> >> >> > > >=20
> >> >> >> > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle th=
is?
> >> >> >> > >=20
> >> >> >> > > virtio-scsi, virtio-blk, and NVMe requests may complete out =
of order.
> >> >> >> > > Several may be processed by the device at the same time.
> >> >> >> >=20
> >> >> >> > Let's say I submit a write followed by read - is read
> >> >> >> > guaranteed to return an up to date info?
> >> >> >>=20
> >> >> >> In general, no. The driver must wait for the write completion be=
fore
> >> >> >> submitting the read if it wants consistency.
> >> >> >>=20
> >> >> >> Stefan
> >> >> >
> >> >> >I see.  I think it's a good design to follow then.
> >> >>=20
> >> >> Hmm, is it suitable to have this approach for configuration interfa=
ce?
> >> >> Storage device is a different beast, having parallel reads and writ=
es
> >> >> makes complete sense for performance.
> >> >>=20
> >> >> ->read a req
> >> >> ->read b req
> >> >> ->read c req
> >> >> <-read a rep
> >> >> <-read b rep
> >> >> <-read c rep
> >> >>=20
> >> >> There is no dependency, even between writes.
> >> >>=20
> >> >> But in case of configuration, does not make any sense to me.
> >> >> Why is it needed? To pass the burden of consistency of
> >> >> configuration to driver sounds odd at least.
> >> >>=20
> >> >> I sense there is no concete idea about what the "admin virtqueue" s=
hould
> >> >> serve for exactly.
> >> >
> >> >It's useful for long-running commands because they prevent other
> >> >commands from executing.
> >> >
> >> >An example I've given is that deleting a group member might require
> >> >waiting for the group member's I/O activity to finish. If that I/O
> >> >activity cannot be cancelled instantaneously, then it could take an
> >> >unbounded amount of time to delete the group member. The device would=
 be
> >> >unable to process futher admin commands.
> >>=20
> >> I see. Then I believe that the device should handle the dependencies.
> >> Example 1:
> >> -> REQ cmd to create group member A
> >> -> REQ cmd to create group member B
> >> <- REP cmd to create group member A
> >> <- REP cmd to create group member B
> >>=20
> >> The device according to internal implementation can either serialize t=
he
> >> 2 group member creations or do it in parallel, if it supports it.
> >>=20
> >> Example 2:
> >> -> REQ cmd to create group member A
> >> -> REQ cmd config group member A
> >> <- REP cmd to create group member A
> >> <- REP cmd config group member A
> >>=20
> >> Here the serialization is necessary and the device is the one to take
> >> care of it.
> >>=20
> >> Makes sense?
> >
> >Yes, I understand. The spec would need to define ordering rules for
> >specific commands and the device must implement them. It allows the
> >driver to pipeline commands while also allowing out-of-order completion
> >(parallelism) in some cases. The disadvantage of this approach is
> >complexity in the spec and implementations.
> >
> >An alternative is unconditional out-of-order completion, where there are
> >no per-command ordering rules. The driver must wait for a command to
> >complete if it relies on the results of that command for its next
> >command. I like this approach because it's less complex in the spec and
> >for device implementers, while the burden on the driver implementer is
> >still reasonable.
>=20
> But isn't this duplicating the burden of maintaining dependencies to
> both driver and device? I mean, device should not depend on driver doing
> the right thing, that means it has to check the dependencies for every
> incoming command anyway. The only difference would be to wait instead of
> returning "-EBUSY" in case the dependency is not satisfied yet.

The device does not need to reject commands that have dependencies with
-EBUSY. The result of commands with dependencies is either A -> B or B
-> A.

For example:
1. Create Group Member A
2. Delete Group Member A

Command 2 might succeed or it might fail with -ENOENT because Group
Member A doesn't exist yet.

> Device knows exactly what are the dependencies. And I believe, those are
> device implementation specific. For example, some implementation could
> support parallel VF config cmd execution, some implementation might
> need to serialize that. Driver has no clue.

Yes, that's up to the device. Out-of-order completion is a superset of
in-order completion. So the device is allowed to run commands in series
when it wants. A driver designed for out-of-order completion will work
fine either way.

> Could you please elaborate a bit more what you mean by "complexity in
> the spec"?

When adding commands to the spec, the dependency relationships with
other commands need to be thought about and documented.

Device implementers need to get those relationships right. That means
they need to remember that command B waits for command A.

Driver implementers have to understand that command B waits for command
A but not command C according to the spec.

That seems complex to me.

Stefan

--haTDp70MznFQk8/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQIgyIACgkQnKSrs4Gr
c8jMYgf4qJGynFoNtjkyN7JSOeto4OA2d0BaCOrMpSMj4tBCwdHqfhSfGap+1Vd6
T3pcywgoIISDIyL04InjTihbtchShG5YUfcQc2xBYFsx2eDh+gI+8u43N4HsJnvb
c98rIF81Wjvkviv4rHIk5OYqOLdm5w8GmDZgg7ealB3VZEzmSnPWI3RFm/uBr+0t
KdYIOUsUJ1rUIQppZhsXkfZ9fM5vl4uOSduHXRvhHCdhf8eopt/8PdIuKSLCN7Fj
8+Oa3DlwlD6OU9GuEFtLT1jzoGssOCo3vyDvn0siNVXxMtIzdlubqJcEz8Cty4CO
0UA0CWOc6DilBB0l+H3LOK65kNiZ
=gcJp
-----END PGP SIGNATURE-----

--haTDp70MznFQk8/8--

