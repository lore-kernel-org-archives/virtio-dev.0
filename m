Return-Path: virtio-dev-return-2864-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B42D581911B
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Dec 2017 10:08:55 -0800 (PST)
Date: Tue, 19 Dec 2017 20:08:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219200726-mutt-send-email-mst@kernel.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
 <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
Subject: [virtio-dev] Re: [PATCH v20 0/7] Virtio-balloon Enhancement
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Dec 19, 2017 at 11:05:11PM +0900, Tetsuo Handa wrote:
> Wei Wang wrote:
> > ChangeLog:
> > v19->v20:
> > 1) patch 1: xbitmap
> > 	- add __rcu to "void **slot";
> > 	- remove the exceptional path.
> > 2) patch 3: xbitmap
> > 	- DeveloperNotes: add an item to comment that the current bit range
> > 	  related APIs operating on extremely large ranges (e.g.
> >           [0, ULONG_MAX)) will take too long time. This can be optimized in
> > 	  the future.
> > 	- remove the exceptional path;
> > 	- remove xb_preload_and_set();
> > 	- reimplement xb_clear_bit_range to make its usage close to
> > 	  bitmap_clear;
> > 	- rename xb_find_next_set_bit to xb_find_set, and re-implement it
> > 	  in a style close to find_next_bit;
> > 	- rename xb_find_next_zero_bit to xb_find_clear, and re-implement
> > 	  it in a stytle close to find_next_zero_bit;
> > 	- separate the implementation of xb_find_set and xb_find_clear for
> > 	  the convenience of future updates.
> 
> Removing exceptional path made this patch easier to read.
> But what I meant is
> 
>   Can you eliminate exception path and fold all xbitmap patches into one, and
>   post only one xbitmap patch without virtio-balloon changes? 

And then people will complain that patch is too big
and hard to understand without any users.

As long as patches don't change the same lines of code,
it's fine to split up imho. In this case it's done
to attribute code better, seems like a reasonable thing to do
to me.

> .
> 
> I still think we don't need xb_preload()/xb_preload_end().
> I think xb_find_set() has a bug in !node path.
> 
> Also, please avoid unconditionally adding to builtin modules.
> There are users who want to save even few KB.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

