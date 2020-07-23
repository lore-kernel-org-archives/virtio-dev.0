Return-Path: virtio-dev-return-7610-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C46B7985DD1
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Jul 2020 04:10:41 +0000 (UTC)
Date: Thu, 23 Jul 2020 00:10:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200723000949-mutt-send-email-mst@kernel.org>
References: <20200629080615.26022-1-david@redhat.com>
 <20200722080356-mutt-send-email-mst@kernel.org>
 <d52e7c61-a458-141c-5b7c-515173724fe8@redhat.com>
 <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
MIME-Version: 1.0
In-Reply-To: <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration
 fails
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 22, 2020 at 02:11:52PM +0200, David Hildenbrand wrote:
> On 22.07.20 14:05, David Hildenbrand wrote:
> > On 22.07.20 14:04, Michael S. Tsirkin wrote:
> >> On Mon, Jun 29, 2020 at 10:06:15AM +0200, David Hildenbrand wrote:
> >>> If something goes wrong during precopy, before stopping the VM, we will
> >>> never send a S_DONE indication to the VM, resulting in the hinted pages
> >>> not getting released to be used by the guest OS (e.g., Linux).
> >>>
> >>> Easy to reproduce:
> >>> 1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
> >>> 2. Cancel migration (e.g., HMP "migrate_cancel")
> >>> 3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
> >>>    no free memory left.
> >>>
> >>> While at it, add similar locking to virtio_balloon_free_page_done() as
> >>> done in virtio_balloon_free_page_stop. Locking is still weird, but that
> >>> has to be sorted out separately.
> >>>
> >>> There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
> >>> comments regarding S_DONE handling.
> >>>
> >>> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> >>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>> Cc: Wei Wang <wei.w.wang@intel.com>
> >>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>
> >> IIUC this is superceded by Alexander's patches right?
> > 
> > Not that I know ... @Alex?
> > 
> 
> Okay, I'm confused, that patch is already upstream (via your tree)?
> 
> dd8eeb9671fc ("virtio-balloon: always indicate S_DONE when migration fails")
> 
> Did you stumble over this mail by mistake again?
> 
> -- 
> Thanks,
> 
> David / dhildenb

Oh. I guess that's what happened. I saw the code in the tree and thought
it came in from Alex's patch.
Sorry about the noise.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

