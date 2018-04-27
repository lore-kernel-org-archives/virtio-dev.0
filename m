Return-Path: virtio-dev-return-3981-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 40F965818D8E
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 05:22:37 -0700 (PDT)
Date: Fri, 27 Apr 2018 11:16:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180427101642.GD6999@stefanha-x1.localdomain>
References: <CAEuE-LgihoR4EY9Crhwym0+dduSqh48sZf5r3bg-YukW91os2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <CAEuE-LgihoR4EY9Crhwym0+dduSqh48sZf5r3bg-YukW91os2w@mail.gmail.com>
Subject: Re: [virtio-dev] Handling large VIRTIO_PCI_QUEUE_NUM values on
 Google Cloud Platform (GCP)
To: Nirmalanand J <nirmalanand.jebakumar@gmail.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 04:04:37PM +0530, Nirmalanand J wrote:
> 1) The number of descriptor count returned by the back-end through
> VIRTIO_PCI_QUEUE_NUM, is that negotiable with the backend? In some
> platforms like Google Cloud Platform (GCP) the value returned is 4096.

VIRTIO_PCI_QUEUE_NUM is the legacy VIRTIO PCI hardware register
(called "queue_size" in 4.1.4.8 Legacy Interfaces: A Note on PCI Device
Layout).  This field is read-only.

However, in VIRTIO 1.0 the modern VIRTIO PCI queue_size field (4.1.4.3
Common configuration structure layout) is writable during device
initialization.  The driver may *reduce* the queue size.

If you would like to use 256 descriptors instead of 4096, please make
sure your driver uses VIRTIO 1.0 (VIRTIO_F_VERSION_1) and not the legacy
interface.  Then the driver can reduce the number of descriptors to 256.

If the device does not support VIRTIO_F_VERSION_1 then you are out of
luck.

Stefan

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4viKAAoJEJykq7OBq3PIQ5AH/ilV3Mlik19vxOW60DuC8s81
5fUodjOaAkofvXnn7FP+AKiRfyFwjo3epxRmBVBrInmt10HmsnEZWFXzBP0W3Hcb
XATEeSLm6lOZE9G5kN2o/sMUbr17fLV3CHG3EOQhpajVwy4PllsG9pifB91VbZRH
WNeUfexaZ4LMpeHzisep+v3NWMyE0c/3ZK6SY2RAZY3/lQ5AY2ZWigR3boRgAut4
R7h82ujLSU4TZCwGUdI1hvvKU8RMhAeKt8stIiPNQtprMcy9rfQAdIbVpWN9y6B7
Ni9lR2TJOOZIOtqyhnCyM8KWZpUd7T9DI6/cxGwMYYxLEP+r2oFYGoVZknti37A=
=4yGm
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
