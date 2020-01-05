Return-Path: virtio-dev-return-6590-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C099F9841DA
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Jan 2020 11:04:33 +0000 (UTC)
Date: Sun, 5 Jan 2020 06:04:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200105054412-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 25, 2019 at 10:50:23AM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specific
> VMExits in following cases, which would considerably slow down the
> performance:
>=20
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
>=20
> We proposed to update virtio over MMIO to version 3[1] to add the
> following new features and enhance the performance.
>=20
> 1) Support Message Signaled Interrupt(MSI), which increases the
>    interrupt performance for virtio multi-queue devices
> 2) Support per-queue doorbell, so the guest kernel may directly write
>    to the doorbells provided by virtio devices.

Do we need to come up with new "doorbell" terminology?
virtio spec calls these available event notifications,
let's stick to this.


>=20
> The following is the network tcp_rr performance testing report, tested
> with virtio-pci device, vanilla virtio-mmio device and patched
> virtio-mmio device (run test 3 times for each case):
>=20
> =09netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>=20
> =09=09Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
> =09trans/s=09    9536=096939=09=099500
> =09trans/s=09    9734=097029=09=099749
> =09trans/s=09    9894=097095=09=099318
>=20
> [1] https://lkml.org/lkml/2019/12/20/113
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>


Do we need a new version though? What is wrong with
a feature bit? This way we can create compatible devices
and drivers.

> ---
>  drivers/virtio/virtio_mmio.c     | 226 +++++++++++++++++++++++++++++++++=
+++---
>  include/uapi/linux/virtio_mmio.h |  28 +++++
>  2 files changed, 240 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e09edb5..065c083 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -68,8 +68,8 @@
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
> -
> -
> +#include <linux/msi.h>
> +#include <asm/irqdomain.h>
> =20
>  /* The alignment to use between consumer and producer parts of vring.
>   * Currently hardcoded to the page size. */
> @@ -90,6 +90,12 @@ struct virtio_mmio_device {
>  =09/* a list of queues so we can dispatch IRQs */
>  =09spinlock_t lock;
>  =09struct list_head virtqueues;
> +
> +=09int doorbell_base;
> +=09int doorbell_scale;
> +=09bool msi_enabled;
> +=09/* Name strings for interrupts. */
> +=09char (*vm_vq_names)[256];

Add a comment explaining 256 pls.

>  };
> =20
>  struct virtio_mmio_vq_info {
> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>  };
> =20
> =20
> +static void vm_free_msi_irqs(struct virtio_device *vdev);
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)=
;
> =20
>  /* Configuration interface */
> =20
> @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->vdev)=
;
> =20
> +=09if (vm_dev->version =3D=3D 3) {
> +=09=09int offset =3D vm_dev->doorbell_base +
> +=09=09=09     vm_dev->doorbell_scale * vq->index;
> +=09=09writel(vq->index, vm_dev->base + offset);
> +=09} else
>  =09/* We write the queue's selector into the notification register to
>  =09 * signal the other end */
> -=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +=09=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
>  =09return true;
>  }

You might want to support VIRTIO_F_NOTIFICATION_DATA too.


> +/* Handle a configuration change */
> +static irqreturn_t vm_config_changed(int irq, void *opaque)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D opaque;
> +
> +=09virtio_config_changed(&vm_dev->vdev);
> +
> +=09return IRQ_HANDLED;
> +}
> +
>  /* Notify all virtqueues on an interrupt. */
>  static irqreturn_t vm_interrupt(int irq, void *opaque)
>  {
> @@ -307,7 +331,12 @@ static irqreturn_t vm_interrupt(int irq, void *opaqu=
e)
>  =09return ret;
>  }
> =20
> +static int vm_msi_irq_vector(struct device *dev, unsigned int nr)
> +{
> +=09struct msi_desc *entry =3D first_msi_entry(dev);
> =20
> +=09return entry->irq + nr;
> +}
> =20
>  static void vm_del_vq(struct virtqueue *vq)
>  {
> @@ -316,6 +345,12 @@ static void vm_del_vq(struct virtqueue *vq)
>  =09unsigned long flags;
>  =09unsigned int index =3D vq->index;
> =20
> +=09if (vm_dev->version =3D=3D 3 && vm_dev->msi_enabled) {
> +=09=09int irq =3D vm_msi_irq_vector(&vq->vdev->dev, index + 1);
> +
> +=09=09free_irq(irq, vq);
> +=09}
> +
>  =09spin_lock_irqsave(&vm_dev->lock, flags);
>  =09list_del(&info->node);
>  =09spin_unlock_irqrestore(&vm_dev->lock, flags);


I think tying MSI to versions is a mistake.



> @@ -334,15 +369,41 @@ static void vm_del_vq(struct virtqueue *vq)
>  =09kfree(info);
>  }
> =20
> -static void vm_del_vqs(struct virtio_device *vdev)
> +static void vm_free_irqs(struct virtio_device *vdev)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +=09if (vm_dev->version =3D=3D 3)
> +=09=09vm_free_msi_irqs(vdev);
> +=09else
> +=09=09free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +}
> +
> +static void vm_del_vqs(struct virtio_device *vdev)
> +{
>  =09struct virtqueue *vq, *n;
> =20
>  =09list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>  =09=09vm_del_vq(vq);
> =20
> -=09free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +=09vm_free_irqs(vdev);
> +}
> +
> +static int vm_request_single_irq(struct virtio_device *vdev)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09int irq =3D platform_get_irq(vm_dev->pdev, 0);
> +=09int err;
> +
> +=09if (irq < 0) {
> +=09=09dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +=09=09return irq;
> +=09}
> +
> +=09err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
> +=09=09=09dev_name(&vdev->dev), vm_dev);
> +
> +=09return err;
>  }
> =20
>  static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigne=
d index,
> @@ -455,6 +516,72 @@ static struct virtqueue *vm_setup_vq(struct virtio_d=
evice *vdev, unsigned index,
>  =09return ERR_PTR(err);
>  }
> =20
> +static inline void mmio_msi_set_enable(struct virtio_mmio_device *vm_dev=
,
> +=09=09int enable)
> +{
> +=09u16 status;
> +
> +=09status =3D readw(vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +=09if (enable)
> +=09=09status |=3D VIRTIO_MMIO_MSI_ENABLE_MASK;
> +=09else
> +=09=09status &=3D ~VIRTIO_MMIO_MSI_ENABLE_MASK;
> +=09writew(status, vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +}
> +
> +static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nvqs=
,
> +=09=09=09struct virtqueue *vqs[], vq_callback_t *callbacks[],
> +=09=09=09const char * const names[], const bool *ctx,
> +=09=09=09struct irq_affinity *desc)
> +{
> +=09int i, err, irq;
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +=09/* Allocate nvqs irqs for queues and one irq for configuration */
> +=09err =3D vm_request_msi_vectors(vdev, nvqs + 1);
> +=09if (err !=3D 0)
> +=09=09return err;

Not all devices need high speed.  Some might want to share
irqs between VQs, or even with config change callback.
Balloon is a case in point.
A hint about max # of MSI necessary would be a good
idea for this case.


Sharing MSI doesn't necessarily require dedicated registers like PCI has,
you can just program same vector in multiple VQs.

> +
> +=09for (i =3D 0; i < nvqs; i++) {
> +=09=09int index =3D i + 1;
> +
> +=09=09if (!names[i]) {
> +=09=09=09vqs[i] =3D NULL;
> +=09=09=09continue;
> +=09=09}
> +=09=09vqs[i] =3D vm_setup_vq(vdev, i, callbacks[i], names[i],
> +=09=09=09=09ctx ? ctx[i] : false);
> +=09=09if (IS_ERR(vqs[i])) {
> +=09=09=09err =3D PTR_ERR(vqs[i]);
> +=09=09=09goto error_find;
> +=09=09}
> +
> +=09=09if (!callbacks[i])
> +=09=09=09continue;
> +
> +=09=09irq =3D vm_msi_irq_vector(&vqs[i]->vdev->dev, index);
> +=09=09/* allocate per-vq irq if available and necessary */
> +=09=09snprintf(vm_dev->vm_vq_names[index],
> +=09=09=09sizeof(*vm_dev->vm_vq_names),
> +=09=09=09"%s-%s",
> +=09=09=09dev_name(&vm_dev->vdev.dev), names[i]);
> +=09=09err =3D request_irq(irq, vring_interrupt, 0,
> +=09=09=09=09vm_dev->vm_vq_names[index], vqs[i]);
> +
> +=09=09if (err)
> +=09=09=09goto error_find;
> +=09}
> +
> +=09mmio_msi_set_enable(vm_dev, 1);
> +=09vm_dev->msi_enabled =3D true;
> +
> +=09return 0;
> +
> +error_find:
> +=09vm_del_vqs(vdev);
> +=09return err;
> +}
> +
>  static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  =09=09       struct virtqueue *vqs[],
>  =09=09       vq_callback_t *callbacks[],
> @@ -463,16 +590,16 @@ static int vm_find_vqs(struct virtio_device *vdev, =
unsigned nvqs,
>  =09=09       struct irq_affinity *desc)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> -=09int irq =3D platform_get_irq(vm_dev->pdev, 0);
>  =09int i, err, queue_idx =3D 0;
> =20
> -=09if (irq < 0) {
> -=09=09dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> -=09=09return irq;
> +=09if (vm_dev->version =3D=3D 3) {
> +=09=09err =3D vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +=09=09=09=09names, ctx, desc);
> +=09=09if (!err)
> +=09=09=09return 0;
>  =09}
> =20
> -=09err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
> -=09=09=09dev_name(&vdev->dev), vm_dev);
> +=09err =3D vm_request_single_irq(vdev);
>  =09if (err)
>  =09=09return err;
> =20
> @@ -493,6 +620,73 @@ static int vm_find_vqs(struct virtio_device *vdev, u=
nsigned nvqs,
>  =09return 0;
>  }
> =20
> +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *ms=
g)
> +{
> +=09struct device *dev =3D desc->dev;
> +=09struct virtio_device *vdev =3D dev_to_virtio(dev);
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09void __iomem *pos =3D vm_dev->base;
> +=09uint16_t cmd =3D VIRTIO_MMIO_MSI_CMD(VIRTIO_MMIO_MSI_CMD_UPDATE,
> +=09=09=09desc->platform.msi_index);
> +
> +=09writel(msg->address_lo, pos + VIRTIO_MMIO_MSI_ADDRESS_LOW);
> +=09writel(msg->address_hi, pos + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
> +=09writel(msg->data, pos + VIRTIO_MMIO_MSI_DATA);
> +=09writew(cmd, pos + VIRTIO_MMIO_MSI_COMMAND);
> +}

All this can happen when IRQ affinity changes while device
is sending interrupts. An interrupt sent between the writel
operations will then be directed incorrectly.



> +
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09int irq, err;
> +=09u16 csr =3D readw(vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +
> +=09if (vm_dev->msi_enabled || (csr & VIRTIO_MMIO_MSI_ENABLE_MASK) =3D=3D=
 0)
> +=09=09return -EINVAL;
> +
> +=09vm_dev->vm_vq_names =3D kmalloc_array(nirqs, sizeof(*vm_dev->vm_vq_na=
mes),
> +=09=09=09GFP_KERNEL);
> +=09if (!vm_dev->vm_vq_names)
> +=09=09return -ENOMEM;
> +
> +=09if (!vdev->dev.msi_domain)
> +=09=09vdev->dev.msi_domain =3D platform_msi_get_def_irq_domain();
> +=09err =3D platform_msi_domain_alloc_irqs(&vdev->dev, nirqs,
> +=09=09=09mmio_write_msi_msg);
> +=09if (err)
> +=09=09goto error_free_mem;
> +
> +=09/* The first MSI vector is used for configuration change events. */
> +=09snprintf(vm_dev->vm_vq_names[0], sizeof(*vm_dev->vm_vq_names),
> +=09=09=09"%s-config", dev_name(&vdev->dev));
> +=09irq =3D vm_msi_irq_vector(&vdev->dev, 0);
> +=09err =3D request_irq(irq, vm_config_changed, 0, vm_dev->vm_vq_names[0]=
,
> +=09=09=09vm_dev);
> +=09if (err)
> +=09=09goto error_free_mem;
> +
> +=09return 0;
> +
> +error_free_mem:
> +=09kfree(vm_dev->vm_vq_names);
> +=09vm_dev->vm_vq_names =3D NULL;
> +=09return err;
> +}
> +
> +static void vm_free_msi_irqs(struct virtio_device *vdev)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +=09if (vm_dev->msi_enabled) {
> +=09=09mmio_msi_set_enable(vm_dev, 0);
> +=09=09free_irq(vm_msi_irq_vector(&vdev->dev, 0), vm_dev);
> +=09=09platform_msi_domain_free_irqs(&vdev->dev);
> +=09=09kfree(vm_dev->vm_vq_names);
> +=09=09vm_dev->vm_vq_names =3D NULL;
> +=09=09vm_dev->msi_enabled =3D false;
> +=09}
> +}
> +
>  static const char *vm_bus_name(struct virtio_device *vdev)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> @@ -567,7 +761,7 @@ static int virtio_mmio_probe(struct platform_device *=
pdev)
> =20
>  =09/* Check device version */
>  =09vm_dev->version =3D readl(vm_dev->base + VIRTIO_MMIO_VERSION);
> -=09if (vm_dev->version < 1 || vm_dev->version > 2) {
> +=09if (vm_dev->version < 1 || vm_dev->version > 3) {
>  =09=09dev_err(&pdev->dev, "Version %ld not supported!\n",
>  =09=09=09=09vm_dev->version);
>  =09=09return -ENXIO;
> @@ -603,6 +797,12 @@ static int virtio_mmio_probe(struct platform_device =
*pdev)
>  =09=09dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Tryi=
ng to continue, but this might not work.\n");
> =20
>  =09platform_set_drvdata(pdev, vm_dev);
> +=09if (vm_dev->version =3D=3D 3) {
> +=09=09u32 db =3D readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +=09=09vm_dev->doorbell_base =3D db & 0xffff;
> +=09=09vm_dev->doorbell_scale =3D (db >> 16) & 0xffff;
> +=09}
> =20
>  =09rc =3D register_virtio_device(&vm_dev->vdev);
>  =09if (rc)
> @@ -619,8 +819,6 @@ static int virtio_mmio_remove(struct platform_device =
*pdev)
>  =09return 0;
>  }
> =20
> -
> -
>  /* Devices list parameter */
> =20
>  #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio=
_mmio.h
> index c4b0968..148895e 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,34 @@
>  #define VIRTIO_MMIO_QUEUE_USED_LOW=090x0a0
>  #define VIRTIO_MMIO_QUEUE_USED_HIGH=090x0a4
> =20
> +/* MSI related registers */
> +
> +/* MSI status register */
> +#define VIRTIO_MMIO_MSI_STATUS=09=090x0c0
> +/* MSI command register */
> +#define VIRTIO_MMIO_MSI_COMMAND=09=090x0c2
> +/* MSI low 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_LOW=090x0c4
> +/* MSI high 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_HIGH=090x0c8
> +/* MSI data */
> +#define VIRTIO_MMIO_MSI_DATA=09=090x0cc
> +
> +/* RO: MSI feature enabled mask */
> +#define VIRTIO_MMIO_MSI_ENABLE_MASK=090x8000

I don't understand the comment. Is this a way for
a version 3 device to say "I want/do not want MSI"?
Why not just use a feature bit? We are not short on these.

> +/* RO: Maximum queue size available */
> +#define VIRTIO_MMIO_MSI_STATUS_QMASK=090x07ff


I don't know what above is. Seems unused.

> +/* Reserved */
> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED=090x7800
> +
> +#define VIRTIO_MMIO_MSI_CMD_UPDATE=090x1
> +#define VIRTIO_MMIO_MSI_CMD_OP_MASK=090xf000
> +#define VIRTIO_MMIO_MSI_CMD_ARG_MASK=090x0fff
> +#define VIRTIO_MMIO_MSI_CMD(op, arg)=09((op) << 12 | (arg))
> +#define VIRITO_MMIO_MSI_CMD_ARG(cmd)=09((cmd) & VIRTIO_MMIO_MSI_CMD_ARG_=
MASK)
> +#define VIRTIO_MMIO_MSI_CMD_OP(cmd)=09\
> +=09=09(((cmd) & VIRTIO_MMIO_MSI_CMD_OP_MASK) >> 12)
> +
>  /* Configuration atomicity value */
>  #define VIRTIO_MMIO_CONFIG_GENERATION=090x0fc
> =20
> --=20
> 1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

