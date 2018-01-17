Return-Path: virtio-dev-return-2978-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D2A8E1CB807D
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Jan 2018 21:28:34 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 13:10:09 +0800
Message-Id: <1516165812-3995-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v22 0/3] Virtio-balloon: support free page reporting
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch series is separated from the previous "Virtio-balloon
Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_VQ,  
implemented by this series enables the virtio-balloon driver to report
hints of guest free pages to the host. It can be used to accelerate live
migration of VMs. Here is an introduction of this usage:

Live migration needs to transfer the VM's memory from the source machine
to the destination round by round. For the 1st round, all the VM's memory
is transferred. From the 2nd round, only the pieces of memory that were
written by the guest (after the 1st round) are transferred. One method
that is popularly used by the hypervisor to track which part of memory is
written is to write-protect all the guest memory.

The second feature enables the optimization of the 1st round memory
transfer - the hypervisor can skip the transfer of guest free pages in the
1st round. It is not concerned that the memory pages are used after they
are given to the hypervisor as a hint of the free pages, because they will
be tracked by the hypervisor and transferred in the next round if they are
used and written.

ChangeLog:
v21-v22:
    - add_one_sg: some code and comment re-arrangement
    - send_cmd_id: handle a cornercase

For precious ChangeLog, please reference
https://lwn.net/Articles/743660/

Wei Wang (3):
  mm: support reporting free page blocks
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
  virtio-balloon: don't report free pages when page poisoning is enabled

 drivers/virtio/virtio_balloon.c     | 250 +++++++++++++++++++++++++++++++-----
 include/linux/mm.h                  |   6 +
 include/uapi/linux/virtio_balloon.h |   6 +
 mm/page_alloc.c                     |  91 +++++++++++++
 4 files changed, 321 insertions(+), 32 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

