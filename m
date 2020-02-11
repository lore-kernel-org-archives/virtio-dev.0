Return-Path: virtio-dev-return-6717-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65717985D08
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 10:57:19 +0000 (UTC)
Date: Tue, 11 Feb 2020 05:57:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200211053953-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <20200210062938-mutt-send-email-mst@kernel.org>
 <20200211160541.GA37446@chaop.bj.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200211160541.GA37446@chaop.bj.intel.com>
Subject: [virtio-dev] Re: [PATCH v2 0/5] virtio mmio specification enhancement
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Chao Peng <chao.p.peng@linux.intel.com>
Cc: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com, jing2.liu@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 11, 2020 at 04:05:41PM +0000, Chao Peng wrote:
> On Mon, Feb 10, 2020 at 06:44:50AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> > > We have compared the number of files and the lines of code between
> > > virtio-mmio and virio-pci.
> > >=20
> > > =09=09=09=09Virtio-PCI=09    Virtio-MMIO=09
> > > =09number of files(Linux)=09    161=09=09=091
> > > =09lines of code(Linux)=09    78237=09=09538
> >=20
> >=20
> >=20
> > Something's very wrong here. virtio PCI is 161 files?
> > Are you counting the whole PCI subsystem?
>=20
> Right, that is just a rough statistics.

Please try not to make them look so wrong then.
E.g. you don't include drivers/base/platform-msi.c for
mmio do you? Your patch brings a bunch of code in there.

> Surely enough, some drivers will
> never get enabled in a typcial config.
>=20
> > Sure enough:
> >=20
> > $ find drivers/pci -name '*c' |wc -l
> > 150
>=20
> and plus:
> $ find arch/x86/pci/ -name '*c' |wc -l
> 22

But what's the point? This is code that is maintained by PCI core
people anyway.

> >=20
> > That's not reasonable, this includes a bunch of drivers that
> > never run on a typical hypervisor.
> >=20
> > MMIO is also not as small as you are trying to show:
> >=20
> > $ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
> >        2 text files.
> >        2 unique files.                             =20
> >        0 files ignored.
> >=20
> > github.com/AlDanial/cloc v 1.82  T=3D0.01 s (230.7 files/s, 106126.5 li=
nes/s)
> > -----------------------------------------------------------------------=
--------
> > Language                     files          blank        comment       =
    code
> > -----------------------------------------------------------------------=
--------
> > C                                1            144            100       =
     535
> > C/C++ Header                     1             39             66       =
      36
> > -----------------------------------------------------------------------=
--------
> > SUM:                             2            183            166       =
     571
> > -----------------------------------------------------------------------=
--------
> >=20
> >=20
> > I don't doubt MMIO is smaller than PCI. Of course that's because it has
> > no features to speak of - just this patch already doubles it's size. If
> > we keep doing that because we want the features then they will reach
> > the same size in about 4 iterations.
>=20
> Since current virtio-mmio size is small enough, so adding any notable
> feature would easily double it.

But really unlike PCI this is just PV stuff that is not reused by
anyone. We end up maintaining all this by ourselves.

> I have no objection that it may one day
> reach the same level of PCI, but in this patch some are actually
> generic changes and for MSI specific code we provide the option to
> confige away.
>=20
> Thanks,
> Chao

The option will make it fall down at runtime but
it does not actually seem to remove all of the overhead.



> >=20
> >=20
> > --=20
> > MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

