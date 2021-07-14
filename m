Return-Path: <stefanha@redhat.com>
Date: Wed, 14 Jul 2021 15:25:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Message-ID: <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
References: <20210505193655.2414268-1-egranata@google.com>
 <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain>
 <87pmvlck3p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Yv6eVjta5rSDZ4E"
Content-Disposition: inline
In-Reply-To: <87pmvlck3p.fsf@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Enrico Granata <egranata@google.com>, virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org
List-ID: <virtio-dev.lists.oasis-open.org>


--+Yv6eVjta5rSDZ4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 11:36:58AM +0200, Cornelia Huck wrote:
> On Wed, Jul 14 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Wed, May 05, 2021 at 12:37:26PM -0700, Enrico Granata wrote:
> >> ---------- Forwarded message ---------
> >> From: Enrico Granata <egranata@google.com>
> >> Date: Wed, May 5, 2021 at 1:37 PM
> >> Subject: [PATCH v2] Provide detailed specification of virtio-blk
> >> lifetime metrics
> >> To: <virtio-dev@lists.oasis-open.org>
> >> Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> >> <linux-block@vger.kernel.org>,
> >> <virtualization@lists.linux-foundation.org>
> >>=20
> >>=20
> >> In the course of review, some concerns were surfaced about the
> >> original virtio-blk lifetime proposal, as it depends on the eMMC
> >> spec which is not open
> >>=20
> >> Add a more detailed description of the meaning of the fields
> >> added by that proposal to the virtio-blk specification, as to
> >> make it feasible to understand and implement the new lifetime
> >> metrics feature without needing to refer to JEDEC's specification
> >>=20
> >> This patch does not change the meaning of those fields nor add
> >> any new fields, but it is intended to provide an open and more
> >> clear description of the meaning associated with those fields.
> >>=20
> >> Signed-off-by: Enrico Granata <egranata@google.com>
> >> ---
> >> Changes in v2:
> >>   - clarified JEDEC references;
> >>   - added VIRTIO_BLK prefix and cleaned up comment syntax;
> >>   - clarified reserved block references
> >>=20
> >>  content.tex | 40 ++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 32 insertions(+), 8 deletions(-)
> >
> > Ping?
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> [Enrico is currently on leave of absence]
>=20
> Is there any outstanding feedback from the linux-block folks? I've lost
> track of this, I'm afraid. (Your R-b is the only feedback I see on this
> list...)
>=20
> We can certainly put up a vote. This is one of the things I wanted to
> see fixed for the next release of the standard.

I have CCed Christoph, linux-block@, and virtualization@. Here is the
link to the patch that we're discussing:
https://patchwork.kernel.org/project/linux-block/patch/20210505193655.24142=
68-1-egranata@google.com/

Stefan

--+Yv6eVjta5rSDZ4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDu88AACgkQnKSrs4Gr
c8hYVAgAtnPGTJOBrka0qF+k5pZMbaxQ0R+0x3XTXkLy9ps2CboeHmh7hrmLCskK
eQ+v6hPvAygCGNArFIqg/0AEUuXgu7xAEhwdDtFZ1ahO8ULxxrCFCWnFhhqn0U0k
JAalGCzyTHpnDtYGWvvIEPYoF8GBrpeEWTJLrff1KReSujxuDeetB4jpPiLYwqE2
hWNsEeQjlTNuCAGSAMAACG02JCs4thf8GNlAAkMZRD8K1O1iFkNQYmUCpebP9pl9
qkIyPeVhpFCIO0hfDGA5TLoqdRne7vLbBeRawMf6JEESq1plQIpCNP0ez6KVmC9k
b5Wb+AaQyWJsP0Wdf/Qb+QbiyGQoeA==
=oGMA
-----END PGP SIGNATURE-----

--+Yv6eVjta5rSDZ4E--

