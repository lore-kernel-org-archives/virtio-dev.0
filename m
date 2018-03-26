Return-Path: virtio-dev-return-3644-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F1BF5818F6A
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Mar 2018 20:25:52 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 26 Mar 2018 03:24:00 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739485741@shsmsx102.ccr.corp.intel.com>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
 <1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v29 3/4] mm/page_poison: expose page_poisoning_enabled
 to kernel modules
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "huangzhichao@huawei.com" <huangzhichao@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Monday, March 26, 2018 10:40 AM, Wang, Wei W wrote:
> Subject: [PATCH v29 3/4] mm/page_poison: expose page_poisoning_enabled
> to kernel modules
>=20
> In some usages, e.g. virtio-balloon, a kernel module needs to know if pag=
e
> poisoning is in use. This patch exposes the page_poisoning_enabled functi=
on
> to kernel modules.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  mm/page_poison.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/mm/page_poison.c b/mm/page_poison.c index e83fd44..762b472
> 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -17,6 +17,11 @@ static int early_page_poison_param(char *buf)  }
> early_param("page_poison", early_page_poison_param);
>=20
> +/**
> + * page_poisoning_enabled - check if page poisoning is enabled
> + *
> + * Return true if page poisoning is enabled, or false if not.
> + */
>  bool page_poisoning_enabled(void)
>  {
>  	/*
> @@ -29,6 +34,7 @@ bool page_poisoning_enabled(void)
>=20
> 	(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
>  		debug_pagealloc_enabled()));
>  }
> +EXPORT_SYMBOL_GPL(page_poisoning_enabled);
>=20
>  static void poison_page(struct page *page)  {
> --
> 2.7.4


Could we get a review of this patch? We've reviewed other parts, and this o=
ne seems to be the last part of this feature. Thanks.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

