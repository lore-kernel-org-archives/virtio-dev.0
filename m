Return-Path: virtio-dev-return-2825-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3073C5818CC0
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2017 09:31:15 -0800 (PST)
Date: Thu, 14 Dec 2017 17:30:50 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214173050.GB18098@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <1512444796-30615-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-5-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v3 4/7] vhost-pci-slave: add vhost-pci slave
 implementation
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 11:33:13AM +0800, Wei Wang wrote:
> +static void vp_slave_set_vring_addr(VhostPCINet *vpnet, VhostUserMsg *msg)
> +{
> +    uint32_t index = msg->payload.addr.index;
> +
> +    vpnet->metadata->vq[index].desc_gpa = msg->payload.addr.desc_user_addr;
> +    vpnet->metadata->vq[index].avail_gpa = msg->payload.addr.avail_user_addr;
> +    vpnet->metadata->vq[index].used_gpa = msg->payload.addr.used_user_addr;

Do user addresses need to be converted to guest physical addresses via a
mem table lookup first?

> +    vpnet->metadata->nvqs = msg->payload.addr.index + 1;

In case the vhost-user master sends messages in an unexpected order:

vpnet->metadata->nvqs = MAX(vpnet->metadata->nvqs, msg->payload.addr.index + 1);

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMrVKAAoJEJykq7OBq3PIdO4IAL5zqXgsx7lr4Rz66DTT35zU
1n6gvpRGCrHzsJHrsZ7nfI/oV9X2gud2QiY3L1E8xWWCGBHgrde23RQtrz2mco+t
TBoRKOQptORjw5e8GUjEzSmqk/mCH2kMpByTR/QRBoGqy8TP4bUux46enFcBtlFO
w70TS+/apZ25InCByQrJO1Wv+gZrbLl48wkXycgcvbLDm5VgifGt/RjEtXOAjA6U
43QpkAsbta3VFf6kRCxuQb11mB0+Lr+1dZOp2giDp2sC62GNXfGceJAu5gfOKeU2
O6LQzUJyKXsRHJoy0Yb/HbaYJkvwqVp+rZ8KADweQcbMQEIjHgf9B60+BhXJIH4=
=TQrr
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
