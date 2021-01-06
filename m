Return-Path: virtio-comment-return-1621-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 6 Jan 2021 18:04:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20210106180433.GB133350@stefanha-x1.localdomain>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
 <20201229110934.GA55616@stefanha-x1.localdomain>
 <b6267b12-4026-ec9b-5bec-155246b1cc00@intel.com>
 <20201230102037.GA87700@stefanha-x1.localdomain>
 <e5b8e645-083f-638a-69cc-f1b01c7a4dd0@intel.com>
 <20201231124242.GA134901@stefanha-x1.localdomain>
 <f1cb44e5-d952-1d6c-f78c-875b9eb58809@intel.com>
 <20210104180206.GA576705@stefanha-x1.localdomain>
 <386675b0-8eef-c17a-c6be-e7bce1f3f827@intel.com>
MIME-Version: 1.0
In-Reply-To: <386675b0-8eef-c17a-c6be-e7bce1f3f827@intel.com>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2021 at 10:43:38AM +0800, Jie Deng wrote:
>=20
> On 2021/1/5 2:02, Stefan Hajnoczi wrote:
> > On Mon, Jan 04, 2021 at 10:31:48AM +0800, Jie Deng wrote:
> > > On 2020/12/31 20:42, Stefan Hajnoczi wrote:
> > > > > > This approach causes a bottleneck when there are multiple I2C d=
evices.
> > > > > > It requires exclusive access to the virtqueue and virtual I2C b=
us,
> > > > > > slowing down applications that are accessing separate I2C devic=
es.
> > > > > >=20
> > > > > > This is inefficient, especially if the I2C devices are emulated=
 or on
> > > > > > separate physical I2C busses where request concurrent processin=
g is
> > > > > > possible.
> > > > > >=20
> > > > > > This also creates starvation/denial-of-service problems in the =
driver
> > > > > > because an application can submit many requests and needs exclu=
sive
> > > > > > access to the virtqueue until all requests have completed.
> > > > > >=20
> > > > > > I suggest defining a VIRTIO_I2C_FLAGS_CONTINUATION bit in struc=
t
> > > > > > virtio_i2c_out_hdr::flags. When a request fails and this flag i=
s set
> > > > > > then the device fails all later requests until it reaches a req=
uest
> > > > > > where the flag is zero. This allows the driver to enqueue a seq=
uence of
> > > > > > requests that fail as a group without waiting for an empty virt=
queue.
> > > > > The flags is designed to be a "driver->device" field for extensib=
ility. It
> > > > > is read-only=EF=BF=BD to the device.
> > > > > So when a request fails, the device can't set this read-only fiel=
d.
> > > > Sorry, "and this flag is set" means "and this flag was set by the
> > > > driver". My intention was that the driver marks a request so the de=
vice
> > > > knows that it needs to fail the next request too when this request
> > > > fails.
> > > No. A device doesn't need to be told by a driver if it needs to fail =
the
> > > next request.
> > > Actually just the opposite, a driver may need to be notified. A drive=
r can't
> > > know which
> > > one is the "next" because only a device know which request is the fir=
st
> > > failed one.
> > I think we are miscommunicating. The driver is telling the device which
> > requests are grouped together - that is the purpose of the
> > VIRTIO_I2C_FLAGS_FAIL_NEXT flag. When a request fails the device is abl=
e
> > to fail the remaining requests in that group. Requests that are not par=
t
> > of the group won't be failed.
>=20
> So do you mean to mark the first one of each grouped requests ?
>=20
> For example, if a driver kicks twice and the virtqueue has following
> requests.
>=20
> R11 R12 R21 R22 R23
>=20
> (First kick: R11 R12, Second kick: R21 R22 R23)
>=20
> Do you want the driver to set the flags of R11 and R21 to be
> VIRTIO_I2C_FLAGS_FAIL_NEXT ?

The driver clears the VIRTQ_DESC_F_NEXT flag on the final buffer in a
group:

  R11 VIRTIO_I2C_FLAGS_FAIL_NEXT=3D1
  R12 VIRTIO_I2C_FLAGS_FAIL_NEXT=3D0
  R21 VIRTIO_I2C_FLAGS_FAIL_NEXT=3D1
  R22 VIRTIO_I2C_FLAGS_FAIL_NEXT=3D1
  R23 VIRTIO_I2C_FLAGS_FAIL_NEXT=3D0

(This is the same approach as VIRTQ_DESC_F_NEXT in "2.7.6 Next Flag:
Descriptor Chaining".)

Doing it this way allows the device to identify the final buffer in the
group. This is helpful because the device is no longer dependent on
buffer available notifications marking the end of a group. So a poll
mode device could be implemented on systems that don't use interrupts.
Also, if a driver notifies the device before adding the last buffer into
the virtqueue for some reason, then the device will know that the group
isn't finished yet and can wait for the final buffer if it wants.

An alternative is treat the entire group as a single virtqueue buffer
instead of multiple buffers. The virtio-blk
VIRTIO_BLK_T_DISCARD/WRITE_ZEROES commands work like this. The driver
submits a single command for a group of discard/write_zeroes operations.

This would be a big change to your proposal and I'm not sure there is
much of an advantage to doing so, I'm just describing it here in case
you like it better. The request structs would look something like this:

  /* A single read, write, or read+write message */
  struct virtio_i2c_msg {
      le16 addr;      /* I2C device address */
      le16 read_len;  /* number of bytes to read from device */
      le16 write_len; /* number of bytes to write to device */
      le16 flags;     /* reserved */
  };

  struct virtio_i2c_result {
      le16 nread;     /* number of bytes read from device */
      le16 nwritten;  /* number of bytes written to device */
      u8 status;      /* VIRTIO_I2C_MSG_OK or VIRTIO_I2C_MSG_ERR */
      u8 padding;
  };

  struct virtio_i2c_req_out {
      le16 nmsg; /* number of struct virtio_i2c_msg */
  };

The request layout is as follows:

  /* Driver->Device */
  struct virtio_i2c_req_out out;
  struct virtio_i2c_msg msgs[out.nmsg];
  u8 write_buf[];

  /* Device->Driver */
  u8 read_buf[];
  struct virtio_i2c_result results[out.nmsg];

Data in write_buf[] and read_buf[] is arranged in msgs[] order. A
request with 2 write messages of 8 bytes each would look like this:

  write_buf[] =3D {...8 bytes for msgs[0]...,
                 ...8 bytes for msgs[1]...};
  read_buf[] =3D { /* empty */ };

Since virtqueue buffers may consist of many vring descriptors the
write_buf[] and read_buf[] data does not need to be contiguous in
memory.

Stefan

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/1+7EACgkQnKSrs4Gr
c8gFhQf9E3gdsmyQ0eU2TuZfuTUCR+Ysgae/BE11btwvgakeHvABjaQ0LpGXUjT8
ohEMVWL0ZUoOQf5CMmiwUwEDqVBL8jkULC49YsxpP+DET0YXMQwhtaRb286w/gv1
CIFPq7IVmliRFwqZ/zEOCTXYiJPg/6TtCSihu0fB4ssfW8OTAWrW/C6+fsBeXsah
rfjnmUl5IAbrXKnAxbL36KweYTMsr5WQNQyjmXI5Ik+h62+DMgyNCKaNyOLvN5eF
cDvD3RI/CDiON5OZ/zjhC4dZ29MkvqFopoCGUUnQLAKVRqJROEu/CXAHy+Gbs73l
XiL442f+kbFrSq0oOkWpj1+yHoS9FA==
=hhOZ
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

