Return-Path: <virtio-dev-return-8744-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97AC598648F
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Sep 2021 07:33:30 +0000 (UTC)
Date: Wed, 29 Sep 2021 09:33:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20210929073322.rtakdo6isjucsj25@sirius.home.kraxel.org>
References: <20210921232024.817-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20210921232024.817-1-gurchetansingh@chromium.org>
Subject: [virtio-dev] Re: [PATCH v3 00/12] Context types, v3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> Gurchetan Singh (10):
>   virtio-gpu api: multiple context types with explicit initialization
>   drm/virtgpu api: create context init feature
>   drm/virtio: implement context init: track valid capabilities in a mask
>   drm/virtio: implement context init: track {ring_idx, emit_fence_info}
>     in virtio_gpu_fence
>   drm/virtio: implement context init: plumb {base_fence_ctx, ring_idx}
>     to virtio_gpu_fence_alloc
>   drm/virtio: implement context init: stop using drv->context when
>     creating fence
>   drm/virtio: implement context init: allocate an array of fence
>     contexts
>   drm/virtio: implement context init: handle
>     VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK
>   drm/virtio: implement context init: add virtio_gpu_fence_event
>   drm/virtio: implement context init: advertise feature to userspace

Pushed to drm-misc-next.

thanks,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

