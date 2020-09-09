Return-Path: virtio-dev-return-7768-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6072D985D3E
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Sep 2020 06:55:45 +0000 (UTC)
Date: Wed, 9 Sep 2020 08:55:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200909065536.c5rfbmd2rlpwrpn6@sirius.home.kraxel.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
 <20200902210847.2689-10-gurchetansingh@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200902210847.2689-10-gurchetansingh@chromium.org>
Subject: [virtio-dev] Re: [PATCH v2 09/23] virtio-gpu api: blob resources
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, sebastien.boeuf@intel.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> @@ -100,7 +102,7 @@ struct drm_virtgpu_resource_info {
>  	__u32 bo_handle;
>  	__u32 res_handle;
>  	__u32 size;
> -	__u32 stride;
> +	__u32 blob_mem;
>  };

Huh?  This is not in the virtio spec update proposed.

>  struct drm_virtgpu_3d_box {
> @@ -117,6 +119,8 @@ struct drm_virtgpu_3d_transfer_to_host {
>  	struct drm_virtgpu_3d_box box;
>  	__u32 level;
>  	__u32 offset;
> +	__u32 stride;
> +	__u32 layer_stride;
>  };

Same here.

>  struct drm_virtgpu_3d_transfer_from_host {
> @@ -124,6 +128,8 @@ struct drm_virtgpu_3d_transfer_from_host {
>  	struct drm_virtgpu_3d_box box;
>  	__u32 level;
>  	__u32 offset;
> +	__u32 stride;
> +	__u32 layer_stride;
>  };

And here.

take care,
  Gerd

PS: cherry-picked patches 1-3 into drm-misc-next.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

