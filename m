Return-Path: virtio-dev-return-5074-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 156BB9858B5
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Nov 2018 06:25:31 +0000 (UTC)
Message-ID: <5BFF8783.4080201@intel.com>
Date: Thu, 29 Nov 2018 14:30:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com> <1542276484-25508-6-git-send-email-wei.w.wang@intel.com> <20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com> <20181128052655.GC12839@xz-x1> <5BFE596B.1080807@intel.com> <20181128093220.GF12839@xz-x1> <5BFF5FC9.2020402@intel.com> <20181129051014.GC29246@xz-x1>
In-Reply-To: <20181129051014.GC29246@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 5/8] migration/ram.c: add a notifier chain for precopy
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/29/2018 01:10 PM, Peter Xu wrote:
> On Thu, Nov 29, 2018 at 11:40:57AM +0800, Wei Wang wrote:
>> On 11/28/2018 05:32 PM, Peter Xu wrote:
> I'm not sure we can use start_postcopy.  It's a variable being set in
> the QMP handler but it does not mean postcopy has started.  I'm afraid
> there can be race where it's still precopy but the variable is set so
> event could be missed...
>
> IMHO the problem is not that complicated.  How about this proposal:
>
> [1]
>
>    typedef enum PrecopyNotifyReason {
>      PRECOPY_NOTIFY_RAM_START,
>      PRECOPY_NOTIFY_RAM_BEFORE_SYNC,
>      PRECOPY_NOTIFY_RAM_AFTER_SYNC,
>      PRECOPY_NOTIFY_COMPLETE,
>      PRECOPY_NOTIFY_RAM_CLEANUP,
>    };
>
> The first three keep the same as your old ones.  Notify RAM_CLEANUP in
> ram_save_cleanup() to make sure it'll always be cleaned up (the same
> as PRECOPY_END, just another name).  Notify COMPLETE in
> qemu_savevm_state_complete_precopy() to show that precopy is
> completed.  Meanwhile on balloon side you should stop the hinting for
> either RAM_CLEANUP or COMPLETE event.  Then either:
>
>    - precopy is switching to postcopy, or
>    - precopy completed, or
>    - precopy failed/cancelled
>
> You should always get at least a notification to stop the balloon.
> Though you could also get one RAM_CLEANUP after one COMPLETE, but
> the balloon should easily handle it (stop the hinting twice).

Sounds better, thanks.


>
> Here maybe you can even remove the "RAM_" in both RAM_START and
> RAM_CLEANUP if we're going to have COMPLETE since after all it'll be
> not only limited to RAM.
>
> Another suggestion is that you can add an Error into the notify hooks,
> please refer to the postcopy one:
>
>    int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);
>
> So the hook functions have a way to even stop the migration (though
> for balloon hinting it'll be always optional so no error should be
> reported...), then the two interfaces are matched.

Yes, I removed that "errp" as it's not needed by the balloon usage.
But no problem, I can add it back if no objections from others.

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

