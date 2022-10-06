Return-Path: <stefanha@redhat.com>
Date: Thu, 6 Oct 2022 11:11:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v6] virtio-blk: add zoned block device
 specification
Message-ID: <Yz7wEeUdVQT3y7u5@fedora>
References: <20220904165601.170769-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F+2TplJk+JzgjBFp"
Content-Disposition: inline
In-Reply-To: <20220904165601.170769-1-dmitry.fomichev@wdc.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Cornelia Huck <cohuck@redhat.com>, Matias Bjorling <matias.bjorling@wdc.com>, Niklas Cassel <niklas.cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--F+2TplJk+JzgjBFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 04, 2022 at 12:56:01PM -0400, Dmitry Fomichev wrote:
> @@ -4746,7 +4930,15 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>          le32 reserved;
>          le64 sector;
>          u8 data[];
> -        u8 status;
> +        union {
> +                u8 status;
> +
> +                struct {
> +                        u8 status;
> +                        u8 reserved[7];
> +                        le64 append_sector;
> +                } zone_append_in_hdr;
> +        };

If a zone append request is sent to a device without VIRTIO_BLK_F_ZONED,
then should the device store VIRTIO_BLK_S_UNSUPP to status or to
zone_append_in_hdr.status?

(I think the answer is status.)

It seems simpler to avoid this problem and instead define:

  struct virtio_blk_zone_append_in_hdr {
      le64 append_sector;
  }

and say that zone append requests have this struct *before* struct
virtio_blk_in_hdr. So the layout is:

  le32 type;
  le32 reserved;
  le64 sector;
  u8 data[];
  le64 append_sector;
  u8 status;

That way the location of the status field does not change, it's always
the last byte.

Stefan

--F+2TplJk+JzgjBFp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmM+8BEACgkQnKSrs4Gr
c8hi6Af7Bz7HCMjdqgtm2lwRxObyicLmKc5Fy2kIIGZqOjgsVLmqaqk4mCBnRzkU
qqCYujzn1yh6XyQRNwIMI7gUzm/J13odooLrsfJrO7qH6DwCEaMfMuMS0f88vZ9Y
tjlfw7fsoy7kQZEIV3+vNyGprTOOYuwO1z7C8D2vmrf+GgyW8dFkjBXpwxcOvwZP
2rBPP05rWWceV1nUA6EqDrm6YQRLbcSgxWePBNSyS+q53nD4D42kOAOvK7JZ1YoJ
yBka9XQrOJyo13TnwC+KAA0biolHpSJpjOMxmT1lg+baHlZknJZnhhUZtqLm19Kk
UFcGpFKGVbSqjd4vHYfRrIMRl/DAlw==
=j0lA
-----END PGP SIGNATURE-----

--F+2TplJk+JzgjBFp--

