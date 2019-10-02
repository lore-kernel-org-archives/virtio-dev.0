Return-Path: virtio-dev-return-6194-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46D45985FC8
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Oct 2019 10:45:15 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <CAKgT0Uf37xAFK2CWqUZJgn7bWznSAi6qncLxBpC55oSpBMG1HQ@mail.gmail.com>
 <0603ca4a-d667-f461-4ba7-ff3c0e9fd4df@redhat.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <020ef7af-dae7-4d57-bed8-1ce912d50c1d@redhat.com>
Date: Wed, 2 Oct 2019 06:44:48 -0400
MIME-Version: 1.0
In-Reply-To: <0603ca4a-d667-f461-4ba7-ff3c0e9fd4df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/2/19 3:13 AM, David Hildenbrand wrote:
> On 02.10.19 02:55, Alexander Duyck wrote:
>> On Tue, Oct 1, 2019 at 12:16 PM Nitesh Narayan Lal <nitesh@redhat.com>=
 wrote:
>>>
>>> On 10/1/19 12:21 PM, Alexander Duyck wrote:
>>>> On Tue, 2019-10-01 at 17:35 +0200, David Hildenbrand wrote:
>>>>> On 01.10.19 17:29, Alexander Duyck wrote:
>>>>>> This series provides an asynchronous means of reporting to a hyper=
visor
>>>>>> that a guest page is no longer in use and can have the data associ=
ated
>>>>>> with it dropped. To do this I have implemented functionality that =
allows
>>>>>> for what I am referring to as unused page reporting. The advantage=
 of
>>>>>> unused page reporting is that we can support a significant amount =
of
>>>>>> memory over-commit with improved performance as we can avoid havin=
g to
>>>>>> write/read memory from swap as the VM will instead actively partic=
ipate
>>>>>> in freeing unused memory so it doesn't have to be written.
>>>>>>
>>>>>> The functionality for this is fairly simple. When enabled it will =
allocate
>>>>>> statistics to track the number of reported pages in a given free a=
rea.
>>>>>> When the number of free pages exceeds this value plus a high water=
 value,
>>>>>> currently 32, it will begin performing page reporting which consis=
ts of
>>>>>> pulling non-reported pages off of the free lists of a given zone a=
nd
>>>>>> placing them into a scatterlist. The scatterlist is then given to =
the page
>>>>>> reporting device and it will perform the required action to make t=
he pages
>>>>>> "reported", in the case of virtio-balloon this results in the page=
s being
>>>>>> madvised as MADV_DONTNEED. After this they are placed back on thei=
r
>>>>>> original free list. If they are not merged in freeing an additiona=
l bit is
>>>>>> set indicating that they are a "reported" buddy page instead of a =
standard
>>>>>> buddy page. The cycle then repeats with additional non-reported pa=
ges
>>>>>> being pulled until the free areas all consist of reported pages.
>>>>>>
>>>>>> In order to try and keep the time needed to find a non-reported pa=
ge to
>>>>>> a minimum we maintain a "reported_boundary" pointer. This pointer =
is used
>>>>>> by the get_unreported_pages iterator to determine at what point it=
 should
>>>>>> resume searching for non-reported pages. In order to guarantee pag=
es do
>>>>>> not get past the scan I have modified add_to_free_list_tail so tha=
t it
>>>>>> will not insert pages behind the reported_boundary. Doing this all=
ows us
>>>>>> to keep the overhead to a minimum as re-walking the list without t=
he
>>>>>> boundary will result in as much as 18% additional overhead on a 32=
G VM.
>>>>>>
>>>>>>
>>>> <snip>
>>>>
>>>>>> As far as possible regressions I have focused on cases where perfo=
rming
>>>>>> the hinting would be non-optimal, such as cases where the code isn=
't
>>>>>> needed as memory is not over-committed, or the functionality is no=
t in
>>>>>> use. I have been using the will-it-scale/page_fault1 test running =
with 16
>>>>>> vcpus and have modified it to use Transparent Huge Pages. With thi=
s I see
>>>>>> almost no difference with the patches applied and the feature disa=
bled.
>>>>>> Likewise I see almost no difference with the feature enabled, but =
the
>>>>>> madvise disabled in the hypervisor due to a device being assigned.=
 With
>>>>>> the feature fully enabled in both guest and hypervisor I see a reg=
ression
>>>>>> between -1.86% and -8.84% versus the baseline. I found that most o=
f the
>>>>>> overhead was due to the page faulting/zeroing that comes as a resu=
lt of
>>>>>> the pages having been evicted from the guest.
>>>>> I think Michal asked for a performance comparison against Nitesh's
>>>>> approach, to evaluate if keeping the reported state + tracking insi=
de
>>>>> the buddy is really worth it. Do you have any such numbers already?=
 (or
>>>>> did my tired eyes miss them in this cover letter? :/)
>>>>>
>>>> I thought what Michal was asking for was what was the benefit of usi=
ng the
>>>> boundary pointer. I added a bit up above and to the description for =
patch
>>>> 3 as on a 32G VM it adds up to about a 18% difference without factor=
ing in
>>>> the page faulting and zeroing logic that occurs when we actually do =
the
>>>> madvise.
>>>>
>>>> Do we have a working patch set for Nitesh's code? The last time I tr=
ied
>>>> running his patch set I ran into issues with kernel panics. If we ha=
ve a
>>>> known working/stable patch set I can give it a try.
>>> Did you try the v12 patch-set [1]?
>>> I remember that you reported the CPU stall issue, which I fixed in th=
e v12.
>>>
>>> [1] https://lkml.org/lkml/2019/8/12/593
>> So I tried testing with the spin_lock calls replaced with spin_lock
>> _irq to resolve the IRQ issue. I also had shuffle enabled in order to
>> increase the number of pages being dirtied.
>>
>> With that setup the bitmap approach is running significantly worse
>> then my approach, even with the boundary removed. Since I had to
> It would make sense to share the setup+benchmark+performance indication=

> that you measured. You don't have to share the actual numbers.

+1

>
>> modify the code to even getting working I am not comfortable posting
>> numbers. My suggestion would be to look at reworking the patch set and=

>> post numbers for my patch set versus the bitmap approach and we can
>> look at them then. I would prefer not to spend my time fixing and
>> tuning a patch set that I am still not convinced is viable.
> I agree, I think Nitesh should work on his patch set and try to
> reproduce what you are seeing.

Sure.
I am always open to suggestions of different benchmarks/setup
where I can run my patch-set.

>
> Also, I think to make a precise statement of "which overhead comes with=

> external tracking", Nitesh should switch to an approach (motivated by
> Michal) like
>
> 1. Sense lockless if a page is still free
> 2. start_isolate_page_range()
> -> Failed? Skip
> 3. test_pages_isolated()
> -> No? undo_isolate_page_range(), skip
> 4. Repeat for multiple pages + report
> 5. undo_isolate_page_range()
>
> That is the bare minimum any external tracking will need =3D some overh=
ead
> for the tracking data. As a nice side effect, it get's rid of taking th=
e
> zone lock manually AFAIKS.
>
> But that's unrelated to your series, only to quantify "how much" does
> external tracking actually cost.

Exactly, first, we need to be sure that the overhead caused by bitmap
scanning is not significant. If we are fine with the approach, I will
certainly look into this as this would be an excellent enhancement.

--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

