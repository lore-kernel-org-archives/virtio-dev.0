Return-Path: virtio-return-3105-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 15 May 2018 10:09:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515090906.GA14755@stefanha-x1.localdomain>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-2-git-send-email-pasic@linux.ibm.com>
 <20180514163659.GR5182@stefanha-x1.localdomain>
 <bfecd798-33bd-a08b-59af-27af699e32ed@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <bfecd798-33bd-a08b-59af-27af699e32ed@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH 1/6] notifications: unify notifications
 wording in core
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 09:40:43PM +0200, Halil Pasic wrote:
> On 05/14/2018 06:36 PM, Stefan Hajnoczi wrote:
> > On Thu, Apr 26, 2018 at 12:59:57PM +0200, Halil Pasic wrote:
> > > @@ -235,12 +236,13 @@ transmit and one for receive.}.
> > >   Driver makes requests available to device by adding
> > >   an available buffer to the queue - i.e. adding a buffer
> > >   describing the request to a virtqueue, and optionally triggering
> > > -a driver event - i.e. sending a notification to the device.
> > > +a driver event - i.e. sending an available buffer notification
> > > +to the device.
> > >   Device executes the requests and - when complete - adds
> > >   a used buffer to the queue - i.e. lets the driver
> > >   know by marking the buffer as used. Device can then trigger
> > > -a device event - i.e. send an interrupt to the driver.
> > > +a device event - i.e. send an used buffer notification to the driver.
> >=20
> > I would say "a used buffer notification".  "A" vs "an" depends on the
> > sound of the initial syllable, not the spelling.  So "a used car" vs "an
> > upper body".
> >=20
> > There are several instances of this in this patch.
> >=20
>=20
> Right. Will try to hunt all of them down.

I noticed other patches with hunks like this:

 ... an
-interrupt ...
+used buffer notification ...

So there are cases that are harder to find due to line-wrapping.  It
should be easy to find them with a Ctrl+F "an used" search in the HTML
version of the document though, or with a multi-line regular expression.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+qOyAAoJEJykq7OBq3PIILEIAMm6/p70KT59+sRASa5PAT44
L/XO6a9fZ7wCFzzSIrWvPsePytw4UEiJFtfK4BkOoYeCbQkMrjBKjvJxDQHpeaXe
n5T2QjWGXdFkEQj4xeIJha58CqDOfYjfmWlWjssHAQxmvhBDaWkLtTzvyofBsPlS
KysT97sMyeyeVSLySVLZVX5sABNdLLC8xkIRtCk7vWmuS+Wgae/eo48ucpZxinxd
OVHyCkSJvw6SXPdZENEeMuH/RXue3vJD32B5P7jpUXH6us9GKQSE4Apg2wgSHtRD
WcwB6goDnvUXg31TSaX/yUMYqnr/xejRqi2qjdD+IkMHtoVqwHFg71/X1hQWXPg=
=aYQM
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
