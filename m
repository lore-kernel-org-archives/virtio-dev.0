Return-Path: virtio-dev-return-6631-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1680985E3F
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Jan 2020 13:26:58 +0000 (UTC)
Date: Thu, 9 Jan 2020 08:26:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200109082209-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
 <c7a8fc93-9493-c0b3-623a-02426995f0f8@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <c7a8fc93-9493-c0b3-623a-02426995f0f8@linux.intel.com>
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 09, 2020 at 02:15:51PM +0800, Liu, Jing2 wrote:
>=20
> On 1/5/2020 7:04 PM, Michael S. Tsirkin wrote:
> > On Wed, Dec 25, 2019 at 10:50:23AM +0800, Zha Bin wrote:
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
> > > We proposed to update virtio over MMIO to version 3[1] to add the
> > > following new features and enhance the performance.
> > >=20
> > > 1) Support Message Signaled Interrupt(MSI), which increases the
> > >     interrupt performance for virtio multi-queue devices
> > > 2) Support per-queue doorbell, so the guest kernel may directly write
> > >     to the doorbells provided by virtio devices.
> > Do we need to come up with new "doorbell" terminology?
> > virtio spec calls these available event notifications,
> > let's stick to this.
>=20
> Yes, let's keep virtio words, which just calls notifications.
>=20
> > > The following is the network tcp_rr performance testing report, teste=
d
> > > with virtio-pci device, vanilla virtio-mmio device and patched
> > > virtio-mmio device (run test 3 times for each case):
> > >=20
> > > =09netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
> > >=20
> > > =09=09Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
> > > =09trans/s=09    9536=096939=09=099500
> > > =09trans/s=09    9734=097029=09=099749
> > > =09trans/s=09    9894=097095=09=099318
> > >=20
> > > [1]https://lkml.org/lkml/2019/12/20/113
> > >=20
> > > Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
> > > Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
> > > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> > Do we need a new version though? What is wrong with
> > a feature bit? This way we can create compatible devices
> > and drivers.
>=20
> We considered using 1 feature bit of 24~37 to specify MSI capability, but
>=20
> this feature bit only means for mmio transport layer, but not representin=
g
>=20
> comment feature negotiation of the virtio device. So we're not sure if th=
is
> is a good choice.

We are not short on bits, just don't use bits below 32
since these are for legacy devices.


> > > [...]
> > > +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg=
 *msg)
> > > +{
> > > +=09struct device *dev =3D desc->dev;
> > > +=09struct virtio_device *vdev =3D dev_to_virtio(dev);
> > > +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev)=
;
> > > +=09void __iomem *pos =3D vm_dev->base;
> > > +=09uint16_t cmd =3D VIRTIO_MMIO_MSI_CMD(VIRTIO_MMIO_MSI_CMD_UPDATE,
> > > +=09=09=09desc->platform.msi_index);
> > > +
> > > +=09writel(msg->address_lo, pos + VIRTIO_MMIO_MSI_ADDRESS_LOW);
> > > +=09writel(msg->address_hi, pos + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
> > > +=09writel(msg->data, pos + VIRTIO_MMIO_MSI_DATA);
> > > +=09writew(cmd, pos + VIRTIO_MMIO_MSI_COMMAND);
> > > +}
> > All this can happen when IRQ affinity changes while device
> > is sending interrupts. An interrupt sent between the writel
> > operations will then be directed incorrectly.
>=20
> When investigating kernel MSI behavior, I found in most case there's no
> action during IRQ affinity changes to avoid the interrupt coming.
>=20
> For example, when migrate_one_irq, it masks the irq before
> irq_do_set_affinity. But for others, like user setting any irq affinity
>=20
> via /proc/, it only holds desc->lock instead of disable/mask irq. In such
> case, how can it ensure the interrupt sending between writel ops?

Could be a bug too. E.g. PCI spec explicitly says it's illegal to
change non-masked interrupts exactly for this reason.



>=20
> > > [...]
> > > +
> > > +/* RO: MSI feature enabled mask */
> > > +#define VIRTIO_MMIO_MSI_ENABLE_MASK=090x8000
> > I don't understand the comment. Is this a way for
> > a version 3 device to say "I want/do not want MSI"?
> > Why not just use a feature bit? We are not short on these.
>=20
> This is just used for current MSI enabled/disabled status, after all MSI
> configurations setup finished.
>=20
> Not for showing MSI capability.
>=20
> In other words, since the concern of feature bit, we choose to update the
> virtio mmio
>=20
> version that devices with v3 have MSI capability and notifications.
>=20
>=20
> Thanks,
>=20
> Jing

MSI looks like an optimization. I don't see how that
justifies incrementing a major version and breaking
compat with all existing guests.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

