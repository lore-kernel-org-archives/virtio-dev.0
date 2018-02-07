Return-Path: virtio-dev-return-3175-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EA4AF5819121
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Feb 2018 10:34:31 -0800 (PST)
Date: Wed, 7 Feb 2018 20:34:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180207203004-mutt-send-email-mst@kernel.org>
References: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
 <1517986471-15185-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517986471-15185-4-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v27 3/4] mm/page_poison: expose page_poisoning_enabled to
 kernel modules
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, huangzhichao@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 07, 2018 at 02:54:30PM +0800, Wei Wang wrote:
> In some usages, e.g. virtio-balloon, a kernel module needs to know if
> page poisoning is in use. This patch exposes the page_poisoning_enabled
> function to kernel modules.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  mm/page_poison.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index e83fd44..c08d02a 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -30,6 +30,11 @@ bool page_poisoning_enabled(void)
>  		debug_pagealloc_enabled()));
>  }
>  
> +/**
> + * page_poisoning_enabled - check if page poisoning is enabled
> + *
> + * Return true if page poisoning is enabled, or false if not.
> + */
>  static void poison_page(struct page *page)
>  {
>  	void *addr = kmap_atomic(page);
> @@ -37,6 +42,7 @@ static void poison_page(struct page *page)
>  	memset(addr, PAGE_POISON, PAGE_SIZE);
>  	kunmap_atomic(addr);
>  }
> +EXPORT_SYMBOL_GPL(page_poisoning_enabled);
>  
>  static void poison_pages(struct page *page, int n)
>  {

Looks like both the comment and the export are in the wrong place.
I'm a bit concerned that callers also in fact poke at the
PAGE_POISON - exporting that seems to be more of an accident
as it's only used without page_poisoning.c - it might be
better to have page_poisoning_enabled get u8 * and set it.

> -- 
> 2.7.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

