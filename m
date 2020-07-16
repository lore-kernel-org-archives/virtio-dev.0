Return-Path: virtio-dev-return-7572-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81EB598607B
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 10:45:13 +0000 (UTC)
Date: Thu, 16 Jul 2020 06:45:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200716064340-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <20200716021929-mutt-send-email-mst@kernel.org>
 <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
Subject: Re: [virtio-dev] [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: teawater <teawaterz@linux.alibaba.com>
Cc: Hui Zhu <teawater@gmail.com>, david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Andrea Arcangeli <aarcange@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 16, 2020 at 03:01:18PM +0800, teawater wrote:
>=20
>=20
> > 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:38=EF=BC=8CMichael S. Tsirkin <ms=
t@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
> >> The first, second and third version are in [1], [2] and [3].
> >> Code of current version for Linux and qemu is available in [4] and [5]=
.
> >> Update of this version:
> >> 1. Report continuous pages will increase the speed.  So added deflate
> >>   continuous pages.
> >> 2. According to the comments from David in [6], added 2 new vqs inflat=
e_cont_vq
> >>   and deflate_cont_vq to report continuous pages with format 32 bits p=
fn and 32
> >>   bits size.
> >> Following is the introduction of the function.
> >> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With =
this
> >> flag, balloon tries to use continuous pages to inflate and deflate.
> >> Opening this flag can bring two benefits:
> >> 1. Report continuous pages will increase memory report size of each ti=
me
> >>   call tell_host.  Then it will increase the speed of balloon inflate =
and
> >>   deflate.
> >> 2. Host THPs will be splitted when qemu release the page of balloon in=
flate.
> >>   Inflate balloon with continuous pages will let QEMU release the page=
s
> >>   of same THPs.  That will help decrease the splitted THPs number in
> >>   the host.
> >>   Following is an example in a VM with 1G memory 1CPU.  This test setu=
ps an
> >>   environment that has a lot of fragmentation pages.  Then inflate bal=
loon will
> >>   split the THPs.
>=20
>=20
> >> // This is the THP number before VM execution in the host.
> >> // None use THP.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:         0 kB
> These lines are from host.
>=20
> >> // After VM start, use usemem
> >> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability=
.git)
> >> // punch-holes function generates 400m fragmentation pages in the gues=
t
> >> // kernel.
> >> usemem --punch-holes -s -1 800m &
> These lines are from guest.  They setups the environment that has a lot o=
f fragmentation pages.
>=20
> >> // This is the THP number after this command in the host.
> >> // Some THP is used by VM because usemem will access 800M memory
> >> // in the guest.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    911360 kB
> These lines are from host.
>=20
> >> // Connect to the QEMU monitor, setup balloon, and set it size to 600M=
.
> >> (qemu) device_add virtio-balloon-pci,id=3Dballoon1
> >> (qemu) info balloon
> >> balloon: actual=3D1024
> >> (qemu) balloon 600
> >> (qemu) info balloon
> >> balloon: actual=3D600
> These lines are from host.
>=20
> >> // This is the THP number after inflate the balloon in the host.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:     88064 kB
> These lines are from host.
>=20
> >> // Set the size back to 1024M in the QEMU monitor.
> >> (qemu) balloon 1024
> >> (qemu) info balloon
> >> balloon: actual=3D1024
> These lines are from host.
>=20
> >> // Use usemem to increase the memory usage of QEMU.
> >> killall usemem
> >> usemem 800m
> These lines are from guest.
>=20
> >> // This is the THP number after this operation.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:     65536 kB
> These lines are from host.
>=20
>=20
>=20
> >>=20
> >> Following example change to use continuous pages balloon.  The number =
of
> >> splitted THPs is decreased.
> >> // This is the THP number before VM execution in the host.
> >> // None use THP.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:         0 kB
> These lines are from host.
>=20
> >> // After VM start, use usemem punch-holes function generates 400M
> >> // fragmentation pages in the guest kernel.
> >> usemem --punch-holes -s -1 800m &
> These lines are from guest.  They setups the environment that has a lot o=
f fragmentation pages.
>=20
> >> // This is the THP number after this command in the host.
> >> // Some THP is used by VM because usemem will access 800M memory
> >> // in the guest.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    911360 kB
> These lines are from host.
>=20
> >> // Connect to the QEMU monitor, setup balloon, and set it size to 600M=
.
> >> (qemu) device_add virtio-balloon-pci,id=3Dballoon1,cont-pages=3Don
> >> (qemu) info balloon
> >> balloon: actual=3D1024
> >> (qemu) balloon 600
> >> (qemu) info balloon
> >> balloon: actual=3D600
> These lines are from host.
>=20
> >> // This is the THP number after inflate the balloon in the host.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    616448 kB
> >> // Set the size back to 1024M in the QEMU monitor.
> >> (qemu) balloon 1024
> >> (qemu) info balloon
> >> balloon: actual=3D1024
> These lines are from host.
>=20
> >> // Use usemem to increase the memory usage of QEMU.
> >> killall usemem
> >> usemem 800m
> These lines are from guest.
>=20
> >> // This is the THP number after this operation.
> >> cat /proc/meminfo | grep AnonHugePages:
> >> AnonHugePages:    907264 kB
> These lines are from host.
>=20
> >=20
> > I'm a bit confused about which of the above run within guest,
> > and which run within host. Could you explain pls?
> >=20
> >=20
>=20
> I added some introduction to show where these lines is get from.
>=20
> Best,
> Hui


OK so we see host has more free THPs. But guest has presumably less now - s=
o
the total page table depth is the same. Did we gain anything?

>=20
> >=20
> >> [1] https://lkml.org/lkml/2020/3/12/144
> >> [2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email=
-teawater@gmail.com/
> >> [3] https://lkml.org/lkml/2020/5/12/324
> >> [4] https://github.com/teawater/linux/tree/balloon_conts
> >> [5] https://github.com/teawater/qemu/tree/balloon_conts
> >> [6] https://lkml.org/lkml/2020/5/13/1211
> >>=20
> >> Hui Zhu (2):
> >>  virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
> >>  virtio_balloon: Add deflate_cont_vq to deflate continuous pages
> >>=20
> >> drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++=
++++-----
> >> include/linux/balloon_compaction.h  |   12 ++
> >> include/uapi/linux/virtio_balloon.h |    1
> >> mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
> >> 4 files changed, 280 insertions(+), 30 deletions(-)
> >=20
> >=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

