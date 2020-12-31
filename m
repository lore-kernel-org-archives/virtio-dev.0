Return-Path: virtio-comment-return-1617-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 31 Dec 2020 12:42:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20201231124242.GA134901@stefanha-x1.localdomain>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
 <20201229110934.GA55616@stefanha-x1.localdomain>
 <b6267b12-4026-ec9b-5bec-155246b1cc00@intel.com>
 <20201230102037.GA87700@stefanha-x1.localdomain>
 <e5b8e645-083f-638a-69cc-f1b01c7a4dd0@intel.com>
MIME-Version: 1.0
In-Reply-To: <e5b8e645-083f-638a-69cc-f1b01c7a4dd0@intel.com>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 31, 2020 at 10:50:13AM +0800, Jie Deng wrote:
>=20
> On 2020/12/30 18:20, Stefan Hajnoczi wrote:
> > On Wed, Dec 30, 2020 at 10:17:23AM +0800, Jie Deng wrote:
> > > On 2020/12/29 19:09, Stefan Hajnoczi wrote:
> > >=20
> > > > On Thu, Dec 24, 2020 at 04:10:43PM +0800, Jie Deng wrote:
> > > > > +The \field{padding} is used to pad to full dword.
> > > > > +
> > > > > +The \field{flags} of the request is currently reserved as zero f=
or future
> > > > > +feature extensibility.
> > > > > +
> > > > > +The \field{write_buf} of the request contains one segment of an =
I2C transaction
> > > > > +being written to the device.
> > > > > +
> > > > > +The \field{read_buf} of the request contains one segment of an I=
2C transaction
> > > > > +being read from the device.
> > > > > +
> > > > > +The final \field{status} byte of the request is written by the d=
evice: either
> > > > > +VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
> > > > > +
> > > > > +\begin{lstlisting}
> > > > > +#define VIRTIO_I2C_MSG_OK     0
> > > > > +#define VIRTIO_I2C_MSG_ERR    1
> > > > > +\end{lstlisting}
> > > > > +
> > > > > +If ``length of \field{read_buf}''=3D0 and ``length of \field{wri=
te_buf}''>0,
> > > > > +the request is called write request.
> > > > > +
> > > > > +If ``length of \field{read_buf}''>0 and ``length of \field{write=
_buf}''=3D0,
> > > > > +the request is called read request.
> > > > > +
> > > > > +If ``length of \field{read_buf}''>0 and ``length of \field{write=
_buf}''>0,
> > > > > +the request is called write-read request. It means an I2C write =
segment followed
> > > > > +by a read segment. Usually, the write segment provides the numbe=
r of an I2C
> > > > > +controlled device register to be read.
> > > > > +
> > > > > +The case when ``length of \field{write_buf}''=3D0, and at the sa=
me time,
> > > > > +``length of \field{read_buf}''=3D0 doesn't make any sense.
> > > > > +
> > > > > +\subsubsection{Device Operation: Operation Status}\label{sec:Dev=
ice Types / I2C Adapter Device / Device Operation: Operation Status}
> > > > > +
> > > > > +\field{addr}, ``length of \field{write_buf}'' and ``length of \f=
ield{read_buf}''
> > > > > +are determined by the driver, while \field{status} is determined=
 by the processing
> > > > > +of the devcie. A driver puts the data written to the device into=
 \field{write_buf}, while
> > > > s/devcie/device/
> > > Will fix this typo.
> > > > > +a device puts the data of the corresponding length into \field{r=
ead_buf} according the
> > > > > +request of the driver.
> > > > > +
> > > > > +A driver may send one request or multiple requests to the device=
 at a time.
> > > > > +The requests in the virtqueue are both queued and processed in o=
rder.
> > > > > +
> > > > > +If a driver sends multiple requests at a time and a device fails=
 to process
> > > > > +some of them, then the first failed request will have its \field=
{status}
> > > > > +being set to VIRTIO_I2C_MSG_ERR by the device and the requests a=
fter the first
> > > > > +failed one will also be treated as VIRTIO_I2C_MSG_ERR by the dri=
ver,
> > > > > +no matter what \field{status} of them. In this case, the number =
of successfully
> > > > > +sent requests this time is the number of the last request being =
successfully
> > > > > +processed.
> > > > If I understand correctly all requests submitted in a single availa=
ble
> > > > buffer notification are grouped together. Once the first request fa=
ils
> > > > the driver must treat all remaining requests as failed?
> > > Right. That's how it works.
> > > > Devices may poll vrings instead of using available buffer notificat=
ions.
> > > > Polled devices cannot provide the grouping semantics described abov=
e.
> > > Poll is not recommended for this device. But if poll is used, the dev=
ice
> > > must notify
> > > the driver once it encounters an error request.
> > >=20
> > > So if poll is used and the virtqueue has following requests (May be
> > > submitted by many kick operation, no need to group)
> > >=20
> > > Y Y Y Y N X X X X
> > >=20
> > > (Y: OK,=C2=A0=C2=A0 N: error,=C2=A0=C2=A0 X: no need to care about, m=
ust be treated as error.)
> > >=20
> > > The device must notify=C2=A0 the driver at the first "N" and driver m=
ust treat
> > > the N and "X X X X" as error.
> > >=20
> > > > If you want to group requests then it is necessary to include a
> > > > per-request group ID or continuation/end-of-group field. virtio-net
> > > > VIRTIO_NET_F_MRG_RXBUF is an example of this.
> > > >=20
> > > > Additionally, this paragraph does not specify whether the device
> > > > executes the remaining requests or not. This seems problematic to m=
e
> > > > because the driver does not know which requests actually executed w=
hen
> > > > a request in a group of requests fails?
> > > The device must not execute the remaining requests.
> > Please add that to the spec so it's clear the device must fail remainin=
g
> > requests insteads of attempting to execute them.
> Sure. Will do that.
> > This approach causes a bottleneck when there are multiple I2C devices.
> > It requires exclusive access to the virtqueue and virtual I2C bus,
> > slowing down applications that are accessing separate I2C devices.
> >=20
> > This is inefficient, especially if the I2C devices are emulated or on
> > separate physical I2C busses where request concurrent processing is
> > possible.
> >=20
> > This also creates starvation/denial-of-service problems in the driver
> > because an application can submit many requests and needs exclusive
> > access to the virtqueue until all requests have completed.
> >=20
> > I suggest defining a VIRTIO_I2C_FLAGS_CONTINUATION bit in struct
> > virtio_i2c_out_hdr::flags. When a request fails and this flag is set
> > then the device fails all later requests until it reaches a request
> > where the flag is zero. This allows the driver to enqueue a sequence of
> > requests that fail as a group without waiting for an empty virtqueue.
> The flags is designed to be a "driver->device" field for extensibility. I=
t
> is read-only=EF=BF=BD to the device.
> So when a request fails, the device can't set this read-only field.

Sorry, "and this flag is set" means "and this flag was set by the
driver". My intention was that the driver marks a request so the device
knows that it needs to fail the next request too when this request
fails.

Thinking about it again, VIRTIO_I2C_FLAGS_FAIL_NEXT would be a clearer
name for this flag.

> We just need to make sure that once the driver adds some requests to the
> virtqueue,
> it should complete them (either success or fail) before adding new reques=
ts.
> I think this
> is a behavior of physical I2C adapter drivers and we can follow.

Existing VIRTIO devices do not have special empty queue semantics and I
don't think virtio-i2c should introduce a special case here. The
VIRTIO_I2C_FLAGS_FAIL_NEXT flag is simple to implement, allows drivers
more freedom to enqueue requests, and eliminates the race condition with
polled device implementations (they could complete failed request #1
before request #2 is enqueued and then request #2 would not be
automatically failed).

Stefan

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/tx0IACgkQnKSrs4Gr
c8hnggf+OyZKqYP5ofCYd6ccgzGsTxvrQRDxObmWU4zP8ZcUev0lHNxgwu5pQucs
4hgp+Rh08FzAlqpsn2xpnugF/nN9DOZQRZ/bgtTce/RktmgUS/EHIyJLXuZvm/LN
uRrTpW++ysVLfBY/NKXWaH1ahaLFruvLQPSVygskR/r/yqZJWtHRnFPtZ7y3giQa
vrge3qzgbx6VzOoAiRl8SnnGt7fzkMrPSE3e5QdGSHRcgiQH12Hbm2NHaZV2pTJk
O//9F98785MJLsM6K7aOytx+dnwgB70ukXaDaTgrlcT0/arrSQz5y1UlNATOmPDm
c5i9PxHECCo3+F4HEPoXLRmLAvN3fA==
=xgVL
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

