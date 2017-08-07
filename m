Return-Path: virtio-dev-return-2457-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 744B25818E5B
	for <virtio-dev@lists.oasis-open.org>; Sun,  6 Aug 2017 23:56:02 -0700 (PDT)
Message-ID: <59880FA5.6040703@intel.com>
Date: Mon, 07 Aug 2017 14:58:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com> <1501742299-4369-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1501742299-4369-2-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v13 1/5] Introduce xbitmap
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, mawilcox@microsoft.com, akpm@linux-foundation.org, willy@infradead.org
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, liliang.opensource@gmail.com, amit.shah@redhat.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, yang.zhang.wz@gmail.com, mgorman@techsingularity.net
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/03/2017 02:38 PM, Wei Wang wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster.  It supports up to
> 'unsigned long' worth of bits, and this commit adds the bare bones --
> xb_set_bit(), xb_clear_bit() and xb_test_bit().
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   include/linux/radix-tree.h |   2 +
>   include/linux/xbitmap.h    |  49 ++++++++++++++++
>   lib/radix-tree.c           | 139 ++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 188 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/xbitmap.h
>
> diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
> index 3e57350..428ccc9 100644
> --- a/include/linux/radix-tree.h
> +++ b/include/linux/radix-tree.h


Hi Matthew,

Could you please help to upstream this patch?


Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

