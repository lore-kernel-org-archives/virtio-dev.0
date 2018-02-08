Return-Path: virtio-dev-return-3179-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 47FD858191A2
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Feb 2018 19:52:18 -0800 (PST)
Message-ID: <5A7BCA07.2000704@intel.com>
Date: Thu, 08 Feb 2018 11:54:47 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com> <1517915299-15349-3-git-send-email-wei.w.wang@intel.com> <20180207014345-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180207014345-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 2/3] migration: use the free page reporting feature
 from balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 02/07/2018 07:57 AM, Michael S. Tsirkin wrote:
> On Tue, Feb 06, 2018 at 07:08:18PM +0800, Wei Wang wrote:
>> Use the free page reporting feature from the balloon device to clear the
>> bits corresponding to guest free pages from the dirty bitmap, so that the
>> free memory are not sent.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
> What the patch seems to do is stop migration
> completely - blocking until guest completes the reporting.
>
> Which makes no sense to me, since it's just an optimization.
> Why not proceed with the migration? What do we have to loose?

If we want the optimization to run in parallel with the migration 
thread, we will need to create another polling thread, like 
multithreading compression. In that way, we will waste some host CPU. 
For example, the migration thread may proceed to send pages to the 
destination while the optimization thread is in progress, but those 
pages may turn out to be free pages (this is likely in the bulk stage) 
which don't need to be sent. In that case, why not let the migration 
thread wait a little bit (i.e. put the optimization into the migration 
thread) and proceed to do some useful things, instead of pretending to 
proceed but doing useless things?

The current plan of this patch is to skip free pages for the bulk stage 
only. I'm not sure if it would be useful for the 2nd stage onward, which 
basically relies on the dirty logging to send pages that have been 
written by the guest. For example, if the guest is not so active while 
live migration happens, there will be very few dirty bits. This 
optimization would be mostly clearing "0" bits from the dirty bitmap.


> I imagine some people might want to defer migration until reporting
> completes to reduce the load on the network. Fair enough,
> but it does not look like you actually measured the reduction
> in traffic. So I suggest you work on that as a separate feature.
>

I have the traffic data actually. Tested with 8G idle guest, Legacy v.s. 
Optimization: ~390MB v.s. ~337MB.
The legacy case has the zero page checking optimization, so the traffic 
reduction is not very obvious. But zero checking has much more overhead, 
which is demonstrated by the migration time (this optimization takes 
~14% of the legacy migration time).


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

