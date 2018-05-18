Return-Path: virtio-dev-return-4097-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B9BD58191C9
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 May 2018 09:06:35 -0700 (PDT)
Date: Fri, 18 May 2018 17:06:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180518160623.GB21655@stefanha-x1.localdomain>
References: <20180517130604.9036-1-venu.busireddy@oracle.com>
 <20180517130604.9036-2-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20180517130604.9036-2-venu.busireddy@oracle.com>
Subject: Re: [virtio-dev] [PATCH 1/1] Allow "Vendor Specific" extension to
 virtio PCI capabilities.
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 17, 2018 at 09:06:04AM -0400, Venu Busireddy wrote:

Can you describe a use case where vendor-specific extensions make sense
as opposed to extending the VIRTIO specification?

This proposal only supports the PCI transport, so do extensions only
affect the PCI transport behavior or also other aspects of VIRTIO
(device behavior, vring, etc)?

> +\devicenormative{\paragraph}{Vendor Specific Extension capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Vendor Specific Extension capability}
> +
> +The device may or may not present the VIRTIO_PCI_CAP_VENDOR_EXT_CFG capability.

s/may or may not/MAY/

> +
> +\drivernormative{\paragraph}{Vendor Specific Extension capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Vendor Specific Extension capability}
> +
> +The driver MUST NOT write to vendor_specific_data[] area or the BAR region.

How does a driver identify vendor-specific extensions that it supports?
No Vendor ID is included in the capability, just an opaque blob, so how
are collisions avoided?

How does a driver behave upon encountering an unknown vendor-specific
extension?

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa/vn/AAoJEJykq7OBq3PIdu8H/2ITxJ0+RH7Zdxwl6E1n1R1+
0Aqk/oMc/vsMlySoyID1FR3zGHkKdEUE40T1Flyr2YHc48K1SDVOBTOPtTM8PXQc
Rvx2c8VxJggsp8r6PyiEQ45le4+LUkNhnbazKWbqBfokvVvZgu/lzjEbPISVMSmK
duHhffhN9yGB/Cl0heg3sOnMnClPfiU9ZC/NhkEPGd9wukwjEBV2bDrmHqhdIooB
imZATYA2CT44KXgmBRbdtAQeu/nuxKmp1t4stOkP+hmu16SK8M9vVeGG2QbRH5CU
S9Ui4jpx8wIu4kkY2pNsIXtuUVzLMN+kv9wa5v7HwJyLT6lEARjZ2ciMSiI0Zww=
=Zk+a
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
