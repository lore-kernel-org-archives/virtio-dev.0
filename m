Return-Path: virtio-dev-return-2782-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D0A8E58190D5
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Dec 2017 03:59:27 -0800 (PST)
Message-ID: <5A292D94.5000700@intel.com>
Date: Thu, 07 Dec 2017 20:01:24 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>	<5A210C96.8050208@intel.com>	<201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>	<286AC319A985734F985F78AFA26841F739376DA1@shsmsx102.ccr.corp.intel.com>	<20171201172519.GA27192@bombadil.infradead.org> <201712031050.IAC64520.QVLFFOOJOSFtHM@I-love.SAKURA.ne.jp>
In-Reply-To: <201712031050.IAC64520.QVLFFOOJOSFtHM@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v18 05/10] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/03/2017 09:50 AM, Tetsuo Handa wrote:
> Matthew Wilcox wrote:
>> On Fri, Dec 01, 2017 at 03:09:08PM +0000, Wang, Wei W wrote:
>>> On Friday, December 1, 2017 9:02 PM, Tetsuo Handa wrote:
>>>> If start == end is legal,
>>>>
>>>>     for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
>>>>
>>>> makes this loop do nothing because 10 < 10 is false.
>>> How about "start <= end "?
>> Don't ask Tetsuo for his opinion, write some userspace code that uses it.
>>
> Please be sure to prepare for "end == -1UL" case, for "start < end" will become
> true when "start = (start | (IDA_BITMAP_BITS - 1)) + 1" made "start == 0" due to
> overflow.

I think there is one more corner case with this API: searching for bit 
"1" from [0, ULONG_MAX] while no bit is set in the range, there appear 
to be no possible value that we can return (returning "end + 1" will be 
"ULONG_MAX + 1", which is 0)
I plan to make the "end" be exclusive of the searching, that is, [start, 
end), and return "end" if no such bit is found.

For cases like [16, 16), returning 16 doesn't mean bit 16 is 1 or 0, it 
simply means there is no bits to search in the given range, since 16 is 
exclusive.

Please let me know if you have a different thought.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

