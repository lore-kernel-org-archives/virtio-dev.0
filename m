Return-Path: virtio-dev-return-3169-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E652F1CB807B
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Feb 2018 23:13:38 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed,  7 Feb 2018 14:54:27 +0800
Message-Id: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v27 0/4] Virtio-balloon: support free page reporting
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, huangzhichao@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch series is separated from the previous "Virtio-balloon
Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,  
implemented by this series enables the virtio-balloon driver to report
hints of guest free pages to the host. It can be used to accelerate live
migration of VMs. Here is an introduction of this usage:

Live migration needs to transfer the VM's memory from the source machine
to the destination round by round. For the 1st round, all the VM's memory
is transferred. From the 2nd round, only the pieces of memory that were
written by the guest (after the 1st round) are transferred. One method
that is popularly used by the hypervisor to track which part of memory is
written is to write-protect all the guest memory.

This feature enables the optimization of the 1st round memory transfer -
the hypervisor can skip the transfer of guest free pages in the 1st round.
It is not concerned that the memory pages are used after they are given
to the hypervisor as a hint of the free pages, because they will be
tracked by the hypervisor and transferred in the next round if they are
used and written.

* Tests
- Migration time improvement
Result:
Live migration time is reduced to 14% with this optimization.
Details:
Local live migration of 8GB idle guest, the legacy live migration takes
~1817ms. With this optimization, it takes ~254ms, which reduces the time
to 14%.
- Workload tests
Results:
Running this feature has no impact on the linux compilation workload
running inside the guest.
Details:
Set up a Ping-Pong local live migration, where the guest ceaselessy
migrates between the source and destination. Linux compilation,
i.e. make bzImage -j4, is performed during the Ping-Pong migration. The
legacy case takes 5min14s to finish the compilation. With this
optimization patched, it takes 5min12s.

ChangeLog:
v26->v27:
    - add a new patch to expose page_poisoning_enabled to kernel modules
    - virtio-balloon: set poison_val to 0xaaaaaaaa, instead of 0xaa
v25->v26: virtio-balloon changes only
    - remove kicking free page vq since the host now polls the vq after
      initiating the reporting
    - report_free_page_func: detach all the used buffers after sending
      the stop cmd id. This avoids leaving the detaching burden (i.e.
      overhead) to the next cmd id. Detaching here isn't considered
      overhead since the stop cmd id has been sent, and host has already
      moved formard.
v24->v25:
    - mm: change walk_free_mem_block to return 0 (instead of true) on
          completing the report, and return a non-zero value from the
          callabck, which stops the reporting.
    - virtio-balloon:
        - use enum instead of define for VIRTIO_BALLOON_VQ_INFLATE etc.
        - avoid __virtio_clear_bit when bailing out;
        - a new method to avoid reporting the some cmd id to host twice
        - destroy_workqueue can cancel free page work when the feature is
          negotiated;
        - fail probe when the free page vq size is less than 2.
v23->v24:
    - change feature name VIRTIO_BALLOON_F_FREE_PAGE_VQ to
      VIRTIO_BALLOON_F_FREE_PAGE_HINT
    - kick when vq->num_free < half full, instead of "= half full"
    - replace BUG_ON with bailing out
    - check vb->balloon_wq in probe(), if null, bail out
    - add a new feature bit for page poisoning
    - solve the corner case that one cmd id being sent to host twice
v22->v23:
    - change to kick the device when the vq is half-way full;
    - open-code batch_free_page_sg into add_one_sg;
    - change cmd_id from "uint32_t" to "__virtio32";
    - reserver one entry in the vq for the driver to send cmd_id, instead
      of busywaiting for an available entry;
    - add "stop_update" check before queue_work for prudence purpose for
      now, will have a separate patch to discuss this flag check later;
    - init_vqs: change to put some variables on stack to have simpler
      implementation;
    - add destroy_workqueue(vb->balloon_wq);

v21->v22:
    - add_one_sg: some code and comment re-arrangement
    - send_cmd_id: handle a cornercase

For previous ChangeLog, please reference
https://lwn.net/Articles/743660/

Wei Wang (4):
  mm: support reporting free page blocks
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  mm/page_poison: expose page_poisoning_enabled to kernel modules
  virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON

 drivers/virtio/virtio_balloon.c     | 255 +++++++++++++++++++++++++++++++-----
 include/linux/mm.h                  |   6 +
 include/uapi/linux/virtio_balloon.h |   7 +
 mm/page_alloc.c                     |  96 ++++++++++++++
 mm/page_poison.c                    |   6 +
 5 files changed, 334 insertions(+), 36 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

