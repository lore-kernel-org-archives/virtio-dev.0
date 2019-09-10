Return-Path: virtio-dev-return-6109-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57E3D985C1E
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Sep 2019 22:11:53 +0000 (UTC)
Message-ID: <3de2409415b20440d5c8f3016ed78fde3d106dc8.camel@linux.intel.com>
From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Tue, 10 Sep 2019 15:11:50 -0700
In-Reply-To: <0df2e5d0-af92-04b4-aa7d-891387874039@redhat.com>
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
	 <20190907172512.10910.74435.stgit@localhost.localdomain>
	 <0df2e5d0-af92-04b4-aa7d-891387874039@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 1/8] mm: Add per-cpu logic to page shuffling
To: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, catalin.marinas@arm.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, ying.huang@intel.com, pbonzini@redhat.com, dan.j.williams@intel.com, fengguang.wu@intel.com, kirill.shutemov@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 2019-09-09 at 10:14 +0200, David Hildenbrand wrote:
> On 07.09.19 19:25, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > Change the logic used to generate randomness in the suffle path so that we
> > can avoid cache line bouncing. The previous logic was sharing the offset
> > and entropy word between all CPUs. As such this can result in cache line
> > bouncing and will ultimately hurt performance when enabled.
> 
> So, usually we perform such changes if there is real evidence. Do you
> have any such performance numbers to back your claims?

I don't have any numbers. From what I can tell the impact is small enough
that this doesn't really have much impact.

With that being the case I can probably just drop this patch. I will
instead just use "rand & 1" in the 2nd patch to generate the return value
which was what was previously done in add_to_free_area_random.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

