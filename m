Return-Path: virtio-dev-return-5446-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A3F7986075
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Feb 2019 08:36:46 +0000 (UTC)
Date: Thu, 14 Feb 2019 16:36:37 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190214083637.GC7652@stefanha-x1.localdomain>
References: <20190213063322.25099-1-stefanha@redhat.com>
 <20190213063322.25099-2-stefanha@redhat.com>
 <77591e8b-5147-fa0f-27f3-a1cb94c62550@redhat.com>
 <20190214033325.GD21877@stefanha-x1.localdomain>
 <CAOssrKdfYic5bSz-GkfZUbd=OrADwrVXPRTQiVgOFbzpiVwNZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <CAOssrKdfYic5bSz-GkfZUbd=OrADwrVXPRTQiVgOFbzpiVwNZg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2 1/2] content: add virtio file system
 device
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 08:20:58AM +0100, Miklos Szeredi wrote:
> On Thu, Feb 14, 2019 at 4:33 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Wed, Feb 13, 2019 at 05:47:19PM +0100, Paolo Bonzini wrote:
> > > On 13/02/19 07:33, Stefan Hajnoczi wrote:
> > > > +Notifications are different from normal requests because they only=
 contain
> > > > +device writable fields.  The driver sends notification replies on =
one of the
> > > > +request queues.  The format of notification requests is as follows:
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_fs_notification_req {
> > > > +        // Device-writable part
> > > > +        struct fuse_out_header out;
> > > > +        u8 dataout[];
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +\field{out} is the completion header common to all types of FUSE r=
equests.  The
> > > > +\field{out.unique} field is 0 and the \field{out.error} field cont=
ains a
> > > > +FUSE_NOTIFY_* code.
> > > > +
> > > > +\field{dataout} consists of request-specific data, if any.  This i=
s identical
> > > > +to the data written to the /dev/fuse device by a FUSE daemon.
> > > > +
> > >
> > > What happens if notifications are lost because no request was there?
> > > virtio-scsi has a flag for that, would it make sense to add it here t=
oo?
> >
> > The FUSE protocol assumes notification delivery is reliable.  Some
> > notifications can be dropped with no or little impact on functionality,
> > but others cannot because it would cause a hung operation.
> >
> > Therefore the device must hold notifications until the driver makes
> > buffers available.  The question becomes what happens when the device
> > runs out of space to hold notifications.  At this point the device must
> > be reset because no further progress is possible.
> >
> > (In our current implementation notifications aren't used at all, but the
> > virtio-fs spec should allow for it so that the full FUSE protocol is
> > available for future applications.)
> >
> > Miklos: What do you think from the FUSE protocol point of view?
>=20
> I  think notifications would be limited in functionality in the virtio
> case.  E.g. FUSE_NOTIFY_INVAL_INODE could be used if the server
> detects that cached attributes have become invalid.  If this is a best
> effort thing (doesn't block other clients) then it's okay.  But if
> it's for implementing strong coherency, then it doesn't work that
> well, since the broken client can block other clients from making
> progress.
>
> So I'm not sure.  Probably easier to leave notifications out of the
> implementation and the spec, until an actual use case arises.

I'd still like to discuss the options because it would be a real problem
to spec the device without notifications and then find out the design
cannot be extended when we need them.

When the device runs out of space to queue notifications for a slow
client, that client must be kicked out so that others can continue.
This seems like the most robust way to keep the file system available.
Only the client that couldn't keep up is hurt.

In our implementation each virtiofsd has a single client, so I'm not
sure the denial-of-service you described can occur (is that something
that involves the ireg daemon?).  The good thing is this means that
virtiofsd may block until its sole client replenishes notifications
buffers.  No other clients are hurt!

Stefan

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZSiUAAoJEJykq7OBq3PI/ygH/RujtiBVGXLcel+FWNwz9/LV
xlvQs0R+RNNdLI180Kd/PqNRTROvNcqt9tEd8JNOYEAZUn7IWO733LAhDjHN9wC1
QoOMXvR84Hf5bc5cqPo0CPvSi9MuX3egrdW2TFWX8HbIwhw3agLVkxZHKdN54emp
8wjai1dYz3MCOt125n5uKstJUrUHvvCNLy0dvY2d9dBJIj8NcAouHaPr2jgeRb3n
oWRheCzMKzbGnXK6qZC4qtNGKSmgfsew3TqHDyXe2bkLv73bSvhUTochm/O/Ve2J
pV8PEyAixDG/+Cn/oRZiFmhSDdwDlt1KoLvb/5o/CA3WBzM5nePn8w8+91blC2c=
=JkaH
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
