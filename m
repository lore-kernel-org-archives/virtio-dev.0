Return-Path: virtio-dev-return-7342-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3ADA8985FC7
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 May 2020 12:20:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
 <7848642F-6AA7-4B5E-AE0E-DB0857C94A93@linux.alibaba.com>
 <31c5d2f9-c104-53e8-d9c8-cb45f7507c85@redhat.com>
 <A3BBAEEE-FBB9-4259-8BED-023CCD530021@linux.alibaba.com>
 <389b6bdc-b196-e4b9-b6be-dcac57524fdf@redhat.com>
 <3c82e149-6c42-690e-9d58-bb8e69870fe0@redhat.com>
 <e48ded49-9b92-7025-a06f-49b24f1c53a6@redhat.com>
Message-ID: <cda84c4d-0f4c-1dd8-44f6-68f211e5de6d@redhat.com>
Date: Thu, 14 May 2020 14:19:51 +0200
MIME-Version: 1.0
In-Reply-To: <e48ded49-9b92-7025-a06f-49b24f1c53a6@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v3 00/15] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: teawater <teawaterz@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 14.05.20 13:47, David Hildenbrand wrote:
> On 14.05.20 13:10, David Hildenbrand wrote:
>> On 14.05.20 12:12, David Hildenbrand wrote:
>>> On 14.05.20 12:02, teawater wrote:
>>>>
>>>>
>>>>> 2020=E5=B9=B45=E6=9C=8814=E6=97=A5 16:48=EF=BC=8CDavid Hildenbrand <d=
avid@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>
>>>>> On 14.05.20 08:44, teawater wrote:
>>>>>> Hi David,
>>>>>>
>>>>>> I got a kernel warning with v2 and v3.
>>>>>
>>>>> Hi Hui,
>>>>>
>>>>> thanks for playing with the latest versions. Surprisingly, I can
>>>>> reproduce even by hotplugging a DIMM instead as well - that's good, s=
o
>>>>> it's not related to virtio-mem, lol. Seems to be some QEMU setup issu=
e
>>>>> with older machine types.
>>>>>
>>>>> Can you switch to a newer qemu machine version, especially
>>>>> pc-i440fx-5.0? Both, hotplugging DIMMs and virtio-mem works for me wi=
th
>>>>> that QEMU machine just fine.
>>>>
>>>> I still could reproduce this issue with pc-i440fx-5.0 or pc.  Did I mi=
ss anything?
>>>>
>>>
>>> Below I don't even see virtio_mem. I had to repair the image (filesyste=
m
>>> fsck) because it was broken, can you try that as well?
>>>
>>> Also, it would be great if you could test with v4.
>>>
>>
>> Correction, something seems to be broken either in QEMU or the kernel. O=
nce I
>> define a DIMM so it's added and online during boot, I get these issues:
>>
>> (I have virtio-mem v4 installed in the guest)
>>
>> #! /bin/bash
>> sudo x86_64-softmmu/qemu-system-x86_64 \
>>     -machine pc-i440fx-5.0,accel=3Dkvm,usb=3Doff \
>>     -cpu host \
>>     -no-reboot \
>>     -nographic \
>>     -device ide-hd,drive=3Dhd \
>>     -drive if=3Dnone,id=3Dhd,file=3D/home/dhildenb/git/Fedora-Cloud-Base=
-31-1.9.x86_64.qcow2,format=3Dqcow2 \
>>     -m 1g,slots=3D10,maxmem=3D2G \
>>     -smp 1 \
>>     -object memory-backend-ram,id=3Dmem0,size=3D256m \
>>     -device pc-dimm,id=3Ddimm0,memdev=3Dmem0 \
>>     -s \
>>     -monitor unix:/var/tmp/monitor,server,nowait
>>
>>
>> Without the DIMM it seems to work just fine.
>>
>=20
> And another correction.=20
>=20
> Using QEMU v5.0.0, Linux 5.7-rc5, untouched
> Fedora-Cloud-Base-32-1.6.x86_64.qcow2, I get even without any memory hotp=
lug:
>=20
> #! /bin/bash
> sudo x86_64-softmmu/qemu-system-x86_64 \
>     -machine pc-i440fx-5.0,accel=3Dkvm,usb=3Doff \
>     -cpu host \
>     -no-reboot \
>     -nographic \
>     -device ide-hd,drive=3Dhd \
>     -drive if=3Dnone,id=3Dhd,file=3D/home/dhildenb/git/Fedora-Cloud-Base-=
32-1.6.x86_64.qcow2,format=3Dqcow2 \
>     -m 5g,slots=3D10,maxmem=3D6G \
>     -smp 1 \
>     -s \
>     -kernel /home/dhildenb/git/linux/arch/x86/boot/bzImage \
>     -append "console=3DttyS0 rd.shell nokaslr swiotlb=3Dnoforce" \
>     -monitor unix:/var/tmp/monitor,server,nowait
>=20
>=20
> Observe how big the initial RAM even is!
>=20
>=20
> So this is no DIMM/hotplug/virtio_mem issue. With memory hotplug, it seem=
s to get
> more likely to trigger if "swiotlb=3Dnoforce" is not specified.
>=20
> "swiotlb=3Dnoforce" seems to trigger some pre-existing issue here. Withou=
t
> "swiotlb=3Dnoforce", I was only able to observe this via pc-i440fx-2.1,
>=20

(talking to myself :) )

I think I finally understood why using "swiotlb=3Dnoforce" with hotplugged
memory is wrong - or with memory > 3GB. Via "swiotlb=3Dnoforce" you tell
the system to "Never use bounce buffers (for debugging)". This works as
long as all memory is DMA memory (e.g., < 3GB) AFAIK.

"If specified, trying to map memory that cannot be used with DMA will
fail, and a rate-limited warning will be printed."

Hotplugged memory (under QEMU) is never added below 4GB, because of the
PCI hole. So both, memory from DIMMs and from virtio-mem will end up at
or above 4GB. To make a device use that memory, you need bounce buffers.

Hotplugged memory is never DMA memory.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

