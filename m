Return-Path: virtio-dev-return-2818-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2153158180FA
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2017 03:45:38 -0800 (PST)
Message-ID: <5A3264D1.8090405@intel.com>
Date: Thu, 14 Dec 2017 19:47:29 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>	<5A311C5E.7000304@intel.com> <201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp> <5A31F445.6070504@intel.com>
In-Reply-To: <5A31F445.6070504@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v19 3/7] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/14/2017 11:47 AM, Wei Wang wrote:
> On 12/13/2017 10:16 PM, Tetsuo Handa wrote:
>
>
>>
>>>                           if (set)
>>>                                   ret = find_next_bit(&tmp,
>>> BITS_PER_LONG, ebit);
>>>                           else
>>>                                   ret = find_next_zero_bit(&tmp,
>>> BITS_PER_LONG,
>>> ebit);
>>>                           if (ret < BITS_PER_LONG)
>>>                                   return ret - 2 + ida_start;
>>>                   } else if (bitmap) {
>>>                           if (set)
>>>                                   ret = find_next_bit(bitmap->bitmap,
>>> IDA_BITMAP_BITS, bit);
>>>                           else
>>>                                   ret = 
>>> find_next_zero_bit(bitmap->bitmap,
>>> IDA_BITMAP_BITS, bit);
>> "bit" may not be 0 for the first round and "bit" is always 0 afterwords.
>> But where is the guaranteed that "end" is a multiple of 
>> IDA_BITMAP_BITS ?
>> Please explain why it is correct to use IDA_BITMAP_BITS unconditionally
>> for the last round.
>
> There missed something here, it will be:
>
> nbits = min(end - ida_start + 1, IDA_BITMAP_BITS - bit);


captured a bug here, should be:
nbits = min(end - ida_start + 1, (unsigned long)IDA_BITMAP_BITS);


> if (set)
>     ret = find_next_bit(bitmap->bitmap, nbits, bit);
> else
>     ret = find_next_zero_bit(bitmap->bitmap,
>                                            nbits, bit);
> if (ret < nbits)
>     return ret + ida_start;
>
>

Best,
Wei





---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

