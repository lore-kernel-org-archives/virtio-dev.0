Return-Path: <stefanha@redhat.com>
Date: Tue, 17 Aug 2021 10:37:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH V9] virtio-gpio: Add the device specification
Message-ID: <YRuDYG6LKSyssCDa@stefanha-x1.localdomain>
References: <cb15de92f8cb840204a945ae643c14700b567600.1628492314.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YeTIDbz6hLekljwR"
Content-Disposition: inline
In-Reply-To: <cb15de92f8cb840204a945ae643c14700b567600.1628492314.git.viresh.kumar@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>


--YeTIDbz6hLekljwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 09, 2021 at 12:32:14PM +0530, Viresh Kumar wrote:
> +\subsubsection{requestq Operation: Get Line Names}\label{sec:Device Types / GPIO Device / requestq Operation / Get Line Names}
> +
> +The driver sends this message to receive a stream of zero-terminated strings,
> +where each string represents the name of a GPIO line, present in increasing
> +order of the GPIO line numbers. The names of the GPIO lines are optional and may
> +be present only for a subset of GPIO lines. If missing, then a zero-byte must be
> +present for the GPIO line. If present, the name string must be zero-terminated
> +and the name must be unique within a GPIO Device.

Sorry I didn't get to this patch before the vote. It's necessary to
specify the character encoding. In the text above it's unclear whether
the characters are limited to US-ASCII, UTF-8, or something else.

I suggest UTF-8 for maximum flexibility.

> +These names of the GPIO lines should be most meaningful producer names for the
> +system, such as name indicating the usage. For example "MMC-CD", "Red LED Vdd"
> +and "ethernet reset" are reasonable line names as they describe what the line is
> +used for, while "GPIO0" is not a good name to give to a GPIO line.

Does this belong in the device normative section? Normally "should",
"must", "may", etc are only used there. If you prefer to keep it here,
please adjust the language ("The device describes GPIO lines with the
most meaningful producer names for the system, ...").

> +
> +The driver sends this message to request the device to configure a line's
> +direction. The driver can either set the direction to
> +\field{VIRTIO_GPIO_DIRECTION_IN} or \field{VIRTIO_GPIO_DIRECTION_OUT}, which
> +also activates the line, or to \field{VIRTIO_GPIO_DIRECTION_NONE}, which
> +deactivates the line.
> +
> +The driver should set the value of the GPIO line, using the
> +\field{VIRTIO_GPIO_MSG_SET_VALUE} message, before setting the direction of the
> +line to output to avoid any undesired behavior.

Does this belong in the driver normative section? Normally "should",
"must", "may", etc are only used there. If you prefer to keep it here,
please adjust the language ("The driver sets the value ...").

--YeTIDbz6hLekljwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEbg2AACgkQnKSrs4Gr
c8grlQf+NpcUooFdRe563Dq0XHjvOy0tCcfY0Nc+Ebgi42NxNafZxXNDXwHXWVUp
DxWhhgUzyi1CNLHcyKhZX5SZV3pykm/pYl7bAFEspyAQIOUarMN6pDcGxK/YtSUp
H/qOwVXSkSl0Fo+XBMspuNKIKL7zHNRFPdoJsoVB8DoBODUpwwdZwzoF/uH3/Wdi
b5PwX9qhjZv6o1Mt+wn1CFN5W9veLu6/ZTOE1UC832ZYop+5XiF4iqfjbW+CYN12
F3TxrwFbig7mCOjAxIk5NnzqyPhpM0MoTVzz1TlojiLagZj3BTJ3yAOOePq1vr+z
QoyLNeLGhZyVAEdpZ7e4B5rp0dWPwg==
=eJSK
-----END PGP SIGNATURE-----

--YeTIDbz6hLekljwR--

