Return-Path: virtio-dev-return-5975-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D673985D15
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Aug 2019 10:16:07 +0000 (UTC)
Date: Wed, 14 Aug 2019 11:16:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190814101601.GA21727@stefanha-x1.localdomain>
References: <20190813125133.19754-1-pagupta@redhat.com>
 <20190813152131.GC32090@stefanha-x1.localdomain>
 <742877012.8416916.1565764395758.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <742877012.8416916.1565764395758.JavaMail.zimbra@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: document console vq detach buffer
To: Pankaj Gupta <pagupta@redhat.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, amit@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 02:33:15AM -0400, Pankaj Gupta wrote:
> > On Tue, Aug 13, 2019 at 06:21:33PM +0530, Pankaj Gupta wrote:
> > > This patch documents console special case where vq buffers
> > > are deleted at port hotunplug time. This behavior is different in
> > > other devices where vq buffers are deleted at device unplug time.
> > >=20
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > ---
> > >  content.tex | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/content.tex b/content.tex
> > > index ee0d7c9..33e8ccc 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -497,6 +497,8 @@ \section{Device Cleanup}\label{sec:General
> > > Initialization And Device Operation /
> > >  of a live virtqueue.
> > > =20
> > >  Thus a driver MUST ensure a virtqueue isn't live (by device reset) b=
efore
> > >  removing exposed buffers.
> > > +Console has a special property that when port is detached virtqueue =
is
> > > considered stopped, device
> > > +must not use any buffers, and it is legal to take buffers out of the
> > > device.
> >=20
> > The word "detach" is not defined or used in the spec, so it's unclear
> > what this is supposed to mean.  Is this related to a control message
> > (VIRTIO_CONSOLE_PORT_OPEN)?
>=20
> By detach here we mean "unplug". =20

"unplug" also has no meaning defined in the spec.  Please explain things
in terms of the actual device interface (control messages, config space
fields, etc) so that the spec is clear.  Which event or operation are
you talking about?

> >=20
> > How about:
> >=20
> >   The device MUST NOT use buffers after it has sent
> >   VIRTIO_CONSOLE_PORT_OPEN with value=3D0 for a port.
> >=20
> > I'm not sure what you mean by "take buffers out of the device"?  I guess
> > you mean the driver can modify the vring because the device isn't
> > looking.
>=20
> "take buffers out of the device" means "remove the unused buffers from th=
e virt queue".

What does "remove the unused buffers from the virt queue" mean?
Decreasing the avail index (for split-ring virtqueue layouts) so that
previously available buffers are no longer available?

Stefan

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1T32EACgkQnKSrs4Gr
c8grFAgAmiSE+SFZLRICfB381/zPNHM7ekCCQsIRLBUCn9qlKNCyWY5mZ3CCjcu/
yTzqs4P8U36tuQcm5Wxq2/8R0suPPK1AaO9OuEOLk93eIE4ah/chujIVYzMnhE5J
8tXvtvlPfqUmz336ywpDZyBcWsqUJyi1Cv0caMK8cdJKa+zr0a7V88nQ6xRfdicN
SOjbh2k/D70f95AL7Jq5YQCNZQLefr9qvyGN6ZJ+0bd7uWHthBTt0bX+C3MFF67X
vrmZ/Vk536+vS2JcSVG91fbFiLTrg+jzuqiWqnVPIVT4aYt4jnSzcJU4rT+Q6hjB
NYFtlpGw2IeC7zL8XByG+yZLWe5ocA==
=6OKe
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
