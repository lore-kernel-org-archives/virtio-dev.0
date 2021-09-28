Return-Path: <xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v4 0/3] virtio: introduce VIRTIO_F_RING_RESET for reset queue
Date: Tue, 28 Sep 2021 15:55:32 +0800
Message-Id: <20210928075535.100384-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v4:
   Cornelia Huck helped me more. Thanks.
   MMIO support this.

Thanks

Xuan Zhuo (3):
  virtio: introduce virtqueue reset as basic facility
  virtio: pci support virtqueue reset
  virtio: mmio support virtqueue reset

 content.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

--
2.31.0

