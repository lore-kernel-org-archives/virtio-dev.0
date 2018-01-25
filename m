Return-Path: virtio-dev-return-3048-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E17DA581911B
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jan 2018 19:29:44 -0800 (PST)
Message-ID: <5A694FB5.5090803@intel.com>
Date: Thu, 25 Jan 2018 11:32:05 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516790562-37889-1-git-send-email-wei.w.wang@intel.com> <1516790562-37889-3-git-send-email-wei.w.wang@intel.com> <20180124183349-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180124183349-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v24 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/25/2018 01:15 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 24, 2018 at 06:42:42PM +0800, Wei Wang wrote:
> +
> +static void report_free_page_func(struct work_struct *work)
> +{
> +	struct virtio_balloon *vb;
> +	unsigned long flags;
> +
> +	vb = container_of(work, struct virtio_balloon, report_free_page_work);
> +
> +	/* Start by sending the obtained cmd id to the host with an outbuf */
> +	send_cmd_id(vb, &vb->start_cmd_id);
> +
> +	/*
> +	 * Set start_cmd_id to VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID to
> +	 * indicate a new request can be queued.
> +	 */
> +	spin_lock_irqsave(&vb->stop_update_lock, flags);
> +	vb->start_cmd_id = cpu_to_virtio32(vb->vdev,
> +				VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID);
> +	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> +
> +	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
> Can you teach walk_free_mem_block to return the && of all
> return calls, so caller knows whether it completed?

There will be two cases that can cause walk_free_mem_block to return 
without completing:
1) host requests to stop in advance
2) vq->broken

How about letting walk_free_mem_block simply return the value returned 
by its callback (i.e. virtio_balloon_send_free_pages)?

For host requests to stop, it returns "1", and the above only bails out 
when walk_free_mem_block return a "< 0" value.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

