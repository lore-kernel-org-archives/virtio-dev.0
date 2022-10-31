Return-Path: <stefanha@redhat.com>
Date: Mon, 31 Oct 2022 16:36:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH v7] virtio-blk: add zoned block device
 specification
Message-ID: <Y2Ax2XpOGRQW4dE3@fedora>
References: <20221031030632.992680-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wqHiwQ91pPUX+0Mp"
Content-Disposition: inline
In-Reply-To: <20221031030632.992680-1-dmitry.fomichev@wdc.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Cornelia Huck <cohuck@redhat.com>, Matias Bjorling <matias.bjorling@wdc.com>, Niklas Cassel <niklas.cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--wqHiwQ91pPUX+0Mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 30, 2022 at 11:06:32PM -0400, Dmitry Fomichev wrote:

A minor issue about normative vs non-normative sections:

> +Devices that offer the VIRTIO_BLK_F_ZONED feature while reporting the
> +VIRTIO_BLK_Z_NONE zoned model are drive-managed zoned block devices. In this
> +case, the driver should treat the device as a regular non-zoned block device.

The VIRTIO spec tries to use should/may/must/etc in the drivernormative
and devicenormative sections. The non-normative sections describe the
interface without making normative statements.

Use of "should" suggests that maybe this should be in a normative
section? If you decide not to move it to a normative section then you
could simply reword it:

  "the driver treats the device as a regular ..."

> +
> +Host-managed zoned block devices have their LBA range divided into Sequential
> +Write Required (SWR) zones that require some additional handling from the host
> +for correct operation. All write requests to SWR zones must be sequential and

There is a "must" here. Same question as above.

Aside from that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wqHiwQ91pPUX+0Mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNgMdgACgkQnKSrs4Gr
c8ho4QgAkwxlnWhvz+W43owtwP17QMNBtOUAErflDtS0QDb9uCS8cQg2+uO7IT/v
ZQjmsMwsvhWhilpnaqBqOfdfQFNbg/LUnAIcAZYC5Q7ETm5dNifX1+ZeLrX+BTTE
w9Wtn25SHKL1KbYclK77TnMya0m5jv/q5Bf+VvXBSbgOOMeVnNx9FYCaQgjoL5NI
e7QB+eidLU/SDnVMfaQPT0CEvUCugI2gzT+50MTwpLpR9/5X5TY0C4tAUf8K1QAV
X0zNDFy7RnMzonfxytVinXc7npRz5wzbryM+F659yEtau40+Pkvt69jOi6PapE/C
Kq+CWZfGltdRnLBOVPqp7O5AztLTGw==
=PRyr
-----END PGP SIGNATURE-----

--wqHiwQ91pPUX+0Mp--

