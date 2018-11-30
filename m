Return-Path: virtio-dev-return-5086-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F9E0985D6D
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Nov 2018 05:00:53 +0000 (UTC)
Message-ID: <5C00C52F.20606@intel.com>
Date: Fri, 30 Nov 2018 13:05:51 +0800
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
> I think this precopy notifier callchain is expected to be used only for
> the precopy mode. Postcopy has its dedicated notifier callchain that
> users could use.
>
> How about changing the migrate_postcopy() check to "ms->start_postcopy":
>
> bool migration_postcopy_start(void)
> {
>      MigrationState *s;
>
>      s = migrate_get_current();
>
>      return atomic_read(&s->start_postcopy);
> }
>
>
> static void precopy_notify(PrecopyNotifyReason reason)
> {
>      if (migration_postcopy_start())
>          return;
>
>      notifier_list_notify(&precopy_notifier_list, &reason);
> }
>
> If postcopy started with precopy, the precopy optimization feature
> could still be used until it switches to the postcopy mode.
> I'm not sure we can use start_postcopy.  It's a variable being set in
> the QMP handler but it does not mean postcopy has started.  I'm afraid
> there can be race where it's still precopy but the variable is set so
> event could be missed...

Peter,
I just found that migration_bitmap_sync is also called by 
ram_postcopy_send_discard_bitmap().
But we don't expect notifier_list_notify to be called in the postcopy mode.

So, probably we still need the start_postcopy check in 
notifier_list_notify though we have
the COMPLETE notifier.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

