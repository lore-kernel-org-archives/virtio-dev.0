Return-Path: virtio-dev-return-7070-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2EFAA985FAE
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Apr 2020 17:46:05 +0000 (UTC)
References: <20200415174318.13597.99753.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <30194715-bd6d-42df-2de0-6d54ad5a1136@redhat.com>
Date: Wed, 15 Apr 2020 19:45:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200415174318.13597.99753.stgit@localhost.localdomain>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH] virtio-balloon: Avoid using the word 'report' when
 referring to free page hinting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>, jasowang@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 15.04.20 19:44, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> It can be confusing to have multiple features within the same driver that
> are using the same verbage. As such this patch is creating a union of
> free_page_report_cmd_id with free_page_hint_cmd_id so that we can clean-up
> the userspace code a bit in terms of readability while maintaining the
> functionality of legacy code.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/virtio/virtio_balloon.c     |    2 +-
>  include/uapi/linux/virtio_balloon.h |   11 +++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 0ef16566c3f3..95d9c2f0a7be 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -580,7 +580,7 @@ static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
>  	if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
>  			       &vb->config_read_bitmap))
>  		virtio_cread(vb->vdev, struct virtio_balloon_config,
> -			     free_page_report_cmd_id,
> +			     free_page_hint_cmd_id,
>  			     &vb->cmd_id_received_cache);
>  
>  	return vb->cmd_id_received_cache;
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 19974392d324..dc3e656470dd 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -48,8 +48,15 @@ struct virtio_balloon_config {
>  	__u32 num_pages;
>  	/* Number of pages we've actually got in balloon. */
>  	__u32 actual;
> -	/* Free page report command id, readonly by guest */
> -	__u32 free_page_report_cmd_id;
> +	/*
> +	 * Free page hint command id, readonly by guest.
> +	 * Was previously named free_page_report_cmd_id so we
> +	 * need to carry that name for legacy support.
> +	 */
> +	union {
> +		__u32 free_page_hint_cmd_id;
> +		__u32 free_page_report_cmd_id;	/* deprecated */
> +	};
>  	/* Stores PAGE_POISON if page poisoning is in use */
>  	__u32 poison_val;
>  };
> 

Can we also change the comment of

#define VIRTIO_BALLOON_F_FREE_PAGE_HINT	 /* VQ to report free pages */

?

Thanks!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

