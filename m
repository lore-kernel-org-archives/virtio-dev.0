Return-Path: virtio-dev-return-3276-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DFCA1581911B
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Feb 2018 19:58:42 -0800 (PST)
Message-ID: <5A938699.8020804@intel.com>
Date: Mon, 26 Feb 2018 12:01:29 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com> <20180208215048-mutt-send-email-mst@kernel.org> <5A7D116B.9070502@intel.com> <20180209051212-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180209051212-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v28 0/4] Virtio-balloon: support free page reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "huangzhichao@huawei.com" <huangzhichao@huawei.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 02/09/2018 11:14 AM, Michael S. Tsirkin wrote:
> On Fri, Feb 09, 2018 at 11:11:39AM +0800, Wei Wang wrote:
>> On 02/09/2018 03:55 AM, Michael S. Tsirkin wrote:
>>> On Thu, Feb 08, 2018 at 05:50:16PM +0800, Wei Wang wrote:
>>>
>>>> Details:
>>>> Set up a Ping-Pong local live migration, where the guest ceaselessy
>>>> migrates between the source and destination. Linux compilation,
>>>> i.e. make bzImage -j4, is performed during the Ping-Pong migration. The
>>>> legacy case takes 5min14s to finish the compilation. With this
>>>> optimization patched, it takes 5min12s.
>>> How is migration time affected in this case?
>>
>> When the linux compilation workload runs, the migration time (both the
>> legacy and this optimization case) varies as the compilation goes on. It
>> seems not easy to give a static speedup number, some times the migration
>> time is reduced to 33%, sometimes to 50%, it varies, and depends on how much
>> free memory the system has at that moment. For example, at the later stage
>> of the compilation, I can observe 5GB memory being used as page cache. But
>> overall, I can observe obvious improvement of the migration time.
>>
>>
>> Best,
>> Wei
> You can run multiple tests and give a best, worst and median numbers.
>

Sorry for my late response (I was on leaves for some other 
responsibilities).

Here are some more numbers of the live migration time comparison while 
linux compilation is in progress (probably the average time is more 
relevant)

average: 52.4% reduction (optimization v.s. legacy = 1242ms v.s. 2611ms)
best: 69.1%
worst: 21.9%


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

