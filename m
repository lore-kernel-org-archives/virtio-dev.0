Return-Path: virtio-dev-return-7770-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A038985D3E
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Sep 2020 07:05:50 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:05:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200909070542.e37mfkz6qqfv3ghs@sirius.home.kraxel.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
 <20200902210847.2689-11-gurchetansingh@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200902210847.2689-11-gurchetansingh@chromium.org>
Subject: [virtio-dev] Re: [PATCH v2 10/23] virtio-gpu api: host visible feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, sebastien.boeuf@intel.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> +enum virtio_gpu_shm_id {
> +	VIRTIO_GPU_SHM_ID_UNDEFINED = 0,
> +	VIRTIO_GPU_SHM_ID_HOST_VISIBLE = 1
> +};

I think this is also not in the virtio spec update.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

