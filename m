Return-Path: virtio-dev-return-2884-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 84C2E5818F5D
	for <virtio-dev@lists.oasis-open.org>; Sat, 23 Dec 2017 23:29:28 -0800 (PST)
Message-ID: <5A3F57D0.9050007@intel.com>
Date: Sun, 24 Dec 2017 15:31:28 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>	<20171221210327.GB25009@bombadil.infradead.org>	<201712231159.ECI73411.tFFFJOHOVMOLQS@I-love.SAKURA.ne.jp>	<20171223032959.GA11578@bombadil.infradead.org> <201712232333.BAH82874.FFFtOMHSLVQOOJ@I-love.SAKURA.ne.jp>
In-Reply-To: <201712232333.BAH82874.FFFtOMHSLVQOOJ@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v20 3/7 RESEND] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/23/2017 10:33 PM, Tetsuo Handa wrote:
>>>> +	bitmap = rcu_dereference_raw(*slot);
>>>> +	if (!bitmap) {
>>>> +		bitmap = this_cpu_xchg(ida_bitmap, NULL);
>>>> +		if (!bitmap)
>>>> +			return -ENOMEM;
>>> I can't understand this. I can understand if it were
>>>
>>>    BUG_ON(!bitmap);
>>>
>>> because you called xb_preload().
>>>
>>> But
>>>
>>> 	/*
>>> 	 * Regular test 2
>>> 	 * set bit 2000, 2001, 2040
>>> 	 * Next 1 in [0, 2048)		--> 2000
>>> 	 * Next 1 in [2000, 2002)	--> 2000
>>> 	 * Next 1 in [2002, 2041)	--> 2040
>>> 	 * Next 1 in [2002, 2040)	--> none
>>> 	 * Next 0 in [2000, 2048)	--> 2002
>>> 	 * Next 0 in [2048, 2060)	--> 2048
>>> 	 */
>>> 	xb_preload(GFP_KERNEL);
>>> 	assert(!xb_set_bit(&xb1, 2000));
>>> 	assert(!xb_set_bit(&xb1, 2001));
>>> 	assert(!xb_set_bit(&xb1, 2040));
>> [...]
>>> 	xb_preload_end();
>>>
>>> you are not calling xb_preload() prior to each xb_set_bit() call.
>>> This means that, if each xb_set_bit() is not surrounded with
>>> xb_preload()/xb_preload_end(), there is possibility of hitting
>>> this_cpu_xchg(ida_bitmap, NULL) == NULL.
>> This is just a lazy test.  We "know" that the bits in the range 1024-2047
>> will all land in the same bitmap, so there's no need to preload for each
>> of them.
> Testcases also serves as how to use that API.
> Assuming such thing leads to incorrect usage.

If callers are aware that the bits that they going to record locate in 
the same bitmap, I think they should also perform the xb_ APIs with only 
one preload. So the test cases here have shown them a correct example. 
We can probably add some comments above to explain this.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

