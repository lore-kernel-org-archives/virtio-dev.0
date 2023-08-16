Return-Path: <virtio-dev-return-13563-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAE8C04A6A
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 12:35:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7F6662B03C
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 12:35:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0789298672D
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 12:35:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 76BE79863EF; Wed, 16 Aug 2023 12:35:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 405709863EE
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Aug 2023 12:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JkHZ6z_POnK-tJmzMfsi3g-1
Date: Wed, 16 Aug 2023 08:33:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230816123347.GB3425284@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-4-lingshan.zhu@intel.com>
 <20230814150046.GF3146793@fedora>
 <9c6b11ce-33aa-ebff-62c4-cd316fab0689@intel.com>
 <20230815123340.GB3235352@fedora>
 <27d263a4-dcc8-6271-fef9-a080d59452e0@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r0miMEbHfHwS5ZtF"
Content-Disposition: inline
In-Reply-To: <27d263a4-dcc8-6271-fef9-a080d59452e0@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 3/5] virtio: The actions by the
 device upon SUSPEND

--r0miMEbHfHwS5ZtF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 12:25:39PM +0800, Zhu, Lingshan wrote:
>=20
>=20
> On 8/15/2023 8:33 PM, Stefan Hajnoczi wrote:
> > On Tue, Aug 15, 2023 at 07:07:42PM +0800, Zhu, Lingshan wrote:
> > >=20
> > > On 8/14/2023 11:00 PM, Stefan Hajnoczi wrote:
> > > > On Tue, Aug 15, 2023 at 03:29:02AM +0800, Zhu Lingshan wrote:
> > > > > This commit specifies the actions to be taken by the device upon
> > > > > SUSPEND.
> > > > >=20
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > Signed-off-by: Eugenio P=C3rez <eperezma@redhat.com>
> > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > ---
> > > > >    content.tex | 9 +++++++++
> > > > >    1 file changed, 9 insertions(+)
> > > > >=20
> > > > > diff --git a/content.tex b/content.tex
> > > > > index 074f43e..43bd5de 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -96,6 +96,15 @@ \section{\field{Device Status} Field}\label{se=
c:Basic Facilities of a Virtio Dev
> > > > >    If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the devi=
ce MUST clear SUSPEND
> > > > >    and resumes operation upon DRIVER_OK.
> > > > > +If VIRTIO_F_SUSPEND is negotiated, when SUSPEND is set, the devi=
ce MUST perform the following operations:
> > > > "when SUSPEND is set" is ambigious. It could mean when the driver w=
rites
> > > > the Device Status Field, when the device transitions to SUSPEND, or
> > > > something else. Maybe "before the device reports the SUSPEND bit se=
t in
> > > > the Device Status Field"?
> > > Nice catch! will fix: when the driver sets SUSPEND, before the device
> > > reports the
> > > SUSPEND bit set in the \field{device status}, the device MUST perform=
 the
> > > following actions.
> > > > > +\begin{itemize}
> > > > > +\item Stop comsuming any descriptors
> > > > "consuming"
> > > yes
> > > > It may be more consistent to talk about virtqueue buffers (i.e.
> > > > requests) rather than descriptors here.
> > > yes
> > > > > +\item Mark all finished descriptors as used and send used buffer=
 notification to the driver
> > > > The device has to complete everything that is in flight, just compl=
eting
> > > > "finished" stuff is not enough. Does "finished descriptors" really =
mean
> > > > "in-flight virtqueue buffers"?
> > > A patch of tracking in-flight descriptors is planned. Here I expect
> > > "finished" mean "done" buffers, transmitted and received ACK.
> > Yes, I don't mean tracking in-flight virtqueue buffers, I mean waiting
> > until they are marked as used. I think "finished" is unclear and the
> > text should explain that the device waits for in-flight virtqueue
> > buffers (in the future this could be relaxed with in-flight tracking
> > functionality).
> Sure, I can add this in the next version: the device MUST wait until all
> descriptors that being processed to finish and mark them as used

Sounds good.

> And we can replace it with tracking in-flight descriptors in the future
>=20
> Thanks
> >=20
> > > > "send a used buffer notification" or "send used buffer notification=
s"
> > > Yes will fix
> > > > > +\item Record Virtqueue State of each enabled virtqueue, see sect=
ion \ref{sec:Virtqueues / Virtqueue State}
> > > > Does "Record" mean that Virtqueue State fields can only be accessed=
 by
> > > > the driver while device is paused (they may be outdated or invalid =
while
> > > > the device is unpaused)?
> > > Yes, to avoid race with the device and make device implementation eas=
ier,
> > > this is also mentioned in Patch 4.
> > > > > +\item Pause its operation and preserve all configurations in its=
 Device Configuration Space, see \ref{sec:Basic Facilities of a Virtio Devi=
ce / Device Configuration Space}
> > > > What does "preserve" mean? Does it mean the Device Configuration Sp=
ace
> > > > is not allowed to change during SUSPEND?
> > > Yes, once the device presents SUSPEND in its device status, it should=
 not
> > > change any
> > > fields in its Device Configuration Space.
> > >=20
> > > Thanks for your review
> > > > > +\item Present SUSPEND in \field{device status}
> > > > > +\end{itemize}
> > > > > +
> > > > >    \section{Feature Bits}\label{sec:Basic Facilities of a Virtio =
Device / Feature Bits}
> > > > >    Each virtio device offers all the features it understands.  Du=
ring
> > > > > --=20
> > > > > 2.35.3
> > > > >=20
> > > > >=20
> > > > > This publicly archived list offers a means to provide input to the
> > > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > > >=20
> > > > > In order to verify user consent to the Feedback License terms and
> > > > > to minimize spam in the list archive, subscription is required
> > > > > before posting.
> > > > >=20
> > > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > > List archive: https://lists.oasis-open.org/archives/virtio-commen=
t/
> > > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_lic=
ense.pdf
> > > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/m=
ailing-lists
> > > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > > Join OASIS: https://www.oasis-open.org/join/
> > > > >=20
> > >=20
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > >=20
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > >=20
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license=
=2Epdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/maili=
ng-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> > >=20
>=20
>=20
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>=20
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>=20
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>=20

--r0miMEbHfHwS5ZtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTcwisACgkQnKSrs4Gr
c8gSJwf/SO5XeMgvUyrVbV7nnsj61Icl10jUTIGgQn9bygGId5JmvJJm8AnH8EhP
xnefJfZpl0YXsAQvGER6dgXZzvMbBgwr8V26ynkXuaJATVihWGXBGmgH48dv709B
Mk+QUbEJuWSHmFjYwJ9omOJny0oJFsxBigIyQRRC8SX2db1i5U70Kk5ojpQSB3XI
Lv3yJkwvOniaLYub65sf/CI3TEV/znhWPdF1d901nf0HLCOPN9ZsxnQq+f1lwOEC
qJN/Bbr0wbZS3qds1fJCLQ1FSvk5G+EWwwFl5e27hK+qu0qRFjvazeyYjxWPQTjz
DnkWQSaYQaKn2+LHsIcHSgQj+7gPtQ==
=oNaK
-----END PGP SIGNATURE-----

--r0miMEbHfHwS5ZtF--

