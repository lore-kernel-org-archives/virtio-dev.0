Return-Path: virtio-dev-return-7686-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EBF9985D39
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Aug 2020 06:38:31 +0000 (UTC)
Date: Wed, 19 Aug 2020 08:38:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200819063823.j5njabobxc767557@sirius.home.kraxel.org>
References: <20200819031011.310180-1-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200819031011.310180-1-stevensd@chromium.org>
Subject: [virtio-dev] Re: [PATCH] virtio: fix build for configs without dma-bufs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, kernel test robot <lkp@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 19, 2020 at 12:10:11PM +0900, David Stevens wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Stevens <stevensd@chromium.org>

Pushed to drm-misc-next

thanks for the qick fix,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

