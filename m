Return-Path: virtio-dev-return-7541-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E09A2985FFF
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Jul 2020 12:15:02 +0000 (UTC)
References: <20200706211314.20018.89695.stgit@localhost.localdomain>
 <20200706211407.20018.51061.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <62c0ab76-cdef-27fd-e4db-a835e3dd7617@redhat.com>
Date: Fri, 10 Jul 2020 14:14:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200706211407.20018.51061.stgit@localhost.localdomain>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2 2/3] virtio-balloon: Add locking to prevent possible
 race when starting hinting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 06.07.20 23:14, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> There is already locking in place when we are stopping free page hinting
> but there is not similar protections in place when we start. I can only
> assume this was overlooked as in most cases the page hinting should not be
> occurring when we are starting the hinting, however there is still a chance
> we could be processing hints by the time we get back around to restarting
> the hinting so we are better off making sure to protect the state with the
> mutex lock rather than just updating the value with no protections.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 0c0fd7114799..b3e96a822b4d 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -593,6 +593,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>          return;
>      }
>  
> +    qemu_mutex_lock(&s->free_page_lock);
> +
>      if (s->free_page_report_cmd_id == UINT_MAX) {
>          s->free_page_report_cmd_id =
>                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> @@ -601,6 +603,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>      }
>  
>      s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
> +    qemu_mutex_unlock(&s->free_page_lock);
> +
>      virtio_notify_config(vdev);
>  }
>  
> 

Yes, makes sense, thanks

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

