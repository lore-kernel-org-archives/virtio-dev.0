Return-Path: <virtio-dev-return-13521-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626E4C001DB
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3D3AA79535
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36BA798633D
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2A08C983F78; Mon, 14 Aug 2023 16:28:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19AB398634B
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Aug 2023 16:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: t3cvurP9N86GGuVg1wmi9g-1
Date: Mon, 14 Aug 2023 10:30:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230814143039.GD3146793@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8YxAithoFgASzzfJ"
Content-Disposition: inline
In-Reply-To: <20230814192904.30062-2-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 1/5] virtio: introduce SUSPEND bit
 in device status

--8YxAithoFgASzzfJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 03:29:00AM +0800, Zhu Lingshan wrote:
> This patch introudces a new status bit in the device status: SUSPEND.
>=20
> This SUSPEND bit can be used by the driver to suspend a device,
> in order to stablize the device states and virtqueue states.
>=20
> Its main use case is live migration.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3rez <eperezma@redhat.com>

There is an character encoding issue in Eugenio's surname.

> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  content.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

This patch hints at the asynchronous nature of the SUSPEND bit (the
driver must re-read the Device Status Field) but doesn't explain the
rationale or any limits.

For example, is there a timeout or should the driver re-read the Device
Status Field forever?

Does the driver need to re-read the Device Status Field after clearing
the SUSPEND bit?

>=20
> diff --git a/content.tex b/content.tex
> index 0a62dce..1bb4401 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic F=
acilities of a Virtio Dev
>  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>    drive the device.
> =20
> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that =
the
> +  device has been suspended by the driver.
> +
>  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>    an error from which it can't recover.
>  \end{description}
> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
> =20
> +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
> +
> +When set SUSPEND, the driver MUST re-read \field{device status} to ensur=
e the SUSPEND bit is set.

"When setting SUSPEND, ..." would be grammatically correct. Another
option is "After setting the SUSPEND bit, ...".

> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a=
 Virtio Device / Device Status Field}
> =20
>  The device MUST NOT consume buffers or send any used buffer
> @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS=
_RESET, the device
>  MUST send a device configuration change notification to the driver.
> =20
> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> +
> +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
> +
> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST cl=
ear SUSPEND
> +and resumes operation upon DRIVER_OK.

I can't parse this sentence. If the driver writes SUSPEND | DRIVER_OK |
=2E.. to the Device Status Field, then the device accepts DRIVER_OK and
clears SUSPEND?

Why?

> +
>  \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / F=
eature Bits}
> =20
>  Each virtio device offers all the features it understands.  During
> @@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
>  	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits=
} for
>  	handling features reserved for future use.
> =20
> +  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver can
> +   SUSPEND the device.
> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Fiel=
d}.
> +
>  \end{description}
> =20
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
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

--8YxAithoFgASzzfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTaOo8ACgkQnKSrs4Gr
c8iEWAgAlOg0ZC8OV46Uuzg1SUrcipn5OJFgKJNx3+DM0Jk9P5TD5Dg89P3O+gko
5O5MXYfo2r+MZVoRBqqPr0DtvRE0tKaHzKbMcfpN87VkSSEFpN/NRynI/NMgJo8T
vhRW72CLW+puYv3gpffUHb8avP4s8gbX6+wAFeXNp9ngqsckExY3er81XPExc7xF
TBMKoJYzI7SxlVqURw9A+xjc+p7JpW+y/OcjpHcbL3O8zWuvCD6XJXYWTi1R4lsD
+m4MJZiqimMh94cpdsc1DyLtLXDzPqbSmNYH9Txu7KvH675TeTuS8cJzdTz/1p9p
1oeyVWb+yAlJFYXCW6j6mNnKdqMZTg==
=3diE
-----END PGP SIGNATURE-----

--8YxAithoFgASzzfJ--

