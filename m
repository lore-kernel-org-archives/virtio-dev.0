Return-Path: virtio-dev-return-5994-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F3C3985B2F
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Aug 2019 14:12:02 +0000 (UTC)
From: Nitesh Narayan Lal <nitesh@redhat.com>
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
 <b5d4ee25-ae3e-f012-d7f2-7a27d7bbcc54@redhat.com>
Message-ID: <c0e3a4dd-3eab-f00d-6a87-272bb9481dd1@redhat.com>
Date: Tue, 20 Aug 2019 10:11:45 -0400
MIME-Version: 1.0
In-Reply-To: <b5d4ee25-ae3e-f012-d7f2-7a27d7bbcc54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Alexander Duyck <alexander.duyck@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/12/19 4:04 PM, Nitesh Narayan Lal wrote:
> On 8/12/19 2:47 PM, Alexander Duyck wrote:
>> On Mon, Aug 12, 2019 at 6:13 AM Nitesh Narayan Lal <nitesh@redhat.com>=
 wrote:
>>> This patch introduces the core infrastructure for free page reporting=
 in
>>> virtual environments. It enables the kernel to track the free pages w=
hich
>>> can be reported to its hypervisor so that the hypervisor could
>>> free and reuse that memory as per its requirement.
>>>
>>> While the pages are getting processed in the hypervisor (e.g.,
>>> via MADV_DONTNEED), the guest must not use them, otherwise, data loss=

>>> would be possible. To avoid such a situation, these pages are
>>> temporarily removed from the buddy. The amount of pages removed
>>> temporarily from the buddy is governed by the backend(virtio-balloon
>>> in our case).
>>>
>>> To efficiently identify free pages that can to be reported to the
>>> hypervisor, bitmaps in a coarse granularity are used. Only fairly big=

>>> chunks are reported to the hypervisor - especially, to not break up T=
HP
>>> in the hypervisor - "MAX_ORDER - 2" on x86, and to save space. The bi=
ts
>>> in the bitmap are an indication whether a page *might* be free, not a=

>>> guarantee. A new hook after buddy merging sets the bits.
>>>
>>> Bitmaps are stored per zone, protected by the zone lock. A workqueue
>>> asynchronously processes the bitmaps, trying to isolate and report pa=
ges
>>> that are still free. The backend (virtio-balloon) is responsible for
>>> reporting these batched pages to the host synchronously. Once reporti=
ng/
>>> freeing is complete, isolated pages are returned back to the buddy.
>>>
>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> So if I understand correctly the hotplug support for this is still not=

>> included correct?=20
>
> That is correct, I have it as an ongoing-item in my cover-email.
> In case, we decide to go with this approach do you think it is a blocke=
r?

I am planning to defer memory hotplug/hotremove support for the future. D=
ue to
following reasons:
* I would like to first get a basic framework ready and merged (in case w=
e
=C2=A0 decide to go ahead with this approach) and then build on top of it=
=2E
* Memory hotplug/hotremove is not a primary use case in our mind right no=
w and
=C2=A0 hence I am not considering this as a blocker for the first step.

Following are the items which I intend to address before my next submissi=
on:
* Use zone flag and reference counter to track the number of zones reques=
ting
=C2=A0 page reporting.
* Move the bitmap and its respective fields into a structure whose rcu-pr=
otected
=C2=A0 pointer object is maintained on a per-zone basis.
* Pick Alexander's patch for page poisoning support and test them with my=
 patch
=C2=A0 set. (@Alexander: I will keep your signed-off for these patches to=
 indicate
=C2=A0 you are the original author, please do let me know there is a bett=
er way to
=C2=A0 give credit).
* Address other suggestions/comments received on v12.

Looking forward to any suggestions/comments.


[...]
> +
> +       /* assign the configuration object provided by the backend */
> +       rcu_assign_pointer(page_reporting_conf, phconf);
> +
> +out:
> +       mutex_unlock(&page_reporting_mutex);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(page_reporting_enable);
> --
> 2.21.0
>
--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

