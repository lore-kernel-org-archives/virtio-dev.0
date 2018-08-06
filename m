Return-Path: virtio-dev-return-4776-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFE49985D1D
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Aug 2018 09:53:29 +0000 (UTC)
Message-ID: <5B681B41.6070205@intel.com>
Date: Mon, 06 Aug 2018 17:56:17 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com> <1533285146-25212-3-git-send-email-wei.w.wang@intel.com> <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
In-Reply-To: <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/03/2018 08:11 PM, Tetsuo Handa wrote:
> On 2018/08/03 17:32, Wei Wang wrote:
>> +static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>> +{
>> +	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
>> +	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
>> +	vb->shrinker.batch = 0;
>> +	vb->shrinker.seeks = DEFAULT_SEEKS;
> Why flags field is not set? If vb is allocated by kmalloc(GFP_KERNEL)
> and is nowhere zero-cleared, KASAN would complain it.

Could you point where in the code that would complain it?
I only see two shrinker flags (NUMA_AWARE and MEMCG_AWARE), and they 
seem not related to that.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

