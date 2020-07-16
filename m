Return-Path: virtio-dev-return-7558-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26431986079
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 02:42:16 +0000 (UTC)
From: Hui Zhu <teawater@gmail.com>
Date: Thu, 16 Jul 2020 10:41:50 +0800
Message-Id: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Subject: [virtio-dev] [RFC for Linux v4 0/2] virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
Content-Type: text/plain; charset=US-ASCII
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Hui Zhu <teawater@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The first, second and third version are in [1], [2] and [3].
Code of current version for Linux and qemu is available in [4] and [5].
Update of this version:
1. Report continuous pages will increase the speed.  So added deflate
   continuous pages.
2. According to the comments from David in [6], added 2 new vqs inflate_cont_vq
   and deflate_cont_vq to report continuous pages with format 32 bits pfn and 32
   bits size.
Following is the introduction of the function.
These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With this
flag, balloon tries to use continuous pages to inflate and deflate.
Opening this flag can bring two benefits:
1. Report continuous pages will increase memory report size of each time
   call tell_host.  Then it will increase the speed of balloon inflate and
   deflate.
2. Host THPs will be splitted when qemu release the page of balloon inflate.
   Inflate balloon with continuous pages will let QEMU release the pages
   of same THPs.  That will help decrease the splitted THPs number in
   the host.
   Following is an example in a VM with 1G memory 1CPU.  This test setups an
   environment that has a lot of fragmentation pages.  Then inflate balloon will
   split the THPs.
// This is the THP number before VM execution in the host.
// None use THP.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB
// After VM start, use usemem
// (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
// punch-holes function generates 400m fragmentation pages in the guest
// kernel.
usemem --punch-holes -s -1 800m &
// This is the THP number after this command in the host.
// Some THP is used by VM because usemem will access 800M memory
// in the guest.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    911360 kB
// Connect to the QEMU monitor, setup balloon, and set it size to 600M.
(qemu) device_add virtio-balloon-pci,id=balloon1
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 600
(qemu) info balloon
balloon: actual=600
// This is the THP number after inflate the balloon in the host.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:     88064 kB
// Set the size back to 1024M in the QEMU monitor.
(qemu) balloon 1024
(qemu) info balloon
balloon: actual=1024
// Use usemem to increase the memory usage of QEMU.
killall usemem
usemem 800m
// This is the THP number after this operation.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:     65536 kB

Following example change to use continuous pages balloon.  The number of
splitted THPs is decreased.
// This is the THP number before VM execution in the host.
// None use THP.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB
// After VM start, use usemem punch-holes function generates 400M
// fragmentation pages in the guest kernel.
usemem --punch-holes -s -1 800m &
// This is the THP number after this command in the host.
// Some THP is used by VM because usemem will access 800M memory
// in the guest.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    911360 kB
// Connect to the QEMU monitor, setup balloon, and set it size to 600M.
(qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 600
(qemu) info balloon
balloon: actual=600
// This is the THP number after inflate the balloon in the host.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    616448 kB
// Set the size back to 1024M in the QEMU monitor.
(qemu) balloon 1024
(qemu) info balloon
balloon: actual=1024
// Use usemem to increase the memory usage of QEMU.
killall usemem
usemem 800m
// This is the THP number after this operation.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    907264 kB

[1] https://lkml.org/lkml/2020/3/12/144
[2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
[3] https://lkml.org/lkml/2020/5/12/324
[4] https://github.com/teawater/linux/tree/balloon_conts
[5] https://github.com/teawater/qemu/tree/balloon_conts
[6] https://lkml.org/lkml/2020/5/13/1211

Hui Zhu (2):
  virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
  virtio_balloon: Add deflate_cont_vq to deflate continuous pages

 drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++++++-----
 include/linux/balloon_compaction.h  |   12 ++
 include/uapi/linux/virtio_balloon.h |    1
 mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
 4 files changed, 280 insertions(+), 30 deletions(-)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

