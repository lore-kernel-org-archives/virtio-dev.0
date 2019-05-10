Return-Path: virtio-dev-return-5725-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80878985DFA
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 May 2019 10:37:48 +0000 (UTC)
Date: Fri, 10 May 2019 11:37:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190510103744.GE22311@stefanha-x1.localdomain>
References: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
 <1556032699-22135-4-git-send-email-ndragazis@arrikto.com>
 <20190424193655.GD31664@stefanha-x1.localdomain>
 <31204c59-a155-dc97-be49-0d47088499d3@arrikto.com>
 <20190429130251.GD7587@stefanha-x1.localdomain>
 <fda06c05-28ae-e9ad-78f9-875ed40f5348@arrikto.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <fda06c05-28ae-e9ad-78f9-875ed40f5348@arrikto.com>
Subject: Re: [virtio-dev] [PATCH 3/4] vhost-user: add requirements for the
 notification capability
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 06:05:13PM +0300, Nikos Dragazis wrote:
> On 29/4/19 4:02 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>=20
> > On Fri, Apr 26, 2019 at 05:14:15PM +0300, Nikos Dragazis wrote:
> >> On 24/4/19 10:36 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
> >>
> >>> On Tue, Apr 23, 2019 at 06:18:18PM +0300, Nikos Dragazis wrote:
> >>>> The configuration structure for the notification capability has cert=
ain
> >>>> device/driver requirements, similar to those of the MSI-X vector
> >>>> configuration. Add these requirements to the device spec.
> >>>>
> >>>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> >>>> ---
> >>>>  virtio-vhost-user.tex | 40 ++++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 40 insertions(+)
> >>>>
> >>>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> >>>> index 0bfc48d..605272f 100644
> >>>> --- a/virtio-vhost-user.tex
> >>>> +++ b/virtio-vhost-user.tex
> >>>> @@ -275,6 +275,46 @@ \subsubsection{Notification structure layout}\l=
abel{sec:Device Types / Vhost-use
> >>>>  \field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to=
 change the
> >>>>  MSI-X vector for that notification.
> >>>> =20
> >>>> +\devicenormative{\paragraph}{Notification capability}{Device Types =
/ Vhost-user Device Backend / Additional Device Resources over PCI / Notifi=
cation capability}
> >>>> +
> >>>> +If MSI-X is available, device MUST support mapping any master queue
> >>>> +event to any valid vector 0 to MSI-X \field{Table Size}. The valid
> >>> Do you mean Table Size - 1 since vector numbering is zero-based?
> >> According to the PCI Spec, the "Table Size", which is a portion of the
> >> Message Control Register of the MSI-X capability structure, is encoded
> >> as <n-1>, where <n> is the actual table size.=C2=A0 For example, a ret=
urned
> >> value of 2047 indicates a table size of 2048, which in turn implies th=
at
> >> this PCI function supports vectors 0-2047.=C2=A0 So, I think it is cor=
rect.
> >>
> >> To be honest, I haven't read the actual spec, but this is my
> >> understanding based on the following sources:
> >>
> >> https://fpgawiki.intel.com/wiki/Implementing_MSI-X_for_PCI_Express_in_=
Altera_FPGA_Devices#MSI-X_Capability_and_Table_Structures_Programming
> >>
> >> https://www.intel.com/content/www/us/en/programmable/documentation/lbl=
1415123763821.html#nik1410564944281
> > Thanks, I have confirmed this by checking the PCI Express specification.
> >
> > It would be nice to clarify that you mean the n-1 encoded table size,
> > and not the actual table size here.
> >
> > Stefan
>=20
>=20
> Yes, you are right, it should be clear. How about this:
>=20
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index 323ad5d..d1305dd 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -278,9 +278,11 @@ \subsubsection{Notification structure layout}\label{=
sec:Device Types / Vhost-use
> =C2=A0\devicenormative{\paragraph}{Notification capability}{Device Types =
/ Vhost-user Device Backend / Additional Device Resources over PCI / Notifi=
cation capability}
> =C2=A0
> =C2=A0If MSI-X is available, device MUST support mapping any master queue
> -event to any valid vector 0 to MSI-X \field{Table Size}. The valid
> -vectors are reported in \field{Table Size} in the MSI-X Capability as
> -specified in \hyperref[intro:PCI]{[PCI]}.
> +event to any valid vector 0 to MSI-X \field{Table Size}. Here
> +\field{Table Size} is the \field{N-1} encoded Table Size stored in the
> +Message Control register of the MSI-X capability structure according to
> +\hyperref[intro:PCI]{[PCI]}, where \field{N} is the actual MSI-X Table
> +Size.

Nice!

Stefan

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzVVHgACgkQnKSrs4Gr
c8iZMAf+J3R1dp29I/DLO4GMQdVvtxZ1WChwS+8kbT37ppJTjARGgi5s+Fjx4rDI
8LgfLCFErhSS3ccXd0aLznBIWccowS57ETOgevnJ3lvZ+XTOauy0oHDyAkynqIaU
pZtQW7N/3UoDsqfjMlcdFfLAqfZmIak+BlgYICZ8ay6U76o8ZwldXK7ufm8Z9eA8
r3Qy9nXS9JJv1E9gwqVjVl6reaUuIJZg011eWjV9xkxOqlH4+QrzqnHv6Xh6OCtS
3YYgtthUlJhuzLCsDiMvyVocxlJ+63RtsIcvA/XPSQknsF4DoaUAH7BAmhF/YLqY
h3gaxZXysLXjsu0V0Wo94ZfKItLfpQ==
=LCf4
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
