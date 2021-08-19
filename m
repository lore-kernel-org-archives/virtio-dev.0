Return-Path: <stefanha@redhat.com>
Date: Thu, 19 Aug 2021 10:40:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V2] virtio-gpio: Specify character encoding for gpio names
Message-ID: <YR4m85Q67H+7GzIB@stefanha-x1.localdomain>
References: <8cb679e3013bc9dd49af5d4837c0dcffeb41b8e8.1629345350.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0XqlH/nTKLdDERx3"
Content-Disposition: inline
In-Reply-To: <8cb679e3013bc9dd49af5d4837c0dcffeb41b8e8.1629345350.git.viresh.kumar@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Bill Mills <bill.mills@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>


--0XqlH/nTKLdDERx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 09:26:54AM +0530, Viresh Kumar wrote:
> Specify 7-bit ASCII character encoding for GPIO names strings.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/115
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Use ASCII instead of UTF-8.
>=20
>  virtio-gpio.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Looks good, thank you. Let's vote again.

Stefan

--0XqlH/nTKLdDERx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEeJvMACgkQnKSrs4Gr
c8iPVAgAn8roEWObObzEn2IRMyxfyJb5m3HGmr6E6qu/4igYPb9DeJJNjtVTNaWK
3QHWUJbt9DBt4WaJfJytEjfuSEHN9TW2YjsrPM2UbNk6IGG6e8aqSzdDcY8JmE5+
dVBxj5LmGd5/Go6WbRfLmj/Bk8EJCt3CK8NjsLVwA+o97CC3DJhIW2quXEvzBTrZ
Uf9OpIEvL4ycnb+CAuNa+Pqcyx9fAl+6961MwFtlFsSXWthjVPV2BVUTIE9Fj9wo
ozWGvv3ZpRrwT1mObcAfvIFKhmsCbak2+cogkKg+/ruSAlJRTHZByyV2qsxuliP4
WSh4QCz81FrDgn6NAJUl0dFlP7TGHg==
=csUW
-----END PGP SIGNATURE-----

--0XqlH/nTKLdDERx3--

