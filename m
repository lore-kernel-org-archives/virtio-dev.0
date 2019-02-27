Return-Path: virtio-comment-return-677-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 27 Feb 2019 17:06:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190227170612.GE927@stefanha-x1.localdomain>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <20190222115433.7160-4-dgilbert@redhat.com>
 <20190225165014.GE379@stefanha-x1.localdomain>
 <20190225184506.GF2710@work-vm>
 <20190227145652.22286c72.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <20190227145652.22286c72.cohuck@redhat.com>
Subject: Re: [virtio-comment] Re: [PATCH v2 3/3] shared memory: Define mmio
 registers
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 02:56:52PM +0100, Cornelia Huck wrote:
> On Mon, 25 Feb 2019 18:45:06 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>=20
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > On Fri, Feb 22, 2019 at 11:54:33AM +0000, Dr. David Alan Gilbert (git=
) wrote: =20
>=20
> > > > +    region, as defined by the device for the region selected by
> > > > +    the \field{SHMId} register.  Reading from a non-existent
> > > > +    region (i.e. where the ID written to \field{SHMId} is unused)
> > > > +    results in a length of -1. =20
> > >=20
> > > -1 is used to indicate the absence of a region, does 0 have a meaning=
? =20
> >=20
> > No, I'd be happy to switch; although this does lead to another question;
> > what happens on an older virtio-mmio implementation when a device
> > tries to read these registers to detect if the region exists?
>=20
> You probably mean that the driver is reading, right? Not sure if we
> ever specified what happens if a driver interacts with a register that
> was not specified when the device was written... maybe we need to bump
> the device version number? But that would break old drivers if they get
> a 3 but expected a 2.

I see the rationale for using 0xffffffff since that's what loads produce
when there is nothing at the memory address.  It would be good to
document that :).

Incrementing the version as Cornelia suggested is cleaner though, if
existing drivers handle that gracefully.  Or maybe a transport feature
bit (are they in short supply?).

Stefan

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdsOEAAoJEJykq7OBq3PICIUH/321i5JAz6QzKHfOZZmpcfBK
vbWF9/e91bUFWU28SGTo4qIQyNOux7SYnkDh6LP1hu1TPciEhqRzzh7nKSyC5FKy
lIZ8YBtIEEebnnhMbUeIKsr9DZdO/YoaVzeUAhD4xEronZbeeZ8r8ztDv7/7lkm4
9MuexWE2Hs4KnEiV5jWntE7tn6yurvgvri6vWmaJ89a/gDXKp6JU1bimE3mczIS1
r2Lmsbb8rAD4zbEM1xkHtqXRjJiwqp35qHHpt5KKu4NImWIc5RdFE43/QcBL5abG
77ZdIP5UjFWLSICehYI/3XBBg2nhN7mIOIvm92rYn0usVyIigQvh+DeErQYKhiY=
=Pvkf
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
