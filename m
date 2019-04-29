Return-Path: virtio-dev-return-5699-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FD45984358
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Apr 2019 13:03:02 +0000 (UTC)
Date: Mon, 29 Apr 2019 09:02:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190429130251.GD7587@stefanha-x1.localdomain>
References: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
 <1556032699-22135-4-git-send-email-ndragazis@arrikto.com>
 <20190424193655.GD31664@stefanha-x1.localdomain>
 <31204c59-a155-dc97-be49-0d47088499d3@arrikto.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <31204c59-a155-dc97-be49-0d47088499d3@arrikto.com>
Subject: Re: [virtio-dev] [PATCH 3/4] vhost-user: add requirements for the
 notification capability
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 05:14:15PM +0300, Nikos Dragazis wrote:
> On 24/4/19 10:36 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>=20
> > On Tue, Apr 23, 2019 at 06:18:18PM +0300, Nikos Dragazis wrote:
> >> The configuration structure for the notification capability has certain
> >> device/driver requirements, similar to those of the MSI-X vector
> >> configuration. Add these requirements to the device spec.
> >>
> >> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> >> ---
> >>  virtio-vhost-user.tex | 40 ++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>
> >> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> >> index 0bfc48d..605272f 100644
> >> --- a/virtio-vhost-user.tex
> >> +++ b/virtio-vhost-user.tex
> >> @@ -275,6 +275,46 @@ \subsubsection{Notification structure layout}\lab=
el{sec:Device Types / Vhost-use
> >>  \field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to c=
hange the
> >>  MSI-X vector for that notification.
> >> =20
> >> +\devicenormative{\paragraph}{Notification capability}{Device Types / =
Vhost-user Device Backend / Additional Device Resources over PCI / Notifica=
tion capability}
> >> +
> >> +If MSI-X is available, device MUST support mapping any master queue
> >> +event to any valid vector 0 to MSI-X \field{Table Size}. The valid
> > Do you mean Table Size - 1 since vector numbering is zero-based?
>=20
> According to the PCI Spec, the "Table Size", which is a portion of the
> Message Control Register of the MSI-X capability structure, is encoded
> as <n-1>, where <n> is the actual table size.=C2=A0 For example, a return=
ed
> value of 2047 indicates a table size of 2048, which in turn implies that
> this PCI function supports vectors 0-2047.=C2=A0 So, I think it is correc=
t.
>=20
> To be honest, I haven't read the actual spec, but this is my
> understanding based on the following sources:
>=20
> https://fpgawiki.intel.com/wiki/Implementing_MSI-X_for_PCI_Express_in_Alt=
era_FPGA_Devices#MSI-X_Capability_and_Table_Structures_Programming
>=20
> https://www.intel.com/content/www/us/en/programmable/documentation/lbl141=
5123763821.html#nik1410564944281

Thanks, I have confirmed this by checking the PCI Express specification.

It would be nice to clarify that you mean the n-1 encoded table size,
and not the actual table size here.

Stefan

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxvX7AAoJEJykq7OBq3PIMoMIAMnG5zw3c0EJgeNtz/jV3uBe
n0lSjZjfL701x59fSIaK4P27bjA/T+62n/tTZTtvjQwd1Hsoaak2M26BdtXyziAM
THY/MI3ifdsZHVo9lRdvAAjfvj724OX6PawCYxsm2nP+Quwj1SK3MXmKE2ytsYoy
9QTs5KqHAxnjsWhO4Sd5qZJlJrJ3cv9+5XrLppGDrQ+J5LqiHkY90zWyobPJrThW
Qs2sG1/8OG/yi1jDKfgCUoLxR7KE8/FdOLgHdOfmZF5CAdXOWcd5OLQEdfHxmZkM
7z3Sh6GNSvwzie6rCLg5X3ZCARAt/86P9XhBFwpDrifZCVUM8uJZBCV8MNnHnIY=
=VtRF
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
