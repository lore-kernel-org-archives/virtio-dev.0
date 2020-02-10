Return-Path: virtio-dev-return-6706-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCD279847E3
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Feb 2020 11:45:00 +0000 (UTC)
Date: Mon, 10 Feb 2020 06:44:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200210062938-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2 0/5] virtio mmio specification enhancement
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com, jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> We have compared the number of files and the lines of code between
> virtio-mmio and virio-pci.
>=20
> =09=09=09=09Virtio-PCI=09    Virtio-MMIO=09
> =09number of files(Linux)=09    161=09=09=091
> =09lines of code(Linux)=09    78237=09=09538



Something's very wrong here. virtio PCI is 161 files?
Are you counting the whole PCI subsystem?
Sure enough:

$ find drivers/pci -name '*c' |wc -l
150

That's not reasonable, this includes a bunch of drivers that
never run on a typical hypervisor.

MMIO is also not as small as you are trying to show:

$ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
       2 text files.
       2 unique files.                             =20
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=3D0.01 s (230.7 files/s, 106126.5 lines/=
s)
---------------------------------------------------------------------------=
----
Language                     files          blank        comment           =
code
---------------------------------------------------------------------------=
----
C                                1            144            100           =
 535
C/C++ Header                     1             39             66           =
  36
---------------------------------------------------------------------------=
----
SUM:                             2            183            166           =
 571
---------------------------------------------------------------------------=
----


I don't doubt MMIO is smaller than PCI. Of course that's because it has
no features to speak of - just this patch already doubles it's size. If
we keep doing that because we want the features then they will reach
the same size in about 4 iterations.


--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

