Return-Path: virtio-dev-return-4307-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7796F58180D0
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 00:11:00 -0700 (PDT)
Message-ID: <5B1A2CDE.7000905@intel.com>
Date: Fri, 08 Jun 2018 15:14:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180530154325-mutt-send-email-mst@kernel.org> <5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi> <5B168EAB.7090607@intel.com> <20180606054227.GA7815@xz-mi> <5B17B1A7.8060307@intel.com> <20180606110217.GF7815@xz-mi> <5B18C18D.3070007@intel.com> <20180607063241.GA750@xz-mi> <5B191E1A.1000605@intel.com> <20180608021758.GS750@xz-mi>
In-Reply-To: <20180608021758.GS750@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v7 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/08/2018 10:17 AM, Peter Xu wrote:
> On Thu, Jun 07, 2018 at 07:59:22PM +0800, Wei Wang wrote:
>> Not necessarily _need_ to share it, I meant it can be shared using qemu
>> command line.
>> Live migration doesn't happen all the time, and that optimization doesn't
>> run that long, if users want to have other BHs run in this iothread context,
>> they can only create one iothread via the qemu cmd line.
> IMO iothreads and aiocontexts are for event-driven model.

To me it's just a thread which polls for submitted callbacks to run. 
When migration reaches the place that needs to submit the optimization 
function, it calls start() to submit it. I'm not sure why there is a 
worry about what's inside the callback.

> Busy loop
> is not an event-driven model.  Here if we want a busy loop I'll create
> a thread when start page hinting, then join the thread when done.

  The old (v4) implementation worked that way as you mentioned above, 
and Michael suggested to use iothread in the previous discussion. I'm 
fine with both actually. For the virtio part, we've had many 
discussions, I would take the choice I had with Michael before, unless 
there is an obvious advantage (e.g. proved better performance).


>
> But I'll stop commenting on this.  Please prepare a more clear
> interface for migration in your next post.  I'll read that.
>

Sure, thanks. The new version is coming soon.




>>
>>>>> I'm a bit curious on how much time will it use to do
>>>>> one round of the free page hints (e.g., an idle guest with 8G mem, or
>>>>> any configuration you tested)?  I suppose during that time the
>>>>> iothread will be held steady with 100% cpu usage, am I right?
>>>> Compared to the time spent by the legacy migration to send free pages, that
>>>> small amount of CPU usage spent on filtering free pages could be neglected.
>>>> Grinding a chopper will not hold up the work of cutting firewood :)
>>> Sorry I didn't express myself clearly.
>>>
>>> My question was that, have you measured how long time it will take
>>> from starting of the free page hints (when balloon state is set to
>>> FREE_PAGE_REPORT_S_REQUESTED), until it completes (when QEMU receives
>>> the VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID, then set the status to
>>> FREE_PAGE_REPORT_S_STOP)?
>>>
>> I vaguely remember it's several ms (for around 7.5G free pages) long time
>> ago. What would be the concern behind that number you want to know?
> Because roughly I know the time between two bitmap syncs.  Then I will
> know how possible a free page hinting process won't stop until the
> next bitmap sync happens.

We have a function, stop(), to stop the optimization before the next 
bitmap sync if the optimization is still running. But I never saw that 
case happens (the free page hinting finishes itself before that).

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

