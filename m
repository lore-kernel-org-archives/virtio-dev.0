Return-Path: virtio-comment-return-1476-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 28 Oct 2020 07:27:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201028072253-mutt-send-email-mst@kernel.org>
References: <5d3d8a27893734be954ebbe560f638fbafb3429c.1603778046.git.jie.deng@intel.com>
 <20201027081406-mutt-send-email-mst@kernel.org>
 <752795c8-868a-add0-30c0-9d34e542140c@intel.com>
MIME-Version: 1.0
In-Reply-To: <752795c8-868a-add0-30c0-9d34e542140c@intel.com>
Subject: [virtio-comment] Re: [PATCH v3] virtio-i2c: add the device specification
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 28, 2020 at 03:54:39PM +0800, Jie Deng wrote:
>=20
> On 2020/10/27 20:20, Michael S. Tsirkin wrote:
> > On Tue, Oct 27, 2020 at 02:00:24PM +0800, Jie Deng wrote:
> > > virtio-i2c is a virtual I2C adapter device. It provides a way
> > > to =EF=AC=82exibly communicate with the I2C slave devices from the gu=
est.
> > >=20
> > > This patch adds the specification for this device.
> > >=20
> > > Signed-off-by: Jie Deng<jie.deng@intel.com>
> > > ---
> > >   conformance.tex | 28 ++++++++++++++---
> > >   content.tex     |  1 +
> > >   virtio-i2c.tex  | 94 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   3 files changed, 119 insertions(+), 4 deletions(-)
> > >   create mode 100644 virtio-i2c.tex
> > >=20
> > > +The driver queues requests to the virtqueue, and they are used by th=
e
> > > +device. The request is the representation of one segment of an I2C
> > > +transaction. Each request is of form:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_i2c_req {
> > > +        le16 addr;
> > > +        le16 flags;
> > > +        le16 len;
> > > +        u8 buf[];
> > > +        u8 status;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The \field{addr} is the address of the I2C slave device.
> > > +
> > > +The first bit of \field{flags} indicates whether it is a read or wri=
te request.
> > > +It means a read request if the first bit of \field{flags} is set, ot=
herwise
> > > +it is a write request. The rest bits of \field{flags} are reserved.
> > > +
> > > +The \field{len} is the number of data bytes in the \field{buf} being=
 read from or
> > > +written to the I2C slave address.
> > > +
> > > +The \field{buf} of the request contains one segment of an I2C transa=
ction.
> > > +If the first bit of \field{flags} is '1', the \field{buf} is written=
 by the
> > > +device and it contains one segment of an I2C transaction being read =
from the
> > > +device.
> > Let's give a name to the flag then? READ I guess?
> > I guess this means it's an exact reverse of the write-only/read-only
> > flag in the descriptor?
> > I still think it's both a potential source of errors and a waste
> > to have this bit in the device struct when we have a generic one.
> >=20
> > How about adding some motivation to explain why it's done
> > like this?
> Hmm... It seems the description here is a bit unsatisfactory. I don't mea=
n
> to use this flag
> to play the role of that flag of the descriptor. I just want to encapsula=
te
> all the i2c_msg fields
> into the request for I2C use. The flag in the descriptor is defined from
> virtio perspective
> while the flag in this request is defined from I2C perspective.
> It may be necessary to reverse the cause and effect:
>=20
> It seems better to say "If it is a write request (write descriptor), then
> the first bit of the flag in the request should be set to 0."
> than "the first bit of the flag in the request is 0, then it is a write
> request (write descriptor)".
>=20
> I will try to add more description to make it looks better.
>=20
> Thanks.


I think it's better to have the device take it from the virtio descriptor t=
hough.
Duplicating info just causes bugs ...

>=20
>=20
> > > If the first bit of \field{flags} is '0', the \field{buf} is written
> > > +by the driver and it contains one segment of an I2C transaction bein=
g written
> > > +to the the device.
> > one the?
> >=20
> Right. Thanks for your careful review.
>=20
>=20
> > more detail on how are multi-segment transactions formed?
> > don't you need flags to start/stop?
> >=20
> Currently, it is designed to simply transparently transmit
> the "i2c_msg messages" from the frontend OS kernel to the backend.

From spec perspective we don't really care. We also don't
assume driver and device are using linux.

> No need to tag the start/stop segment.
>=20
> Thanks.



i2c_msg has flags to signal start/stop of multi-segment transactions.


> >=20
> > > +The final \field{status} byte is written by the device: either VIRTI=
O_I2C_MSG_OK
> > > +for success or VIRTIO_I2C_MSG_ERR for error.
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_I2C_MSG_OK     0
> > > +#define VIRTIO_I2C_MSG_ERR    1
> > > +\end{lstlisting}
> > what if one segment in a transaction fails?
>=20
> The driver shall return the number of segments successfully processed.
>=20
> Thanks.

where would it return it?

> > > +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2=
C Adapter Device / Device Operation}
> > > +
> > > +A driver MUST set \field{addr}, \field{flags} and \field{len} before=
 sending
> > > +the request.
> > > +
> > > +A driver MUST place one segment of an I2C transaction into \field{bu=
f} if the
> > > +first bit of \field{flags} is '0'.
> > > +
> > > +A driver MUST NOT use \field{addr}, \field{flags}, \field{len} and \=
field{buf}
> > > +if the final \field{status} returned from the device is VIRTIO_I2C_M=
SG_ERR.
> > > +
> > > +A driver MUST queue the requests in order if multiple requests are g=
oing to
> > > +be sent at a time.
> > > +
> > > +\devicenormative{\subsubsection}{Device Operation}{Device Types / I2=
C Adapter Device / Device Operation}
> > > +
> > > +A device MUST NOT change the value of \field{addr}, \field{flags} an=
d \field{len}.
> > > +
> > > +A device MUST place one segment of an I2C transaction into \field{bu=
f} if the first
> > > +bit of \field{flags} is '1'.
> > > +
> > > +A device MUST guarantee the requests being handled in order if multi=
ple requests
> > > +are received.
> > > --=20
> > > 2.7.4


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

