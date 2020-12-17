Return-Path: virtio-comment-return-1560-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 17 Dec 2020 03:00:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201217030015-mutt-send-email-mst@kernel.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216155218.GA720702@stefanha-x1.localdomain>
 <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
MIME-Version: 1.0
In-Reply-To: <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 17, 2020 at 03:08:07PM +0800, Jie Deng wrote:
>=20
> On 2020/12/16 23:52, Stefan Hajnoczi wrote:
>=20
>     On Wed, Nov 25, 2020 at 01:55:18PM +0800, Jie Deng wrote:
>=20
>         diff --git a/virtio-i2c.tex b/virtio-i2c.tex
>         new file mode 100644
>         index 0000000..fdb0050
>         --- /dev/null
>         +++ b/virtio-i2c.tex
>         @@ -0,0 +1,139 @@
>         +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapte=
r Device}
>         +
>         +virtio-i2c is a virtual I2C adapter device. It provides a way to=
 flexibly
>         +organize and use the host I2C slave devices from the guest. By a=
ttaching
>         +the host ACPI I2C slave nodes to the virtual I2C adapter device,=
 the guest can
>         +communicate with them without changing or adding extra drivers f=
or these
>         +slave I2C devices.
>=20
>     Is there a way to identify I2C busses if more than one virtio-i2c dev=
ice
>     is present? For example, imagine a host with 2 I2C busses. How does t=
he
>     guest know which virtio-i2c device connects to which host bus?
>=20
> This virtio-i2c is a master device. The slave devices attached to it can =
be
> configured
> by the backend in the host. These slave devices can be under different ho=
st I2C
> master devices.
> The guest will see this virtio-i2c master device and its slave devices.
>=20
> There is a example about the backend which shows how it works
>=20
> https://projectacrn.github.io/latest/developer-guides/hld/virtio-i2c.html=
?
> highlight=3Di2c
> https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/hw=
/pci/
> virtio/virtio_i2c.c
>=20
>=20
>=20
>         +\begin{lstlisting}
>         +struct virtio_i2c_req {
>         +        le16 addr;
>         +        le32 flags;
>=20
>     What is the memory layout?
>=20
>     1. 0x0 addr, 0x2 flags
>=20
>     or
>=20
>     2. 0x0 addr, 0x4 flags
>=20
>     This is unclear to me. I don't see a general statement in the spec ab=
out
>     struct field alignment/padding and no details in this new spec change=
.
>=20
> Both are OK to me. I used to use "packed" but Michael said there was no n=
eed to
> pack it.=C3=82=C2=A0
>=20
> https://lkml.org/lkml/2020/9/3/339
>=20
> So you prefer it to be clear ?
>=20
>         +        le16 written;
>         +        le16 read;
>         +        u8 write_buf[];
>         +        u8 read_buf[];
>         +        u8 status;
>         +};
>         +\end{lstlisting}
>         +
>         +The \field{addr} of the request is the address of the I2C slave =
device.
>=20
>     https://en.wikipedia.org/wiki/I2c#Addressing_structure suggests there
>     are at least 7-bit and 10-bit addressing schemes in I2C. How does thi=
s
>     map to the little-endian 16-bit addr field?
>=20
> This field maps to the kernel struct "i2c_msg.addr".
>=20
> struct virtio_i2c_req *vmsg;
> struct i2c_msg *msg;
>=20
> vmsg->addr =3D cpu_to_le16(msg->addr);
>=20
> The field in the request can be seen as host byte order
> while the link can be seen as the I2C network byte order.
> The host driver may take care this conversion.
>=20
>         +The \field{flags} of the request is currently reserved as zero f=
or future
>         +feature extensibility.
>         +
>         +The \field{written} of the request is the number of data bytes i=
n the \field{write_buf}
>         +being written to the I2C slave address.
>=20
>     This field seems redundant since the device can determine the size of
>     write_buf implicitly from the total out buffer size. virtio-blk takes
>     this approach.
>=20
> The read/write are the actual number of data bytes being read from or wri=
tten
> to the device
> which is not determined by the device. So I don't think it is redundant.

I am still not sure I understand the difference.
This point is unclear to multiple people.



>         +The \field{read} of the request is the number of data bytes in t=
he \field{read_buf}
>         +being read from the I2C slave address.
>=20
>     Same here. virtio-blk doesn't use an explicit read size field because
>     the device can determine it.
>=20


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

