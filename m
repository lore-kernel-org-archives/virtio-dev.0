Return-Path: virtio-dev-return-5131-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F9D5985EDD
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Dec 2018 12:44:38 +0000 (UTC)
Date: Thu, 6 Dec 2018 13:44:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181206134426.4b3db30f.cohuck@redhat.com>
In-Reply-To: <20181205162701.14138-1-tiwei.bie@intel.com>
References: <20181205162701.14138-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v4] packed-ring: fix used descriptor checking in example
 code
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu,  6 Dec 2018 00:27:01 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

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
> diff --git a/packed-ring.tex b/packed-ring.tex
> index f24f49b..0047ecf 100644
> --- a/packed-ring.tex
> +++ b/packed-ring.tex
> @@ -687,16 +687,33 @@ vq->driver_event.flags = RING_EVENT_FLAGS_DISABLE;
>  for (;;) {
>          struct pvirtq_desc *d = vq->desc[vq->next_used];
>  
> +        /*
> +         * Check that
> +         * 1. Descriptor has been made available. This check is necessary
> +         *    if the driver is making new descriptors available in parallel
> +         *    with this processing of used descriptors (e.g. from another thread).
> +         *    Note: there are many other ways to check this, e.g.
> +         *    track the number of outstanding available descriptors or buffers
> +         *    and check that it's not 0.
> +         * 2. Descriptor has been used by the device.
> +         */
>          flags = d->flags;
> +        bool avail = flags & VIRTQ_DESC_F_AVAIL;
>          bool used = flags & VIRTQ_DESC_F_USED;
> -
> -        if (used != vq->used_wrap_count) {
> +        if (avail != vq->used_wrap_count || used != vq->used_wrap_count) {
>                  vq->driver_event.flags = RING_EVENT_FLAGS_ENABLE;
>                  memory_barrier();
>  
> +                /*
> +                 * Re-test in case the driver made more descriptors available in
> +                 * parallel with the used descriptor processing (e.g. from another
> +                 * thread) and/or the device used more descriptors before the driver
> +                 * enabled events.
> +                 */
>                  flags = d->flags;
> +                bool avail = flags & VIRTQ_DESC_F_AVAIL;
>                  bool used = flags & VIRTQ_DESC_F_USED;
> -                if (used != vq->used_wrap_count) {
> +                if (avail != vq->used_wrap_count || used != vq->used_wrap_count) {
>                          break;
>                  }
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

