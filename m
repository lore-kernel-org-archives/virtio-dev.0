Return-Path: virtio-dev-return-4863-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9494C985D29
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Sep 2018 04:46:05 +0000 (UTC)
Date: Wed, 19 Sep 2018 06:46:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
To: Jiandi An <jiandi@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Dave Airlie <airlied@linux.ie>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> buffer.  I tried to put a dma_sync_sg_for_device() on virtio_gpu_object obj->pages-sgl
> before VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D is sent.  This fixes the kernel console path.

That should be the right place.

> Once display manger is kicked off for example (sudo systemctl start lightdm.service) and
> resource id 3 gets created from user space down, it still gives a blank black screen.

Hmm.  I'd suspect there is simply a code path missing.  Can you send the
patch you have?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

