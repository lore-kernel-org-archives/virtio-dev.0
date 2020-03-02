Return-Path: virtio-dev-return-6866-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A608E985CDE
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 14:17:53 +0000 (UTC)
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-5-david@redhat.com>
 <20200302140519.GN4380@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dd34277f-21ad-cae8-8f07-10915fea305e@redhat.com>
Date: Mon, 2 Mar 2020 15:17:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200302140519.GN4380@dhcp22.suse.cz>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 04/11] mm: Export alloc_contig_range() /
 free_contig_range()
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Alexander Potapenko <glider@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.03.20 15:05, Michal Hocko wrote:
> On Mon 02-03-20 14:49:34, David Hildenbrand wrote:
>> A virtio-mem device wants to allocate memory from the memory region it
>> manages in order to unplug it in the hypervisor - similar to
>> a balloon driver. Also, it might want to plug previously unplugged
>> (allocated) memory and give it back to Linux. alloc_contig_range() /
>> free_contig_range() seem to be the perfect interface for this task.
>>
>> In contrast to existing balloon devices, a virtio-mem device operates
>> on bigger chunks (e.g., 4MB) and only on physical memory it manages. It
>> tracks which chunks (subblocks) are still plugged, so it can go ahead
>> and try to alloc_contig_range()+unplug them on unplug request, or
>> plug+free_contig_range() unplugged chunks on plug requests.
>>
>> A virtio-mem device will use alloc_contig_range() / free_contig_range()
>> only on ranges that belong to the same node/zone in at least
>> MAX(MAX_ORDER - 1, pageblock_order) order granularity - e.g., 4MB on
>> x86-64. The virtio-mem device added that memory, so the memory
>> exists and does not contain any holes. virtio-mem will only try to alloc=
ate
>> on ZONE_NORMAL, never on ZONE_MOVABLE, just like when allocating
>> gigantic pages (we don't put unmovable data into the movable zone).
>=20
> Same feedback as in pxm_to_node export. No objections to exporting the
> symbol but it would be better to squash this function into the patch
> which uses it. The changelog is highly virtio-mem specific anyway.
> Maybe it is just a dejavu but I feel I have already said that but I do
> not remember any details.

As I said back then, I am not a friend of squashing core changes into
driver changes (and AFAIK separating such is the common practice - well
I have never written a driver myself). I doubt it will make review
easier or faster (especially when it comes to patch #1).

I can squash #4 into #5, #6 into #7, #8 into #9 if it makes your review
easier.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

