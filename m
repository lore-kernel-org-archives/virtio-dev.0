Return-Path: virtio-dev-return-5073-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9CA319858B5
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Nov 2018 03:36:00 +0000 (UTC)
Message-ID: <5BFF5FC9.2020402@intel.com>
Date: Thu, 29 Nov 2018 11:40:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com> <1542276484-25508-6-git-send-email-wei.w.wang@intel.com> <20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com> <20181128052655.GC12839@xz-x1> <5BFE596B.1080807@intel.com> <20181128093220.GF12839@xz-x1>
In-Reply-To: <20181128093220.GF12839@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 5/8] migration/ram.c: add a notifier chain for precopy
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/28/2018 05:32 PM, Peter Xu wrote:
>
> So what I am worrying here are corner cases where we might forget to
> stop the hinting.  I'm fabricating one example sequence of events:
>
>    (start migration)
>    START_MIGRATION
>    BEFORE_SYNC
>    AFTER_SYNC
>    ...
>    BEFORE_SYNC
>    AFTER_SYNC
>    (some SaveStateEntry failed rather than RAM, then
>     migration_detect_error returned MIG_THR_ERR_FATAL so we need to
>     fail the migration, however when running the previous
>     ram_save_iterate for RAM's specific SaveStateEntry we didn't see
>     any error so no ERROR event detected)
>
> Then it seems the hinting will last forever.  Considering that now I'm
> not sure whether this can be done ram-only, since even if you capture
> ram_save_complete() and at the same time you introduce PRECOPY_END you
> may still miss the PRECOPY_END event since AFAIU ram_save_complete()
> won't be called at all in this case.
>
> Could this happen?

Thanks, indeed this case could happen if we add PRECOPY_END in
ram_save_complete.

How about putting PRECOPY_END in ram_save_cleanup?
I think it would be called in any case.

I'm also thinking probably we don't need PRECOPY_ERR when we have 
PRECOPY_END,
and what do you think of the notifier names below:

+typedef enum PrecopyNotifyReason {
+    PRECOPY_NOTIFY_RAM_SAVE_END = 0,
+    PRECOPY_NOTIFY_RAM_SAVE_START = 1,
+    PRECOPY_NOTIFY_RAM_SAVE_BEFORE_SYNC_BITMAP = 2,
+    PRECOPY_NOTIFY_RAM_SAVE_AFTER_SYNC_BITMAP = 3,
+    PRECOPY_NOTIFY_RAM_SAVE_MAX = 4,
+} PrecopyNotifyReason;


>
>>
>>> [1]
>>>
>>>>> Another thing to mention about the "reasons" (though I see it more
>>>>> like "events"): have you thought about adding a PRECOPY_NOTIFY_END?
>>>>> It might help in some cases:
>>>>>
>>>>>      - then you don't need to trickily export the migrate_postcopy()
>>>>>        since you'll notify that before postcopy starts
>>>> I'm thinking probably we don't need to export migrate_postcopy even now.
>>>> It's more like a sanity check, and not needed because now we have the
>>>> notifier registered to the precopy specific callchain, which has ensured
>>>> that
>>>> it is invoked via precopy.
>>> But postcopy will always start with precopy, no?
>> Yes, but I think we could add the check in precopy_notify()
> I'm not sure that's good.  If the notifier could potentially have
> other user, they might still work with postcopy, and they might expect
> e.g. BEFORE_SYNC to be called for every sync, even if it's at the
> precopy stage of a postcopy.

I think this precopy notifier callchain is expected to be used only for
the precopy mode. Postcopy has its dedicated notifier callchain that
users could use.

How about changing the migrate_postcopy() check to "ms->start_postcopy":

bool migration_postcopy_start(void)
{
     MigrationState *s;

     s = migrate_get_current();

     return atomic_read(&s->start_postcopy);
}


static void precopy_notify(PrecopyNotifyReason reason)
{
     if (migration_postcopy_start())
         return;

     notifier_list_notify(&precopy_notifier_list, &reason);
}

If postcopy started with precopy, the precopy optimization feature
could still be used until it switches to the postcopy mode.



> In that sense I still feel the
> PRECOPY_END is better (so contantly call it at the end of precopy, no
> matter whether there's another postcopy afterwards).  It sounds like a
> cleaner interface.

Probably I still haven't got the point how PRECOPY_END could help above yet.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

