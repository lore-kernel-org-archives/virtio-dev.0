Return-Path: virtio-comment-return-1554-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 16 Dec 2020 15:52:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20201216155218.GA720702@stefanha-x1.localdomain>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2020 at 01:55:18PM +0800, Jie Deng wrote:
> diff --git a/virtio-i2c.tex b/virtio-i2c.tex
> new file mode 100644
> index 0000000..fdb0050
> --- /dev/null
> +++ b/virtio-i2c.tex
> @@ -0,0 +1,139 @@
> +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device=
}
> +
> +virtio-i2c is a virtual I2C adapter device. It provides a way to flexibl=
y
> +organize and use the host I2C slave devices from the guest. By attaching
> +the host ACPI I2C slave nodes to the virtual I2C adapter device, the gue=
st can
> +communicate with them without changing or adding extra drivers for these
> +slave I2C devices.=20

Is there a way to identify I2C busses if more than one virtio-i2c device
is present? For example, imagine a host with 2 I2C busses. How does the
guest know which virtio-i2c device connects to which host bus?

> +\begin{lstlisting}
> +struct virtio_i2c_req {
> +        le16 addr;
> +        le32 flags;

What is the memory layout?

1. 0x0 addr, 0x2 flags

or

2. 0x0 addr, 0x4 flags

This is unclear to me. I don't see a general statement in the spec about
struct field alignment/padding and no details in this new spec change.

> +        le16 written;
> +        le16 read;
> +        u8 write_buf[];
> +        u8 read_buf[];
> +        u8 status;
> +};
> +\end{lstlisting}
> +
> +The \field{addr} of the request is the address of the I2C slave device.

https://en.wikipedia.org/wiki/I2c#Addressing_structure suggests there
are at least 7-bit and 10-bit addressing schemes in I2C. How does this
map to the little-endian 16-bit addr field?

> +The \field{flags} of the request is currently reserved as zero for futur=
e
> +feature extensibility.
> +
> +The \field{written} of the request is the number of data bytes in the \f=
ield{write_buf}
> +being written to the I2C slave address.

This field seems redundant since the device can determine the size of
write_buf implicitly from the total out buffer size. virtio-blk takes
this approach.

> +The \field{read} of the request is the number of data bytes in the \fiel=
d{read_buf}
> +being read from the I2C slave address.

Same here. virtio-blk doesn't use an explicit read size field because
the device can determine it.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/aLTIACgkQnKSrs4Gr
c8hdngf/WQGKydlHSmEYGmaHBRaX6ChxQ9aLnv8rG2c8T37IzwwHeHW/heYHYPH9
6RAuoJc+eR/Hue+XP/aHz+Watu7h69xnEjicT6KlVdZiO+NK4KI3yG4UizHSNU0H
VuAdzo9OViDyMLcqsNG/NKJz8zf6upApBMD8Vmgb5BTehLVeomMeVV5XkkoIHS6Y
aIPsbD0SIM+X/t+nPK7ssP7h+7GJLnRd2p+K6McRWdIwE5H8z5h6bw0evp6PLc3L
Nrlw6WphU9pJwdjFIG1ZrvYbuu5VgIunNhKC9Mm4GuUNqtffM/9zITu4aNCbZUWk
BHjcoJtGP1DdlPnoksXvv43lHXUioA==
=24Nr
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

