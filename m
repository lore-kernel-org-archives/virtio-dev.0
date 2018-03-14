Return-Path: virtio-dev-return-3563-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C078B581806A
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Mar 2018 12:17:06 -0700 (PDT)
Date: Wed, 14 Mar 2018 21:16:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180314211302-mutt-send-email-mst@kernel.org>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
 <1520426065-40265-3-git-send-email-wei.w.wang@intel.com>
 <20180314181137.GG3006@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314181137.GG3006@work-vm>
Subject: [virtio-dev] Re: [PATCH v4 2/4] migration: API to clear bits of guest free pages
 from the dirty bitmap
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 14, 2018 at 06:11:37PM +0000, Dr. David Alan Gilbert wrote:
> > +            used_len = block->used_length - offset;
> > +            addr += used_len;
> > +        }
> > +
> > +        start = offset >> TARGET_PAGE_BITS;
> > +        npages = used_len >> TARGET_PAGE_BITS;
> > +        ram_state->migration_dirty_pages -=
> > +                      bitmap_count_one_with_offset(block->bmap, start, npages);
> > +        bitmap_clear(block->bmap, start, npages);
> 
> If this is happening while the migration is running, this isn't safe -
> the migration code could clear a bit at about the same point this
> happens, so that the count returned by bitmap_count_one_with_offset
> wouldn't match the word that was cleared by bitmap_clear.
> 
> The only way I can see to fix it is to run over the range using
> bitmap_test_and_clear_atomic, using the return value to decrement
> the number of dirty pages.
> But you also need to be careful with the update of the
> migration_dirty_pages value itself, because that's also being read
> by the migration thread.
> 
> Dave

I see that there's migration_bitmap_sync but it does not seem to be
taken on all paths. E.g. migration_bitmap_clear_dirty and
migration_bitmap_find_dirty are called without that lock sometimes.
Thoughts?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

