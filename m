Return-Path: virtio-dev-return-4873-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE2E0985B6F
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Sep 2018 05:47:56 +0000 (UTC)
Date: Fri, 21 Sep 2018 07:47:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180921054752.gjeaznoboqf2giit@sirius.home.kraxel.org>
References: <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
 <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
 <d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
 <20180919113807.6mwqxkdg6f55h6fg@sirius.home.kraxel.org>
 <bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
 <20180920063201.nt7kw555s4clshzr@sirius.home.kraxel.org>
 <95778dd4-8aca-eff6-f84a-c8efdd3b355d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95778dd4-8aca-eff6-f84a-c8efdd3b355d@amd.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
To: Jiandi An <jiandi@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Dave Airlie <airlied@linux.ie>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Just pass it down, the call sites all know it (see patch just sent).
> 
> Tested that patch you sent.  Together with this patch it also resolves
> the virtio gpu graphical display issue for SEV guest.

Cool.  Can you ack or review the patch so I can commit it?

> Is there a way to optimize the dma_sync_sg to only sync on the pages
> being updated instead of all the pages in the obj sgl list every time?

Well, the rectangle is passed to virtio_gpu_cmd_transfer_to_host_2d, so
it should be possible to figure which pages are affected and trim the
scatter list accordingly.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

