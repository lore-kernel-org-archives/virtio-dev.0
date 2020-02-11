Return-Path: virtio-dev-return-6722-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31E61985D08
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 11:22:06 +0000 (UTC)
Date: Tue, 11 Feb 2020 06:21:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200211061932-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 11, 2020 at 11:35:43AM +0800, Liu, Jing2 wrote:
>=20
> On 2/11/2020 11:17 AM, Jason Wang wrote:
> >=20
> > On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> > > From: Liu Jiang<gerry@linux.alibaba.com>
> > >=20
> > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of usi=
ng
> > > virtio over mmio devices as a lightweight machine model for modern
> > > cloud. The standard virtio over MMIO transport layer only supports on=
e
> > > legacy interrupt, which is much heavier than virtio over PCI transpor=
t
> > > layer using MSI. Legacy interrupt has long work path and causes speci=
fic
> > > VMExits in following cases, which would considerably slow down the
> > > performance:
> > >=20
> > > 1) read interrupt status register
> > > 2) update interrupt status register
> > > 3) write IOAPIC EOI register
> > >=20
> > > We proposed to add MSI support for virtio over MMIO via new feature
> > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
> > >=20
> > > With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> > > uses msi_sharing[1] to indicate the event and vector mapping.
> > > Bit 1 is 0: device uses non-sharing and fixed vector per event mappin=
g.
> > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> >=20
> >=20
> > I believe dynamic mapping should cover the case of fixed vector?
> >=20
> Actually this bit *aims* for msi sharing or msi non-sharing.
>=20
> It means, when msi sharing bit is 1, device doesn't want vector per queue
>=20
> (it wants msi vector sharing as name) and doesn't want a high interrupt
> rate.
>=20
> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>=20
> So they are opposite not superset.
>=20
> Thanks!
>=20
> Jing

what's the point of all this flexibility? the cover letter
complains about the code size of pci, then you go back
and add a ton of options with no justification.



>=20
> > Thanks
> >=20
> >=20
> >=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

