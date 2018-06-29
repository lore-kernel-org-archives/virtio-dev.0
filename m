Return-Path: virtio-dev-return-4612-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0014B58191BC
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jun 2018 09:32:59 -0700 (PDT)
Date: Fri, 29 Jun 2018 19:32:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180629192007-mutt-send-email-mst@kernel.org>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
 <20180629172216-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396C251E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7396C251E@shsmsx102.ccr.corp.intel.com>
Subject: [virtio-dev] Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 29, 2018 at 03:52:40PM +0000, Wang, Wei W wrote:
> On Friday, June 29, 2018 10:46 PM, Michael S. Tsirkin wrote:
> > To: David Hildenbrand <david@redhat.com>
> > Cc: Wang, Wei W <wei.w.wang@intel.com>; virtio-dev@lists.oasis-open.org;
> > linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > kvm@vger.kernel.org; linux-mm@kvack.org; mhocko@kernel.org;
> > akpm@linux-foundation.org; torvalds@linux-foundation.org;
> > pbonzini@redhat.com; liliang.opensource@gmail.com;
> > yang.zhang.wz@gmail.com; quan.xu0@gmail.com; nilal@redhat.com;
> > riel@redhat.com; peterx@redhat.com
> > Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
> > 
> > On Wed, Jun 27, 2018 at 01:06:32PM +0200, David Hildenbrand wrote:
> > > On 25.06.2018 14:05, Wei Wang wrote:
> > > > This patch series is separated from the previous "Virtio-balloon
> > > > Enhancement" series. The new feature,
> > > > VIRTIO_BALLOON_F_FREE_PAGE_HINT, implemented by this series
> > enables
> > > > the virtio-balloon driver to report hints of guest free pages to the
> > > > host. It can be used to accelerate live migration of VMs. Here is an
> > introduction of this usage:
> > > >
> > > > Live migration needs to transfer the VM's memory from the source
> > > > machine to the destination round by round. For the 1st round, all
> > > > the VM's memory is transferred. From the 2nd round, only the pieces
> > > > of memory that were written by the guest (after the 1st round) are
> > > > transferred. One method that is popularly used by the hypervisor to
> > > > track which part of memory is written is to write-protect all the guest
> > memory.
> > > >
> > > > This feature enables the optimization by skipping the transfer of
> > > > guest free pages during VM live migration. It is not concerned that
> > > > the memory pages are used after they are given to the hypervisor as
> > > > a hint of the free pages, because they will be tracked by the
> > > > hypervisor and transferred in the subsequent round if they are used and
> > written.
> > > >
> > > > * Tests
> > > > - Test Environment
> > > >     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> > > >     Guest: 8G RAM, 4 vCPU
> > > >     Migration setup: migrate_set_speed 100G, migrate_set_downtime 2
> > > > second
> > > >
> > > > - Test Results
> > > >     - Idle Guest Live Migration Time (results are averaged over 10 runs):
> > > >         - Optimization v.s. Legacy = 284ms vs 1757ms --> ~84% reduction
> > > >     - Guest with Linux Compilation Workload (make bzImage -j4):
> > > >         - Live Migration Time (average)
> > > >           Optimization v.s. Legacy = 1402ms v.s. 2528ms --> ~44% reduction
> > > >         - Linux Compilation Time
> > > >           Optimization v.s. Legacy = 5min6s v.s. 5min12s
> > > >           --> no obvious difference
> > > >
> > >
> > > Being in version 34 already, this whole thing still looks and feels
> > > like a big hack to me. It might just be me, but especially if I read
> > > about assumptions like "QEMU will not hotplug memory during
> > > migration". This does not feel like a clean solution.
> > >
> > > I am still not sure if we really need this interface, especially as
> > > real free page hinting might be on its way.
> > >
> > > a) we perform free page hinting by setting all free pages
> > > (arch_free_page()) to zero. Migration will detect zero pages and
> > > minimize #pages to migrate. I don't think this is a good idea but
> > > Michel suggested to do a performance evaluation and Nitesh is looking
> > > into that right now.
> > 
> > Yes this test is needed I think. If we can get most of the benefit without PV
> > interfaces, that's nice.
> > 
> > Wei, I think you need this as part of your performance comparison
> > too: set page poisoning value to 0 and enable KSM, compare with your
> > patches.
> 
> Do you mean live migration with zero pages?
> I can first share the amount of memory transferred during live migration I saw,
> Legacy is around 380MB,
> Optimization is around 340MB.
> This proves that most pages have already been 0 and skipped during the legacy live migration. But the legacy time is still much larger because zero page checking is costly. 
> (It's late night here, I can get you that with my server probably tomorrow)
> 
> Best,
> Wei

Sure thing.

Also we might want to look at optimizing the RLE compressor for
the common case of pages full of zeroes.

Here are some ideas:
https://rusty.ozlabs.org/?p=560

Note Epiphany #2 as well as comments Paolo Bonzini and by Victor Kaplansky.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

