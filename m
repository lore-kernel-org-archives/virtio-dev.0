Return-Path: virtio-dev-return-8068-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC5B8985A84
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 11:20:28 +0000 (UTC)
Date: Mon, 1 Mar 2021 11:20:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YDzN9zwyeOp8+ftw@stefanha-x1.localdomain>
References: <CAPR809ud5OC2fAdyRqHR0tw+H++nDVk1g2FZw2-KCLJHnCcm3Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPR809ud5OC2fAdyRqHR0tw+H++nDVk1g2FZw2-KCLJHnCcm3Q@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2] Add lifetime metrics to virtio-blk
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7PI5LX5i1XsniEta"
Content-Disposition: inline
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--7PI5LX5i1XsniEta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 25, 2021 at 04:41:41PM -0700, Enrico Granata wrote:
> @@ -4611,6 +4615,7 @@ \subsection{Device Operation}\label{sec:Device
> Types / Block Device / Device Ope
>  #define VIRTIO_BLK_T_GET_ID       8
>  #define VIRTIO_BLK_T_DISCARD      11
>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> +#define VIRTIO_BLK_T_GET_LIFETIME 15

Sorry I missed this in the previous revision:

There is some funny business in the Linux drivers/block/virtio_blk.c
driver and QEMU hw/block/virtio-blk.c device implementations where the
least significant bit indicates a driver-to-device DMA transfer when
set and a device-to-driver DMA transfer when clear. That's why
DISCARD/WRITE_ZEROES have odd-numbered request types but GET_ID has an
even-numbered request type.

The implementations should probably be overhauled to stop doing this.
There doesn't seem to be a good reason for it! :P

To make life easy, please choose an even-numbered request type. That way
these implementations will treat VIRTIO_BLK_T_GET_LIFETIME as a "read"
instead of a "write". 10, 12, or 14 would work.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7PI5LX5i1XsniEta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA8zfYACgkQnKSrs4Gr
c8iRjQf/WgfjWL3ocX2F3JYaPiG3lplRX3h9qq8gldeI7Swj5WBOjHYqcNLaX2qE
04kF+ADsv0dYFo2b9j08IWXO/l7kNa6lJkKWvSZRFjmYgzJ+3bTjD+YIM83bqvMB
DmFAUtOdc41aLkDxk5+1S1sPIJBg6SfmjQdTfdcZ8kHFGaaF878qCqSNGHv75O7v
mI/1gamqwuwEOCN7XBtyNcOJLW0c/vfvG3v4Mkxy3RWjLVUH75cc6rB9zTjeowK2
P1rG9Tqi54d2MjdkNx9/DcTqHRG+la/4trR0GY24uPI3o0jt0dtCw2YdFXxFFwf/
gB9167OdtGbSIHQ8JZ5QOdIQ4Nd28A==
=aFkn
-----END PGP SIGNATURE-----

--7PI5LX5i1XsniEta--

