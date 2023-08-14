Return-Path: <virtio-dev-return-13524-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC5DC04FE0
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:29:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A30B733592
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B48A986423
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8FA4598633D; Mon, 14 Aug 2023 16:28:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78E2A986630
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Aug 2023 16:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tSKnGWpFPLaO8w4mQhnh3g-1
Date: Mon, 14 Aug 2023 11:00:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230814150046.GF3146793@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="koi+zE3223jqgSlz"
Content-Disposition: inline
In-Reply-To: <20230814192904.30062-4-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 3/5] virtio: The actions by the
 device upon SUSPEND

--koi+zE3223jqgSlz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 03:29:02AM +0800, Zhu Lingshan wrote:
> This commit specifies the actions to be taken by the device upon
> SUSPEND.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3rez <eperezma@redhat.com>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  content.tex | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index 074f43e..43bd5de 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -96,6 +96,15 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST cl=
ear SUSPEND
>  and resumes operation upon DRIVER_OK.
> =20
> +If VIRTIO_F_SUSPEND is negotiated, when SUSPEND is set, the device MUST =
perform the following operations:

"when SUSPEND is set" is ambigious. It could mean when the driver writes
the Device Status Field, when the device transitions to SUSPEND, or
something else. Maybe "before the device reports the SUSPEND bit set in
the Device Status Field"?

> +\begin{itemize}
> +\item Stop comsuming any descriptors

"consuming"

It may be more consistent to talk about virtqueue buffers (i.e.
requests) rather than descriptors here.

> +\item Mark all finished descriptors as used and send used buffer notific=
ation to the driver

The device has to complete everything that is in flight, just completing
"finished" stuff is not enough. Does "finished descriptors" really mean
"in-flight virtqueue buffers"?

"send a used buffer notification" or "send used buffer notifications"

> +\item Record Virtqueue State of each enabled virtqueue, see section \ref=
{sec:Virtqueues / Virtqueue State}

Does "Record" mean that Virtqueue State fields can only be accessed by
the driver while device is paused (they may be outdated or invalid while
the device is unpaused)?

> +\item Pause its operation and preserve all configurations in its Device =
Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / Dev=
ice Configuration Space}

What does "preserve" mean? Does it mean the Device Configuration Space
is not allowed to change during SUSPEND?

> +\item Present SUSPEND in \field{device status}
> +\end{itemize}
> +
>  \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / F=
eature Bits}
> =20
>  Each virtio device offers all the features it understands.  During
> --=20
> 2.35.3
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

--koi+zE3223jqgSlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTaQZ4ACgkQnKSrs4Gr
c8iNlQgAtKgvJ0BfZiouuXm5cBHz9G0wvvn3Uk91o9hHBfbssehJGK1qnDEjqcB0
bjoZ8+HbPVu/DeF9b0iUkUleMIrKSaJiWfb+LC+phhoNBf+Vi6zDvefj9U4xk1a4
stiMx1MV7kXvIy+QycOyaoaVN4uU4A98RX94H64+34dplJWIDS0d4g8wSh3TIVZc
PqwcVXdZQXY8yfVfzdg8Ij1uuAd6BSzesTZzqm8V0iHJdfS1LHWQ2hhWLKOOG3iS
sLiecnjpGeFfgDYxovlFxBaCiBKiqY4KRyfuT8We9NxIDh7uK2YTAxmOhqMOT+GG
qhX/92dQIGISQT620akqy6/brN7oZA==
=VXop
-----END PGP SIGNATURE-----

--koi+zE3223jqgSlz--

