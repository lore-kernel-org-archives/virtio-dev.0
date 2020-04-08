Return-Path: virtio-dev-return-7022-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14AC6985EFA
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Apr 2020 19:48:44 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 08 Apr 2020 12:48:40 -0700
Message-ID: <20200408194628.24143.51644.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v17 RESUBMIT QEMU 0/3] virtio-balloon: add support for
 providing free page reporting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

This series provides an asynchronous means of reporting free guest pages
to QEMU through virtio-balloon so that the memory associated with those
pages can be dropped and reused by other processes and/or guests on the
host. Using this it is possible to avoid unnecessary I/O to disk and
greatly improve performance in the case of memory overcommit on the host.

I originally submitted this patch series[1] back on February 11th 2020,
but at that time I was focused primarily on the kernel portion of this
patch set. However as of April 7th those patches are now included in
Linus's kernel tree[2] and so I thought I should resubmit the QEMU side of
this for inclusion so that the feature will be available in QEMU hopefully
by the time the 5.7 kernel tree is released.

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc

---

Alexander Duyck (3):
      virtio-balloon: Implement support for page poison tracking feature
      virtio-balloon: Add support for providing free page reports to host
      virtio-balloon: Provide a interface for free page reporting


 hw/virtio/virtio-balloon.c                      |   67 ++++++++++++++++++++++-
 include/hw/virtio/virtio-balloon.h              |    3 +
 include/standard-headers/linux/virtio_balloon.h |    1 
 3 files changed, 66 insertions(+), 5 deletions(-)

--

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

