Return-Path: virtio-dev-return-2908-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C11558191BC
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 21:54:03 -0800 (PST)
Message-ID: <5A4DC1F9.40908@intel.com>
Date: Thu, 04 Jan 2018 13:56:09 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1514904621-39186-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1514904621-39186-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH] virtio_balloon: use non-blocking allocation
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/02/2018 10:50 PM, Tetsuo Handa wrote:
> Commit c7cdff0e864713a0 ("virtio_balloon: fix deadlock on OOM") tried to
> avoid OOM lockup by moving memory allocations to outside of balloon_lock.
>
> Now, Wei is trying to allocate far more pages outside of balloon_lock and
> some more memory inside of balloon_lock in order to perform efficient
> communication between host and guest using scatter-gather API.
>
> Since pages allocated outside of balloon_lock are not visible to the OOM
> notifier path until fill_balloon() holds balloon_lock (and enqueues the
> pending pages), allocating more pages than now may lead to unacceptably
> premature OOM killer invocation.
>
> It would be possible to make the pending pages visible to the OOM notifier
> path. But there is no need to try to allocate memory so hard from the
> beginning. As of commit 18468d93e53b037e ("mm: introduce a common
> interface for balloon pages mobility"), it made sense to try allocation
> as hard as possible. But after commit 5a10b7dbf904bfe0 ("virtio_balloon:
> free some memory from balloon on OOM"), it no longer makes sense to try
> allocation as hard as possible, for fill_balloon() will after all have to
> release just allocated memory if some allocation request hits the OOM
> notifier path. Therefore, this patch disables __GFP_DIRECT_RECLAIM when
> allocating memory for inflating the balloon. Then, memory for inflating
> the balloon can be allocated inside balloon_lock, and we can release just
> allocated memory as needed.
>
> Also, this patch adds __GFP_NOWARN, for possibility of hitting memory
> allocation failure is increased by removing __GFP_DIRECT_RECLAIM, which
> might spam the kernel log buffer. At the same time, this patch moves
> "puff" messages to outside of balloon_lock, for it is not a good thing to
> block the OOM notifier path for 1/5 of a second. (Moreover, it is better
> to release the workqueue and allow processing other pending items. But
> that change is out of this patch's scope.)
>
> __GFP_NOMEMALLOC is currently not required because workqueue context
> which calls balloon_page_alloc() won't cause __gfp_pfmemalloc_flags()
> to return ALLOC_OOM. But since some process context might start calling
> balloon_page_alloc() in future, this patch does not remove
> __GFP_NOMEMALLOC.
>
> (Only compile tested. Please do runtime tests before committing.)
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> ---
>   drivers/virtio/virtio_balloon.c | 23 +++++++++++++----------
>   mm/balloon_compaction.c         |  5 +++--
>   2 files changed, 16 insertions(+), 12 deletions(-)
>
>

I think it is better to simply make the temporal "LIST_HEAD(pages)" to 
be visible to oom notify, e.g. make it "struct list_head 
vb->inflating_pages"

Then we can change virtioballoon_oom_notify():

static int oom_notify()
{
     ...
     if (*freed != oom_pages && !list_empty(&vb->inflating_pages))
                return NOTIFY_BAD;

     return NOTIFY_OK;
}


virtioballoon_oom_notify() {
     int ret;

     do {
         ret = oom_notify()
     } while (ret == NOTIFY_BAD);

     return ret;
}


I view the above as something "nice to have" (users also have an option 
to disable F_DEFLATE_ON_OOM, in which case inflated pages are also not 
released by oom).  I can help with this after the "virtio_balloon 
enhancement" series is done.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

