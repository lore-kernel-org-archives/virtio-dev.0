Return-Path: virtio-dev-return-3633-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FD5E581905A
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Mar 2018 08:15:32 -0700 (PDT)
Date: Thu, 22 Mar 2018 17:15:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180322171450-mutt-send-email-mst@kernel.org>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
 <20180319071537.28649-6-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319071537.28649-6-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH v2 5/6] vfio: remove DPRINTF() definition from
 vfio-common.h
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 19, 2018 at 03:15:36PM +0800, Tiwei Bie wrote:
> This macro isn't used by any VFIO code. And its name is
> too generic. The vfio-common.h (in include/hw/vfio) can
> be included by other modules in QEMU. It can introduce
> conflicts.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

This one can go ahead immediately.
Try posting as a separate patch.

> ---
>  include/hw/vfio/vfio-common.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b820f7984c..f6aa4ae959 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -34,15 +34,6 @@
>  #define ERR_PREFIX "vfio error: %s: "
>  #define WARN_PREFIX "vfio warning: %s: "
>  
> -/*#define DEBUG_VFIO*/
> -#ifdef DEBUG_VFIO
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  enum {
>      VFIO_DEVICE_TYPE_PCI = 0,
>      VFIO_DEVICE_TYPE_PLATFORM = 1,
> -- 
> 2.11.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

