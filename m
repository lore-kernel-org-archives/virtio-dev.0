Return-Path: virtio-dev-return-5191-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 544DE985D7B
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Dec 2018 15:36:16 +0000 (UTC)
Date: Wed, 12 Dec 2018 15:20:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181212152005.GB11292@stefanha-x1.localdomain>
References: <20181211125156.22523-1-stefanha@redhat.com>
 <20181212102556.65bd43d3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20181212102556.65bd43d3.cohuck@redhat.com>
Subject: Re: [virtio-dev] [VIRTIO RFC] content: add virtio file system device
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Vivek Goyal <vgoyal@redhat.com>, Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 10:25:56AM +0100, Cornelia Huck wrote:
> On Tue, 11 Dec 2018 12:51:56 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > The work-in-progress virtio file system device transports Linux FUSE
> > requests between a FUSE daemon running on the host and the FUSE driver
> > inside the guest.
> >=20
> > This is an early version of the spec that maps FUSE requests to
> > virtqueues.  No changes are needed to the FUSE request format.
> >=20
> > Multiqueue is supported for normal requests.  FUSE_INTERRUPT and
> > FUSE_FORGET requests are only sent on the dedicated hiprio queue.
> > Notifications are sent on the notifications queue.
> >=20
> > The FUSE driver currently works in a "pull" model where userspace reads
> > requests from /dev/fuse one at a time.  Virtqueues are a "push" model
> > where the FUSE driver will need to enqueue requests onto a specific
> > virtqueue and wait for the guest to process them.
> >=20
> > The request queue buffers are completed by the device when the request
> > has been processed and struct fuse_out_header has been filled out.  The
> > FUSE driver then picks up the completed request and processes it as if
> > the FUSE daemon had written to /dev/fuse.
> >=20
> > Notifications involve device-to-driver communication.  Since virtqueues
> > live in guest RAM, the device cannot initiate communication.  Instead
> > the notifications queue is populated with empty buffers by the FUSE
> > driver (similar to a NIC rx queue).  The device then "completes" a
> > buffer when it wishes to notify the driver.  Replies to the notification
> > are place in a normal request queue, they do not go via the
> > notifications queue.
> >=20
> > Note that this design assumes that the driver knows the required buffer
> > size for each request.  My understanding is that this is true in FUSE.
> > The only exception is FUSE_NOTIFY_STORE, and even there the FUSE
> > implementation has a limit of 32 pages, which makes for a natural buffer
> > size limit for the notifications queue.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > The HTML version of this draft spec is available at
> > https://stefanha.github.io/virtio/virtio-fs.html#x1-38800010.
> >=20
> > This is mostly for reference and serious review isn't necessary yet.
> >=20
> > For more information on virtio-fs, see https://virtio-fs.gitlab.io/.
> >=20
> > Once the implementation matures we will send a real VIRTIO spec patch.
> >=20
> >  content.tex      |   3 +
> >  introduction.tex |   3 +
> >  virtio-fs.tex    | 208 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 214 insertions(+)
> >  create mode 100644 virtio-fs.tex
> >=20
> > diff --git a/content.tex b/content.tex
> > index b101d1b..4d38c5a 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2528,6 +2528,8 @@ Device ID  &  Virtio Device    \\
> >  \hline
> >  24         &   Memory device \\
> >  \hline
> > +26         &   file system device \\
>=20
> Would it make sense to go ahead and reserve this id now?

Yes.

Stefan

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcESclAAoJEJykq7OBq3PIWw4IAKUfOfPrOfh4n1WkC47yKsXY
iZc1NjjxdsOQjXVpKSqYfH/8IQ0tpR2SUSdHjDUEX5GgI/eWYlEK+S0GUgR642Pd
CJy1DroCERgtSgvtDF6wo75G0yspLvqDggLDKHfmCtFEYtFK7iYWiEg+votr9l4T
QFYArCP8/NK2VA0DAicRAQWy9WvraBFtZX2GPGXXeq/iUxLkIgI77PzF46wkH90b
he6N0BtRdN1s8X5pjblnkUiv+UxiVpsDh+m8zPu93ziAgMJtVopxCmyeKIROmf+2
dOnCaUleM/CbOU6irCHcnXQcMVMqc8H53WSRcYIe79/FySMnQ8wcRQfrFr75csw=
=1JSN
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
