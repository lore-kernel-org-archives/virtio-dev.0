Return-Path: virtio-dev-return-6912-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FE64985F01
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Mar 2020 11:46:24 +0000 (UTC)
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-8-david@redhat.com>
 <20200310114312.GG8447@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e505b4cb-1d12-d6e6-3524-9dfa65ae34bf@redhat.com>
Date: Tue, 10 Mar 2020 12:46:05 +0100
MIME-Version: 1.0
In-Reply-To: <20200310114312.GG8447@dhcp22.suse.cz>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 07/11] virtio-mem: Allow to offline partially unplugged
 memory blocks
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <virtio-dev.lists.oasis-open.org>

On 10.03.20 12:43, Michal Hocko wrote:
> On Mon 02-03-20 14:49:37, David Hildenbrand wrote:
> [...]
>> +static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
>> +					    unsigned long mb_id)
>> +{
>> +	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
>> +	unsigned long pfn;
>> +	int sb_id, i;
>> +
>> +	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
>> +		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
>> +			continue;
>> +		/*
>> +		 * Drop our reference to the pages so the memory can get
>> +		 * offlined and add the unplugged pages to the managed
>> +		 * page counters (so offlining code can correctly subtract
>> +		 * them again).
>> +		 */
>> +		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>> +			       sb_id * vm->subblock_size);
>> +		adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
>> +		for (i = 0; i < nr_pages; i++)
>> +			page_ref_dec(pfn_to_page(pfn + i));
> 
> Is there ever situation this might be a different than 1->0 transition?

Only if some other code would be taking a reference. At least not from
virtio-mem perspective.

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

