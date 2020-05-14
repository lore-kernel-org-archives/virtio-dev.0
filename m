Return-Path: virtio-dev-return-7334-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C94DC985FC6
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 May 2020 08:48:34 +0000 (UTC)
References: <20200507103119.11219-1-david@redhat.com>
 <7848642F-6AA7-4B5E-AE0E-DB0857C94A93@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <31c5d2f9-c104-53e8-d9c8-cb45f7507c85@redhat.com>
Date: Thu, 14 May 2020 10:48:01 +0200
MIME-Version: 1.0
In-Reply-To: <7848642F-6AA7-4B5E-AE0E-DB0857C94A93@linux.alibaba.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v3 00/15] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: teawater <teawaterz@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 14.05.20 08:44, teawater wrote:
> Hi David,
>=20
> I got a kernel warning with v2 and v3.

Hi Hui,

thanks for playing with the latest versions. Surprisingly, I can
reproduce even by hotplugging a DIMM instead as well - that's good, so
it's not related to virtio-mem, lol. Seems to be some QEMU setup issue
with older machine types.

Can you switch to a newer qemu machine version, especially
pc-i440fx-5.0? Both, hotplugging DIMMs and virtio-mem works for me with
that QEMU machine just fine.

What also seems to make it work with pc-i440fx-2.1, is giving the
machine 4G of initial memory (-m 4g,slots=3D10,maxmem=3D5G).

Cheers!


> // start a QEMU that is get from https://github.com/davidhildenbrand/qemu=
/tree/virtio-mem-v2 and setup a file as a ide disk.
> /home/teawater/qemu/qemu/x86_64-softmmu/qemu-system-x86_64 -machine pc-i4=
40fx-2.1,accel=3Dkvm,usb=3Doff -cpu host -no-reboot -nographic -device ide-=
hd,drive=3Dhd -drive if=3Dnone,id=3Dhd,file=3D/home/teawater/old.img,format=
=3Draw -kernel /home/teawater/kernel/bk2/arch/x86/boot/bzImage -append "con=
sole=3DttyS0 root=3D/dev/sda nokaslr swiotlb=3Dnoforce" -m 1g,slots=3D10,ma=
xmem=3D2G -smp 1 -s -monitor unix:/home/teawater/qemu/m,server,nowait
>=20
> // Setup virtio-mem and plug 256m memory in qemu monitor:
> object_add memory-backend-ram,id=3Dmem1,size=3D256m
> device_add virtio-mem-pci,id=3Dvm0,memdev=3Dmem1
> qom-set vm0 requested-size 256M
>=20
> // Go back to the terminal and access file system will got following kern=
el warning.
> [   19.515549] pci 0000:00:04.0: [1af4:1015] type 00 class 0x00ff00
> [   19.516227] pci 0000:00:04.0: reg 0x10: [io  0x0000-0x007f]
> [   19.517196] pci 0000:00:04.0: BAR 0: assigned [io  0x1000-0x107f]
> [   19.517843] virtio-pci 0000:00:04.0: enabling device (0000 -> 0001)
> [   19.535957] PCI Interrupt Link [LNKD] enabled at IRQ 11
> [   19.536507] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy dr=
iver
> [   19.537528] virtio_mem virtio0: start address: 0x100000000
> [   19.538094] virtio_mem virtio0: region size: 0x10000000
> [   19.538621] virtio_mem virtio0: device block size: 0x200000
> [   19.539186] virtio_mem virtio0: memory block size: 0x8000000
> [   19.539752] virtio_mem virtio0: subblock size: 0x400000
> [   19.540357] virtio_mem virtio0: plugged size: 0x0
> [   19.540834] virtio_mem virtio0: requested size: 0x0
> [   20.170441] virtio_mem virtio0: plugged size: 0x0
> [   20.170933] virtio_mem virtio0: requested size: 0x10000000
> [   20.172247] Built 1 zonelists, mobility grouping on.  Total pages: 266=
012
> [   20.172955] Policy zone: Normal
>=20
> / # ls
> [   26.724565] ------------[ cut here ]------------
> [   26.725047] ata_piix 0000:00:01.1: DMA addr 0x000000010fc14000+49152 o=
verflow (mask ffffffff, bus limit 0).
> [   26.726024] WARNING: CPU: 0 PID: 179 at /home/teawater/kernel/linux2/k=
ernel/dma/direct.c:364 dma_direct_map_page+0x118/0x130
> [   26.727141] Modules linked in:
> [   26.727456] CPU: 0 PID: 179 Comm: ls Not tainted 5.6.0-rc5-next-202003=
11+ #9
> [   26.728163] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [   26.729305] RIP: 0010:dma_direct_map_page+0x118/0x130
> [   26.729825] Code: 8b 1f e8 3b 70 59 00 48 8d 4c 24 08 48 89 c6 4c 89 2=
c 24 4d 89 e1 49 89 e8 48 89 da 48 c7 c7 08 6c 34 82 31 c0 e8 d8 8e f7 ff <=
00
> [   26.731683] RSP: 0000:ffffc90000213838 EFLAGS: 00010082
> [   26.732205] RAX: 0000000000000000 RBX: ffff88803ebeb1b0 RCX: ffffffff8=
2665148
> [   26.732913] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 000000000=
0000046
> [   26.733621] RBP: 000000000000c000 R08: 00000000000001df R09: 000000000=
00001df
> [   26.734338] R10: 0000000000000000 R11: ffffc900002135a8 R12: 00000000f=
fffffff
> [   26.735054] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88803=
d55f5b0
> [   26.735772] FS:  00000000024e9880(0000) GS:ffff88803ec00000(0000) knlG=
S:0000000000000000
> [   26.736579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.737162] CR2: 00000000005bfc7f CR3: 0000000107e12004 CR4: 000000000=
0360ef0
> [   26.737879] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   26.738591] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   26.739307] Call Trace:
> [   26.739564]  dma_direct_map_sg+0x64/0xb0
> [   26.739969]  ? ata_scsi_write_same_xlat+0x350/0x350
> [   26.740461]  ata_qc_issue+0x214/0x260
> [   26.740839]  ata_scsi_queuecmd+0x16a/0x490
> [   26.741255]  scsi_queue_rq+0x679/0xa60
> [   26.741639]  blk_mq_dispatch_rq_list+0x90/0x510
> [   26.742099]  ? elv_rb_del+0x1f/0x30
> [   26.742456]  ? deadline_remove_request+0x6a/0xb0
> [   26.742926]  blk_mq_do_dispatch_sched+0x78/0x100
> [   26.743397]  blk_mq_sched_dispatch_requests+0xf9/0x170
> [   26.743924]  __blk_mq_run_hw_queue+0x7e/0x130
> [   26.744365]  __blk_mq_delay_run_hw_queue+0x107/0x150
> [   26.744874]  blk_mq_run_hw_queue+0x61/0x100
> [   26.745299]  blk_mq_sched_insert_requests+0x71/0x110
> [   26.745798]  blk_mq_flush_plug_list+0x14b/0x210
> [   26.746258]  blk_flush_plug_list+0xbf/0xe0
> [   26.746675]  blk_finish_plug+0x27/0x40
> [   26.747056]  read_pages+0x7c/0x190
> [   26.747399]  __do_page_cache_readahead+0x19c/0x1b0
> [   26.747886]  filemap_fault+0x54e/0x9a0
> [   26.748268]  ? alloc_set_pte+0x102/0x610
> [   26.748673]  ? walk_component+0x64/0x2e0
> [   26.749072]  ? filemap_map_pages+0xfa/0x3f0
> [   26.749498]  ext4_filemap_fault+0x2c/0x3b
> [   26.749911]  __do_fault+0x38/0xb0
> [   26.750251]  __handle_mm_fault+0xd2a/0x16d0
> [   26.750678]  handle_mm_fault+0xe2/0x1f0
> [   26.751069]  do_page_fault+0x250/0x590
> [   26.751448]  async_page_fault+0x34/0x40
> [   26.751841] RIP: 0033:0x5bfc7f
> [   26.752155] Code: Bad RIP value.
> [   26.752481] RSP: 002b:00007ffef0289cd8 EFLAGS: 00010246
> [   26.752999] RAX: 0000000000000001 RBX: 00007ffef028af81 RCX: 00007ffef=
028af84
> [   26.753715] RDX: 00007ffef0289e01 RSI: 00007ffef0289ea8 RDI: 000000000=
0000001
> [   26.754424] RBP: 00000000000000ac R08: 0000000000000001 R09: 000000000=
0000006
> [   26.755144] R10: 000000000089fc18 R11: 0000000000000246 R12: 00007ffef=
0289ea8
> [   26.755853] R13: 000000000043a5f0 R14: 0000000000000000 R15: 000000000=
0000000
> [   26.756560] ---[ end trace 23cc3e9021358587 ]---
> [   26.778034] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.778690] ata2.00: failed command: READ DMA
> [   26.779131] ata2.00: cmd c8/00:e8:92:ad:00/00:00:00:00:00/e0 tag 0 dma=
 118784 in
> [   26.779131]          res 50/00:00:0a:80:03/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.780691] ata2.00: status: { DRDY }
> [   26.781603] ata2.00: configured for MWDMA2
> [   26.782034] sd 1:0:0:0: [sda] tag#0 FAILED Result: hostbyte=3DDID_OK d=
riverbyte=3DDRIVER_SENSE cmd_age=3D0s
> [   26.782958] sd 1:0:0:0: [sda] tag#0 Sense Key : Illegal Request [curre=
nt]
> [   26.783646] sd 1:0:0:0: [sda] tag#0 Add. Sense: Unaligned write comman=
d
> [   26.784321] sd 1:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 ad 92 00=
 00 e8 00
> [   26.785056] blk_update_request: I/O error, dev sda, sector 44434 op 0x=
0:(READ) flags 0x80700 phys_seg 3 prio class 0
> [   26.786118] ata2: EH complete
> [   26.810033] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.810690] ata2.00: failed command: READ DMA
> [   26.811133] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.811133]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.812681] ata2.00: status: { DRDY }
> [   26.813569] ata2.00: configured for MWDMA2
> [   26.813992] ata2: EH complete
> [   26.826031] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.826687] ata2.00: failed command: READ DMA
> [   26.827131] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.827131]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.828668] ata2.00: status: { DRDY }
> [   26.829552] ata2.00: configured for MWDMA2
> [   26.829972] ata2: EH complete
> [   26.842030] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.842686] ata2.00: failed command: READ DMA
> [   26.843127] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.843127]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.844656] ata2.00: status: { DRDY }
> [   26.845538] ata2.00: configured for MWDMA2
> [   26.845961] ata2: EH complete
> [   26.858030] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.858690] ata2.00: failed command: READ DMA
> [   26.859132] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.859132]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.860656] ata2.00: status: { DRDY }
> [   26.861542] ata2.00: configured for MWDMA2
> [   26.861960] ata2: EH complete
> [   26.874030] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.874693] ata2.00: failed command: READ DMA
> [   26.875131] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.875131]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.876675] ata2.00: status: { DRDY }
> [   26.877554] ata2.00: configured for MWDMA2
> [   26.877976] ata2: EH complete
> [   26.890030] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.890655] ata2.00: failed command: READ DMA
> [   26.891082] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.891082]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.892544] ata2.00: status: { DRDY }
> [   26.893408] ata2.00: configured for MWDMA2
> [   26.893812] sd 1:0:0:0: [sda] tag#0 FAILED Result: hostbyte=3DDID_OK d=
riverbyte=3DDRIVER_SENSE cmd_age=3D0s
> [   26.894698] sd 1:0:0:0: [sda] tag#0 Sense Key : Illegal Request [curre=
nt]
> [   26.895356] sd 1:0:0:0: [sda] tag#0 Add. Sense: Unaligned write comman=
d
> [   26.895993] sd 1:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 ad fa 00=
 00 08 00
> [   26.896693] blk_update_request: I/O error, dev sda, sector 44538 op 0x=
0:(READ) flags 0x0 phys_seg 1 prio class 0
> [   26.897668] ata2: EH complete
> [   26.922032] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.922652] ata2.00: failed command: READ DMA
> [   26.923080] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.923080]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.924538] ata2.00: status: { DRDY }
> [   26.925404] ata2.00: configured for MWDMA2
> [   26.925807] ata2: EH complete
> [   26.938031] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.938650] ata2.00: failed command: READ DMA
> [   26.939076] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.939076]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.940529] ata2.00: status: { DRDY }
> [   26.941391] ata2.00: configured for MWDMA2
> [   26.941793] ata2: EH complete
> [   26.954031] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.954652] ata2.00: failed command: READ DMA
> [   26.955079] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.955079]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.956536] ata2.00: status: { DRDY }
> [   26.957400] ata2.00: configured for MWDMA2
> [   26.957800] ata2: EH complete
> [   26.970031] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.970653] ata2.00: failed command: READ DMA
> [   26.971079] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.971079]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.972536] ata2.00: status: { DRDY }
> [   26.973402] ata2.00: configured for MWDMA2
> [   26.973804] ata2: EH complete
> [   26.986030] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   26.986654] ata2.00: failed command: READ DMA
> [   26.987082] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   26.987082]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   26.988541] ata2.00: status: { DRDY }
> [   26.989406] ata2.00: configured for MWDMA2
> [   26.989807] ata2: EH complete
> [   27.002031] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   27.002653] ata2.00: failed command: READ DMA
> [   27.003083] ata2.00: cmd c8/00:08:fa:ad:00/00:00:00:00:00/e0 tag 0 dma=
 4096 in
> [   27.003083]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4=
0 (internal error)
> [   27.004541] ata2.00: status: { DRDY }
> [   27.005404] ata2.00: configured for MWDMA2
> [   27.005806] sd 1:0:0:0: [sda] tag#0 FAILED Result: hostbyte=3DDID_OK d=
riverbyte=3DDRIVER_SENSE cmd_age=3D0s
> [   27.006688] sd 1:0:0:0: [sda] tag#0 Sense Key : Illegal Request [curre=
nt]
> [   27.007346] sd 1:0:0:0: [sda] tag#0 Add. Sense: Unaligned write comman=
d
> [   27.007982] sd 1:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 ad fa 00=
 00 08 00
> [   27.008680] blk_update_request: I/O error, dev sda, sector 44538 op 0x=
0:(READ) flags 0x0 phys_seg 1 prio class 0
> [   27.009649] ata2: EH complete
> Bus error
>=20
> I cannot reproduce this warning with set file as nvdimm with following co=
mmand.
> sudo /home/teawater/qemu/qemu/x86_64-softmmu/qemu-system-x86_64 -machine =
pc,accel=3Dkvm,kernel_irqchip,nvdimm -no-reboot -nographic -kernel /home/te=
awater/kernel/bk2/arch/x86/boot/bzImage -append "console=3DttyS0 root=3D/de=
v/pmem0 swiotlb=3Dnoforce" -m 1g,slots=3D1,maxmem=3D2G -smp 1 -device nvdim=
m,id=3Dnv0,memdev=3Dmem0 -object memory-backend-file,id=3Dmem0,mem-path=3D/=
home/teawater/old.img,size=3D268435456 -monitor unix:/home/teawater/qemu/m,=
server,nowait
>=20
> Best,
> Hui


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

