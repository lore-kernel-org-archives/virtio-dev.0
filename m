Return-Path: virtio-dev-return-6568-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B7F0985D43
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Dec 2019 09:28:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Date: Tue, 24 Dec 2019 10:28:20 +0100
Message-Id: <2828152B-D0EB-4802-A304-4A90CA5C4B6C@redhat.com>
References: <91ED8152-61FC-4E87-9F7B-44CD05C77279@linux.alibaba.com>
In-Reply-To: <91ED8152-61FC-4E87-9F7B-44CD05C77279@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: teawater <teawaterz@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> Am 24.12.2019 um 08:04 schrieb teawater <teawaterz@linux.alibaba.com>:
>=20
> =EF=BB=BFHi David,
>=20
> Thanks for your work.
>=20
> I Got following build fail if X86_64_ACPI_NUMA is n with rfc3 and rfc4:
> make -j8 bzImage
>  GEN     Makefile
>  DESCEND  objtool
>  CALL    /home/teawater/kernel/linux-upstream3/scripts/atomic/check-atomi=
cs.sh
>  CALL    /home/teawater/kernel/linux-upstream3/scripts/checksyscalls.sh
>  CHK     include/generated/compile.h
>  CC      drivers/virtio/virtio_mem.o
> /home/teawater/kernel/linux-upstream3/drivers/virtio/virtio_mem.c: In fun=
ction =E2=80=98virtio_mem_translate_node_id=E2=80=99:
> /home/teawater/kernel/linux-upstream3/drivers/virtio/virtio_mem.c:478:10:=
 error: implicit declaration of function =E2=80=98pxm_to_node=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
>   node =3D pxm_to_node(node_id);
>          ^~~~~~~~~~~
> cc1: some warnings being treated as errors
> /home/teawater/kernel/linux-upstream3/scripts/Makefile.build:265: recipe =
for target 'drivers/virtio/virtio_mem.o' failed
> make[3]: *** [drivers/virtio/virtio_mem.o] Error 1
> /home/teawater/kernel/linux-upstream3/scripts/Makefile.build:503: recipe =
for target 'drivers/virtio' failed
> make[2]: *** [drivers/virtio] Error 2
> /home/teawater/kernel/linux-upstream3/Makefile:1649: recipe for target 'd=
rivers' failed
> make[1]: *** [drivers] Error 2
> /home/teawater/kernel/linux-upstream3/Makefile:179: recipe for target 'su=
b-make' failed
> make: *** [sub-make] Error 2
>=20

Thanks Hui,

So it has to be wrapped in an ifdef, thanks!

Cheers!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

