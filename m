Return-Path: virtio-comment-return-703-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 8 Mar 2019 09:18:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190308091852.GA12318@stefanha-x1.localdomain>
References: <20190304132531.10507-1-dgilbert@redhat.com>
 <20190304132531.10507-2-dgilbert@redhat.com>
 <20190307162516.GH2843@stefanha-x1.localdomain>
 <20190307175347.GL2811@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20190307175347.GL2811@work-vm>
Subject: Re: [virtio-comment] [PATCH v3 1/3] shared memory: Define shared
 memory regions
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 05:53:48PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Mon, Mar 04, 2019 at 01:25:29PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > +\subsection{Addressing within regions}\label{sec:Basic Facilities of=
 a Virtio Device / Shared Memory Regions / Addressing within regions }
> > > +
> > > +Commands sent over the virtqueues may refer to data within the
> > > +shared memory regions, for example a command may be used by a
> > > +driver to cause a device to add or remove a mapping within
> > > +a region.  When referring to data, the addresses will normally be
> > > +offsets within a particular region rather than absolute host or
> > > +guest addresses.  The \field{shmid} may be explicit or may be
> > > +inferred from the command type.
> >=20
> > This sounds like normative statements.  They belong in a driver or
> > device normative section.
>=20
> I think we were trying in a previous version to make it one; but the
> problem is it's not really a statement about something a device or
> driver must do; it's a statement advising someone writing the spec
> for a particular device to make sure it's specified like that.

I see.  An idea for phrasing this in descriptive language:

  References into shared memory regions are represented as offsets from
  the beginning of the region instead of absolute memory addresses since
  absolute memory addresses are transport- and/or
  architecture-dependent.  Offsets are used both for references between
  structures stored within shared memory and for requests placed in
  virtqueues that refer to shared memory.

Feel free to discard this if you prefer the current wording.

Stefan

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgjN8AAoJEJykq7OBq3PImU0H+wZzw9bE+goJW83nsFcrJ/+U
WMGIqc+/0AEMg54NiaCW0le0Q4ulnl5D44BIPyBDTWGLPEo/5n7MZCH8MOsXs0sX
2EnKHQ8YxRVlg5tiNXhtsA+oyab3IPhAh/3TBXR3+Er4oF2M3FTpcRZB07HE1Or6
+M5M3HoqyI4c2UiqrkUnhor7sHm7hRHlGxMpczE4tMradEK1ovBEkChZhAuGYtro
PbjbsR8UElpFQ0/uIcyfmgybIuSuNOWrv1d0HqsgrTxBS74G1YVnVBrreujke43t
uj7A4citB2S2pqdifGjr9Qkcs4biCwTm+hs24AeVHoh/YjHQWG3So6IMGSxOagE=
=CUzu
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
