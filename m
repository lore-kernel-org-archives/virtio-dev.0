Return-Path: virtio-dev-return-7437-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D246985E07
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Jun 2020 07:09:56 +0000 (UTC)
References: <20200507140139.17083-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8e130bb2-e4bc-bbfc-a635-b44957f069ed@redhat.com>
Date: Tue, 2 Jun 2020 09:09:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v4 00/15] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 07.05.20 16:01, David Hildenbrand wrote:
> This series is based on v5.7-rc4. The patches are located at:
>     https://github.com/davidhildenbrand/linux.git virtio-mem-v4
> 
> This is basically a resend of v3 [1], now based on v5.7-rc4 and restested.
> One patch was reshuffled and two ACKs I missed to add were added. The
> rebase did not require any modifications to patches.
> 
> Details about virtio-mem can be found in the cover letter of v2 [2]. A
> basic QEMU implementation was posted yesterday [3].
> 
> [1] https://lkml.kernel.org/r/20200507103119.11219-1-david@redhat.com
> [2] https://lkml.kernel.org/r/20200311171422.10484-1-david@redhat.com
> [3] https://lkml.kernel.org/r/20200506094948.76388-1-david@redhat.com
> 
> v3 -> v4:
> - Move "MAINTAINERS: Add myself as virtio-mem maintainer" to #2
> - Add two ACKs from Andrew (in reply to v2)
> -- "mm: Allow to offline unmovable PageOffline() pages via ..."
> -- "mm/memory_hotplug: Introduce offline_and_remove_memory()"
> 
> v2 -> v3:
> - "virtio-mem: Paravirtualized memory hotplug"
> -- Include "linux/slab.h" to fix build issues
> -- Remember the "region_size", helpful for patch #11
> -- Minor simplifaction in virtio_mem_overlaps_range()
> -- Use notifier_from_errno() instead of notifier_to_errno() in notifier
> -- More reliable check for added memory when unloading the driver
> - "virtio-mem: Allow to specify an ACPI PXM as nid"
> -- Also print the nid
> - Added patch #11-#15

@MST ping, v5.7 has been released

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

