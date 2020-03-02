Return-Path: virtio-dev-return-6871-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A7BC985D29
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 18:42:10 +0000 (UTC)
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-7-david@redhat.com>
 <abac569d8d1978aebadf71b65cdeb240a6256ad2.camel@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <65d4aadd-4d19-865a-3b65-d6a6d4f23dc5@redhat.com>
Date: Mon, 2 Mar 2020 19:41:39 +0100
MIME-Version: 1.0
In-Reply-To: <abac569d8d1978aebadf71b65cdeb240a6256ad2.camel@linux.intel.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 06/11] mm: Allow to offline unmovable PageOffline()
 pages via MEM_GOING_OFFLINE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Pingfan Liu <kernelfans@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.03.20 18:40, Alexander Duyck wrote:
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Thanks a lot Alex!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

