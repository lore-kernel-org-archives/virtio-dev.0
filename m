Return-Path: virtio-dev-return-6214-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B187D985D49
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Oct 2019 15:21:45 +0000 (UTC)
From: Nitesh Narayan Lal <nitesh@redhat.com>
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <CAKgT0Uf37xAFK2CWqUZJgn7bWznSAi6qncLxBpC55oSpBMG1HQ@mail.gmail.com>
 <c06b68cb-5e94-ae3e-f84e-48087d675a8f@redhat.com>
 <CAKgT0Ud6TT=XxqFx6ePHzbUYqMp5FHVPozRvnNZK3tKV7j2xjg@mail.gmail.com>
 <0a16b11e-ec3b-7196-5b7f-e7395876cf28@redhat.com>
 <d96f744d2c48f5a96c6962c6a0a89d2429e5cab8.camel@linux.intel.com>
 <7fc13837-546c-9c4a-1456-753df199e171@redhat.com>
 <5b6e0b6df46c03bfac906313071ac0362d43c432.camel@linux.intel.com>
 <c2fd074b-1c86-cd93-41ea-ae1a6b2ca841@redhat.com>
Message-ID: <5c640ecb-cfef-2fa6-57aa-1352f1036f4e@redhat.com>
Date: Wed, 9 Oct 2019 11:21:34 -0400
MIME-Version: 1.0
In-Reply-To: <c2fd074b-1c86-cd93-41ea-ae1a6b2ca841@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Alexander Duyck <alexander.duyck@gmail.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/7/19 1:06 PM, Nitesh Narayan Lal wrote:
[...]
>> So what was the size of your guest? One thing that just occurred to me=
 is
>> that you might be running a much smaller guest than I was.
> I am running a 30 GB guest.
>
>>>>  If so I would have expected a much higher difference versus
>>>> baseline as zeroing/faulting the pages in the host gets expensive fa=
irly
>>>> quick. What is the host kernel you are running your test on? I'm jus=
t
>>>> wondering if there is some additional overhead currently limiting yo=
ur
>>>> setup. My host kernel was just the same kernel I was running in the =
guest,
>>>> just built without the patches applied.
>>> Right now I have a different host-kernel. I can install the same kern=
el to the
>>> host as well and see if that changes anything.
>> The host kernel will have a fairly significant impact as I recall. For=

>> example running a stock CentOS kernel lowered the performance compared=
 to
>> running a linux-next kernel. As a result the numbers looked better sin=
ce
>> the overall baseline was lower to begin with as the host OS was
>> introducing additional overhead.
> I see in that case I will try by installing the same guest kernel
> to the host as well.

As per your suggestion, I tried replacing the host kernel with an
upstream kernel without my patches i.e., my host has a kernel built on to=
p
of the upstream kernel's master branch which has Sept 23rd commit and the=
 guest
has the same kernel for the no-hinting case and same kernel + my patches
for the page reporting case.

With the changes reported earlier on top of v12, I am not seeing any furt=
her
degradation (other than what I have previously reported).

To be sure that THP is actively used, I did an experiment where I changed=
 the
MEMSIZE in the page_fault. On doing so THP usage checked via /proc/meminf=
o also
increased as I expected.

In any case, if you find something else please let me know and I will loo=
k into it
again.


I am still looking into your suggestion about cache line bouncing and wil=
l reply
to it, if I have more questions.


[...]



--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

