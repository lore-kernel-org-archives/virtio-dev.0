Return-Path: <virtio-comment-return-3101-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sat, 4 Jun 2022 09:18:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YpsVPbbBHhX+xZW9@stefanha-x1.localdomain>
References: <20220601235559.41091-1-dmitry.fomichev@wdc.com>
 <Yphlet2cKT9ySAay@stefanha-x1.localdomain>
 <bf9ea224c637ce7f202418359ac96a6a182f45bb.camel@wdc.com>
 <YpnBi++zhJ/lXhDk@stefanha-x1.localdomain>
 <c4455f2ed87b7ed11b03851c0dac6d3e68ffe92a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fN8tM8LGQrcx/7x+"
Content-Disposition: inline
In-Reply-To: <c4455f2ed87b7ed11b03851c0dac6d3e68ffe92a.camel@wdc.com>
Subject: [virtio-comment] Re: [virtio-dev] [RFC PATCH] virtio-blk: add zoned block device
 specification
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Cc: "its@irrelevant.dk" <its@irrelevant.dk>, "hare@suse.de" <hare@suse.de>, Niklas Cassel <Niklas.Cassel@wdc.com>, Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Hans Holmberg <Hans.Holmberg@wdc.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "faithilikerun@gmail.com" <faithilikerun@gmail.com>, "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>, "stefanha@gmail.com" <stefanha@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--fN8tM8LGQrcx/7x+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 04, 2022 at 12:09:46AM +0000, Dmitry Fomichev wrote:
> On Fri, 2022-06-03 at 09:08 +0100, Stefan Hajnoczi wrote:
> > (Resent from my subscriber email.)
> >=20
> > On Fri, 3 Jun 2022 at 03:30, Dmitry Fomichev <Dmitry.Fomichev@wdc.com> =
wrote:
> > >=20
> > > On Thu, 2022-06-02 at 08:23 +0100, Stefan Hajnoczi wrote:
> > > > (Resending from my mailing list subscriber address so this makes it=
 onto
> > > > the list.)
> > > >=20
> > > > On Thu, 2 Jun 2022 at 00:56, Dmitry Fomichev <dmitry.fomichev@wdc.c=
om>
> > > > wrote:
> > > > Here is the non-union representation of the structs. Note that this
> > > > means existing request processing code can handle IN/OUT/FLUSH even
> > > > when VIRTIO_BLK_F_ZONED is negotiated. We don't need two different
> > > > code paths for these common commands:
> > > >=20
> > > > /* IN/OUT/FLUSH/DISCARD/WRITE_ZEROES */
> > > > struct virtio_blk_req {
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 type;
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 reserved;
> > > > =A0=A0=A0=A0=A0=A0=A0 le64 sector;
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 data[];
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 status;
> > > > };
> > > >=20
> > > > /* ZONE_APPEND */
> > > > struct virtio_blk_req_zone_append {
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 type;
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 reserved;
> > > > =A0=A0=A0=A0=A0=A0=A0 le64 sector;
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 data[];
> > > > =A0=A0=A0=A0=A0=A0=A0 le64 zone_result;
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 status;
> > > > };
> > > >=20
> > > > /* ZONE_OPEN, ZONE_CLOSE, ZONE_FINISH, ZONE_RESET */
> > > > struct virtio_blk_req_zone_mgmt_send {
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 type;
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 reserved;
> > > > =A0=A0=A0=A0=A0=A0=A0 le64 sector;
> > > > =A0=A0=A0=A0=A0=A0=A0 /* ALL zone operation flag */
> > > > =A0=A0=A0=A0=A0=A0=A0 __u8 all;
> > > > =A0=A0=A0=A0=A0=A0=A0 __u8 unused1[3];
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 data[];
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 status;
> > > > };
> > > >=20
> > > > /* ZONE_REPORT */
> > > > struct virtio_blk_req_zone_mgmt_receive {
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 type;
> > > > =A0=A0=A0=A0=A0=A0=A0 le32 reserved;
> > > > =A0=A0=A0=A0=A0=A0=A0 le64 sector;
> > > > =A0=A0=A0=A0=A0=A0=A0 /* Partial zone report flag */
> > > > =A0=A0=A0=A0=A0=A0=A0 __u8 partial;
> > > > =A0=A0=A0=A0=A0=A0=A0 __u8 unused2[3];
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 data[];
> > > > =A0=A0=A0=A0=A0=A0=A0 u8 status;
> > > > };
> > >=20
> > > We felt that it is less confusing to have a single ZBD request struct=
ure so
> > > there
> > > is 1:1 relationship between the VIRTIO_BLK_F_ZONED bit value and the =
choice
> > > of
> > > the request -
> > >=20
> > > VIRTIO_BLK_F_ZONED off ->=A0 virtio_blk_req
> > > VIRTIO_BLK_F_ZONED on ->=A0 virtio_blk_zoned_req
> > >=20
> > > We also want to make sure that zone management/send/receive and append
> > > requests
> > > are always the same size and it should be easier with a single request
> > > structure.
> > >=20
> > > It is possible to use a simpler, but less structured union here -
> > >=20
> > > struct virtio_blk_zoned_req {
> > > =A0=A0=A0=A0=A0=A0=A0 le32 type;
> > > =A0=A0=A0=A0=A0=A0=A0 le32 reserved;
> > > =A0=A0=A0=A0=A0=A0=A0 le64 sector;
> > > =A0=A0=A0=A0=A0=A0=A0 union zoned_params {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* ALL zone operation f=
lag */
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __u8 all;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Partial zone report =
flag */
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __u8 partial;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __u32 rsvd1;
> > > =A0=A0=A0=A0=A0=A0=A0 } zone;
> > > =A0=A0=A0=A0=A0=A0=A0 u8 data[];
> > > =A0=A0=A0=A0=A0=A0=A0 le64 zone_result;
> > > =A0=A0=A0=A0=A0=A0=A0 u8 reserved1[3];
> > > =A0=A0=A0=A0=A0=A0=A0 u8 status;
> > > }
> > >=20
> > > Using the single code path is very important and the PoC Linux driver=
 code
> > > that I
> > > have sketched up achieves that. Since the request header is identical=
 for the
> > > both cases, I hope that it can be done in QEMU too.
> >=20
> > There are two possibilities for optimizing the request layout:
> > 1. For drivers and devices that implement both !VIRTIO_BLK_F_ZONED and
> > VIRTIO_BLK_F_ZONED. Here it's best to share the same request layout
> > for commands available in both modes. In other words IN and OUT
> > requests to zoned devices should use struct virtio_blk_req so code can
> > be shared and only commands unique to zoned devices use struct
> > virtio_blk_zoned_req.
> > 2. For drivers and devices that implement only one of
> > !VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_ZONED. Here consistent request
> > layout is best so the code parses all commands in the same way. In
> > other words, IN and OUT requests to zoned devices use struct
> > virtio_blk_zoned_req so that the implementation doesn't have to bother
> > with struct virtio_blk_req at all.
> >=20
> > I think you chose #2 and I gravitated towards #1. Which one is optimal
> > depends on the use case. Feel free to stick with #2.
> >=20
>=20
> OK. We certainly considered #1, but we found that in Linux virtio-blk dri=
ver
> implementation, the request size is fixed. There is the member called vbl=
k-
> >tag_set.cmd_size and it is set to sizeof(struct virtblk_req) + <sg list =
size> as
> a part of the device scan routine. Since the Zone Append request has to b=
e larger
> than the regular (non-zoned) one by at least 8 bytes to accommodate the A=
LBA
> field, we can't mix and match the two for the same device. Here is how th=
is
> device initialization part can be modified to handle the VIRTIO_BLK_F_ZON=
ED
> feature bit if we stick with #2 -
>=20
>=20
> @@ -810,13 +1287,18 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>         }
> =20
>         memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> -       vblk->tag_set.ops =3D &virtio_mq_ops;
>         vblk->tag_set.queue_depth =3D queue_depth;
>         vblk->tag_set.numa_node =3D NUMA_NO_NODE;
>         vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
> -       vblk->tag_set.cmd_size =3D
> -               sizeof(struct virtblk_req) +
> -               sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> +       if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +               vblk->tag_set.ops =3D &virtio_mq_zoned_ops;
> +               vblk->tag_set.cmd_size =3D sizeof(struct virtblk_zoned_re=
q);
> +       } else {
> +               vblk->tag_set.ops =3D &virtio_mq_ops;
> +               vblk->tag_set.cmd_size =3D sizeof(struct virtblk_req);
> +       };
> +       vblk->tag_set.cmd_size +=3D
> +                       sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG=
_CNT;
>         vblk->tag_set.driver_data =3D vblk;
>         vblk->tag_set.nr_hw_queues =3D vblk->num_vqs;

I've included a #1 solution below in case you like it. cmd_size doesn't
need to be changed, sizeof(struct virtblk_req) is fine. Here is struct
virtblk_req extended to handle the ALBA field:

  struct virtblk_req {
      struct virtio_blk_outhdr out_hdr;
+     struct {
+             __virtio64 alba;
+             u8 status;
+     } in;
-     u8 status;
      struct sg_table sg_table;
      struct scatterlist sg[];
  };

The in struct could also be a union of several structs. I kept it simple
assuming just one request (ZONE_APPEND) has additional device-to-driver
(in) fields.

The request layout variation is taken into account when building the
virtqueue scatterlist:

  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
-         struct scatterlist *data_sg, bool have_data)
+         struct scatterlist *data_sg, bool have_data, bool have_alba)
  {
-     struct scatterlist hdr, status, *sgs[3];
+     struct scatterlist hdr, in, *sgs[3];
      unsigned int num_out =3D 0, num_in =3D 0;

      sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
      sgs[num_out++] =3D &hdr;

      if (have_data) {
          if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OU=
T))
              sgs[num_out++] =3D data_sg;
          else
              sgs[num_out + num_in++] =3D data_sg;
      }

+     if (have_alba)
+         sg_init_one(&in, &vbr->in, sizeof(vbr->in));
+     else
+         sg_init_one(&in, &vbr->in.status, sizeof(vbr->in.status));
+     sgs[num_out + num_in++] =3D &in;
-     sg_init_one(&status, &vbr->status, sizeof(vbr->status));
-     sgs[num_out + num_in++] =3D &status;

      return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
  }

--fN8tM8LGQrcx/7x+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKbFT0ACgkQnKSrs4Gr
c8gYpQf/VUvTv157LWQteFe0CpPXwimN9lSEtUfVFMzFAwB1X4aTA3IQyUoNxnCU
ZLqgStXl3uH6xuEJv1Xk0fHw/bj49VMEr0gkvTKBU/fkQO0VjG3pfSTa5ajRwH54
zL0p5KEEJhQpD44kk8tT8GFz5iMD/J6iAf65IBPVjx4mjLR1giuPKlOpEPKUQpK2
TPEJ1G2APDxl91YMbzDsGLMaID/NXyABhzBzdbZ0ACxVvJxZMXvSodMl+M1HnL99
rVWXeDCG8O8nmFFuLxTGcQC/FGEQARN4pg4hT5ypbxa7qZJdKvM0JpHQhsRNoC0d
9eSDCSNH5COQvSpCGD1pc22DDhSutg==
=cVU0
-----END PGP SIGNATURE-----

--fN8tM8LGQrcx/7x+--

