Return-Path: virtio-dev-return-3608-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F33685819057
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Mar 2018 15:55:32 -0700 (PDT)
Date: Tue, 20 Mar 2018 00:55:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320004900-mutt-send-email-mst@kernel.org>
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
 <1521197309-13544-5-git-send-email-wei.w.wang@intel.com>
 <20180316165319-mutt-send-email-mst@kernel.org>
 <5AAE4124.5010602@intel.com>
 <20180319062023-mutt-send-email-mst@kernel.org>
 <5AAF7C72.5070403@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AAF7C72.5070403@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v5 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 19, 2018 at 05:01:38PM +0800, Wei Wang wrote:
> On 03/19/2018 12:24 PM, Michael S. Tsirkin wrote:
> > On Sun, Mar 18, 2018 at 06:36:20PM +0800, Wei Wang wrote:
> > > On 03/16/2018 11:16 PM, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 16, 2018 at 06:48:28PM +0800, Wei Wang wrote:
> > 
> > OTOH it seems that if thread stops nothing will wake it up
> > whem vm is restarted. Such bahaviour change across vmstop/vmstart
> > is unexpected.
> > I do not understand why we want to increment the counter
> > on vm stop though. It does make sense to stop the thread
> > but why not resume where we left off when vm is resumed?
> > 
> 
> I'm not sure which counter we incremented. But it would be clear if we have
> a high level view of how it works (it is symmetric actually). Basically, we
> start the optimization when each round starts and stop it at the end of each
> round (i.e. before we do the bitmap sync), as shown below:
> 
> 1) 1st Round starts --> free_page_start
> 2) 1st Round in progress..
> 3) 1st Round ends  --> free_page_stop
> 4) 2nd Round starts --> free_page_start
> 5) 2nd Round in progress..
> 6) 2nd Round ends --> free_page_stop
> ......
> 
> For example, in 2), the VM is stopped. virtio_balloon_poll_free_page_hints
> finds the vq is empty (i.e. elem == NULL) and the runstate is stopped, the
> optimization thread exits immediately. That is, this optimization thread is
> gone forever (the optimization we can do for this round is done). We won't
> know when would the VM be woken up:
> A) If the VM is woken up very soon when the migration thread is still in
> progress of 2), then in 4) a new optimization thread (not the same one for
> the first round) will be created and start the optimization for the 2nd
> round as usual (If you have questions about 3) in this case, that
> free_page_stop will do nothing than just return, since the optimization
> thread has exited) ;
> B) If the VM is woken up after the whole migration has ended, there is still
> no point in resuming the optimization.
> 
> I think this would be the simple design for the first release of this
> optimization. There are possibilities to improve case A) above by continuing
> optimization for the 1st Round as it is still in progress, but I think
> adding that complexity for this rare case wouldn't be worthwhile (at least
> for now). What would you think?
> 
> 
> Best,
> Wei

In my opinion this just makes the patch very messy.

E.g. attempts to attach a debugger to the guest will call vmstop and
then behaviour changes. This is a receipe for heisenbugs which are then
extremely painful to debug.

It is not really hard to make things symmetrical:
e.g. if you stop on vmstop then you should start on vmstart, etc.
And stopping thread should not involve a bunch of state
changes, just stop it and that's it.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

