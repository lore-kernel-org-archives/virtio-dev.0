Return-Path: virtio-comment-return-1563-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 17 Dec 2020 10:43:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20201217104348.GH4338@stefanha-x1.localdomain>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216155218.GA720702@stefanha-x1.localdomain>
 <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
MIME-Version: 1.0
In-Reply-To: <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaoouwwPWoQSJZYp"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--jaoouwwPWoQSJZYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2020 at 03:08:07PM +0800, Jie Deng wrote:
>=20
> On 2020/12/16 23:52, Stefan Hajnoczi wrote:
> > On Wed, Nov 25, 2020 at 01:55:18PM +0800, Jie Deng wrote:
> > > diff --git a/virtio-i2c.tex b/virtio-i2c.tex
> > > new file mode 100644
> > > index 0000000..fdb0050
> > > --- /dev/null
> > > +++ b/virtio-i2c.tex
> > > @@ -0,0 +1,139 @@
> > > +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter De=
vice}
> > > +
> > > +virtio-i2c is a virtual I2C adapter device. It provides a way to fle=
xibly
> > > +organize and use the host I2C slave devices from the guest. By attac=
hing
> > > +the host ACPI I2C slave nodes to the virtual I2C adapter device, the=
 guest can
> > > +communicate with them without changing or adding extra drivers for t=
hese
> > > +slave I2C devices.
> > Is there a way to identify I2C busses if more than one virtio-i2c devic=
e
> > is present? For example, imagine a host with 2 I2C busses. How does the
> > guest know which virtio-i2c device connects to which host bus?
> This virtio-i2c is a master device. The slave devices attached to it can =
be
> configured
> by the backend in the host. These slave devices can be under different ho=
st
> I2C master devices.
> The guest will see this virtio-i2c master device and its slave devices.

There could still be multiple virtio-i2c devices. I guess the guest can
use the device's bus address (e.g. virtio-pci address, virtio-mmio base
address, etc) to differentiate (e.g. guest udev rules).

No changes to the spec are needed here.

> >=20
> > > +\begin{lstlisting}
> > > +struct virtio_i2c_req {
> > > +        le16 addr;
> > > +        le32 flags;
> > What is the memory layout?
> >=20
> > 1. 0x0 addr, 0x2 flags
> >=20
> > or
> >=20
> > 2. 0x0 addr, 0x4 flags
> >=20
> > This is unclear to me. I don't see a general statement in the spec abou=
t
> > struct field alignment/padding and no details in this new spec change.
>=20
> Both are OK to me. I used to use "packed" but Michael said there was no n=
eed
> to pack it.
>=20
> https://lkml.org/lkml/2020/9/3/339
>=20
> So you prefer it to be clear ?

Packing wasn't necessary because all fields were aligned in that patch:

  struct virtio_i2c_hdr {
    __virtio16 addr;
    __virtio16 flags;
    __virtio16 len;
  } __packed;

The struct virtio_i2c_req definition in the virtio spec patch is not
naturally aligned though. There are a few options: the fields can be
reordered to achieve that, explicit padding fields can be introduced, or
it can be explicitly marked packed.

That way the memory layout will be clear for anyone wishing to implement
the spec.

> > > +        le16 written;
> > > +        le16 read;
> > > +        u8 write_buf[];
> > > +        u8 read_buf[];
> > > +        u8 status;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The \field{addr} of the request is the address of the I2C slave devi=
ce.
> > https://en.wikipedia.org/wiki/I2c#Addressing_structure suggests there
> > are at least 7-bit and 10-bit addressing schemes in I2C. How does this
> > map to the little-endian 16-bit addr field?
>=20
> This field maps to the kernel struct "i2c_msg.addr".
>=20
> struct virtio_i2c_req  *vmsg;
> struct i2c_msg *msg;
>=20
> vmsg->addr  =3D cpu_to_le16(msg->addr);
>=20
> The field in the request can be seen as host byte order
> while the link can be seen as the I2C network byte order.
> The host driver may take care thisconversion.

Please include a description in the spec of how to represent 7-bit and
10-bit I2C addresses as defined by the I2C spec in the le16 addr field.

The other option would be to refer to Linux as you did in your reply,
but nothing else in this device seems Linux-specific so let's avoid the
reference. That way the vitio-i2c spec will be more general and easy to
implement by people who are unfamiliar with Linux.

--jaoouwwPWoQSJZYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/bNmQACgkQnKSrs4Gr
c8gHNwf/faMssqwQi2R++SR+rXwdjqFahK5fz1Wjm89PPUrz8gB3mTAfevfxjHzU
9H9VqGagNRRddln1wDe+fqIsOYifI5a4F84fk6zFOFfBf3M6FcM9dYVq3KXt6PZi
Qd4y6qNp6sZBDom8qNLvCf6Rf839d0WNOyBCRbirTqd9ikfyT2G7/PzFE5mhgjlp
jxIhd8ck6As2PEWfU4kP450pQFrS2d1d+y2w96zf4avFGEmHlj1kVCK6iCtbL8zw
COEkv3APYJYcwBFFv4IeSfMqn5s/NH8FssZtmk1vyxSmOxTLsGJTq2iQ3efWiTll
+J+i4byiOs1UlNoJiI5cGykH0Tr+WA==
=HJrX
-----END PGP SIGNATURE-----

--jaoouwwPWoQSJZYp--

