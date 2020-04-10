Return-Path: virtio-dev-return-7043-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53BB8985FDB
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Apr 2020 03:41:25 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 09 Apr 2020 20:41:22 -0700
Message-ID: <20200410033729.24738.22879.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v19 QEMU 0/4] virtio-balloon: add support for free page
 reporting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: pbonzini@redhat.com, david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

This series provides an asynchronous means of reporting free guest pages
to QEMU through virtio-balloon so that the memory associated with those
pages can be dropped and reused by other processes and/or guests on the
host. Using this it is possible to avoid unnecessary I/O to disk and
greatly improve performance in the case of memory overcommit on the host.

I originally submitted this patch series back on February 11th 2020[1],
but at that time I was focused primarily on the kernel portion of this
patch set. However as of April 7th those patches are now included in
Linus's kernel tree[2] and so I am submitting the QEMU pieces for
inclusion.

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc

Changes from v17:
Fixed typo in patch 1 title
Addressed white-space issues reported via checkpatch
Added braces {} for two if statements to match expected coding style

Changes from v18:
Updated patches 2 and 3 based on input from dhildenb
Added comment to patch 2 describing what keeps us from reporting a bad page
Added patch to address issue with ROM devices being directly writable

---

Alexander Duyck (4):
      virtio-balloon: Implement support for page poison tracking feature
      linux-headers: update to contain virito-balloon free page reporting
      virtio-balloon: Provide an interface for free page reporting
      memory: Do not allow direct write access to rom_device regions


 hw/virtio/virtio-balloon.c                      |   85 ++++++++++++++++++++++-
 include/exec/memory.h                           |    4 +
 include/hw/virtio/virtio-balloon.h              |    3 +
 include/standard-headers/linux/virtio_balloon.h |    1 
 4 files changed, 86 insertions(+), 7 deletions(-)

--

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

