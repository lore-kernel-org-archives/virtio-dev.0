Return-Path: virtio-dev-return-7566-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F23D986079
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 06:43:32 +0000 (UTC)
Date: Thu, 16 Jul 2020 02:43:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200716024114-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-2-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1594867315-8626-2-git-send-email-teawater@gmail.com>
Subject: [virtio-dev] Re: [RFC for Linux v4 1/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Hui Zhu <teawater@gmail.com>
Cc: david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Hui Zhu <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 16, 2020 at 10:41:51AM +0800, Hui Zhu wrote:
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index dc3e656..4d0151a 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12

So how does the guest/host interface look like?
Could you write up something about it?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

