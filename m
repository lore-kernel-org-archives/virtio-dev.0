Return-Path: virtio-dev-return-7612-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77D0C985DD7
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Jul 2020 06:16:16 +0000 (UTC)
Date: Thu, 23 Jul 2020 07:16:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200723061605.GB268427@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-4-ndragazis@arrikto.com>
 <20200717093457.GD128195@stefanha-x1.localdomain>
 <2561d1a2-e57d-cab5-0fe5-7394bb6032ce@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <2561d1a2-e57d-cab5-0fe5-7394bb6032ce@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 03/10] vhost-user: add requirements for
 the notification capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 07:02:18PM +0300, Nikos Dragazis wrote:
> On 17/7/20 12:34 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>=20
> > On Mon, May 18, 2020 at 11:37:14PM +0300, Nikos Dragazis wrote:
> > > The configuration structure for the notification capability has certa=
in
> > > device/driver requirements, similar to those of the MSI-X vector
> > > configuration. Add these requirements to the device spec.
> > >=20
> > > Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> > > ---
> > >   virtio-vhost-user.tex | 42 ++++++++++++++++++++++++++++++++++++++++=
++
> > >   1 file changed, 42 insertions(+)
> > >=20
> > > diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> > > index 13ecd41..7a8cd9c 100644
> > > --- a/virtio-vhost-user.tex
> > > +++ b/virtio-vhost-user.tex
> > > @@ -275,6 +275,48 @@ \subsubsection{Notification structure layout}\la=
bel{sec:Device Types / Vhost-use
> > >   \field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to=
 change the
> > >   MSI-X vector for that notification.
> > > +\devicenormative{\paragraph}{Notification capability}{Device Types /=
 Vhost-user Device Backend / Additional Device Resources over PCI / Notific=
ation capability}
> > > +
> > > +If MSI-X is available, device MUST support mapping any master queue
> > > +event to any valid vector 0 to MSI-X \field{Table Size}. Here
> > This section combines two things:
> > 1. vhost-user concepts -> VIRTIO notifications
> > 2. VIRTIO notifications -> VIRTIO PCI transport MSI-X implementation of
> >     notifications
> >=20
> > I think this should be split:
> > 1. The virtio-vhost-user device spec should explain that vhost-user que=
ue
> >     events are mapped to VIRTIO notifications
> > 2. The PCI transport spec should explain how notifications are mapped t=
o
> >     MSI-X
> >=20
> > This way other VIRTIO device types will be able to use notifications to=
o
> > without everyone explaining MSI-X specifics. Also it won't tie
> > virtio-vhost-user to VIRTIO PCI.
>=20
> If I understand correctly, you are suggesting that we should standardize
> the notification resource, similarly to the shared memory resource, so
> that any device can use it. Is that so?

Yes. Notifications and doorbells should become part of the core VIRTIO
device model. That way other devices can use them too.

Stefan

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZKyUACgkQnKSrs4Gr
c8gW/AgAjkr34fxZSlTMURDbR1cid4+40pnyWod7NH5C0pPXhuIUVKia7m5Gy151
fafwrwjfOTwDQICDRKIFM/VlynptKc6c5t3GCATe1/Yb5a07osFrc7gu7j9vYCWH
MuGanK5gACDkBfmrbeiczIjXs884ETpW7SRA6BOLyRMZjjiExFWmqESKg1gPiUmj
1WIbtjluJEziRG/9rkcy820EqbD6Kt1TCwHvEsD6MPfsUB2XNVng9hK1mZnQy5+X
5WxCFfRAM6Qm26kjRUIloZ1LbhAp75HnsTi7TE+FqC9M2JYsQ4k0I3dR9EX/peiE
LkWOZtb1COXTpGe51tO/YiZcCXsT4A==
=n3DT
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

