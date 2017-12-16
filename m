Return-Path: virtio-dev-return-2843-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 367775818043
	for <virtio-dev@lists.oasis-open.org>; Sat, 16 Dec 2017 02:12:21 -0800 (PST)
Message-ID: <5A34F1F4.6010900@intel.com>
Date: Sat, 16 Dec 2017 18:14:12 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>	<5A311C5E.7000304@intel.com>	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>	<5A31F445.6070504@intel.com> <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
In-Reply-To: <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v19 3/7] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/15/2017 12:29 AM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> I used the example of xb_clear_bit_range(), and xb_find_next_bit() is
>> the same fundamentally. Please let me know if anywhere still looks fuzzy.
> I don't think it is the same for xb_find_next_bit() with set == 0.
>
> +		if (radix_tree_exception(bmap)) {
> +			unsigned long tmp = (unsigned long)bmap;
> +			unsigned long ebit = bit + 2;
> +
> +			if (ebit >= BITS_PER_LONG)
> +				continue;
> +			if (set)
> +				ret = find_next_bit(&tmp, BITS_PER_LONG, ebit);
> +			else
> +				ret = find_next_zero_bit(&tmp, BITS_PER_LONG,
> +							 ebit);
> +			if (ret < BITS_PER_LONG)
> +				return ret - 2 + IDA_BITMAP_BITS * index;
>
> What I'm saying is that find_next_zero_bit() will not be called if you do
> "if (ebit >= BITS_PER_LONG) continue;" before calling find_next_zero_bit().
>
> When scanning "0000000000000000000000000000000000000000000000000000000000000001",
> "bit < BITS_PER_LONG - 2" case finds "0" in this word but
> "bit >= BITS_PER_LONG - 2" case finds "0" in next word or segment.
>
> I can't understand why this is correct behavior. It is too much puzzling.
>

OK, I'll post out a version without the exceptional path.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

