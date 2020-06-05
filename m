Return-Path: virtio-dev-return-7442-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD4FB9860CF
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Jun 2020 10:06:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <9acc5d04-c8e9-ef53-85e4-709030997ca6@redhat.com>
 <1cfa9edb-47ea-1495-4e28-4cf391eab44c@linux.alibaba.com>
 <d6cd1870-1012-cb3d-7d29-8e5ad2703717@redhat.com>
 <6b4724bf-84b5-9880-5464-1908425d106d@redhat.com>
Message-ID: <e1643897-ebd7-75f8-d271-44f62318aa66@redhat.com>
Date: Fri, 5 Jun 2020 12:05:40 +0200
MIME-Version: 1.0
In-Reply-To: <6b4724bf-84b5-9880-5464-1908425d106d@redhat.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alex Shi <alex.shi@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 05.06.20 11:36, David Hildenbrand wrote:
> On 05.06.20 11:08, David Hildenbrand wrote:
>> On 05.06.20 10:55, Alex Shi wrote:
>>>
>>>
>>> =E5=9C=A8 2020/1/9 =E4=B8=8B=E5=8D=889:48, David Hildenbrand =E5=86=99=
=E9=81=93:
>>>> Ping,
>>>>
>>>> I'd love to get some feedback on
>>>>
>>>> a) The remaining MM bits from MM folks (especially, patch #6 and #8).
>>>> b) The general virtio infrastructure (esp. uapi in patch #2) from virt=
io
>>>> folks.
>>>>
>>>> I'm planning to send a proper v1 (!RFC) once I have all necessary MM
>>>> acks. In the meanwhile, I will do more testing and minor reworks (e.g.=
,
>>>> fix !CONFIG_NUMA compilation).
>>>
>>>
>>> Hi David,
>>>
>>> Thanks for your work!
>>>
>>> I am trying your https://github.com/davidhildenbrand/linux.git virtio-m=
em-v5
>>> which works fine for me, but just a 'DMA error' happens when a vm start=
 with
>>> less than 2GB memory, Do I missed sth?
>>
>> Please use the virtio-mem-v4 branch for now, v5 is still under
>> construction (and might be scrapped completely if v4 goes upstream as is=
).
>>
>> Looks like a DMA issue. Your're hotplugging 1GB, which should not really
>> eat too much memory. There was a similar issue reported by Hui in [1],
>> which boiled down to wrong usage of the swiotlb parameter.
>>
>> In such cases you should always try to reproduce with hotplug of a
>> sam-sized DIMM. E.g., hotplugging a 1GB DIMM should result in the same
>> issue.
>>
>> What does your .config specify for CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE?
>>
>> I'll try to reproduce with v4 briefly.
>=20
> I guess I know what's happening here. In case we only have DMA memory
> when booting, we don't reserve swiotlb buffers. Once we hotplug memory
> and online ZONE_NORMAL, we don't have any swiotlb DMA bounce buffers to
> map such PFNs (total 0 (slots), used 0 (slots)).
>=20
> Can you try with "swiotlb=3Dforce" on the kernel cmdline?

Alternative, looks like you can specify "-m 2G,maxmem=3D16G,slots=3D1", to
create proper ACPI tables that indicate hotpluggable memory. (I'll have
to look into QEMU to figure out to always indicate hotpluggable memory
that way).


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

