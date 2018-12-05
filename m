Return-Path: virtio-dev-return-5122-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07E65985ED1
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Dec 2018 14:04:25 +0000 (UTC)
Date: Wed, 5 Dec 2018 15:04:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181205150408.62cc2e41.cohuck@redhat.com>
In-Reply-To: <20181205021651.392-1-tiwei.bie@intel.com>
References: <20181205021651.392-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3] packed-ring: fix example code
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed,  5 Dec 2018 10:16:51 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> Driver can't just check whether USED bit equals to the used
> wrap counter when checking whether a descriptor is a used
> descriptor, because driver also needs to check whether the
> descriptor has been made available. Below is an example:
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
> After driver made two descriptor chains available and each
> chain consists of two descriptors, the ring could be:
> 
> +----+-----------+----+-----------+
> | 10 | 10 (id=0) | 10 | 10 (id=1) |
> +----+-----------+----+-----------+
> 
> After device processed all the available descriptors and made
> them used (e.g. in order), the ring could be:
> 
> +-----------+----+-----------+----+
> | 11 (id=0) | 10 | 11 (id=1) | 10 |
> +-----------+----+-----------+----+
> 
> After driver processed all the used descriptors and made
> one descriptor (not chained, just one descriptor) available,
> the ring could be:
> 
> +-----------+----+----+----+
> | 01 (id=0) | 10 | 11 | 10 |
> +-----------+----+----+----+
> 
> After device made that descriptor used, the ring will be:
> 
> +-----------+----+----+----+
> | 00 (id=0) | 10 | 11 | 10 |
> +-----------+----+----+----+
> 
> If driver just checks whether USED bit equals to the used
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
>  packed-ring.tex | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/packed-ring.tex b/packed-ring.tex
> index f24f49b..c8cd83b 100644
> --- a/packed-ring.tex
> +++ b/packed-ring.tex
> @@ -687,16 +687,29 @@ vq->driver_event.flags = RING_EVENT_FLAGS_DISABLE;
>  for (;;) {
>          struct pvirtq_desc *d = vq->desc[vq->next_used];
>  
> +        /*
> +         * Check that
> +         * 1. Descriptor has been made available.
> +         *    Note: there are many other ways to check this, e.g.
> +         *    track the number of outstanding available descriptors or buffers
> +         *    and check that it's not 0.
> +         * 2. Descriptor has been used by device.

s/device/the device/

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
> +                 * Re-test in case another thread submitted more descriptors
> +                 * and/or device used more descriptors before driver enabled events.

s/device/the device/
s/driver/the driver/

(Also in the patch description.)

> +                 */
>                  flags = d->flags;
> +                bool avail = flags & VIRTQ_DESC_F_AVAIL;
>                  bool used = flags & VIRTQ_DESC_F_USED;
> -                if (used != vq->used_wrap_count) {
> +                if (avail != vq->used_wrap_count || used != vq->used_wrap_count) {
>                          break;
>                  }
>  


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

