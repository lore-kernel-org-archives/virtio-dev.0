Return-Path: virtio-dev-return-4308-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C0B0158191AD
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 00:28:17 -0700 (PDT)
Message-ID: <5B1A30ED.6040906@intel.com>
Date: Fri, 08 Jun 2018 15:31:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180529181221-mutt-send-email-mst@kernel.org> <5B0E6AE9.2030505@intel.com> <20180530154325-mutt-send-email-mst@kernel.org> <5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi> <5B168EAB.7090607@intel.com> <20180606054227.GA7815@xz-mi> <5B17B1A7.8060307@intel.com> <20180606110217.GF7815@xz-mi> <5B18C18D.3070007@intel.com> <20180607063241.GA750@xz-mi>
In-Reply-To: <20180607063241.GA750@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v7 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/07/2018 02:32 PM, Peter Xu wrote:
>>>> Btw, the migration_state_notifiers is already there, but seems not really
>>>> used (I only tracked spice-core.c called
>>>> add_migration_state_change_notifier). I thought adding new migration states
>>>> can reuse all that we have.
>>>> What's your real concern about that? (not sure how defining new events would
>>>> make a difference)
>>> Migration state is exposed via control path (QMP).  Adding new states
>>> mean that the QMP clients will see more.  IMO that's not really
>>> anything that a QMP client will need to know, instead we can keep it
>>> internally.  That's a reason from compatibility pov.
>>>
>>> Meanwhile, it's not really a state-thing at all for me.  It looks
>>> really more like hook or event (start/stop of sync).
>> Thanks for sharing your concerns in detail, which are quite helpful for the
>> discussion. To reuse 99a0db9b, we can also add sub-states (or say events),
>> instead of new migration states.
>> For example, we can still define "enum RamSaveState" as above, which can be
>> an indication for the notifier queued on the 99a0db9b notider_list to decide
>> whether to call start or stop.
>> Does this solve your concern?
> Frankly speaking I don't fully understand how you would add that
> sub-state.  If you are confident with the idea, maybe you can post
> your new version with the change, then I can read the code.

Reusing 99a0db9b functions well, but I find it is more clear to let ram 
save state have it's own notifier list..will show how that works in v8.

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

