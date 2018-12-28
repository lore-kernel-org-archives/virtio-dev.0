Return-Path: virtio-dev-return-5209-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0758D985E31
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Dec 2018 03:01:31 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 28 Dec 2018 10:26:24 +0800
Message-Id: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 0/2] Virtio: fix some vq allocation issues
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Some vqs don't need to be allocated when the related feature bits are
disabled. Callers notice the vq allocation layer by setting the related
names[i] to be NULL.

This patch series fixes the find_vqs implementations to handle this case.

Wei Wang (2):
  virtio_pci: use queue idx instead of array idx to set up the vq
  virtio: don't allocate vqs when names[i] = NULL

 drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
 drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
 drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
 drivers/virtio/virtio_mmio.c           |  9 +++++++--
 drivers/virtio/virtio_pci_common.c     |  8 ++++----
 5 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

