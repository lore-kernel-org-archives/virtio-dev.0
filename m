Return-Path: <virtio-dev-return-11479-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023BFC6FD1A
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 14:39:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E1306120D7E
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 14:39:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE4409866CD
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 14:39:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C03A39866C2; Tue,  7 Mar 2023 14:39:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFC949866C3
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Mar 2023 14:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: pMpKFNS1M9mZB9E5h1YmXg-1
Date: Tue, 7 Mar 2023 09:39:11 -0500
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
Message-ID: <20230307143911.GC124259@fedora>
References: <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Aiee27cFPDp7DTHO"
Content-Disposition: inline
In-Reply-To: <ZAbvxj+7lgaI1HkI@nanopsycho>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

--Aiee27cFPDp7DTHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 09:03:18AM +0100, Jiri Pirko wrote:
> Mon, Mar 06, 2023 at 07:37:31PM CET, mst@redhat.com wrote:
> >On Mon, Mar 06, 2023 at 06:03:40AM -0500, Stefan Hajnoczi wrote:
> >> On Sun, Mar 05, 2023 at 07:18:24PM -0500, Michael S. Tsirkin wrote:
> >> > On Sun, Mar 05, 2023 at 07:03:02PM -0500, Stefan Hajnoczi wrote:
> >> > > On Sun, Mar 05, 2023 at 04:38:59AM -0500, Michael S. Tsirkin wrote:
> >> > > > On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
> >> > > > > What happens if a command takes 1 second to complete, is the d=
evice
> >> > > > > allowed to process the next command from the virtqueue during =
this time,
> >> > > > > possibly completing it before the first command?
> >> > > > >=20
> >> > > > > This requires additional clarification in the spec because "th=
ey are
> >> > > > > processed by the device in the order in which they are queued"=
 does not
> >> > > > > explain whether commands block the virtqueue (in order complet=
ion) or
> >> > > > > not (out of order completion).
> >> > > >=20
> >> > > > Oh I begin to see. Hmm how does e.g. virtio scsi handle this?
> >> > >=20
> >> > > virtio-scsi, virtio-blk, and NVMe requests may complete out of ord=
er.
> >> > > Several may be processed by the device at the same time.
> >> >=20
> >> > Let's say I submit a write followed by read - is read
> >> > guaranteed to return an up to date info?
> >>=20
> >> In general, no. The driver must wait for the write completion before
> >> submitting the read if it wants consistency.
> >>=20
> >> Stefan
> >
> >I see.  I think it's a good design to follow then.
>=20
> Hmm, is it suitable to have this approach for configuration interface?
> Storage device is a different beast, having parallel reads and writes
> makes complete sense for performance.
>=20
> ->read a req
> ->read b req
> ->read c req
> <-read a rep
> <-read b rep
> <-read c rep
>=20
> There is no dependency, even between writes.
>=20
> But in case of configuration, does not make any sense to me.
> Why is it needed? To pass the burden of consistency of
> configuration to driver sounds odd at least.
>=20
> I sense there is no concete idea about what the "admin virtqueue" should
> serve for exactly.

It's useful for long-running commands because they prevent other
commands from executing.

An example I've given is that deleting a group member might require
waiting for the group member's I/O activity to finish. If that I/O
activity cannot be cancelled instantaneously, then it could take an
unbounded amount of time to delete the group member. The device would be
unable to process futher admin commands.

Group member creation might have similar issues if it involves acquiring
remote resources (e.g. connecting to a Ceph cluster or allocating ports
on a distributed network switch). It can be impossible to defer resource
acquisition/initialization because because VIRTIO devices must be
available as soon as the driver can see them (i.e. how do populate
Configuration Space fields if you don't have the details of the resource
yet?).

So I have raised two questions:

1. What are the admin queue command completion semantics: in-order or
   out-of-order command completion?

2. Will there be long-running commands and how will we deal with them
   when they hang?

Stefan

--Aiee27cFPDp7DTHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQHTI8ACgkQnKSrs4Gr
c8hLgwgAnoWvGC1l33udXiUQKic5QU5eFRwMb2vYH5fJUgQ5OZLwseLjHtzZaY93
/dAs6yD2oXX8fhIb3SMMUeREzLkALvung1nuCRxiISkYg3PH6RoFS19OwNvBWqnm
Nrztb0C1ZIPDwjW5MuSQjqF4Lp6uKChUsmsPbwZ69gtiGFWjylqBH/bpKp7zIB8X
Ds5SF2i5/Ez7ExVvdq8jWkSq43mp58AlSgnhJk6oFDP2e6ILpt9FrkiN+x0zXR7P
e+1tV6rwOSQejHlCEGMGUNlianKWkIekHpMfsaB4S/QTvoTyxlRLtPA41xrA3UlL
WqMFsUaWXZ2VlarPF2qRu42E5C7jfw==
=s/rb
-----END PGP SIGNATURE-----

--Aiee27cFPDp7DTHO--

