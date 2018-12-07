Return-Path: virtio-dev-return-5140-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AD1C985B16
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Dec 2018 18:07:19 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri,  7 Dec 2018 16:48:39 +0800
Message-Id: <20181207084842.13133-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [RFC 0/3] virtio_ring: define flags as shifts consistently
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is a follow up of the discussion in this thread:
https://patchwork.ozlabs.org/patch/1001015/#2042353

Tiwei Bie (3):
  virtio_ring: define flags as shifts consistently
  virtio_ring: add VIRTIO_RING_NO_LEGACY
  virtio_ring: use new vring flags

 drivers/virtio/virtio_ring.c     | 100 ++++++++++++++++++-------------
 include/uapi/linux/virtio_ring.h |  61 +++++++++++++------
 2 files changed, 103 insertions(+), 58 deletions(-)

-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

