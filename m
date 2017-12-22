Return-Path: virtio-dev-return-2882-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 621811CB807E
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Dec 2017 00:43:27 -0800 (PST)
Message-ID: <5A3CC62D.6020001@intel.com>
Date: Fri, 22 Dec 2017 16:45:33 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>	<20171221141805.GA27695@bombadil.infradead.org> <201712212337.JFC57368.tLFOJFVSFHMOOQ@I-love.SAKURA.ne.jp>
In-Reply-To: <201712212337.JFC57368.tLFOJFVSFHMOOQ@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v20 3/7 RESEND] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/21/2017 10:37 PM, Tetsuo Handa wrote:
> Matthew Wilcox wrote:
>>> +/**
>>> + * xb_find_set - find the next set bit in a range of bits
>>> + * @xb: the xbitmap to search from
>>> + * @offset: the offset in the range to start searching
>>> + * @size: the size of the range
>>> + *
>>> + * Returns: the found bit or, @size if no set bit is found.
>>> + */
>>> +unsigned long xb_find_set(struct xb *xb, unsigned long size,
>>> +			  unsigned long offset)
>>> +{
>>> +	struct radix_tree_root *root = &xb->xbrt;
>>> +	struct radix_tree_node *node;
>>> +	void __rcu **slot;
>>> +	struct ida_bitmap *bitmap;
>>> +	unsigned long index = offset / IDA_BITMAP_BITS;
>>> +	unsigned long index_end = size / IDA_BITMAP_BITS;
>>> +	unsigned long bit = offset % IDA_BITMAP_BITS;
>>> +
>>> +	if (unlikely(offset >= size))
>>> +		return size;
>>> +
>>> +	while (index <= index_end) {
>>> +		unsigned long ret;
>>> +		unsigned int nbits = size - index * IDA_BITMAP_BITS;
>>> +
>>> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
>>> +
>>> +		if (!node && !bitmap)
>>> +			return size;
>>> +
>>> +		if (bitmap) {
>>> +			if (nbits > IDA_BITMAP_BITS)
>>> +				nbits = IDA_BITMAP_BITS;
>>> +
>>> +			ret = find_next_bit(bitmap->bitmap, nbits, bit);
>>> +			if (ret != nbits)
>>> +				return ret + index * IDA_BITMAP_BITS;
>>> +		}
>>> +		bit = 0;
>>> +		index++;
>>> +	}
>>> +
>>> +	return size;
>>> +}
>>> +EXPORT_SYMBOL(xb_find_set);
>> This is going to be slower than the implementation I sent yesterday.  If I
>> call:
>> 	xb_init(xb);
>> 	xb_set_bit(xb, ULONG_MAX);
>> 	xb_find_set(xb, ULONG_MAX, 0);
>>
>> it's going to call __radix_tree_lookup() 16 quadrillion times.
>> My implementation will walk the tree precisely once.
>>
> Yes. Wei's patch still can not work.
> We should start reviewing Matthew's implementation.

It runs without any issue on my machine. I didn't generate an "xbitmap" 
executable (I just found adding xbitmap executable causes a build error 
due to a Makefile error), instead, I tested it within "main" and it 
passed all the tests.

Matthew has implemented a new version, let's start from there.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

