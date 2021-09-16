Return-Path: <virtio-dev-return-8669-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F4309863D0
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Sep 2021 05:50:58 +0000 (UTC)
Date: Thu, 16 Sep 2021 07:50:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20210916055046.jppdym2g7mhdxcbv@sirius.home.kraxel.org>
References: <20210909013717.861-1-gurchetansingh@chromium.org>
 <20210909013717.861-9-gurchetansingh@chromium.org>
 <20210915055350.sgfadzktcl5bngtq@sirius.home.kraxel.org>
 <CAAfnVB=z80_cK_Z3Gkk1WXUopkuPiF67QNrD8O8StmijApYqcQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAfnVB=z80_cK_Z3Gkk1WXUopkuPiF67QNrD8O8StmijApYqcQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v1 08/12] drm/virtio: implement context
 init: stop using drv->context when creating fence
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > I guess you need to also update virtio_gpu_fence_event_process()
> > then?  It currently has the strict ordering logic baked in ...
> 
> The update to virtio_gpu_fence_event_process was done as a preparation a
> few months back:
> 
> https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/virtio/virtgpu_fence.c?id=36549848ed27c22bb2ffd5d1468efc6505b05f97

Ah, ok, missed the detail that the context check is already there.

thanks,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

