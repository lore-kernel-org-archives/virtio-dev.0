Return-Path: virtio-dev-return-2812-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DEDD5818CA4
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Dec 2017 04:24:14 -0800 (PST)
Message-ID: <5A311C5E.7000304@intel.com>
Date: Wed, 13 Dec 2017 20:26:06 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com> <201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
In-Reply-To: <201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v19 3/7] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/12/2017 09:20 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> +void xb_clear_bit_range(struct xb *xb, unsigned long start, unsigned long end)
>> +{
>> +	struct radix_tree_root *root = &xb->xbrt;
>> +	struct radix_tree_node *node;
>> +	void **slot;
>> +	struct ida_bitmap *bitmap;
>> +	unsigned int nbits;
>> +
>> +	for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
>> +		unsigned long index = start / IDA_BITMAP_BITS;
>> +		unsigned long bit = start % IDA_BITMAP_BITS;
>> +
>> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
>> +		if (radix_tree_exception(bitmap)) {
>> +			unsigned long ebit = bit + 2;
>> +			unsigned long tmp = (unsigned long)bitmap;
>> +
>> +			nbits = min(end - start + 1, BITS_PER_LONG - ebit);
>> +
>> +			if (ebit >= BITS_PER_LONG)
> What happens if we hit this "continue;" when "index == ULONG_MAX / IDA_BITMAP_BITS" ?

Thanks. I also improved the test case for this. I plan to change the 
implementation a little bit to avoid such overflow (has passed the test 
case that I have, just post out for another set of eyes):

{
...
         unsigned long idx = start / IDA_BITMAP_BITS;
         unsigned long bit = start % IDA_BITMAP_BITS;
         unsigned long idx_end = end / IDA_BITMAP_BITS;
         unsigned long ret;

         for (idx = start / IDA_BITMAP_BITS; idx <= idx_end; idx++) {
                 unsigned long ida_start = idx * IDA_BITMAP_BITS;

                 bitmap = __radix_tree_lookup(root, idx, &node, &slot);
                 if (radix_tree_exception(bitmap)) {
                         unsigned long tmp = (unsigned long)bitmap;
                         unsigned long ebit = bit + 2;

                         if (ebit >= BITS_PER_LONG)
                                 continue;
                         if (set)
                                 ret = find_next_bit(&tmp, 
BITS_PER_LONG, ebit);
                         else
                                 ret = find_next_zero_bit(&tmp, 
BITS_PER_LONG,
                                                          ebit);
                         if (ret < BITS_PER_LONG)
                                 return ret - 2 + ida_start;
                 } else if (bitmap) {
                         if (set)
                                 ret = find_next_bit(bitmap->bitmap,
                                                     IDA_BITMAP_BITS, bit);
                         else
                                 ret = find_next_zero_bit(bitmap->bitmap,
IDA_BITMAP_BITS, bit);
                         if (ret < IDA_BITMAP_BITS)
                                 return ret + ida_start;
                 } else if (!bitmap && !set) {
                         return bit + IDA_BITMAP_BITS * idx;
                 }
                 bit = 0;
         }

         return end;
}


>
> Can you eliminate exception path and fold all xbitmap patches into one, and
> post only one xbitmap patch without virtio-baloon changes? If exception path
> is valuable, you can add exception path after minimum version is merged.
> This series is too difficult for me to close corner cases.

That exception path is claimed to save memory, and I don't have a strong 
reason to remove that part.
Matthew, could we get your feedback on this?



>
>> +/**
>> + * xb_find_next_set_bit - find the next set bit in a range
>> + * @xb: the xbitmap to search
>> + * @start: the start of the range, inclusive
>> + * @end: the end of the range, exclusive
>> + *
>> + * Returns: the index of the found bit, or @end + 1 if no such bit is found.
>> + */
>> +unsigned long xb_find_next_set_bit(struct xb *xb, unsigned long start,
>> +				   unsigned long end)
>> +{
>> +	return xb_find_next_bit(xb, start, end, 1);
>> +}
> Won't "exclusive" loose ability to handle ULONG_MAX ? Since this is a
> library module, missing ability to handle ULONG_MAX sounds like an omission.
> Shouldn't we pass (or return) whether "found or not" flag (e.g. strtoul() in
> C library function)?
>
>    bool xb_find_next_set_bit(struct xb *xb, unsigned long start, unsigned long end, unsigned long *result);
>    unsigned long xb_find_next_set_bit(struct xb *xb, unsigned long start, unsigned long end, bool *found);

Yes, ULONG_MAX needs to be tested by xb_test_bit(). Compared to checking 
the return value, would it be the same to let the caller check for the 
ULONG_MAX boundary?

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

