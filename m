Return-Path: virtio-dev-return-5061-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2905985CA5
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Nov 2018 08:56:33 +0000 (UTC)
Message-ID: <5BFE596B.1080807@intel.com>
Date: Wed, 28 Nov 2018 17:01:31 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com> <1542276484-25508-6-git-send-email-wei.w.wang@intel.com> <20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com> <20181128052655.GC12839@xz-x1>
In-Reply-To: <20181128052655.GC12839@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 5/8] migration/ram.c: add a notifier chain for precopy
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/28/2018 01:26 PM, Peter Xu wrote:
>
> Ok thanks.  Please just make sure you will capture all the error
> cases, e.g., I also see path like this (a few lines below):
>
>          if (pages < 0) {
>              qemu_file_set_error(f, pages);
>              break;
>          }
>
> It seems that you missed that one.

I think that one should be fine. This notification is actually put at the
bottom of ram_save_iterate. All the above error will bail out to the "out:"
path and then go to call precopy_notify(PRECOPY_NOTIFY_ERR).

>
> I would even suggest that you capture the error with higher level.
> E.g., in migration_iteration_run() after qemu_savevm_state_iterate().
> Or we can just check the return value of qemu_savevm_state_iterate(),
> which we have had ignored so far.

Not very sure about the higher level, because other SaveStateEntry may cause
errors that this feature don't need to care, I think we may only need it 
in ram_save.


> [1]
>
>>
>>> Another thing to mention about the "reasons" (though I see it more
>>> like "events"): have you thought about adding a PRECOPY_NOTIFY_END?
>>> It might help in some cases:
>>>
>>>     - then you don't need to trickily export the migrate_postcopy()
>>>       since you'll notify that before postcopy starts
>> I'm thinking probably we don't need to export migrate_postcopy even now.
>> It's more like a sanity check, and not needed because now we have the
>> notifier registered to the precopy specific callchain, which has ensured
>> that
>> it is invoked via precopy.
> But postcopy will always start with precopy, no?

Yes, but I think we could add the check in precopy_notify()


>
>>>     - you'll have a solid point that you'll 100% guarantee that we'll
>>>       stop the free page hinting and don't need to worry about whether
>>>       there is chance the hinting will be running without an end [2].
>> Thanks, I think it makes sense. Plan to add PRECOPY_NOTIFY_END in
>> ram_save_complete.
> Yeah you can.
>
> Btw, if you're mostly adding the notifies only in RAM-only codes, then
> you can consider add the "RAM" into the names of events too to be
> clear.

Sounds good, will try and see if the name would become too long :)

>
> My suggestion at [1] is precopy general, but you can still capture it
> at the end of ram_save_iterate, then they are RAM-only again.  Please
> feel free to choose what fits more...

OK, thanks.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

