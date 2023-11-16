Return-Path: <virtio-dev-return-14059-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87F7C197A0
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Nov 2023 22:22:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC05B1922ED
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Nov 2023 22:22:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEDD8986E09
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Nov 2023 22:22:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9345B986E06; Thu, 16 Nov 2023 22:22:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D41B986E07
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Nov 2023 22:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3DeAtSn7MdGf-v5yeeU4jg-1
Date: Thu, 16 Nov 2023 15:02:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.reshetova@intel.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux.dev
Message-ID: <20231116200245.GA336841@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UXVqzP4HaiAThsgh"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Subject: [virtio-dev] Using packed virtqueues in Confidential VMs

--UXVqzP4HaiAThsgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Elena,
You raised concerns about using packed virtqueues with untrusted devices at
Linux Plumbers Conference. I reviewed the specification and did not find
fundamental issues that would preclude the use of packed virtqueues in
untrusted devices. Do you have more information about issues with packed
virtqueues?

I also reviewed Linux's virtio_ring.c to look for implementation issues. One
thing I noticed was that detach_buf_packed -> vring_unmap_desc_packed trusts
the fields of indirect descriptors that have been mapped to the device:

  flags = le16_to_cpu(desc->flags);

  dma_unmap_page(vring_dma_dev(vq),
                 le64_to_cpu(desc->addr),
                 le32_to_cpu(desc->len),
                 (flags & VRING_DESC_F_WRITE) ?
                 DMA_FROM_DEVICE : DMA_TO_DEVICE);

This could be problematic if the device is able to modify indirect descriptors.
However, the indirect descriptor table is mapped with DMA_TO_DEVICE:

  addr = vring_map_single(vq, desc,
                          total_sg * sizeof(struct vring_packed_desc),
                          DMA_TO_DEVICE);

There is no problem when there is an enforcing IOMMU that maps the page with
read-only permissions but that's not always the case. Software devices (QEMU,
vhost kernel, or vhost-user) usually have full access to guest RAM. They can
cause dma_unmap_page() to be invoked with arguments of their choice (except for
the first argument) by modifying indirect descriptors.

I am not sure if this poses a danger since software devices already have access
to guest RAM, but I think this code is risky. It would be safer for the driver
to stash away the arguments needed for dma_unmap_page() in memory that is not
mapped to the device.

Other than that, I didn't find any issues with the packed virtqueue
implementation.

Stefan

--UXVqzP4HaiAThsgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVWdWUACgkQnKSrs4Gr
c8jzIwf/VNcXA1BGnKbeFiqj4GYXPsVHLgF68vDjj90ry1WI2KEC7cFJMVbYTfQf
N+ZyTAczQSeVVVvT8qTDkO4qQWTrPzHvd1TrVHhYK8x9XZwA8fASiyEWDSPAzfKY
EBsAEJll9ZNmZUdbGTGCbJxMnE6LQLPCJrAgmG9vZ1OKgc/f5Ljitnr21DhHktq9
aPhKUaTXNVlhrZYoXsRg4erY718tzoBK4xGP+PixGwrg7r8kNUkXPINGanSMVHxB
iCeeMma1n3gHE0p7LAVm2KcUQHs7s4X0qdmwS1JrYr+liGQmo/x/CDsFoPYjf3x+
QHoL+/8BIu2oRBo6Zbhdcfa9wNwABw==
=UCVN
-----END PGP SIGNATURE-----

--UXVqzP4HaiAThsgh--

