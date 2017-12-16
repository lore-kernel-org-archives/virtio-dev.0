Return-Path: virtio-dev-return-2841-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 43BC55818043
	for <virtio-dev@lists.oasis-open.org>; Sat, 16 Dec 2017 02:08:19 -0800 (PST)
Message-ID: <5A34F103.7070004@intel.com>
Date: Sat, 16 Dec 2017 18:10:11 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com> <201712151837.MQq7hdgk%fengguang.wu@intel.com> <20171215132405.GB10348@bombadil.infradead.org>
In-Reply-To: <20171215132405.GB10348@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v19 1/7] xbitmap: Introduce xbitmap
To: Matthew Wilcox <willy@infradead.org>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/15/2017 09:24 PM, Matthew Wilcox wrote:
> On Fri, Dec 15, 2017 at 07:05:07PM +0800, kbuild test robot wrote:
>>      21		struct radix_tree_node *node;
>>      22		void **slot;
>                               ^^^
> missing __rcu annotation here.
>
> Wei, could you fold that change into your next round?  Thanks!
>

Sure, I'll do. Thanks for your time on this patch series.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

