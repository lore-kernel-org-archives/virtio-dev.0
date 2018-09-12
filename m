Return-Path: virtio-dev-return-4833-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EE23985D07
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Sep 2018 07:25:45 +0000 (UTC)
Date: Wed, 12 Sep 2018 09:25:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
To: Jiandi An <jiandi@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Dave Airlie <airlied@linux.ie>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> I attempted to fix it in the ttm layer and here is the discussion
> https://lore.kernel.org/lkml/b44280d7-eb13-0996-71f5-3fbdeb466801@amd.com/
> 
> The ttm maintainer Christian is suggesting to map and set ttm->pages as decrypted
> right after ttm->pages are allocated.
> 
> Just checking with you guys maybe there is a better way to handle this in
> the virtio gpu layer instead of the common ttm layer.  Could you guys shine some
> light on this?  Thanks.

I think the tty layer is the right place to fix this.  virtio just calls
down to ttm for mappings.  I think virtio should just hint to ttm using
a flag in some struct, probably ttm_buffer_object or
ttm_mem_type_manager, that the objects need decrypted mappings.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

