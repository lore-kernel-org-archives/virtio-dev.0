Return-Path: virtio-dev-return-2871-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DD1A758180FF
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Dec 2017 18:47:48 -0800 (PST)
Message-ID: <5A3B2148.8050306@intel.com>
Date: Thu, 21 Dec 2017 10:49:44 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com> <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp> <5A3A3CBC.4030202@intel.com> <20171220122547.GA1654@bombadil.infradead.org> <286AC319A985734F985F78AFA26841F73938CC3E@shsmsx102.ccr.corp.intel.com> <20171220171019.GA12236@bombadil.infradead.org>
In-Reply-To: <20171220171019.GA12236@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v20 0/7] Virtio-balloon Enhancement
To: Matthew Wilcox <willy@infradead.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/21/2017 01:10 AM, Matthew Wilcox wrote:
> On Wed, Dec 20, 2017 at 04:13:16PM +0000, Wang, Wei W wrote:
>> On Wednesday, December 20, 2017 8:26 PM, Matthew Wilcox wrote:
>>> 	unsigned long bit;
>>> 	xb_preload(GFP_KERNEL);
>>> 	xb_set_bit(xb, 700);
>>> 	xb_preload_end();
>>> 	bit = xb_find_set(xb, ULONG_MAX, 0);
>>> 	assert(bit == 700);
>> This above test will result in "!node with bitmap !=NULL", and it goes to the regular "if (bitmap)" path, which finds 700.
>>
>> A better test would be
>> ...
>> xb_set_bit(xb, 700);
>> assert(xb_find_set(xb, ULONG_MAX, 800) == ULONG_MAX);
>> ...
> I decided to write a test case to show you what I meant, then I discovered
> the test suite didn't build, then the test I wrote took forever to run, so
> I rewrote xb_find_set() using the radix tree iterators.  So I have no idea
> what bugs may be in your implementation, but at least this function passes
> the current test suite.  Of course, there may be gaps in the test suite.
> And since I changed the API to not have the ambiguous return value, I
> also changed the test suite, and maybe I introduced a bug.

Thanks for the effort. That's actually caused by the previous "!node" 
path, which incorrectly changed "index = (index | RADIX_TREE_MAP_MASK) + 
1". With the change below, it will run pretty well with the test cases.

if (!node && !bitmap)
     return size;

Would you mind to have a try with the v20 RESEND patch that was just 
shared? It makes the above change and added the test case you suggested?

One more question is about the return value, why would it be ambiguous? 
I think it is the same as find_next_bit() which returns the found bit or 
size if not found.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

