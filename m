Return-Path: virtio-dev-return-5879-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 600BA985D3F
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jul 2019 15:58:07 +0000 (UTC)
Date: Tue, 23 Jul 2019 16:58:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190723155801.GH5445@stefanha-x1.localdomain>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-2-stefanha@redhat.com>
 <20190618210753-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
In-Reply-To: <20190618210753-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v3 1/2] content: add virtio file system
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 09:29:13PM -0400, Michael S. Tsirkin wrote:
> On Wed, Feb 20, 2019 at 12:46:12PM +0000, Stefan Hajnoczi wrote:
> > +\begin{description}
> > +\item[\field{tag}] is the name associated with this file system.  The =
tag is
> > +    encoded in UTF-8 and padded with NUL bytes if shorter than the
> > +    available space.  This field is not NUL-terminated if the encoded =
bytes
> > +    take up the entire field.
> > +\item[\field{num_queues}] is the total number of request virtqueues ex=
posed by
> > +    the device. The driver MAY use only one request queue,
> > +    or it can use more to achieve better performance.
>=20
> Pls copy instances of MAY,SHOULD,MUST into conformance sections.
> Pls convert text outside of conformance sections to "can"
> or "is allowed to" etc.

Thanks for your feedback.  All of these comments will be addressed in
the next revision.

Stefan

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl03LogACgkQnKSrs4Gr
c8hNQwgArLD+W+vj2GEw9923KUPVES0bgK3HoKPtNTUvgswRNRtxFRbwg0oSi2kc
rNcdZ+LGl4h3jO1ZLOPdL6hXy1z49NkU75gSmrKcd8myJbtS6zlhqCea1g3CRrL+
31GpjAWjee93bkPowRh56sB04p4uCxkfAQOf0CoNNfL4KrWOwP5vdEKbVnPihuMo
toBBhmiA0z1mk7peFepQV1sPo9zQu5mUL+rGoz+FomBZlwyfcLXmWf8pmlntuxRu
QRnXTVYkj2+4eO3brmGx53Qdun6gQQ1MV8ylbamoK+tq9fMRYInUcf/n3B/QZyu2
JZ/fYMEsFslRgXrd0xej0H1lC/4P7w==
=kzIj
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
