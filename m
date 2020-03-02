Return-Path: virtio-dev-return-6872-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB4A0985D29
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 18:42:33 +0000 (UTC)
References: <20200302134941.315212-1-david@redhat.com>
 <7f8a9225-99f2-b00d-241f-ef934395c667@redhat.com>
 <20200302182922.GT4380@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8de97b11-2eb5-8fe4-1867-ade57e5aee37@redhat.com>
Date: Mon, 2 Mar 2020 19:41:21 +0100
MIME-Version: 1.0
In-Reply-To: <20200302182922.GT4380@dhcp22.suse.cz>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 00/11] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.03.20 19:29, Michal Hocko wrote:
> On Mon 02-03-20 19:15:09, David Hildenbrand wrote:
> [...]
>> As requested by Michal, I will squash some patches.
> 
> Just to clarify. If I am the only one to care then do not bother.

Oh, I do bother about your review comments a lot :) And pulling out the
NID part from patch #2 makes a lot of sense (so I can properly squash
patch #1 into that). Looks much cleaner.

> Btw. I still have patch 6 on the todo list to review. I just didn't find
> time for it today.

Perfect, I'll definitely wait until I resend a v2 - thanks.

Cheers!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

