Return-Path: <xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v6 0/3] virtio: introduce VIRTIO_F_RING_RESET for reset queue
Date: Fri, 15 Oct 2021 09:44:11 +0800
Message-Id: <20211015014414.98335-1-xuanzhuo@linux.alibaba.com>
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

v6:
   The device MUST present consistent default values after queue reset.

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

