Return-Path: virtio-comment-return-650-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 25 Feb 2019 16:37:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190225163717.GD379@stefanha-x1.localdomain>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <20190222115433.7160-2-dgilbert@redhat.com>
 <20190222134839.7e0ef3e7.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <20190222134839.7e0ef3e7.cohuck@redhat.com>
Subject: [virtio-comment] Re: [PATCH v2 1/3] shared memory: Define shared memory regions
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 01:48:39PM +0100, Cornelia Huck wrote:
> On Fri, 22 Feb 2019 11:54:31 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
>=20
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Define the requirements and idea behind shared memory regions.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  content.tex    |  2 ++
> >  shared-mem.tex | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 shared-mem.tex
> >=20
> > diff --git a/content.tex b/content.tex
> > index 836ee52..3dd504c 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -371,6 +371,8 @@ making any more buffers available. When VIRTIO_F_NO=
TIFICATION_DATA
> >  has been negotiated, these notifications would then have
> >  identical \field{next_off} and \field{next_wrap} values.
> > =20
> > +\input{shared-mem.tex}
> > +
> >  \chapter{General Initialization And Device Operation}\label{sec:Genera=
l Initialization And Device Operation}
> > =20
> >  We start with an overview of device initialization, then expand on the
> > diff --git a/shared-mem.tex b/shared-mem.tex
> > new file mode 100644
> > index 0000000..85b0c55
> > --- /dev/null
> > +++ b/shared-mem.tex
> > @@ -0,0 +1,33 @@
> > +\section{Shared Memory Regions}\label{sec:Basic Facilities of a Virtio=
 Device / Shared Memory Regions}
> > +
> > +Shared memory regions are an additional facility
> > +available to devices that need a region of memory that's
> > +continuously shared between the host and the guest, rather
> > +than passed between them in the way virtqueue elements are.
> > +
> > +Example uses include shared caches and version pools for versioned
> > +data structures.
> > +
> > +The region is chosen by the host and presented to the guest, as
> > +such it is useful in situations where the memory is accessed on
> > +the host by other libraries that can't safely access guest RAM.
>=20
> This explanation looks good to me.
>=20
> > +
> > +Shared memory regions MUST NOT be used to control the operation
> > +of the device, nor to stream data; those should still be performed
> > +using virtqueues.
>=20
> The 'MUST NOT' makes it look like a normative statement; however, this
> is more like design advice?

It also reads strangely because "MUST NOT" is used but then the next
clause uses "should".

Regarding normative statements, in the VIRTIO spec they are made in
separate device or driver normative sections.  I'm not sure if using
them in a non-normative section is okay.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdBm9AAoJEJykq7OBq3PIPygH/0yC3hNHoGlvq8PVZnI4Lkna
Bo3IaxgY2juFDbk0LE5fJYKkB//RQnXYgF61TfqRyziq0vJC6/vcczreop26/eHC
P5sQ4x+l52KXCa2Ilj3ZLeMnfljWiO2/qvwi70ky0vv+ww6oNUqoluZq73qRshTw
7OinQXUXLNQf56ociObLu6reUCF/tGbThSWAThs3y634kGwrfbNev4qKOMLWJXdH
zYDlUsXaPyjNQ+dVqnhSMOv9RtEs6+q2lHzfynBAYEm/UfL7YA7w79ucAgjBXPL1
bGgCthcnVYIEWEk1JC4LQQbf1FiPknbLI4SqSOg2mZJ613XQ7zlP5qEriaagYmE=
=obzz
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
