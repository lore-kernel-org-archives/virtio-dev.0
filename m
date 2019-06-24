Return-Path: virtio-dev-return-5800-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1473984377
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jun 2019 13:58:19 +0000 (UTC)
Date: Mon, 24 Jun 2019 14:58:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190624135808.GC3833@stefanha-x1.localdomain>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-3-stefanha@redhat.com>
 <20190618213147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20190618213147-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 09:41:25PM -0400, Michael S. Tsirkin wrote:
> On Wed, Feb 20, 2019 at 12:46:13PM +0000, Stefan Hajnoczi wrote:
> > Describe how shared memory region ID 0 is the DAX window and how
> > FUSE_SETUPMAPPING maps file ranges into the window.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Note that this depends on the shared memory resource specification
> > extension that David Gilbert is working on.
> > https://lists.oasis-open.org/archives/virtio-comment/201901/msg00000.ht=
ml
> >=20
> > The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> > https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fu=
se.h
> > ---
> >  virtio-fs.tex | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/virtio-fs.tex b/virtio-fs.tex
> > index 5df5b9c..abb1e48 100644
> > --- a/virtio-fs.tex
> > +++ b/virtio-fs.tex
> > @@ -157,6 +157,31 @@ The driver MUST submit FUSE_INTERRUPT, FUSE_FORGET=
, and FUSE_BATCH_FORGET reques
> > =20
> >  The driver MUST anticipate that request queues are processed concurren=
tly with the hiprio queue.
> > =20
> > +\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / =
File System Device / Device Operation / Device Operation: DAX Window}
> > +
> > +FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
> > +driver-provided buffer and the device.  In cases where data transfer is
> > +undesirable, the device can map file contents into the DAX window shar=
ed memory
> > +region.  The driver then accesses file contents directly in device-own=
ed memory
> > +without a data transfer.
> > +
> > +Shared memory region ID 0 is called the DAX window.  The driver maps a=
 file
> > +range into the DAX window using the FUSE\_SETUPMAPPING request.  The m=
apping is
> > +removed using the FUSE\_REMOVEMAPPING request.
>=20
> I don't see FUSE\_SETUPMAPPING or FUSE\_REMOVEMAPPING  under
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/fuse.h
> Is it just me?

They are not upstream yet and can be found here:

https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h=
#L384

There is a chicken-and-egg problem.  Linux should merge this once the
spec has been accepted.  The spec makes reference to a new FUSE command
that is being added to Linux.  :D

I suggest we break it by merging the VIRTIO spec change first.  There
won't be a spec release so soon anyway and we can revert it in case
there are issues Linux.  Miklos, the FUSE maintainer, is well aware of
virtio-fs and contributes to it, so it's unlikely that Linux will reject
these commands.

> > +
> > +After FUSE\_SETUPMAPPING has completed successfully the file range is =
accessible
> > +from the DAX window at the offset provided by the driver in the reques=
t.
>=20
> Dgilbert's patches describing shared memory say that
> the legal ways to set up mappings are all implementation-dependent.
> How does driver know which attributes to use for the
> mapping?

Two different types of mappings:
1. The DAX window shared memory region described by DaveG's spec.
2. The file mappings established using FUSE_SETUPMAPPING.

The virtio_fs.ko driver maps the DAX window, e.g. from a PCI BAR in an
implementation-defined way.  virtio_pci_*.c in Linux will have to help
out with the implementation-specific details here.

The only flags currently supported by FUSE_SETUPMAPPING are READ and
WRITE.  This depends on the file's access mode.  There is nothing
implementation-specific in FUSE_SETUPMAPPING.

> Also, we recently had a discussion about DAX support on hosts
> and safety wrt crashes. Do we need to expose this
> information to guests maybe?

No.  Although virtio-fs uses the DAX subsystem, it does not use NVDIMM's
persistence model (e.g. CPU cache flush for persistence).  FUSE_FSYNC is
sent when persistence is required.  Therefore virtio-fs is still using
the traditional file/block persistence model.  No changes necessary for
power failure, etc.

> Finally, do we want to have a way to express that the filesystem
> only allows RO mappings?

Thanks for this idea.  I'm discussing it with the FUSE community because
mount -o ro with FUSE currently doesn't involve the file system daemon.

> > +
> > +\devicenormative{\paragraph}{Device Operation: DAX Window}{Device Type=
s / File System Device / Device Operation / Device Operation: DAX Window}
> > +
> > +The device MUST allow mappings that completely or partially overlap ex=
isting mappings within the DAX window.
>=20
>=20
> Any alignment requirements?

Good point.  There are alignment requirements and the driver has no way
of knowing what they are.  I'll find a way to communicate them into the
guest, either via virtio or via FUSE.

> Also, with no limit on mappings, it looks like guest can use up lots of
> host VMAs quickly. Shouldn't there be a limit on # of mappings?

The VM can only deteriorate its own performance, right?

We haven't seen catastrophic problems that bring the system to it's
knees.  But we're aware that increasing the number VMAs slows down the
lookup.  There is currently no imposed limit.

Ideas have been discussed to avoid using (so many) VMAs but it seems
like that will take some time to develop and get upstream.  This will
not affect the virtio specification because the device interface doesn't
need to know about this.

Stefan

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0Q1vAACgkQnKSrs4Gr
c8hzYwf/TmDyxgayXUS3x+7uQYDi6sdn8v2jpxjclG9FnNgnedyliocTbdFJ9fg0
mWK8kk1qw+y3G8Vy+S5XIwpnAH1x6UqSPqH9yDRLvMzkPvEshaeY5kQdG67HMaeS
IMMkhY5pLdbybKnGcVVJZCxw4cEvvVd1zDT+LzP06N6CZZbse44+8IFJPj5KUGlK
XkrooMz817jSMB7U1pWQT25+PBgnN+NAjqs4gWW074LP8VTCmj6AbrjgiLNVWoM5
w3W/Ekr+FOLAc8z63g+r+wLi2HGhsaUeiA3aiRvF0dUmqYe/kh4XCOMHHh/EpNSb
Dc1p3q5bTExqpAq8UakIVrffOlsNpw==
=G4kx
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
