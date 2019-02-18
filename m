Return-Path: virtio-dev-return-5450-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2964985B52
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Feb 2019 10:20:53 +0000 (UTC)
Date: Mon, 18 Feb 2019 10:20:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190218102049.GA12256@stefanha-x1.localdomain>
References: <20190213063322.25099-1-stefanha@redhat.com>
 <20190213063322.25099-2-stefanha@redhat.com>
 <77591e8b-5147-fa0f-27f3-a1cb94c62550@redhat.com>
 <20190214033325.GD21877@stefanha-x1.localdomain>
 <CAOssrKdfYic5bSz-GkfZUbd=OrADwrVXPRTQiVgOFbzpiVwNZg@mail.gmail.com>
 <20190214083637.GC7652@stefanha-x1.localdomain>
 <CAOssrKcXftoaszAoNF3936rTP0KgD6mL4P=hoy54v2i+x-1o8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <CAOssrKcXftoaszAoNF3936rTP0KgD6mL4P=hoy54v2i+x-1o8A@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2 1/2] content: add virtio file system
 device
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:50:23AM +0100, Miklos Szeredi wrote:
> On Thu, Feb 14, 2019 at 9:36 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Thu, Feb 14, 2019 at 08:20:58AM +0100, Miklos Szeredi wrote:
> > > On Thu, Feb 14, 2019 at 4:33 AM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > >
> > > > On Wed, Feb 13, 2019 at 05:47:19PM +0100, Paolo Bonzini wrote:
> > > > > On 13/02/19 07:33, Stefan Hajnoczi wrote:
> > > > > > +Notifications are different from normal requests because they =
only contain
> > > > > > +device writable fields.  The driver sends notification replies=
 on one of the
> > > > > > +request queues.  The format of notification requests is as fol=
lows:
> > > > > > +
> > > > > > +\begin{lstlisting}
> > > > > > +struct virtio_fs_notification_req {
> > > > > > +        // Device-writable part
> > > > > > +        struct fuse_out_header out;
> > > > > > +        u8 dataout[];
> > > > > > +};
> > > > > > +\end{lstlisting}
> > > > > > +
> > > > > > +\field{out} is the completion header common to all types of FU=
SE requests.  The
> > > > > > +\field{out.unique} field is 0 and the \field{out.error} field =
contains a
> > > > > > +FUSE_NOTIFY_* code.
> > > > > > +
> > > > > > +\field{dataout} consists of request-specific data, if any.  Th=
is is identical
> > > > > > +to the data written to the /dev/fuse device by a FUSE daemon.
> > > > > > +
> > > > >
> > > > > What happens if notifications are lost because no request was the=
re?
> > > > > virtio-scsi has a flag for that, would it make sense to add it he=
re too?
> > > >
> > > > The FUSE protocol assumes notification delivery is reliable.  Some
> > > > notifications can be dropped with no or little impact on functional=
ity,
> > > > but others cannot because it would cause a hung operation.
> > > >
> > > > Therefore the device must hold notifications until the driver makes
> > > > buffers available.  The question becomes what happens when the devi=
ce
> > > > runs out of space to hold notifications.  At this point the device =
must
> > > > be reset because no further progress is possible.
> > > >
> > > > (In our current implementation notifications aren't used at all, bu=
t the
> > > > virtio-fs spec should allow for it so that the full FUSE protocol is
> > > > available for future applications.)
> > > >
> > > > Miklos: What do you think from the FUSE protocol point of view?
> > >
> > > I  think notifications would be limited in functionality in the virtio
> > > case.  E.g. FUSE_NOTIFY_INVAL_INODE could be used if the server
> > > detects that cached attributes have become invalid.  If this is a best
> > > effort thing (doesn't block other clients) then it's okay.  But if
> > > it's for implementing strong coherency, then it doesn't work that
> > > well, since the broken client can block other clients from making
> > > progress.
> > >
> > > So I'm not sure.  Probably easier to leave notifications out of the
> > > implementation and the spec, until an actual use case arises.
> >
> > I'd still like to discuss the options because it would be a real problem
> > to spec the device without notifications and then find out the design
> > cannot be extended when we need them.
> >
> > When the device runs out of space to queue notifications for a slow
> > client, that client must be kicked out so that others can continue.
> > This seems like the most robust way to keep the file system available.
> > Only the client that couldn't keep up is hurt.
> >
> > In our implementation each virtiofsd has a single client, so I'm not
> > sure the denial-of-service you described can occur (is that something
> > that involves the ireg daemon?).
>=20
> The DoS would involve any mechanism synchronizing one client's
> metadata modification with another client's metadata retrieval.  In
> our implementation it is hoped to bypass that synchronization by using
> the version number living in shared memory.
>=20
> > The good thing is this means that
> > virtiofsd may block until its sole client replenishes notifications
> > buffers.  No other clients are hurt!
>=20
> Right, so the notification in itself is not a source of DoS, but for
> it to be useful, it would necessarily involve some higher level
> synchronization, no?

I think this depends on the file system.  In some cases notifications
require resource allocation and that leads to the problems we've been
discussing.  In other cases the file system daemon may be able to send
notifications at a later point in time without resource exhaustion, so
no flow control or synchronization is needed.

Here are my thoughts on each FUSE notification type:

FUSE_NOTIFY_POLL
Requires guaranteed delivery: Yes, to wake up a sleeping task
Possibility of resource exhaustion: Yes, If other clients generate poll
notifications via their activity, then the notifications buffers can be
exhausted.

When is FUSE_NOTIFY_POLL used?  I guess it's needed in cases where the
file system is changed on the remote side.  virtiofsd should implement
this notification eventually so that virtio-fs clients notice changes.

FUSE_NOTIFY_INVAL_INODE
Alternative: Use version shared memory region instead*

FUSE_NOTIFY_INVAL_ENTRY
Alternative: Use version shared memory region instead*

FUSE_NOTIFY_STORE
Alternative: Use DAX instead

FUSE_NOTIFY_RETRIEVE
Alternative: Use DAX instead

FUSE_NOTIFY_DELETE
Alternative: Use version shared memory region instead*
             (Does it handle deleted inodes?)

* The version shared memory region prevents clients from using stale
  data (good) but doesn't prompt the client that something has changed
  (bad).  This means inotify or similar cannot rely on these
  notifications to detect changes if we use the version shared memory
  instead.

Stefan

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcaocBAAoJEJykq7OBq3PIpWMH/R/DrS9MeOwIyNebPK0UJvbg
GrttZtnyDs58gwxvJRoTHD50SXxo8DZPG66fEONFKH0fVSI4xIR8tyWPwusf6+6V
CChPxpMOmj/8lhNjZVa5U4lj+iRqax7yTkAjVpw2gVCamjquWQGbcFgQykvcywzo
3G6L+Kn882EyFQT4YBGXfs6WPXBtQh4jOT1tckov9atKOVg9t/YQcsHXG4YSwOFW
ejHMQA61EhmsZUR8k5T0o7/5ThvmShBfnweT/LwNrH19O1wRvEJFCkWF9b1RY5lf
pDTcRDTxYJgWrdSdAcqkdGqCbQUe7pDO+Q4Q/PGxHJwvAU3erw8xqGMfp8kARps=
=QHZZ
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
