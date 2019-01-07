Return-Path: virtio-dev-return-5255-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EBF1984089
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Jan 2019 07:36:10 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon,  7 Jan 2019 15:01:03 +0800
Message-Id: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v3 0/3] virtio-balloon: tweak config_changed
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Since virtio-ccw doesn't work with accessing to the config space
inside an interrupt context, this patch series avoids that issue by
moving the config register accesses to the related workqueue contexts.

v2->v3 ChangeLog:
    - rename cmd_id_received to cmd_id_received_cache, and have call sites
      read the latest value via virtio_balloon_cmd_id_received. (Still
      kept Cornelia and Halil's reviewed-by as it's a minor change)
    - remove zeroing vb->num_free_page_blocks in probe since vb is
      allocated via kzalloc.
v1->v2 ChangeLog:
    - add config_read_bitmap to indicate to the workqueue callbacks about
      the necessity of reading the related config fields.

Wei Wang (3):
  virtio-balloon: tweak config_changed implementation
  virtio-balloon: improve update_balloon_size_func
  virtio_balloon: remove the unnecessary 0-initialization

 drivers/virtio/virtio_balloon.c | 104 ++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 35 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

