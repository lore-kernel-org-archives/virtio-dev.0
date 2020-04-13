Return-Path: virtio-dev-return-7054-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9568598437C
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Apr 2020 22:48:42 +0000 (UTC)
MIME-Version: 1.0
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034150.24738.98143.stgit@localhost.localdomain> <c9b60224-e280-7351-33df-bbb3e25f6cfd@redhat.com>
In-Reply-To: <c9b60224-e280-7351-33df-bbb3e25f6cfd@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 13 Apr 2020 15:48:29 -0700
Message-ID: <CAKgT0UcLfpyGOmaOk9zYT6mfgR2E=Ra-1ViMN3gAeTX2r9CCag@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v19 QEMU 4/4] memory: Do not allow direct write access to
 rom_device regions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 10, 2020 at 3:50 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/04/20 05:41, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > According to the documentation in memory.h a ROM memory region will be
> > backed by RAM for reads, but is supposed to go through a callback for
> > writes. Currently we were not checking for the existence of the rom_dev=
ice
> > flag when determining if we could perform a direct write or not.
> >
> > To correct that add a check to memory_region_is_direct so that if the
> > memory region has the rom_device flag set we will return false for all
> > checks where is_write is set.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  include/exec/memory.h |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 1614d9a02c0c..e000bd2f97b2 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -2351,8 +2351,8 @@ void address_space_write_cached_slow(MemoryRegion=
Cache *cache,
> >  static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_w=
rite)
> >  {
> >      if (is_write) {
> > -        return memory_region_is_ram(mr) &&
> > -               !mr->readonly && !memory_region_is_ram_device(mr);
> > +        return memory_region_is_ram(mr) && !mr->readonly &&
> > +               !mr->rom_device && !memory_region_is_ram_device(mr);
> >      } else {
> >          return (memory_region_is_ram(mr) && !memory_region_is_ram_devi=
ce(mr)) ||
> >                 memory_region_is_romd(mr);
> >
>
> Good catch.  I queued this up for 5.0.
>
> Thanks,
>
> Paolo

Thanks Paolo,

It looks like you only pulled this patch correct?

If so, David & Michael, do I need to resubmit the first 3 in this
series or can those be pulled separately?

Thanks.

Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

