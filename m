Return-Path: virtio-dev-return-6107-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 052B0985BF8
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Sep 2019 20:37:50 +0000 (UTC)
Message-ID: <9b1c34e8b846e2d9ede6879bce47c7d704c89bd3.camel@linux.intel.com>
From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Tue, 10 Sep 2019 13:37:47 -0700
In-Reply-To: <20190910180026.GE4023@dhcp22.suse.cz>
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
	 <20190910124209.GY2063@dhcp22.suse.cz>
	 <CAKgT0Udr6nYQFTRzxLbXk41SiJ-pcT_bmN1j1YR4deCwdTOaUQ@mail.gmail.com>
	 <20190910144713.GF2063@dhcp22.suse.cz>
	 <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
	 <20190910175213.GD4023@dhcp22.suse.cz>
	 <20190910180026.GE4023@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: Michal Hocko <mhocko@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 2019-09-10 at 20:00 +0200, Michal Hocko wrote:
> On Tue 10-09-19 19:52:13, Michal Hocko wrote:
> > On Tue 10-09-19 09:05:43, Alexander Duyck wrote:
> [...]
> > > All this is providing is just a report and it is optional if the
> > > hypervisor will act on it or not. If the hypervisor takes some sort of
> > > action on the page, then the expectation is that the hypervisor will
> > > use some sort of mechanism such as a page fault to discover when the
> > > page is used again.
> > 
> > OK so the baloon driver is in charge of this metadata and the allocator
> > has to live with that. Isn't that a layer violation?
> 
> Another thing that is not clear to me is how these marked pages are
> different from any other free pages. All of them are unused and you are
> losing your metadata as soon as the page gets allocated because the page
> changes its owner and the struct page belongs to it.

Really they aren't any different then other free pages other than they are
marked. Us losing the metadata as soon as the page is allocated is fine as
we will need to re-report it when it is returned so we no longer need the
metadata once it is allocated.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

