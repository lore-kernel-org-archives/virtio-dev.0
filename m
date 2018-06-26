Return-Path: virtio-dev-return-4532-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BDCDA58180D0
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Jun 2018 18:55:42 -0700 (PDT)
Date: Tue, 26 Jun 2018 04:55:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180626045118-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v33 1/4] mm: add a function to get free page blocks
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Jun 16, 2018 at 08:08:53AM +0900, Linus Torvalds wrote:
> On Fri, Jun 15, 2018 at 2:08 PM Wei Wang <wei.w.wang@intel.com> wrote:
> >
> > This patch adds a function to get free pages blocks from a free page
> > list. The obtained free page blocks are hints about free pages, because
> > there is no guarantee that they are still on the free page list after
> > the function returns.

...

> > +uint32_t get_from_free_page_list(int order, __le64 buf[], uint32_t size)

...

> 
> Ack. This is the kind of simple interface where I don't need to worry
> about the MM code calling out to random drivers or subsystems.
> 
> I think that "order" should be checked for validity, but from a MM
> standpoint I think this is fine.
> 
>                 Linus

The only issue seems to be getting hold of buf that's large enough -
and we don't really know what the size is, or whether one
buf would be enough.

Linus, do you think it would be ok to have get_from_free_page_list
actually pop entries from the free list and use them as the buffer
to store PAs?

Caller would be responsible for freeing the returned entries.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

