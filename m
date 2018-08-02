Return-Path: virtio-dev-return-4767-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07FAE985CF9
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Aug 2018 11:23:30 +0000 (UTC)
Message-ID: <5B62EAAC.8000505@intel.com>
Date: Thu, 02 Aug 2018 19:27:40 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com> <1532683495-31974-3-git-send-email-wei.w.wang@intel.com> <20180730090041.GC24267@dhcp22.suse.cz> <5B619599.1000307@intel.com> <20180801113444.GK16767@dhcp22.suse.cz> <5B62DDCC.3030100@intel.com> <87d7ae45-79cb-e294-7397-0e45e2af49cd@I-love.SAKURA.ne.jp>
In-Reply-To: <87d7ae45-79cb-e294-7397-0e45e2af49cd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Michal Hocko <mhocko@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, akpm@linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/02/2018 07:00 PM, Tetsuo Handa wrote:
> On 2018/08/02 19:32, Wei Wang wrote:
>> On 08/01/2018 07:34 PM, Michal Hocko wrote:
>>> Do you have any numbers for how does this work in practice?
>> It works in this way: for example, we can set the parameter, balloon_pages_to_shrink,
>> to shrink 1GB memory once shrink scan is called. Now, we have a 8GB guest, and we balloon
>> out 7GB. When shrink scan is called, the balloon driver will get back 1GB memory and give
>> them back to mm, then the ballooned memory becomes 6GB.
> Since shrinker might be called concurrently (am I correct?),

Not sure about it being concurrently, but I think it would be called 
repeatedly as should_continue_reclaim() returns true.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

