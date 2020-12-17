Return-Path: virtio-comment-return-1562-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 17 Dec 2020 10:26:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20201217102640.GG4338@stefanha-x1.localdomain>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216155218.GA720702@stefanha-x1.localdomain>
 <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
 <20201217030015-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201217030015-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jie Deng <jie.deng@intel.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2020 at 03:00:55AM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 17, 2020 at 03:08:07PM +0800, Jie Deng wrote:
> >=20
> > On 2020/12/16 23:52, Stefan Hajnoczi wrote:
> >=20
> >     On Wed, Nov 25, 2020 at 01:55:18PM +0800, Jie Deng wrote:
> >=20
> >         diff --git a/virtio-i2c.tex b/virtio-i2c.tex
> >         new file mode 100644
> >         index 0000000..fdb0050
> >         --- /dev/null
> >         +++ b/virtio-i2c.tex
> >         @@ -0,0 +1,139 @@
> >         +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adap=
ter Device}
> >         +
> >         +virtio-i2c is a virtual I2C adapter device. It provides a way =
to flexibly
> >         +organize and use the host I2C slave devices from the guest. By=
 attaching
> >         +the host ACPI I2C slave nodes to the virtual I2C adapter devic=
e, the guest can
> >         +communicate with them without changing or adding extra drivers=
 for these
> >         +slave I2C devices.
> >=20
> >     Is there a way to identify I2C busses if more than one virtio-i2c d=
evice
> >     is present? For example, imagine a host with 2 I2C busses. How does=
 the
> >     guest know which virtio-i2c device connects to which host bus?
> >=20
> > This virtio-i2c is a master device. The slave devices attached to it ca=
n be
> > configured
> > by the backend in the host. These slave devices can be under different =
host I2C
> > master devices.
> > The guest will see this virtio-i2c master device and its slave devices.
> >=20
> > There is a example about the backend which shows how it works
> >=20
> > https://projectacrn.github.io/latest/developer-guides/hld/virtio-i2c.ht=
ml?
> > highlight=3Di2c
> > https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/=
hw/pci/
> > virtio/virtio_i2c.c
> >=20
> >=20
> >=20
> >         +\begin{lstlisting}
> >         +struct virtio_i2c_req {
> >         +        le16 addr;
> >         +        le32 flags;
> >=20
> >     What is the memory layout?
> >=20
> >     1. 0x0 addr, 0x2 flags
> >=20
> >     or
> >=20
> >     2. 0x0 addr, 0x4 flags
> >=20
> >     This is unclear to me. I don't see a general statement in the spec =
about
> >     struct field alignment/padding and no details in this new spec chan=
ge.
> >=20
> > Both are OK to me. I used to use "packed" but Michael said there was no=
 need to
> > pack it.=C3=83=E2=80=9A=C3=82=C2=A0
> >=20
> > https://lkml.org/lkml/2020/9/3/339
> >=20
> > So you prefer it to be clear ?
> >=20
> >         +        le16 written;
> >         +        le16 read;
> >         +        u8 write_buf[];
> >         +        u8 read_buf[];
> >         +        u8 status;
> >         +};
> >         +\end{lstlisting}
> >         +
> >         +The \field{addr} of the request is the address of the I2C slav=
e device.
> >=20
> >     https://en.wikipedia.org/wiki/I2c#Addressing_structure suggests the=
re
> >     are at least 7-bit and 10-bit addressing schemes in I2C. How does t=
his
> >     map to the little-endian 16-bit addr field?
> >=20
> > This field maps to the kernel struct "i2c_msg.addr".
> >=20
> > struct virtio_i2c_req *vmsg;
> > struct i2c_msg *msg;
> >=20
> > vmsg->addr =3D cpu_to_le16(msg->addr);
> >=20
> > The field in the request can be seen as host byte order
> > while the link can be seen as the I2C network byte order.
> > The host driver may take care this conversion.
> >=20
> >         +The \field{flags} of the request is currently reserved as zero=
 for future
> >         +feature extensibility.
> >         +
> >         +The \field{written} of the request is the number of data bytes=
 in the \field{write_buf}
> >         +being written to the I2C slave address.
> >=20
> >     This field seems redundant since the device can determine the size =
of
> >     write_buf implicitly from the total out buffer size. virtio-blk tak=
es
> >     this approach.
> >=20
> > The read/write are the actual number of data bytes being read from or w=
ritten
> > to the device
> > which is not determined by the device. So I don't think it is redundant=
.
>=20
> I am still not sure I understand the difference.
> This point is unclear to multiple people.

I think I get it now. This is made clear by splitting the struct:

  /* Driver->device fields */
  struct virtio_i2c_out_hdr
  {
      le16 addr;
      le16 padding;
      le32 flags;
  };

  /* Device->driver fields */
  struct virtio_i2c_in_hdr
  {
      le16 written;
      le16 read;
      u8 status;
  };

  /*
   * Virtqueue element layout looks like this:
   *
   * struct virtio_i2c_out_hdr out_hdr; /* OUT */
   * u8 write_buf[]; /* OUT */
   * u8 read_buf[]; /* IN */
   * struct virtio_i2c_in_hdr in_hdr; /* IN */
   */

This makes sense to me: a bi-directional request has both write_buf[]
and read_buf[] so the vring used.len field is not enough to report back
how many bytes were written and read. The virtio_i2c_in_hdr fields are
really needed.

Please split the struct in the spec so it's clear how this works.

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/bMmAACgkQnKSrs4Gr
c8goEQf6AzaEP0WRs+vPFG/tTP2GaxfSvzELRVpTP9F9EUFReHaej3WTNCWZTMzg
vQW8tdC1+vpGp/9NIWh668bTLQXQ2Jc0qeLf1z0iQHXICCGQduzzP+Lfm6DMIFB3
jVF3lsODsD00thQw53zt7mBX6ehVb6CQ5S12KCDwEBguWjDBnd2uhCnFiFWAPgaU
MrciQRYapMojCdE3RwNTSM+hdSFxMW3dXs0ZPxo4MaodsJM9hPKWk5JWXtdaqTQi
QPG8BwDCSfe557XLkV6PoMYB+FPEyPxONGqVizrNe9WcRmvl3k049XOMG0o2G2Tt
zZobkgdq/9uOAjLj0SCuURMYcP5aTQ==
=Qk/K
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--

