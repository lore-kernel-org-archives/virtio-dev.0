Return-Path: virtio-dev-return-2827-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 46B865818D93
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2017 09:49:03 -0800 (PST)
Date: Thu, 14 Dec 2017 17:48:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214174842.GT14433@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <1512444796-30615-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="skzcsJvRJWOW8YcK"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-5-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v3 4/7] vhost-pci-slave: add vhost-pci slave
 implementation
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--skzcsJvRJWOW8YcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 11:33:13AM +0800, Wei Wang wrote:
> The vhost-pci slave implementation is added to support the creation of
> the vhost-pci-net device. It follows the vhost-user protocol to get the
> master VM's info (e.g. memory regions, vring address).

How does the guest know when the QEMU vhost-user slave has finished
initializing everything?  It seems like a guest driver could access the
device before things are initialized.

How will reconnection work?

> +static int vp_slave_get_features(VhostPCINet *vpnet, CharBackend *chr_be,
> +                                 VhostUserMsg *msg)
> +{
> +    /* Offer the initial features, which have the protocol feature bit set */
> +    msg->payload.u64 = (uint64_t)vpnet->host_features |
> +                       (1 << VHOST_USER_F_PROTOCOL_FEATURES);

How can the vhost-user slave inside the guest participate in feature
negotiation?  It must be able to participate, otherwise slaves cannot
disable features that QEMU supports but they don't want to support.

It's not feasible to pass in host_features as a QEMU parameter because
that would require libvirt, OpenStack, cloud providers, etc to add
support so users can manually set the bits for their slave
implementation.

> +static int vp_slave_get_queue_num(CharBackend *chr_be, VhostUserMsg *msg)
> +{
> +    msg->payload.u64 = VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX;

The guest cannot limit the number of virtqueues?

--skzcsJvRJWOW8YcK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMrl6AAoJEJykq7OBq3PIXKgH/0YBlqyEsOSLujfwqFGlx//c
s6xRj8aECV9s7rrQp8VQAzCIOJAgCGhzlDZHkJgs/JvlFgdGpS7SoLiNMewSvd7q
jWQoOISMxrfnDd5OIeDReRZqbi2eYejCeEIXRMHyCOEv+8UpP9XIks3wG7e0T/ky
JtZ+cvMhAtTuxpzS49bcA1r8L6PGNW7LZEv4VzW65541IXN7Mjr+tEVnrcIO/RXJ
ugDcLOMc6X+9Yc8rgx2cbZQZ7cR/udNi/s5vs2egCs1YaWmb2FEf6ipv+wzdT4vd
1h/2rZIQf9eHO+8LMGOWGE/tig7Lw+9Blfyti6CHJUJ31tX3p/5VTn/ovE0cs78=
=SWrl
-----END PGP SIGNATURE-----

--skzcsJvRJWOW8YcK--
