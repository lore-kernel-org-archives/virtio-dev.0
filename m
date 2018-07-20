Return-Path: virtio-dev-return-4712-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 108C4985C68
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Jul 2018 09:00:41 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 20 Jul 2018 16:33:00 +0800
Message-Id: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v36 0/5] Virtio-balloon: support free page reporting
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
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

This feature enables the optimization by skipping the transfer of guest
free pages during VM live migration. It is not concerned that the memory
pages are used after they are given to the hypervisor as a hint of the
free pages, because they will be tracked by the hypervisor and transferred
in the subsequent round if they are used and written.

* Tests
- Test Environment
    Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
    Guest: 8G RAM, 4 vCPU
    Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second

- Test Results
    - Idle Guest Live Migration Time (results are averaged over 10 runs):
        - Optimization v.s. Legacy = 409ms vs 1757ms --> ~77% reduction
	(setting page poisoning zero and enabling ksm don't affect the
         comparison result)
    - Guest with Linux Compilation Workload (make bzImage -j4):
        - Live Migration Time (average)
          Optimization v.s. Legacy = 1407ms v.s. 2528ms --> ~44% reduction
        - Linux Compilation Time
          Optimization v.s. Legacy = 5min4s v.s. 5min12s
          --> no obvious difference

ChangeLog:
v35->v36:
    - remove the mm patch, as Linus has a suggestion to get free page
      addresses via allocation, instead of reading from the free page
      list.
    - virtio-balloon:
        - replace oom notifier with shrinker;
        - the guest to host communication interface remains the same as
          v32.
	- allocate free page blocks and send to host one by one, and free
          them after sending all the pages.

For ChangeLogs from v22 to v35, please reference
https://lwn.net/Articles/759413/

For ChangeLogs before v21, please reference
https://lwn.net/Articles/743660/

Wei Wang (5):
  virtio-balloon: remove BUG() in init_vqs
  virtio_balloon: replace oom notifier with shrinker
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  mm/page_poison: expose page_poisoning_enabled to kernel modules
  virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON

 drivers/virtio/virtio_balloon.c     | 456 ++++++++++++++++++++++++++++++------
 include/uapi/linux/virtio_balloon.h |   7 +
 mm/page_poison.c                    |   6 +
 3 files changed, 394 insertions(+), 75 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

