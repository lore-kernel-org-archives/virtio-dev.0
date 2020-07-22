Return-Path: virtio-dev-return-7608-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D3F0985D51
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jul 2020 14:55:53 +0000 (UTC)
MIME-Version: 1.0
References: <20200629080615.26022-1-david@redhat.com> <20200722080356-mutt-send-email-mst@kernel.org>
 <d52e7c61-a458-141c-5b7c-515173724fe8@redhat.com> <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
In-Reply-To: <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Jul 2020 07:55:40 -0700
Message-ID: <CAKgT0UeXgDkyNxrM-7XuJ8KdtY2qT9CpSfcMx9RFUm_wppivbg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration fails
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 22, 2020 at 5:12 AM David Hildenbrand <david@redhat.com> wrote:
>
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

I agree. David's patches should be upstream, and if they aren't they
should be applied before mine. Mine are meant to be a follow-on as I
end the set with the "report"->"hint" rename for several fields. The
idea is the fixes go first and the rename comes last.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

