Return-Path: virtio-dev-return-5226-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A2F0983D45
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 06:06:06 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu,  3 Jan 2019 13:31:00 +0800
Message-Id: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 0/2] virtio-balloon: tweak config_changed
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Since virtio-ccw doesn't work with accessing to the config registers
inside an interrupt context, this patch series avoids that issue by
moving the config register accesses to the related workqueue contexts.

Wei Wang (2):
  virtio-balloon: tweak config_changed implementation
  virtio-balloon: improve update_balloon_size_func

 drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

