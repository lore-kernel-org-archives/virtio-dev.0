Return-Path: <virtio-dev-return-8713-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E081C98627F
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Sep 2021 12:31:57 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Mon, 27 Sep 2021 20:31:51 +0800
Message-Id: <20210927123153.20242-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 0/2] virtio: introduce VIRTIO_F_RING_RESET for reset queue
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi All:

This is a new version to support VIRTIO_F_RING_RESET. The feautre
extends the basic facility to allow the driver to reset a virtqueue.
This main motivation is to support the reset function of the queue of the
network device.

Please review.

Thanks

Xuan Zhuo (2):
  virtio: introduce virtqueue reset as basic facility
  virtio: pci support virtqueue reset

 content.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

