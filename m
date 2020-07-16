Return-Path: virtio-dev-return-7560-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38A7D98607D
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 02:42:39 +0000 (UTC)
From: Hui Zhu <teawater@gmail.com>
Date: Thu, 16 Jul 2020 10:41:53 +0800
Message-Id: <1594867315-8626-4-git-send-email-teawater@gmail.com>
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Subject: [virtio-dev] [RFC for qemu v4 0/2] virtio-balloon: Add option cont-pages to set VIRTIO_BALLOON_F_CONT_PAGES
Content-Type: text/plain; charset=US-ASCII
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Hui Zhu <teawater@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Code of current version for Linux and qemu is available in [1] and [2].
Update of this version:
1. Report continuous pages will increase the speed.  So added deflate
   continuous pages.
2. According to the comments from David in [3], added 2 new vqs icvq and
   dcvq to get continuous pages with format 32 bits pfn and 32 bits size.

Following is the introduction of the function.
Set option cont-pages to on will open flags VIRTIO_BALLOON_F_CONT_PAGES.
qemu will get continuous pages from icvq and dcvq and do madvise
MADV_WILLNEED and MADV_DONTNEED with the pages.
Opening this flag can bring two benefits:
1. Increase the speed of balloon inflate and deflate.
2. Decrease the splitted THPs number in the host.

[1] https://github.com/teawater/linux/tree/balloon_conts
[2] https://github.com/teawater/qemu/tree/balloon_conts
[3] https://lkml.org/lkml/2020/5/13/1211

Hui Zhu (2):
  virtio_balloon: Add cont-pages and icvq
  virtio_balloon: Add dcvq to deflate continuous pages

 hw/virtio/virtio-balloon.c                      |   92 +++++++++++++++---------
 include/hw/virtio/virtio-balloon.h              |    2
 include/standard-headers/linux/virtio_balloon.h |    1
 3 files changed, 63 insertions(+), 32 deletions(-)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

