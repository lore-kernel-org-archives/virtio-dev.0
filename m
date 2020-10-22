Return-Path: virtio-comment-return-1464-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 22 Oct 2020 08:15:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201022081313-mutt-send-email-mst@kernel.org>
References: <7e62cac21047d1692edea06c1fd917faea53087f.1600742717.git.jie.deng@intel.com>
 <20201021080250-mutt-send-email-mst@kernel.org>
 <0525fa7b-fdb4-fb8d-dac7-7aad143fc380@intel.com>
MIME-Version: 1.0
In-Reply-To: <0525fa7b-fdb4-fb8d-dac7-7aad143fc380@intel.com>
Subject: Re: [virtio-comment] [PATCH] virtio-i2c: add the device specification
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 22, 2020 at 03:45:16PM +0800, Jie Deng wrote:
> On 2020/10/21 20:08, Michael S. Tsirkin wrote:
>=20
> > On Tue, Sep 22, 2020 at 10:49:02AM +0800, Jie Deng wrote:
> >=20
> > +
> > +The first bit of \field{flags} indicates whether it is a read or write=
 request.
> > +It mesns a read request if the first bit of \field{flags} is set, othe=
rwise
> >=20
> > means
>=20
> I will fix this typo. Thank you.
>=20
> > > +it is a write request. The rest bits of \field{flags} are reserved.
> > Do we really need this flg? write request is just a big write followed =
by 1
> > byte read, read request is write read 1 byte read.
> The "addr", "flags", "len" and "buf" are all from Linux kernel structure
> "struct i2c_msg".
> This design may help the backend driver to extract "struct i2c_msg" from
> "struct virtio_i2c_req" easily.
>=20
> The "flags" has many bits been defined in I2C. It is no mere an
> identification for
> read/write. Although, currently, we only used the first bit, we may use
> other bits
> for feature extension in the future. So I think it's necessary to keep it=
.
>=20
> Thanks.

It's ok to reserve 2 bytes for now.




>=20
> >=20
> >=20
> > > +The \field{len} of the request indicates the length of the I2C messa=
ge.
> > > +
> > > +The \field{buf} of the request contains the I2C message. If the firs=
t bit of
> > > +\field{flags} is '1', the \field{buf} is written by the device and i=
t contains
> > > +the message read from the device. If the first bit of \field{flags} =
is '0', the
> > > +\field{buf} is written by the driver and it contains the message wri=
tten to the
> > > +the device.
> > > +
> > > +The final \field{status} byte is written by the device: either VIRTI=
O_I2C_MSG_OK
> > > +for success or VIRTIO_I2C_MSG_ERR for error.
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_I2C_MSG_OK     0
> > > +#define VIRTIO_I2C_MSG_ERR    1
> > > +\end{lstlisting}
> > > +
> > > +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2=
C Adapter Device / Device Operation}
> > > +
> > > +A driver MUST set \field{addr}, \field{flags} and \field{len} before=
 sending
> > > +the message.
> > > +
> > > +A driver MUST place the I2C message into \field{buf} if the first bi=
t of
> > > +\field{flags} is '0'.
> > > +
> > > +A driver MUST NOT use the message if the final \field{status}
> >=20
> > What does "use the message" mean? What message?
> I mean=C2=A0 the "addr", "flags" , "len " and "buf " in "virtio_i2c_req" =
here.
> I will describe it more precisely in v2.
>=20
> Thanks.


Right. For example it is very unclear what does the
buffer map to.  a single i2c_msg? then do we not need STOP
etc etc ... ?


> > > return from the
> > > +device is VIRTIO_I2C_MSG_ERR.
> > returned?
>=20
> I will fix this typo. Thank you.
>=20
>=20
> > > +
> > > +\devicenormative{\subsubsection}{Device Operation}{Device Types / I2=
C Adapter Device / Device Operation}
> > > +
> > > +A device MUST NOT change the value of \field{addr}, \field{flags} an=
d \field{len}.
> >=20
> >=20
> > > +
> > > +A device MUST place the message into \field{buf} if the first bit of=
 \field{flags}
> > > +is '1'.
> >=20
> > again, what the message?
> >=20
> Here is the I2C message. I will describe it more precisely in v2.
>=20
> Thanks.


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

