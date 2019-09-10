Return-Path: virtio-dev-return-6110-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47C20985C1E
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Sep 2019 22:14:50 +0000 (UTC)
Message-ID: <ac75ce0302faa234860a49cc965a6d342b3ca685.camel@linux.intel.com>
From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Tue, 10 Sep 2019 15:14:47 -0700
In-Reply-To: <20190910121130.GU2063@dhcp22.suse.cz>
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
	 <20190907172512.10910.74435.stgit@localhost.localdomain>
	 <0df2e5d0-af92-04b4-aa7d-891387874039@redhat.com>
	 <0ca58fea280b51b83e7b42e2087128789bc9448d.camel@linux.intel.com>
	 <20190910121130.GU2063@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 1/8] mm: Add per-cpu logic to page shuffling
To: Michal Hocko <mhocko@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, catalin.marinas@arm.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org, akpm@linux-foundation.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, osalvador@suse.de, yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, ying.huang@intel.com, pbonzini@redhat.com, dan.j.williams@intel.com, fengguang.wu@intel.com, kirill.shutemov@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 2019-09-10 at 14:11 +0200, Michal Hocko wrote:
> On Mon 09-09-19 08:11:36, Alexander Duyck wrote:
> > On Mon, 2019-09-09 at 10:14 +0200, David Hildenbrand wrote:
> > > On 07.09.19 19:25, Alexander Duyck wrote:
> > > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > 
> > > > Change the logic used to generate randomness in the suffle path so that we
> > > > can avoid cache line bouncing. The previous logic was sharing the offset
> > > > and entropy word between all CPUs. As such this can result in cache line
> > > > bouncing and will ultimately hurt performance when enabled.
> > > 
> > > So, usually we perform such changes if there is real evidence. Do you
> > > have any such performance numbers to back your claims?
> > 
> > I'll have to go rerun the test to get the exact numbers. The reason this
> > came up is that my original test was spanning NUMA nodes and that made
> > this more expensive as a result since the memory was both not local to the
> > CPU and was being updated by multiple sockets.
> 
> What was the pattern of page freeing in your testing? I am wondering
> because order 0 pages should be prevailing and those usually go via pcp
> lists so they do not get shuffled unless the batch is full IIRC.

So I am pretty sure my previous data was faulty. One side effect of the
page reporting is that it was evicting pages out of the guest and when the
pages were faulted back in they were coming from local page pools. This
was throwing off my early numbers and making tests look better than they
should have for the reported case.

I had this patch previously merged with another one so I wasn't testing it
on its own, it was instead a part of a bigger set. Now that I have tried
testing it on its own I can see that it has no significant impact on
performance. With that being the case I will probably just drop it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

