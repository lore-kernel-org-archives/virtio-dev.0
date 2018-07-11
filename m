Return-Path: virtio-dev-return-4683-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97294985B2B
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 04:00:47 +0000 (UTC)
Date: Wed, 11 Jul 2018 07:00:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180711064709-mutt-send-email-mst@kernel.org>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 10, 2018 at 10:33:08AM -0700, Linus Torvalds wrote:
> NAK.
> 
> On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
> >
> > +
> > +       buf_page = list_first_entry_or_null(pages, struct page, lru);
> > +       if (!buf_page)
> > +               return -EINVAL;
> > +       buf = (__le64 *)page_address(buf_page);
> 
> Stop this garbage.
> 
> Why the hell would you pass in some crazy "liost of pages" that uses
> that lru list?
> 
> That's just insane shit.
> 
> Just pass in a an array to fill in.
> No idiotic games like this with
> odd list entries (what's the locking?) and crazy casting to
> 
> So if you want an array of page addresses, pass that in as such. If
> you want to do it in a page, do it with
> 
>     u64 *array = page_address(page);
>     int nr = PAGE_SIZE / sizeof(u64);
> 
> and now you pass that array in to the thing. None of this completely
> insane crazy crap interfaces.

Question was raised what to do if there are so many free
MAX_ORDER pages that their addresses don't fit in a single MAX_ORDER
page. Yes, only a huge guest would trigger that but it seems
theoretically possible.

I guess an array of arrays then?

An alternative suggestion was not to pass an array at all,
instead peel enough pages off the list to contain
all free entries. Maybe that's too hacky.


> 
> Plus, I still haven't heard an explanation for why you want so many
> pages in the first place, and why you want anything but MAX_ORDER-1.
> 
> So no. This kind of unnecessarily complex code with completely insane
> calling interfaces does not make it into the VM layer.
> 
> Maybe that crazy "let's pass a chain of pages that uses the lru list"
> makes sense to the virtio-balloon code. But you need to understand
> that it makes ZERO conceptual sense to anybody else. And the core VM
> code is about a million times more important than the balloon code in
> this case, so you had better make the interface make sense to *it*.
> 
>                Linus

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

