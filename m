Return-Path: <virtio-dev-return-8754-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A8BA9865FA
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Sep 2021 17:50:13 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri,  1 Oct 2021 01:50:05 +0800
Message-Id: <20210930175008.88352-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5 0/3] virtio: introduce VIRTIO_F_RING_RESET for reset queue
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: cohuck@redhat.com, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi All:

This is a new version to support VIRTIO_F_RING_RESET. The feautre
extends the basic facility to allow the driver to reset a virtqueue.
This main motivation is to support the reset function of the queue of the
network device.

Please review.

v5:
   It is defined in the transports that the device can modify the default
   value after reset, and the driver can use a different configuration to
   re-enable the device.

v4:
   Cornelia Huck helped me more. Thanks.
   MMIO support this.

Thanks

Xuan Zhuo (3):
  virtio: introduce virtqueue reset as basic facility
  virtio: pci support virtqueue reset
  virtio: mmio support virtqueue reset

 content.tex | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

