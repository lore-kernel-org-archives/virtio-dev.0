Return-Path: virtio-dev-return-7337-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF03B985FC7
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 May 2020 10:12:47 +0000 (UTC)
References: <20200507103119.11219-1-david@redhat.com>
 <7848642F-6AA7-4B5E-AE0E-DB0857C94A93@linux.alibaba.com>
 <31c5d2f9-c104-53e8-d9c8-cb45f7507c85@redhat.com>
 <A3BBAEEE-FBB9-4259-8BED-023CCD530021@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <389b6bdc-b196-e4b9-b6be-dcac57524fdf@redhat.com>
Date: Thu, 14 May 2020 12:12:10 +0200
MIME-Version: 1.0
In-Reply-To: <A3BBAEEE-FBB9-4259-8BED-023CCD530021@linux.alibaba.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v3 00/15] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: teawater <teawaterz@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 14.05.20 12:02, teawater wrote:
>=20
>=20
>> 2020=E5=B9=B45=E6=9C=8814=E6=97=A5 16:48=EF=BC=8CDavid Hildenbrand <davi=
d@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On 14.05.20 08:44, teawater wrote:
>>> Hi David,
>>>
>>> I got a kernel warning with v2 and v3.
>>
>> Hi Hui,
>>
>> thanks for playing with the latest versions. Surprisingly, I can
>> reproduce even by hotplugging a DIMM instead as well - that's good, so
>> it's not related to virtio-mem, lol. Seems to be some QEMU setup issue
>> with older machine types.
>>
>> Can you switch to a newer qemu machine version, especially
>> pc-i440fx-5.0? Both, hotplugging DIMMs and virtio-mem works for me with
>> that QEMU machine just fine.
>=20
> I still could reproduce this issue with pc-i440fx-5.0 or pc.  Did I miss =
anything?
>=20

Below I don't even see virtio_mem. I had to repair the image (filesystem
fsck) because it was broken, can you try that as well?

Also, it would be great if you could test with v4.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

