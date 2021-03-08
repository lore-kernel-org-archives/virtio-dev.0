Return-Path: virtio-dev-return-8105-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E798A9863D7
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 Mar 2021 14:48:41 +0000 (UTC)
Date: Mon, 8 Mar 2021 14:48:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YEY5P9TsLo838aU2@stefanha-x1.localdomain>
References: <CAPR809tCFMcSz7zh4P9Xq55sMfJu7NXM6fpZvtdND523ZivoAA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPR809tCFMcSz7zh4P9Xq55sMfJu7NXM6fpZvtdND523ZivoAA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] Add lifetime metrics to virtio-blk
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EHmyKR49yhC8WXWW"
Content-Disposition: inline
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--EHmyKR49yhC8WXWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 05, 2021 at 10:27:43AM -0700, Enrico Granata wrote:
> @@ -4754,6 +4779,12 @@ \subsection{Device Operation}\label{sec:Device
> Types / Block Device / Device Ope
>  (case~\ref{item:flush3}).  Failure to do so can cause data loss
>  in case of a crash.
>=20
> +If the device is backed by storage providing lifetime metrics (such as e=
MMC
> +or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIF=
ETIME
> +flag. The flag MUST NOT be offered if the device is backed by storage fo=
r which
> +the lifetime metrics described in this document cannot be obtained or fo=
r which
> +such metrics have no useful meaning.
> +
>  If the driver changes \field{writeback} between the submission of the wr=
ite
>  and its completion, the write could be either volatile or stable when
>  its completion is reported; in other words, the exact behavior is undefi=
ned.

This should probably go at the end of this device normative section
instead of splitting the clauses about write persistence.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EHmyKR49yhC8WXWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBGOT8ACgkQnKSrs4Gr
c8i4Vgf/Qx+4PsK4HWUGGqLvj80rlOCzLCKid1aip3oV271+8zT9m+AxHwrKgwsQ
6qCYtOqQoSfwLIDqINFGNscIXynf1pWkb/+B7ufgVCyG1q5Ps6AxCGNGWoyuPV6X
kuyGqA8W7Ef4DauSEGmsIEQ6daMY+NgIEJU3qQfMZHQDlssdRSYuDfcYZ+sc/PbS
vsnRc5M5wa/B+pI14IoN66EJRTLibR2zvNHrAPvM1DbPg5tbtO3p7SyAHymvjmz7
rX757jMt7wi2RKem5YIP1xqJdSVrrirS0jTTtHpqcWuk6tsi+57kbzy/ozD3nqCe
bd9NXglK5PP37HzsgSepRCdeYMLGHA==
=x3K3
-----END PGP SIGNATURE-----

--EHmyKR49yhC8WXWW--

