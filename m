Return-Path: virtio-dev-return-5111-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B539985B80
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Dec 2018 08:05:51 +0000 (UTC)
Message-ID: <5C04E50A.1040603@intel.com>
Date: Mon, 03 Dec 2018 16:10:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com> <1543803511-34793-6-git-send-email-wei.w.wang@intel.com> <20181203052021.GC27620@xz-x1>
In-Reply-To: <20181203052021.GC27620@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v10 5/7] migration/ram.c: add a notifier chain for precopy
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/03/2018 01:20 PM, Peter Xu wrote:
> On Mon, Dec 03, 2018 at 10:18:29AM +0800, Wei Wang wrote:
>> This patch adds a notifier chain for the memory precopy. This enables various
>> precopy optimizations to be invoked at specific places.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
>> ---
> [...]
>
>> +int precopy_notify(PrecopyNotifyReason reason, Error **errp);
> This function could be hidden from include/migration/misc.h, but I
> don't know whether that is a reason for a repost.
>
> And what I meant was that we fail precopy if notifier failed the
> hooks, but warning is fine too anyway no real use case there.

Yes, I was also thinking about this. Failing precopy needs to change
some upper layer functions which are defined with "void".

There is no use case that needs to fail precopy currently, so I chose to
keep the change minimal. But we can make more changes if people think
it's necessary to do.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

