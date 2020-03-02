Return-Path: virtio-dev-return-6851-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81A3A985CD2
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 12:53:24 +0000 (UTC)
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-9-david@redhat.com>
 <20200225141134.GU22443@dhcp22.suse.cz>
 <d1dbb687-7959-f4f1-6a64-33ee039782ef@redhat.com>
 <20200302124852.GJ4380@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <db703da8-cef6-c4bd-a4ba-0863408574d3@redhat.com>
Date: Mon, 2 Mar 2020 13:53:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200302124852.GJ4380@dhcp22.suse.cz>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH RFC v4 08/13] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.03.20 13:48, Michal Hocko wrote:
> On Tue 25-02-20 15:27:28, David Hildenbrand wrote:
>> On 25.02.20 15:11, Michal Hocko wrote:
>>> On Thu 12-12-19 18:11:32, David Hildenbrand wrote:
>>>> virtio-mem wants to offline and remove a memory block once it unplugged
>>>> all subblocks (e.g., using alloc_contig_range()). Let's provide
>>>> an interface to do that from a driver. virtio-mem already supports to
>>>> offline partially unplugged memory blocks. Offlining a fully unplugged
>>>> memory block will not require to migrate any pages. All unplugged
>>>> subblocks are PageOffline() and have a reference count of 0 - so
>>>> offlining code will simply skip them.
>>>>
>>>> All we need an interface to trigger the "offlining" and the removing in a
>>>> single operation - to make sure the memory block cannot get onlined by
>>>> user space again before it gets removed.
>>>
>>> Why does that matter? Is it really likely that the userspace would
>>> interfere? What would be the scenario?
>>
>> I guess it's not that relevant after all (I think this comment dates
>> back to the times where we didn't have try_remove_memory() and could
>> actually BUG_ON() in remove_memory() if there would have been a race).
>> Can drop that part.
>>
>>>
>>> Or is still mostly about not requiring callers to open code this general
>>> patter?
>>
>> From kernel module context, I cannot get access to the actual memory
>> block device (find_memory_block()) and call the device_unregister().
>>
>> Especially, also the device hotplug lock is not exported. So this is a
>> clean helper function to be used from kernel module context. (e.g., also
>> hyper-v showed interest for using that)
> 
> Fair enough.
> 

I'll send a v1 shortly, I rephrased the description to make this clear.
Thanks!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

