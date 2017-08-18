Return-Path: virtio-dev-return-2477-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4714558182B4
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Aug 2017 00:37:15 -0700 (PDT)
Message-ID: <599699AF.1090705@intel.com>
Date: Fri, 18 Aug 2017 15:39:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com> <1502940416-42944-4-git-send-email-wei.w.wang@intel.com> <20170818051451-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170818051451-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v14 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/18/2017 10:22 AM, Michael S. Tsirkin wrote:
> +static void send_balloon_page_sg(struct virtio_balloon *vb,
> +				 struct virtqueue *vq,
> +				 void *addr,
> +				 uint32_t size)
> +{
> +	unsigned int len;
> +	int ret;
> +
> +	do {
> +		ret = add_one_sg(vq, addr, size);
> +		virtqueue_kick(vq);
> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +		/*
> +		 * It is uncommon to see the vq is full, because the sg is sent
> +		 * one by one and the device is able to handle it in time. But
> +		 * if that happens, we go back to retry after an entry gets
> +		 * released.
> +		 */
> Why send one by one though? Why not batch some s/gs and wait for all
> of them to be completed? If memory if fragmented, waiting every time is
> worse than what we have now (VIRTIO_BALLOON_ARRAY_PFNS_MAX at a time).
>

OK, I'll do batching in some fashion.


Best,
Wei




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

