Return-Path: <stefanha@redhat.com>
Date: Wed, 18 Aug 2021 13:52:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-gpio: Specify character encoding
 for gpio names
Message-ID: <YR0CeS7DPxYSm0RY@stefanha-x1.localdomain>
References: <da4212f303c9fa797bde4eb8bcdc2d8d2d71bc99.1629286171.git.viresh.kumar@linaro.org>
 <CAK8P3a0V_9DR1yNfO2HgXnb521TJzg_51HfCn47Hb_-v8uMDDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0GXZn7WkqV/2xo6X"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0V_9DR1yNfO2HgXnb521TJzg_51HfCn47Hb_-v8uMDDA@mail.gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


--0GXZn7WkqV/2xo6X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2021 at 02:02:19PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 18, 2021 at 1:31 PM Viresh Kumar <viresh.kumar@linaro.org> wr=
ote:
> > diff --git a/virtio-gpio.tex b/virtio-gpio.tex
> > index 5da16d920aa3..0b0689cceb08 100644
> > --- a/virtio-gpio.tex
> > +++ b/virtio-gpio.tex
> > @@ -119,7 +119,8 @@ \subsubsection{requestq Operation: Get Line Names}\=
label{sec:Device Types / GPIO
> >  order of the GPIO line numbers. The names of the GPIO lines are option=
al and may
> >  be present only for a subset of GPIO lines. If missing, then a zero-by=
te must be
> >  present for the GPIO line. If present, the name string must be zero-te=
rminated
> > -and the name must be unique within a GPIO Device.
> > +and the name must be unique within a GPIO Device. The names of the GPI=
O lines
> > +are encoded in UTF-8.
>=20
> I would prefer mandating this to be 7-bit ASCII, since Linux uses the str=
ing as
> a file name in the (deprecated) sysfs interface, and the more unusual sym=
bols
> may be hard to type on the command line.
>=20
> There is also a question about UTF-8 normalization of those strings: shou=
ld
> the guest assume that the names within a device just have different binary
> representations, or also that they represent unique strings when there are
> multiple equivalent or compatible sequences?

I'm fine with either one. If there are technical limitations that make
ASCII a safer choice then that's fine.

virtio-blk uses ASCII while virtio-serial and virtiofs use UTF-8 for
strings.

Stefan

--0GXZn7WkqV/2xo6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEdAnkACgkQnKSrs4Gr
c8g5yQf/dD2rMIKgIhxcPUez9EPxOPyhHofR+JXW82Hu1xlGf1eXOqM+/ad96zhb
l57RL4CUfDsNZqo4BfS/8JIU7VcHxXgFkqYyiKke1OYKERqNh66YCPuC2nDHleUq
TvXw+ArVk3tCVsKNMrl3lNPw6DUEhVlWjt84zFWo924winkFKlMzRLFpHAxUtiTg
3t5vW5whtLw9iw0utzqUHTWH89vadwvUZOoUm343u+c5znK2x0wg6gkEALY2I6Ew
JO/+KbvVxfEr334ktchrjbmeSBNkyadACVRTUoYNM9hyqVs27rktgwd5537sPlNF
M33d4OYT8+0ypfs/+wbSIpvX72tWYQ==
=TTfr
-----END PGP SIGNATURE-----

--0GXZn7WkqV/2xo6X--

