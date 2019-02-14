Return-Path: virtio-dev-return-5441-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29989986074
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Feb 2019 03:33:31 +0000 (UTC)
Date: Thu, 14 Feb 2019 11:33:25 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190214033325.GD21877@stefanha-x1.localdomain>
References: <20190213063322.25099-1-stefanha@redhat.com>
 <20190213063322.25099-2-stefanha@redhat.com>
 <77591e8b-5147-fa0f-27f3-a1cb94c62550@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <77591e8b-5147-fa0f-27f3-a1cb94c62550@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2 1/2] content: add virtio file system
 device
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 05:47:19PM +0100, Paolo Bonzini wrote:
> On 13/02/19 07:33, Stefan Hajnoczi wrote:
> > +Notifications are different from normal requests because they only con=
tain
> > +device writable fields.  The driver sends notification replies on one =
of the
> > +request queues.  The format of notification requests is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_fs_notification_req {
> > +        // Device-writable part
> > +        struct fuse_out_header out;
> > +        u8 dataout[];
> > +};
> > +\end{lstlisting}
> > +
> > +\field{out} is the completion header common to all types of FUSE reque=
sts.  The
> > +\field{out.unique} field is 0 and the \field{out.error} field contains=
 a
> > +FUSE_NOTIFY_* code.
> > +
> > +\field{dataout} consists of request-specific data, if any.  This is id=
entical
> > +to the data written to the /dev/fuse device by a FUSE daemon.
> > +
>=20
> What happens if notifications are lost because no request was there?
> virtio-scsi has a flag for that, would it make sense to add it here too?

The FUSE protocol assumes notification delivery is reliable.  Some
notifications can be dropped with no or little impact on functionality,
but others cannot because it would cause a hung operation.

Therefore the device must hold notifications until the driver makes
buffers available.  The question becomes what happens when the device
runs out of space to hold notifications.  At this point the device must
be reset because no further progress is possible.

(In our current implementation notifications aren't used at all, but the
virtio-fs spec should allow for it so that the full FUSE protocol is
available for future applications.)

Miklos: What do you think from the FUSE protocol point of view?

Stefan

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZOGFAAoJEJykq7OBq3PIS6sH/2YdROSL6NIyXZnuG+U2A1r+
yPFblXhctQqyge01qfcfzPwYkch0iq01Is+s5SIEdRZsmCE0bqn4D6EdcUnNu7wM
3KUvUXN//aCm2Kh8K4als7c05gfNAtRSAsNdQJN6J5FHX/5ciXyarjh7u/NlVSEw
6H2yzRIcZDZxwlW4ZydXr8THnfSvtNST3dHBNr+JA/765aCOggr0uOWXdCE0/DT2
S5m7xouTW1eC0zwYyHqdFMJkaRzC0IYEX31kPJvoVRhTCed+8dXprB0xv2FoI1vE
fUIzw0Gfv9lRtJiw6hEVEPu/Mu0yqaL/Ho1OsHWhVEdxtKJ/JdHtZ9GmrIIn+us=
=NLfz
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
