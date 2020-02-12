Return-Path: virtio-dev-return-6744-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC3BF985DD2
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Feb 2020 09:16:52 +0000 (UTC)
Date: Wed, 12 Feb 2020 04:16:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200212041554-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
 <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: "Liu, Jing2" <jing2.liu@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 12, 2020 at 05:06:52PM +0800, Jason Wang wrote:
>=20
> On 2020/2/12 =E4=B8=8A=E5=8D=8811:54, Liu, Jing2 wrote:
> >=20
> >=20
> > On 2/11/2020 3:40 PM, Jason Wang wrote:
> > >=20
> > > On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
> > > >=20
> > > >=20
> > > > On 2/11/2020 12:02 PM, Jason Wang wrote:
> > > > >=20
> > > > > On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
> > > > > >=20
> > > > > > On 2/11/2020 11:17 AM, Jason Wang wrote:
> > > > > > >=20
> > > > > > > On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> > > > > > > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > > > > > >=20
> > > > > > > > Userspace VMMs (e.g. Qemu microvm, Firecracker)
> > > > > > > > take advantage of using
> > > > > > > > virtio over mmio devices as a lightweight machine model for=
 modern
> > > > > > > > cloud. The standard virtio over MMIO transport
> > > > > > > > layer only supports one
> > > > > > > > legacy interrupt, which is much heavier than
> > > > > > > > virtio over PCI transport
> > > > > > > > layer using MSI. Legacy interrupt has long work
> > > > > > > > path and causes specific
> > > > > > > > VMExits in following cases, which would considerably slow d=
own the
> > > > > > > > performance:
> > > > > > > >=20
> > > > > > > > 1) read interrupt status register
> > > > > > > > 2) update interrupt status register
> > > > > > > > 3) write IOAPIC EOI register
> > > > > > > >=20
> > > > > > > > We proposed to add MSI support for virtio over MMIO via new=
 feature
> > > > > > > > bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt perf=
ormance.
> > > > > > > >=20
> > > > > > > > With the VIRTIO_F_MMIO_MSI feature bit
> > > > > > > > supported, the virtio-mmio MSI
> > > > > > > > uses msi_sharing[1] to indicate the event and vector mappin=
g.
> > > > > > > > Bit 1 is 0: device uses non-sharing and fixed
> > > > > > > > vector per event mapping.
> > > > > > > > Bit 1 is 1: device uses sharing mode and dynamic mapping.
> > > > > > >=20
> > > > > > >=20
> > > > > > > I believe dynamic mapping should cover the case of fixed vect=
or?
> > > > > > >=20
> > > > > > Actually this bit *aims* for msi sharing or msi non-sharing.
> > > > > >=20
> > > > > > It means, when msi sharing bit is 1, device doesn't want
> > > > > > vector per queue
> > > > > >=20
> > > > > > (it wants msi vector sharing as name) and doesn't want a
> > > > > > high interrupt rate.
> > > > > >=20
> > > > > > So driver turns to !per_vq_vectors and has to do dynamical mapp=
ing.
> > > > > >=20
> > > > > > So they are opposite not superset.
> > > > > >=20
> > > > > > Thanks!
> > > > > >=20
> > > > > > Jing
> > > > >=20
> > > > >=20
> > > > > I think you need add more comments on the command.
> > > > >=20
> > > > > E.g if I want to map vector 0 to queue 1, how do I need to do?
> > > > >=20
> > > > > write(1, queue_sel);
> > > > > write(0, vector_sel);
> > > >=20
> > > > That's true. Besides, two commands are used for msi sharing mode,
> > > >=20
> > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
> > > >=20
> > > > "To set up the event and vector mapping for MSI sharing mode,
> > > > driver SHOULD write a valid MsiVecSel followed by
> > > > VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
> > > > command to map the configuration change/selected queue events
> > > > respectively.=C2=A0 " (See spec patch 5/5)
> > > >=20
> > > > So if driver detects the msi sharing mode, when it does setup
> > > > vq, writes the queue_sel (this already exists in setup vq),
> > > > vector sel and then MAP_QUEUE command to do the queue event
> > > > mapping.
> > > >=20
> > >=20
> > > So actually the per vq msix could be done through this.
> >=20
> > Right, per vq msix can also be mapped by the 2 commands if we want.
> >=20
> > The current design benefits for those devices requesting per vq msi tha=
t
> > driver
> >=20
> > doesn't have to map during setup each queue,
> >=20
> > since we define the relationship by default.
> >=20
>=20
> Well since you've defined the dynamic mapping, having some "default" mapp=
ing
> won't help to reduce the complexity but increase it.
>=20
>=20
> >=20
> > > I don't get why you need to introduce MSI_SHARING_MASK which is the
> > > charge of driver instead of device.
> >=20
> > MSI_SHARING_MASK is just for identifying the msi_sharing bit in
> > readl(MsiState) (0x0c4). The device tells whether it wants msi_sharing.
> >=20
> > MsiState register: R
> >=20
> > le32 {
> > =C2=A0=C2=A0=C2=A0 msi_enabled : 1;
> > =C2=A0=C2=A0=C2=A0 msi_sharing: 1;
> > =C2=A0=C2=A0=C2=A0 reserved : 30;
> > };
> >=20
>=20
> The question is why device want such information.
>=20
>=20
> >=20
> > > The interrupt rate should have no direct relationship with whether
> > > it has been shared or not.
> >=20
> > >=20
> > > Btw, you introduce mask/unmask without pending, how to deal with the
> > > lost interrupt during the masking then?
> > >=20
> > >=20
> > > > For msi non-sharing mode, no special action is needed because we
> > > > make the rule of per_vq_vector and fixed relationship.
> > > >=20
> > > > Correct me if this is not that clear for spec/code comments.
> > > >=20
> > >=20
> > > The ABI is not as straightforward as PCI did. Why not just reuse the
> > > PCI layout?
> > >=20
> > > E.g having
> > >=20
> > > queue_sel
> > > queue_msix_vector
> > > msix_config
> > >=20
> > > for configuring map between msi vector and queues/config
> >=20
> > Thanks for the advice. :)
> >=20
> > Actually when looking into pci, the queue_msix_vector/msix_config is th=
e
> > msi vector index, which is the same as the mmio register MsiVecSel
> > (0x0d0).
> >=20
> > So we don't introduce two extra registers for mapping even in sharing
> > mode.
> >=20
> > What do you think?
> >=20
>=20
> I'm not sure I get the point, but I still prefer the separate vector_sel
> from queue_msix_vector.
>=20
> Btw, Michael propose per vq registers which could also work.
>=20
> Thanks
>=20

Right and I'd even ask a question: do we need shared MSI at all?
Is it somehow better than legacy interrupt? And why?
Performance numbers please.

> >=20
> > >=20
> > > Then
> > >=20
> > > vector_sel
> > > address
> > > data
> > > pending
> > > mask
> > > unmask
> > >=20
> > > for configuring msi table?
> >=20
> > PCI-like msix table is not introduced to device and instead simply use
> > commands to tell the mask/configure/enable.
> >=20
> > Thanks!
> >=20
> > Jing
> >=20
> > >=20
> > > Thanks
> > >=20
> > >=20
> > > > Thanks!
> > > >=20
> > > > Jing
> > > >=20
> > > >=20
> > > > >=20
> > > > > ?
> > > > >=20
> > > > > Thanks
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > Thanks
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > -------------------------------------------------------------=
--------
> > > > > > >=20
> > > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-op=
en.org
> > > > > > > For additional commands, e-mail:
> > > > > > > virtio-dev-help@lists.oasis-open.org
> > > > > > >=20
> > > > > >=20
> > > > >=20
> > >=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

