Return-Path: virtio-dev-return-5137-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D6B77985AE8
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Dec 2018 01:20:08 +0000 (UTC)
Date: Fri, 7 Dec 2018 09:18:10 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20181207011810.GA12404@btwcube1>
References: <20181205162701.14138-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205162701.14138-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH v4] packed-ring: fix used descriptor
 checking in example code
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 06, 2018 at 12:27:01AM +0800, Tiwei Bie wrote:
> When the driver is processing used descriptors in parallel
> with adding new available descriptors, the driver can't just
> check whether USED bit equals to the used wrap counter when
> checking whether a descriptor is a used descriptor, because
> the driver also needs to check whether the descriptor has
> been made available. Below is an example:
> 
> Assuming ring size is 4, ring's initial state will be:
> 
> +----+----+----+----+
> | 00 | 00 | 00 | 00 |
> +----+----+----+----+
> 
> 00 means AVAIL=0 USED=0, 01 means AVAIL=0 USED=1
> 10 means AVAIL=1 USED=0, 11 means AVAIL=1 USED=1
> 
> After the driver made two descriptor chains available and
> each chain consists of two descriptors, the ring could be:
> 
> +----+-----------+----+-----------+
> | 10 | 10 (id=0) | 10 | 10 (id=1) |
> +----+-----------+----+-----------+
> 
> After the device processed all the available descriptors and
> made them used (e.g. in order), the ring could be:
> 
> +-----------+----+-----------+----+
> | 11 (id=0) | 10 | 11 (id=1) | 10 |
> +-----------+----+-----------+----+
> 
> After the driver processed all the used descriptors and made
> one descriptor (not chained, just one descriptor) available,
> the ring could be:
> 
> +-----------+----+----+----+
> | 01 (id=0) | 10 | 11 | 10 |
> +-----------+----+----+----+
> 
> After the device made that descriptor used, the ring will be:
> 
> +-----------+----+----+----+
> | 00 (id=0) | 10 | 11 | 10 |
> +-----------+----+----+----+
> 
> If the driver just checks whether USED bit equals to the used
> wrap counter when checking whether a descriptor is a used
> descriptor, after processing the first descriptor (whose
> AVAIL and USED bits are both 0), and advancing vq->next_used
> pointer, it will then also treat the next descriptor, i.e.
> the second descriptor (whose AVAIL and USED bits are 1 and
> 0 respectively) as a used descriptor which is wrong.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/29
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> v2:
> - Add "Fixes" tag;
> - Refine commit log;
> 
> v3:
> - Compare with vq->used_wrap_count (MST);
> - Add comments (MST);
> - Refine commit log;
> 
> v4:
> - s/device/the device/ (Cornelia);
> - s/driver/the driver/ (Cornelia);
> - Improve commit log and comments (MST);
> - Make commit log title more specific;
> 
>  packed-ring.tex | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 

Please start the voting on this change. Thanks!

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

