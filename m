Return-Path: virtio-dev-return-7176-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D0D4985BA9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Apr 2020 08:21:53 +0000 (UTC)
References: <20200424164239.10723.58352.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <24b5a6e2-0062-4d73-db9d-2c811c7b7751@redhat.com>
Date: Mon, 27 Apr 2020 10:21:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200424164239.10723.58352.stgit@localhost.localdomain>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v22 QEMU 0/5] virtio-balloon: add support for page poison
 reporting and free page reporting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 24.04.20 18:50, Alexander Duyck wrote:
> This series provides an asynchronous means of reporting free guest pages
> to QEMU through virtio-balloon so that the memory associated with those
> pages can be discarded and reused by other processes and/or guests on the
> host. Using this it is possible to avoid unnecessary I/O to disk and
> greatly improve performance in the case of memory overcommit on the host.
> 
> As a part of enabling this feature it was necessary to implement the page
> poison reporting feature which had been added to the kernel, but was not
> available in QEMU. This patch set adds it as a new device property
> "page-poison" which is enabled by default, and adds support for migrating
> the reported value.
> 
> I originally submitted this patch series back on February 11th 2020[1],
> but at that time I was focused primarily on the kernel portion of this
> patch set. However as of April 7th those patches are now included in
> Linus's kernel tree[2] and so I am submitting the QEMU pieces for
> inclusion.
> 
> [1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc
> 
> Changes from v17:
> Fixed typo in patch 1 title
> Addressed white-space issues reported via checkpatch
> Added braces {} for two if statements to match expected coding style
> 
> Changes from v18:
> Updated patches 2 and 3 based on input from dhildenb
> Added comment to patch 2 describing what keeps us from reporting a bad page
> Added patch to address issue with ROM devices being directly writable
> 
> Changes from v19:
> Added std-headers change to match changes pushed for linux kernel headers
> Added patch to remove "report" from page hinting code paths
> Updated comment to better explain why we disable hints w/ page poisoning
> Removed code that was modifying config size for poison vs hinting
> Dropped x-page-poison property
> Added code to bounds check the reported region vs the RAM block
> Dropped patch for ROM devices as that was already pulled in by Paolo
> 
> Changes from v20:
> Rearranged patches to push Linux header sync patches to front
> Removed association between free page hinting and VIRTIO_BALLOON_F_PAGE_POISON
> Added code to enable VIRTIO_BALLOON_F_PAGE_POISON if page reporting is enabled
> Fixed possible resource leak if poison or qemu_balloon_is_inhibited return true
> 
> Changes from v21:
> Added ack for patch 3
> Rewrote patch description for page poison reporting feature
> Made page-poison independent property and set to enabled by default
> Added logic to migrate poison_val
> Added several comments in code to better explain features
> Switched free-page-reporting property to disabled by default

Except one minor nit, looks good to me. We'll have to take care of
compat handling regarding patch #4 as soon as we have 5.0 compat
machines in place.


-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

