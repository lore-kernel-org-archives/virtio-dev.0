Return-Path: virtio-dev-return-6101-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8703985AFA
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Sep 2019 14:47:02 +0000 (UTC)
MIME-Version: 1.0
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190907172528.10910.37051.stgit@localhost.localdomain> <20190910122313.GW2063@dhcp22.suse.cz>
In-Reply-To: <20190910122313.GW2063@dhcp22.suse.cz>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 10 Sep 2019 07:46:50 -0700
Message-ID: <CAKgT0Ud1xqhEy_LL4AfMgreP0uXrkF-fSDn=6uDXfn7Pvj5AAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v9 3/8] mm: Move set/get_pcppage_migratetype to mmzone.h
To: Michal Hocko <mhocko@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 10, 2019 at 5:23 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sat 07-09-19 10:25:28, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > In order to support page reporting it will be necessary to store and
> > retrieve the migratetype of a page. To enable that I am moving the set and
> > get operations for pcppage_migratetype into the mm/internal.h header so
> > that they can be used outside of the page_alloc.c file.
>
> Please describe who is the user and why does it needs this interface.
> This is really important because migratetype is an MM internal thing and
> external users shouldn't really care about it at all. We really do not
> want a random code to call those, especially the set_pcppage_migratetype.

I was using it to store the migratetype of the page so that I could
find the boundary list that contained the reported page as the array
is indexed based on page order and migratetype. However on further
discussion I am thinking I may just use page->index directly to index
into the boundary array. Doing that I should be able to get a very
slight improvement in lookup time since I am not having to pull order
and migratetype and then compute the index based on that. In addition
it becomes much more clear as to what is going on, and if needed I
could add debug checks to verify the page is "Reported" and that the
"Buddy" page type is set.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

