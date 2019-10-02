Return-Path: virtio-dev-return-6193-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FFDF985FC8
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Oct 2019 10:37:22 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <CAKgT0Uf37xAFK2CWqUZJgn7bWznSAi6qncLxBpC55oSpBMG1HQ@mail.gmail.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <c06b68cb-5e94-ae3e-f84e-48087d675a8f@redhat.com>
Date: Wed, 2 Oct 2019 06:36:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf37xAFK2CWqUZJgn7bWznSAi6qncLxBpC55oSpBMG1HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/1/19 8:55 PM, Alexander Duyck wrote:
> On Tue, Oct 1, 2019 at 12:16 PM Nitesh Narayan Lal <nitesh@redhat.com> =
wrote:
>>
>> On 10/1/19 12:21 PM, Alexander Duyck wrote:
>>> On Tue, 2019-10-01 at 17:35 +0200, David Hildenbrand wrote:
>>>> On 01.10.19 17:29, Alexander Duyck wrote:
>>>>> This series provides an asynchronous means of reporting to a hyperv=
isor
>>>>> that a guest page is no longer in use and can have the data associa=
ted
>>>>> with it dropped. To do this I have implemented functionality that a=
llows
>>>>> for what I am referring to as unused page reporting. The advantage =
of
>>>>> unused page reporting is that we can support a significant amount o=
f
>>>>> memory over-commit with improved performance as we can avoid having=
 to
>>>>> write/read memory from swap as the VM will instead actively partici=
pate
>>>>> in freeing unused memory so it doesn't have to be written.
>>>>>
>>>>> The functionality for this is fairly simple. When enabled it will a=
llocate
>>>>> statistics to track the number of reported pages in a given free ar=
ea.
>>>>> When the number of free pages exceeds this value plus a high water =
value,
>>>>> currently 32, it will begin performing page reporting which consist=
s of
>>>>> pulling non-reported pages off of the free lists of a given zone an=
d
>>>>> placing them into a scatterlist. The scatterlist is then given to t=
he page
>>>>> reporting device and it will perform the required action to make th=
e pages
>>>>> "reported", in the case of virtio-balloon this results in the pages=
 being
>>>>> madvised as MADV_DONTNEED. After this they are placed back on their=

>>>>> original free list. If they are not merged in freeing an additional=
 bit is
>>>>> set indicating that they are a "reported" buddy page instead of a s=
tandard
>>>>> buddy page. The cycle then repeats with additional non-reported pag=
es
>>>>> being pulled until the free areas all consist of reported pages.
>>>>>
>>>>> In order to try and keep the time needed to find a non-reported pag=
e to
>>>>> a minimum we maintain a "reported_boundary" pointer. This pointer i=
s used
>>>>> by the get_unreported_pages iterator to determine at what point it =
should
>>>>> resume searching for non-reported pages. In order to guarantee page=
s do
>>>>> not get past the scan I have modified add_to_free_list_tail so that=
 it
>>>>> will not insert pages behind the reported_boundary. Doing this allo=
ws us
>>>>> to keep the overhead to a minimum as re-walking the list without th=
e
>>>>> boundary will result in as much as 18% additional overhead on a 32G=
 VM.
>>>>>
>>>>>
>>> <snip>
>>>
>>>>> As far as possible regressions I have focused on cases where perfor=
ming
>>>>> the hinting would be non-optimal, such as cases where the code isn'=
t
>>>>> needed as memory is not over-committed, or the functionality is not=
 in
>>>>> use. I have been using the will-it-scale/page_fault1 test running w=
ith 16
>>>>> vcpus and have modified it to use Transparent Huge Pages. With this=
 I see
>>>>> almost no difference with the patches applied and the feature disab=
led.
>>>>> Likewise I see almost no difference with the feature enabled, but t=
he
>>>>> madvise disabled in the hypervisor due to a device being assigned. =
With
>>>>> the feature fully enabled in both guest and hypervisor I see a regr=
ession
>>>>> between -1.86% and -8.84% versus the baseline. I found that most of=
 the
>>>>> overhead was due to the page faulting/zeroing that comes as a resul=
t of
>>>>> the pages having been evicted from the guest.
>>>> I think Michal asked for a performance comparison against Nitesh's
>>>> approach, to evaluate if keeping the reported state + tracking insid=
e
>>>> the buddy is really worth it. Do you have any such numbers already? =
(or
>>>> did my tired eyes miss them in this cover letter? :/)
>>>>
>>> I thought what Michal was asking for was what was the benefit of usin=
g the
>>> boundary pointer. I added a bit up above and to the description for p=
atch
>>> 3 as on a 32G VM it adds up to about a 18% difference without factori=
ng in
>>> the page faulting and zeroing logic that occurs when we actually do t=
he
>>> madvise.
>>>
>>> Do we have a working patch set for Nitesh's code? The last time I tri=
ed
>>> running his patch set I ran into issues with kernel panics. If we hav=
e a
>>> known working/stable patch set I can give it a try.
>> Did you try the v12 patch-set [1]?
>> I remember that you reported the CPU stall issue, which I fixed in the=
 v12.
>>
>> [1] https://lkml.org/lkml/2019/8/12/593
> So I tried testing with the spin_lock calls replaced with spin_lock
> _irq to resolve the IRQ issue. I also had shuffle enabled in order to
> increase the number of pages being dirtied.
>
> With that setup the bitmap approach is running significantly worse
> then my approach, even with the boundary removed. Since I had to
> modify the code to even getting working I am not comfortable posting
> numbers.=20

I didn't face any issue in getting the code work or compile.
Before my v12 posting, I did try your previously suggested test
(will-it-scale/page_fault1 for 12 hours on a 60 GB) and didn't see any is=
sues.
I think it would help more if you can share the setup which you are runni=
ng.

> My suggestion would be to look at reworking the patch set and
> post numbers for my patch set versus the bitmap approach and we can
> look at them then.

Agreed. However, in order to fix an issue I have to reproduce it first.

>  I would prefer not to spend my time fixing and
> tuning a patch set that I am still not convinced is viable.

You=C2=A0 don't have to, I can fix the issues in my patch-set. :)

>
> Thanks.
>
> - Alex
--=20
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

