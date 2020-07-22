Return-Path: virtio-dev-return-7605-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50021985D51
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jul 2020 12:04:26 +0000 (UTC)
Date: Wed, 22 Jul 2020 08:04:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200722080356-mutt-send-email-mst@kernel.org>
References: <20200629080615.26022-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629080615.26022-1-david@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration
 fails
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 29, 2020 at 10:06:15AM +0200, David Hildenbrand wrote:
> If something goes wrong during precopy, before stopping the VM, we will
> never send a S_DONE indication to the VM, resulting in the hinted pages
> not getting released to be used by the guest OS (e.g., Linux).
> 
> Easy to reproduce:
> 1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
> 2. Cancel migration (e.g., HMP "migrate_cancel")
> 3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
>    no free memory left.
> 
> While at it, add similar locking to virtio_balloon_free_page_done() as
> done in virtio_balloon_free_page_stop. Locking is still weird, but that
> has to be sorted out separately.
> 
> There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
> comments regarding S_DONE handling.
> 
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

IIUC this is superceded by Alexander's patches right?
If not pls rebase ...

> ---
>  hw/virtio/virtio-balloon.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 10507b2a43..8a84718490 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -628,8 +628,13 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
>  
> -    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
> -    virtio_notify_config(vdev);
> +    if (s->free_page_report_status != FREE_PAGE_REPORT_S_DONE) {
> +        /* See virtio_balloon_free_page_stop() */
> +        qemu_mutex_lock(&s->free_page_lock);
> +        s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
> +        qemu_mutex_unlock(&s->free_page_lock);
> +        virtio_notify_config(vdev);
> +    }
>  }
>  
>  static int
> @@ -653,17 +658,26 @@ virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
>      case PRECOPY_NOTIFY_SETUP:
>          precopy_enable_free_page_optimization();
>          break;
> -    case PRECOPY_NOTIFY_COMPLETE:
> -    case PRECOPY_NOTIFY_CLEANUP:
>      case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
>          virtio_balloon_free_page_stop(dev);
>          break;
>      case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
>          if (vdev->vm_running) {
>              virtio_balloon_free_page_start(dev);
> -        } else {
> -            virtio_balloon_free_page_done(dev);
> +            break;
>          }
> +        /*
> +         * Set S_DONE before migrating the vmstate, so the guest will reuse
> +         * all hinted pages once running on the destination. Fall through.
> +         */
> +    case PRECOPY_NOTIFY_CLEANUP:
> +        /*
> +         * Especially, if something goes wrong during precopy or if migration
> +         * is canceled, we have to properly communicate S_DONE to the VM.
> +         */
> +        virtio_balloon_free_page_done(dev);
> +        break;
> +    case PRECOPY_NOTIFY_COMPLETE:
>          break;
>      default:
>          virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

