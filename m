Return-Path: virtio-dev-return-6512-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83B19985EEC
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Dec 2019 09:41:33 +0000 (UTC)
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-2-david@redhat.com> <5687328.t4MNS9KDDX@kreacher>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ec81db03-b970-420a-9c1b-29849b5e8902@redhat.com>
Date: Fri, 13 Dec 2019 10:41:20 +0100
MIME-Version: 1.0
In-Reply-To: <5687328.t4MNS9KDDX@kreacher>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH RFC v4 01/13] ACPI: NUMA: export pxm_to_node
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.12.19 22:43, Rafael J. Wysocki wrote:
> On Thursday, December 12, 2019 6:11:25 PM CET David Hildenbrand wrote:
>> Will be needed by virtio-mem to identify the node from a pxm.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/acpi/numa/srat.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
>> index eadbf90e65d1..d5847fa7ac69 100644
>> --- a/drivers/acpi/numa/srat.c
>> +++ b/drivers/acpi/numa/srat.c
>> @@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
>>  		return NUMA_NO_NODE;
>>  	return pxm_to_node_map[pxm];
>>  }
>> +EXPORT_SYMBOL(pxm_to_node);
>>  
>>  int node_to_pxm(int node)
>>  {
>>
> 
> This is fine by me FWIW.

Can I count that as an Acked-by and carry it along? Thanks!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

