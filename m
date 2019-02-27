Return-Path: virtio-dev-return-5540-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36436985DD0
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Feb 2019 16:19:22 +0000 (UTC)
Date: Wed, 27 Feb 2019 16:19:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190227161918.GI22539@stefanha-x1.localdomain>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-2-stefanha@redhat.com>
 <20190225161148.GD2710@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Content-Disposition: inline
In-Reply-To: <20190225161148.GD2710@work-vm>
Subject: [virtio-dev] Re: [PATCH v3 1/2] content: add virtio file system device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 04:11:49PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > The virtio file system device transports Linux FUSE requests between a
> > FUSE daemon running on the host and the FUSE driver inside the guest.
> >=20
> > The actual FUSE request definitions are not duplicated in the virtio
> > specification, similar to how virtio-scsi does not document SCSI
> > command details.  FUSE request definitions are available here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/fuse.h
> >=20
> > This patch documents the core virtio file system device, which is
> > functional but lacks the DAX feature introduced in the next patch.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  content.tex      |   3 +
> >  introduction.tex |   3 +
> >  virtio-fs.tex    | 196 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 202 insertions(+)
> >  create mode 100644 virtio-fs.tex
> >=20
> > diff --git a/content.tex b/content.tex
> > index 836ee52..ac41fdb 100644
>=20
> > +The FUSE protocol documented in \hyperref[intro:FUSE]{FUSE} specifies =
the set
> > +of request types and their contents.  All request fields are little-en=
dian.
>=20
> FUSE doesn't seem to define it's endianness - and I'm not sure it's
> worth it for us to define it and do the work of adding a byteswapping
> shim.  It would be reasonably invasive in the kernel code to do that
> if we're the only user, and really I think the chances of having a
> cross-endian user are pretty slim; so adding invasive code for a
> non-existent user seems a bad thing.
> IMHO we should just stick with the existing FUSE definition; I believe
> it's possible to detect a byteswapped interface by validating the
> 'opcode' field of the fuse_in_header; existing daemons should just error
> on this; in the unlikely event that someone discovers they really want
> a cross endian implementation then they can add that byteswapping in
> their daemon.
>=20
> We should still keep the virtio level little endian of course.

Sounds good to me but I will double-check the FUSE protocol to make sure
using the opcode field as a byte order mark will work.

Thanks, will fix in v4.

Stefan

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdriGAAoJEJykq7OBq3PIp6oH/2njpjnEPtioej1W8MPoOI9t
YCTMl/9D15D2rNTuHBrufiOAozHx0c6YCTvHYc1fxd5YqFXpfjHIeR2N/hrf9I6l
PGrH4qd8obYUvOScZJhuO96q61m3MO/qHFh8rD7x9RVLYB8bJf7T8rpDyThUZ51j
FR0Gux/GNy9byVaqZt8R2mmS2jryPQhrHnqxXv5c59YexaNq3radvrRmfsyyMJ7K
ZzswS0XFAvg2IWaUcrAufIQ/R4I2M49UTKoqVkovLbuMhs0Clwsn7W2nFSvHOss5
sebF7ISXzpYR9Mp6iQ1Lh2lGBv0FHyf2gRjll+a4VODNMc5zJlFsswt/fPox18w=
=9XZL
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
