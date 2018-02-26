Return-Path: virtio-dev-return-3277-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 23BA45819119
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Feb 2018 20:39:31 -0800 (PST)
Message-ID: <5A939024.3080501@intel.com>
Date: Mon, 26 Feb 2018 12:42:12 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com> <20180208201523.GE2326@work-vm> <5A7D1121.6030903@intel.com> <20180209105335.GA2428@work-vm>
In-Reply-To: <20180209105335.GA2428@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 0/3] virtio-balloon: free page hint reporting support
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 02/09/2018 06:53 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> On 02/09/2018 04:15 AM, Dr. David Alan Gilbert wrote:
>>> * Wei Wang (wei.w.wang@intel.com) wrote:
>>>> This is the deivce part implementation to add a new feature,
>>>> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
>>>> receives the guest free page hints from the driver and clears the
>>>> corresponding bits in the dirty bitmap, so that those free pages are
>>>> not transferred by the migration thread to the destination.
>>>>
>>>> Please see the driver patch link for test results:
>>>> https://lkml.org/lkml/2018/2/4/60
>>> Hi Wei,
>>>      I'll look at the code a bit more - but first some more basic
>>> questions on that lkml post:
>>>
>>>       a) The idle guest time thing is a nice result; can you just state
>>>          what the host was, speed of connection, and what other options
>>>          you were using?
>>>
>>>       b) The workload test, the one with the kernel compile; you list
>>>          the kernel compile time but don't mention any changes in the
>>>          migration times of the ping-pong; can you give those times as
>>>          well?
>>>
>>>       c) What's your real workload that this is aimed at?
>>>          Is it really for people migrating idle VMs - or do you have some
>>>          NFV application in mind, if so why not include a figure for
>>>          those?
>>>
>> Hi Dave,
>>
>> Thanks for joining the review. Please see below info.
>>
>> a) Environment info
>>      - Host:
>>          - Physical CPU: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>>          - kernel: 3.10.0
>>
>>      - Guest:
>>          - kernel: 4.15.0
>>          - QEMU setup: -cpu host -M pc -smp 4,threads=1,sockets=1 -m 8G
>> --mem-prealloc -realtime mlock=on -balloon virtio,free-page-hint=true
>>
>>      - Migration setup:
>>          - migrate_set_speed 0
>>          - migrate_set_downtime 0.01  (10ms)
> That's an unusually low downtime (and I'm not sure what setting the
> speed to 0 does!).

For idle guest tests, I used 0.01s downtime. If we run workloads, we can 
change it to 2s. Just make sure we set the same downtime for both legacy 
and optimization cases so that we can have an apple to apple comparison.

speed being set to 0 means using the largest bandwidth. Here it is 
effectively the same as setting it to 100G.

>
>> b) Michael asked the same question on the kernel patches, I'll reply there
>> with you cc-ed, so that kernel maintainers can also see it. Btw, do you have
>> any other workloads you would suggest to have a try?
> No, not really; I guess it's best for VMs that are either idle or have
> lots of spare RAM.

Yes, less free memory results in less improvement (please see the more 
results with the linux compilation workload shared in LKML).


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

