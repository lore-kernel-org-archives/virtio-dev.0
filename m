Return-Path: virtio-dev-return-5957-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3B82985E09
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Aug 2019 22:49:42 +0000 (UTC)
MIME-Version: 1.0
References: <20190812213158.22097.30576.stgit@localhost.localdomain>
 <20190812213324.22097.30886.stgit@localhost.localdomain> <CAPcyv4jEvPL3qQffDsJxKxkCJLo19FN=gd4+LtZ1FnARCr5wBw@mail.gmail.com>
In-Reply-To: <CAPcyv4jEvPL3qQffDsJxKxkCJLo19FN=gd4+LtZ1FnARCr5wBw@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 12 Aug 2019 15:49:30 -0700
Message-ID: <CAKgT0UeHAXCM+aXL=SYXqVym=Vy3av21Vc6VY-rWQYE13-MNKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v5 1/6] mm: Adjust shuffle code to allow for future coalescing
To: Dan Williams <dan.j.williams@intel.com>
Cc: Nitesh Narayan Lal <nitesh@redhat.com>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, virtio-dev@lists.oasis-open.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Rik van Riel <riel@surriel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 12, 2019 at 3:24 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Aug 12, 2019 at 2:33 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > This patch is meant to move the head/tail adding logic out of the shuffle
>
> s/This patch is meant to move/Move/

I'll update that on next submission.

> > code and into the __free_one_page function since ultimately that is where
> > it is really needed anyway. By doing this we should be able to reduce the
> > overhead
>
> Is the overhead benefit observable? I would expect the overhead of
> get_random_u64() dominates.
>
> > and can consolidate all of the list addition bits in one spot.
>
> This sounds the better argument.

Actually the overhead is the bit where we have to setup the arguments
and call the function. There is only one spot where this function is
ever called and that is in __free_one_page.

> [..]
> > diff --git a/mm/shuffle.h b/mm/shuffle.h
> > index 777a257a0d2f..add763cc0995 100644
> > --- a/mm/shuffle.h
> > +++ b/mm/shuffle.h
> > @@ -3,6 +3,7 @@
> >  #ifndef _MM_SHUFFLE_H
> >  #define _MM_SHUFFLE_H
> >  #include <linux/jump_label.h>
> > +#include <linux/random.h>
> >
> >  /*
> >   * SHUFFLE_ENABLE is called from the command line enabling path, or by
> > @@ -43,6 +44,32 @@ static inline bool is_shuffle_order(int order)
> >                 return false;
> >         return order >= SHUFFLE_ORDER;
> >  }
> > +
> > +static inline bool shuffle_add_to_tail(void)
> > +{
> > +       static u64 rand;
> > +       static u8 rand_bits;
> > +       u64 rand_old;
> > +
> > +       /*
> > +        * The lack of locking is deliberate. If 2 threads race to
> > +        * update the rand state it just adds to the entropy.
> > +        */
> > +       if (rand_bits-- == 0) {
> > +               rand_bits = 64;
> > +               rand = get_random_u64();
> > +       }
> > +
> > +       /*
> > +        * Test highest order bit while shifting our random value. This
> > +        * should result in us testing for the carry flag following the
> > +        * shift.
> > +        */
> > +       rand_old = rand;
> > +       rand <<= 1;
> > +
> > +       return rand < rand_old;
> > +}
>
> This function seems too involved to be a static inline and I believe
> each compilation unit that might call this routine gets it's own copy
> of 'rand' and 'rand_bits' when the original expectation is that they
> are global. How about leave this bit to mm/shuffle.c and rename it
> coin_flip(), or something more generic, since it does not
> 'add_to_tail'? The 'add_to_tail' action is something the caller
> decides.

The thing is there is only one caller to this function, and that is
__free_one_page. That is why I made it a static inline since that way
we can avoid having to call this as a function at all and can just
inline the code into __free_one_page.

As far as making this more generic I guess I can look into that. Maybe
I will look at trying to implement something like get_random_bool()
and then just do a macro to point to that. One other things that
occurs to me now that I am looking over the code is that I am not sure
the original or this modified version actually provide all that much
randomness if multiple threads have access to it at the same time. If
rand_bits races past the 0 you can end up getting streaks of 0s for
256+ bits.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

