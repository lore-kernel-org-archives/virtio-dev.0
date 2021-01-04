Return-Path: virtio-comment-return-1619-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 4 Jan 2021 18:02:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20210104180206.GA576705@stefanha-x1.localdomain>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
 <20201229110934.GA55616@stefanha-x1.localdomain>
 <b6267b12-4026-ec9b-5bec-155246b1cc00@intel.com>
 <20201230102037.GA87700@stefanha-x1.localdomain>
 <e5b8e645-083f-638a-69cc-f1b01c7a4dd0@intel.com>
 <20201231124242.GA134901@stefanha-x1.localdomain>
 <f1cb44e5-d952-1d6c-f78c-875b9eb58809@intel.com>
MIME-Version: 1.0
In-Reply-To: <f1cb44e5-d952-1d6c-f78c-875b9eb58809@intel.com>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2021 at 10:31:48AM +0800, Jie Deng wrote:
>=20
> On 2020/12/31 20:42, Stefan Hajnoczi wrote:
> >=20
> > > > This approach causes a bottleneck when there are multiple I2C devic=
es.
> > > > It requires exclusive access to the virtqueue and virtual I2C bus,
> > > > slowing down applications that are accessing separate I2C devices.
> > > >=20
> > > > This is inefficient, especially if the I2C devices are emulated or =
on
> > > > separate physical I2C busses where request concurrent processing is
> > > > possible.
> > > >=20
> > > > This also creates starvation/denial-of-service problems in the driv=
er
> > > > because an application can submit many requests and needs exclusive
> > > > access to the virtqueue until all requests have completed.
> > > >=20
> > > > I suggest defining a VIRTIO_I2C_FLAGS_CONTINUATION bit in struct
> > > > virtio_i2c_out_hdr::flags. When a request fails and this flag is se=
t
> > > > then the device fails all later requests until it reaches a request
> > > > where the flag is zero. This allows the driver to enqueue a sequenc=
e of
> > > > requests that fail as a group without waiting for an empty virtqueu=
e.
> > > The flags is designed to be a "driver->device" field for extensibilit=
y. It
> > > is read-only=EF=BF=BD to the device.
> > > So when a request fails, the device can't set this read-only field.
> > Sorry, "and this flag is set" means "and this flag was set by the
> > driver". My intention was that the driver marks a request so the device
> > knows that it needs to fail the next request too when this request
> > fails.
> No. A device doesn't need to be told by a driver if it needs to fail the
> next request.
> Actually just the opposite, a driver may need to be notified. A driver ca=
n't
> know which
> one is the "next" because only a device know which request is the first
> failed one.

I think we are miscommunicating. The driver is telling the device which
requests are grouped together - that is the purpose of the
VIRTIO_I2C_FLAGS_FAIL_NEXT flag. When a request fails the device is able
to fail the remaining requests in that group. Requests that are not part
of the group won't be failed.

>=20
> Once a device fails to handle a request, it shall fail the existing
> remaining requests
> since these requests needs to be handled in order.
> > Thinking about it again, VIRTIO_I2C_FLAGS_FAIL_NEXT would be a clearer
> > name for this flag.
> >=20
> > > We just need to make sure that once the driver adds some requests to =
the
> > > virtqueue,
> > > it should complete them (either success or fail) before adding new re=
quests.
> > > I think this
> > > is a behavior of physical I2C adapter drivers and we can follow.
> > Existing VIRTIO devices do not have special empty queue semantics and I
> > don't think virtio-i2c should introduce a special case here. The
> > VIRTIO_I2C_FLAGS_FAIL_NEXT flag is simple to implement, allows drivers
> > more freedom to enqueue requests, and eliminates the race condition wit=
h
> > polled device implementations (they could complete failed request #1
> > before request #2 is enqueued and then request #2 would not be
> > automatically failed).
> The I2C core is using a synchronization semantics. It means once a I2C bu=
s
> driver send
> some messages, it should wait for the device to complete them (either
> success or fail)
> before sending new messages. The virtio-i2c driver also have to follow th=
is
> to register it into
> I2C subsystem. So the freedom is already limited by the I2C core, and as =
a
> result, we don't have
> such race conditions.

VIRTIO devices are not specific to Linux so the design should avoid the
limitations of the current Linux driver behavior, if possible. It's easy
to include the VIRTIO_I2C_FLAGS_FAIL_NEXT bit that I described, both in
the spec and in the Linux driver, and it will allow flexibility in the
future.

Stefan

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/zWB4ACgkQnKSrs4Gr
c8gW8wf+L+1dYN7q4yVD/XVefh997kYstusJhwIN9ViHgtYrPrmLBE4bXOkN0UEB
+2z8bX4VnfSY/BMySj6yM1kN5gmsJDLYdXrllqZnitVqVtvNFWUoiQ+/DhYx913W
Tn8XOVr5wsJ+jI9vTeAywKFQrwE5vRiA0y6D1tZ6/KMFY5oKmMKycsB/kh7SVz9C
cSK7VwTtKOr20iwFXjcTv7orxaoCPBDQnllJqnIsK0ICjVYG9xxOsuQGKmwoAULR
2GTLQGa9SVidUJ1ImatAHiqVorlKELuFyxRd/x1tKUnwD+cczE9eRo0G+bZtraIw
ZgqON2ybuJWaGzAjEXTzJgPYaw67ZA==
=0pMC
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

