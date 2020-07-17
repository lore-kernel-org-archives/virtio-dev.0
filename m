Return-Path: virtio-dev-return-7577-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 600D5986095
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 03:53:04 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716064340-mutt-send-email-mst@kernel.org>
Date: Fri, 17 Jul 2020 11:52:42 +0800
Message-Id: <A8B48063-59E3-4398-B41F-9CABA9DFA7AC@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <20200716021929-mutt-send-email-mst@kernel.org>
 <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
 <20200716064340-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Andrea Arcangeli <aarcange@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 18:45=EF=BC=8CMichael S. Tsirkin <mst@=
redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 16, 2020 at 03:01:18PM +0800, teawater wrote:
>>=20
>>=20
>>> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:38=EF=BC=8CMichael S. Tsirkin <ms=
t@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
>>>> The first, second and third version are in [1], [2] and [3].
>>>> Code of current version for Linux and qemu is available in [4] and [5]=
.
>>>> Update of this version:
>>>> 1. Report continuous pages will increase the speed.  So added deflate
>>>>  continuous pages.
>>>> 2. According to the comments from David in [6], added 2 new vqs inflat=
e_cont_vq
>>>>  and deflate_cont_vq to report continuous pages with format 32 bits pf=
n and 32
>>>>  bits size.
>>>> Following is the introduction of the function.
>>>> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With =
this
>>>> flag, balloon tries to use continuous pages to inflate and deflate.
>>>> Opening this flag can bring two benefits:
>>>> 1. Report continuous pages will increase memory report size of each ti=
me
>>>>  call tell_host.  Then it will increase the speed of balloon inflate a=
nd
>>>>  deflate.
>>>> 2. Host THPs will be splitted when qemu release the page of balloon in=
flate.
>>>>  Inflate balloon with continuous pages will let QEMU release the pages
>>>>  of same THPs.  That will help decrease the splitted THPs number in
>>>>  the host.
>>>>  Following is an example in a VM with 1G memory 1CPU.  This test setup=
s an
>>>>  environment that has a lot of fragmentation pages.  Then inflate ball=
oon will
>>>>  split the THPs.
>>=20
>>=20
>>>> // This is the THP number before VM execution in the host.
>>>> // None use THP.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:         0 kB
>> These lines are from host.
>>=20
>>>> // After VM start, use usemem
>>>> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability=
.git)
>>>> // punch-holes function generates 400m fragmentation pages in the gues=
t
>>>> // kernel.
>>>> usemem --punch-holes -s -1 800m &
>> These lines are from guest.  They setups the environment that has a lot =
of fragmentation pages.
>>=20
>>>> // This is the THP number after this command in the host.
>>>> // Some THP is used by VM because usemem will access 800M memory
>>>> // in the guest.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    911360 kB
>> These lines are from host.
>>=20
>>>> // Connect to the QEMU monitor, setup balloon, and set it size to 600M=
.
>>>> (qemu) device_add virtio-balloon-pci,id=3Dballoon1
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>>>> (qemu) balloon 600
>>>> (qemu) info balloon
>>>> balloon: actual=3D600
>> These lines are from host.
>>=20
>>>> // This is the THP number after inflate the balloon in the host.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:     88064 kB
>> These lines are from host.
>>=20
>>>> // Set the size back to 1024M in the QEMU monitor.
>>>> (qemu) balloon 1024
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>> These lines are from host.
>>=20
>>>> // Use usemem to increase the memory usage of QEMU.
>>>> killall usemem
>>>> usemem 800m
>> These lines are from guest.
>>=20
>>>> // This is the THP number after this operation.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:     65536 kB
>> These lines are from host.
>>=20
>>=20
>>=20
>>>>=20
>>>> Following example change to use continuous pages balloon.  The number =
of
>>>> splitted THPs is decreased.
>>>> // This is the THP number before VM execution in the host.
>>>> // None use THP.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:         0 kB
>> These lines are from host.
>>=20
>>>> // After VM start, use usemem punch-holes function generates 400M
>>>> // fragmentation pages in the guest kernel.
>>>> usemem --punch-holes -s -1 800m &
>> These lines are from guest.  They setups the environment that has a lot =
of fragmentation pages.
>>=20
>>>> // This is the THP number after this command in the host.
>>>> // Some THP is used by VM because usemem will access 800M memory
>>>> // in the guest.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    911360 kB
>> These lines are from host.
>>=20
>>>> // Connect to the QEMU monitor, setup balloon, and set it size to 600M=
.
>>>> (qemu) device_add virtio-balloon-pci,id=3Dballoon1,cont-pages=3Don
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>>>> (qemu) balloon 600
>>>> (qemu) info balloon
>>>> balloon: actual=3D600
>> These lines are from host.
>>=20
>>>> // This is the THP number after inflate the balloon in the host.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    616448 kB
>>>> // Set the size back to 1024M in the QEMU monitor.
>>>> (qemu) balloon 1024
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>> These lines are from host.
>>=20
>>>> // Use usemem to increase the memory usage of QEMU.
>>>> killall usemem
>>>> usemem 800m
>> These lines are from guest.
>>=20
>>>> // This is the THP number after this operation.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    907264 kB
>> These lines are from host.
>>=20
>>>=20
>>> I'm a bit confused about which of the above run within guest,
>>> and which run within host. Could you explain pls?
>>>=20
>>>=20
>>=20
>> I added some introduction to show where these lines is get from.
>>=20
>> Best,
>> Hui
>=20
>=20
> OK so we see host has more free THPs. But guest has presumably less now -=
 so
> the total page table depth is the same. Did we gain anything?
>=20


cat /proc/meminfo | grep AnonHugePages:
This command will output how many THPs is used by current system.
There is no program using THPs except qemu.
So this command will show how many THPs is used by qemu.

The last outout of =E2=80=9Ccat /proc/meminfo | grep AnonHugePages:=E2=80=
=9D show how many THPs is used by qemu when this 2 qemu=E2=80=99s anon page=
 number is same.
Without =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 65536kb THPs.
Wiht =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 907264kb THPs.
Keep more THPs will make memory access speed high.

This is a test record use this 1G 1 cpu qemu after the fragmentation balloo=
n test:
Without =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 81920kB THPs.
/ # usemem 800m
943718400 bytes / 489412 usecs =3D 1883076 KB/s
18725 usecs to free memory
/ # usemem 800m
943718400 bytes / 487070 usecs =3D 1892130 KB/s
18913 usecs to free memory
/ # usemem 800m
943718400 bytes / 484234 usecs =3D 1903212 KB/s
18538 usecs to free memory
/ # usemem 800m
943718400 bytes / 486568 usecs =3D 1894082 KB/s
18982 usecs to free memory

With =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 907264kb THPs.
/ # usemem 800m
943718400 bytes / 479098 usecs =3D 1923614 KB/s
18980 usecs to free memory
/ # usemem 800m
943718400 bytes / 477433 usecs =3D 1930323 KB/s
18562 usecs to free memory
/ # usemem 800m
943718400 bytes / 479790 usecs =3D 1920840 KB/s
18663 usecs to free memory
/ # usemem 800m
943718400 bytes / 480253 usecs =3D 1918988 KB/s
19011 usecs to free memory

Best,
Hui



>>=20
>>>=20
>>>> [1] https://lkml.org/lkml/2020/3/12/144
>>>> [2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email=
-teawater@gmail.com/
>>>> [3] https://lkml.org/lkml/2020/5/12/324
>>>> [4] https://github.com/teawater/linux/tree/balloon_conts
>>>> [5] https://github.com/teawater/qemu/tree/balloon_conts
>>>> [6] https://lkml.org/lkml/2020/5/13/1211
>>>>=20
>>>> Hui Zhu (2):
>>>> virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
>>>> virtio_balloon: Add deflate_cont_vq to deflate continuous pages
>>>>=20
>>>> drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++=
++++-----
>>>> include/linux/balloon_compaction.h  |   12 ++
>>>> include/uapi/linux/virtio_balloon.h |    1
>>>> mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
>>>> 4 files changed, 280 insertions(+), 30 deletions(-)
>>>=20
>>>=20
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

