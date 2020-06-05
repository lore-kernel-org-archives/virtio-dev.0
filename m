Return-Path: virtio-dev-return-7443-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE1339860D7
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Jun 2020 12:18:58 +0000 (UTC)
References: <20191212171137.13872-1-david@redhat.com>
 <9acc5d04-c8e9-ef53-85e4-709030997ca6@redhat.com>
 <1cfa9edb-47ea-1495-4e28-4cf391eab44c@linux.alibaba.com>
 <d6cd1870-1012-cb3d-7d29-8e5ad2703717@redhat.com>
 <6b4724bf-84b5-9880-5464-1908425d106d@redhat.com>
 <e1643897-ebd7-75f8-d271-44f62318aa66@redhat.com>
 <95c6ef21-23e0-c768-999d-3af7f69d02d3@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b41dcc92-604e-0c48-92e5-5cb3d78f189e@redhat.com>
Date: Fri, 5 Jun 2020 14:18:28 +0200
MIME-Version: 1.0
In-Reply-To: <95c6ef21-23e0-c768-999d-3af7f69d02d3@linux.alibaba.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alex Shi <alex.shi@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 05.06.20 12:46, Alex Shi wrote:
>=20
>=20
> =E5=9C=A8 2020/6/5 =E4=B8=8B=E5=8D=886:05, David Hildenbrand =E5=86=99=E9=
=81=93:
>>> I guess I know what's happening here. In case we only have DMA memory
>>> when booting, we don't reserve swiotlb buffers. Once we hotplug memory
>>> and online ZONE_NORMAL, we don't have any swiotlb DMA bounce buffers to
>>> map such PFNs (total 0 (slots), used 0 (slots)).
>>>
>>> Can you try with "swiotlb=3Dforce" on the kernel cmdline?
>> Alternative, looks like you can specify "-m 2G,maxmem=3D16G,slots=3D1", =
to
>> create proper ACPI tables that indicate hotpluggable memory. (I'll have
>> to look into QEMU to figure out to always indicate hotpluggable memory
>> that way).
>>
>=20
>=20
> That works too. Yes, better resolved in qemu, maybe. :)
>=20

You can checkout

git@github.com:davidhildenbrand/qemu.git virtio-mem-v4

(prone to change before officially sent), which will create srat tables
also if no "slots" parameter was defined (and no -numa config was
specified).

Your original example should work with that.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

