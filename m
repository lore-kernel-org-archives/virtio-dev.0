Return-Path: virtio-dev-return-6196-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C79E985FDA
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Oct 2019 14:37:21 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <CAKgT0Uf37xAFK2CWqUZJgn7bWznSAi6qncLxBpC55oSpBMG1HQ@mail.gmail.com>
 <c06b68cb-5e94-ae3e-f84e-48087d675a8f@redhat.com>
 <CAKgT0Ud6TT=XxqFx6ePHzbUYqMp5FHVPozRvnNZK3tKV7j2xjg@mail.gmail.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <10e1f17f-db99-a723-97e2-1ae292fff408@redhat.com>
Date: Wed, 2 Oct 2019 10:36:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud6TT=XxqFx6ePHzbUYqMp5FHVPozRvnNZK3tKV7j2xjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/2/19 10:25 AM, Alexander Duyck wrote:
> On Wed, Oct 2, 2019 at 3:37 AM Nitesh Narayan Lal <nitesh@redhat.com> w=
rote:
>>
>> On 10/1/19 8:55 PM, Alexander Duyck wrote:
>>> On Tue, Oct 1, 2019 at 12:16 PM Nitesh Narayan Lal <nitesh@redhat.com=
> wrote:
>>>> On 10/1/19 12:21 PM, Alexander Duyck wrote:
>>>>> On Tue, 2019-10-01 at 17:35 +0200, David Hildenbrand wrote:
>>>>>> On 01.10.19 17:29, Alexander Duyck wrote:
> <snip>
>
>>>>> Do we have a working patch set for Nitesh's code? The last time I t=
ried
>>>>> running his patch set I ran into issues with kernel panics. If we h=
ave a
>>>>> known working/stable patch set I can give it a try.
>>>> Did you try the v12 patch-set [1]?
>>>> I remember that you reported the CPU stall issue, which I fixed in t=
he v12.
>>>>
>>>> [1] https://lkml.org/lkml/2019/8/12/593
>>> So I tried testing with the spin_lock calls replaced with spin_lock
>>> _irq to resolve the IRQ issue. I also had shuffle enabled in order to=

>>> increase the number of pages being dirtied.
>>>
>>> With that setup the bitmap approach is running significantly worse
>>> then my approach, even with the boundary removed. Since I had to
>>> modify the code to even getting working I am not comfortable posting
>>> numbers.
>> I didn't face any issue in getting the code work or compile.
>> Before my v12 posting, I did try your previously suggested test
>> (will-it-scale/page_fault1 for 12 hours on a 60 GB) and didn't see any=
 issues.
>> I think it would help more if you can share the setup which you are ru=
nning.
> So one issue with the standard page_fault1 is that it is only
> operating at the 4K page level. You won't see much impact from you
> patches with that as the overhead of splitting a MAX_ORDER - 2 page
> down to a 4K page will end up being the biggest thing you are
> benchmarking.
>
> I think I have brought it up before but I am running with the
> page_fault1 modified to use THP. Making the change is pretty
> straightforward as  all you have to do is add an madvise to the test
> code. All that is needed is to add "madvise(c, MEMSIZE,
> MADV_HUGEPAGE);" between the assert and the for loop in the
> page_fault1 code and then rebuild the test. I actually copied
> page_fault1.c into a file I named page_fault4.c and added the line. As
> a result it seems like the code will build it as an additional test.

Thanks for explaining.

>
> The only other alteration I can think of that might have much impact
> would be to enable the page shuffling. The idea is that it will cause
> us to use more pages because half of the pages freed are dumped to the
> tail of the list so we are constantly churning the memory.
>
>>> My suggestion would be to look at reworking the patch set and
>>> post numbers for my patch set versus the bitmap approach and we can
>>> look at them then.
>> Agreed. However, in order to fix an issue I have to reproduce it first=
=2E
> With the tweak I have suggested above it should make it much easier to
> reproduce. Basically all you need is to have the allocation competing
> against hinting. Currently the hinting isn't doing this because the
> allocations are mostly coming out of 4K pages instead of higher order
> ones.

Understood.

>
> Alternatively you could just make the suggestion I had proposed about
> using spin_lock/unlock_irq in your worker thread and that resolved it
> for me.

I will first reproduce as you suggested and then make the change.
That will help me to understand the issue in a better way.

>
>>>  I would prefer not to spend my time fixing and
>>> tuning a patch set that I am still not convinced is viable.
>> You  don't have to, I can fix the issues in my patch-set. :)
> Sounds good. Hopefully the stuff I pointed out above helps you to get
> a reproduction and resolve the issues.

Indeed, I will try these suggestions and fix this issue.
Did you run into any other issues while building or running?

>
> - Alex

--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

