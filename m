Return-Path: virtio-dev-return-6573-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74D2B985D91
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Dec 2019 08:40:57 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
Date: Thu, 26 Dec 2019 16:40:18 +0800
MIME-Version: 1.0
In-Reply-To: <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specific
> VMExits in following cases, which would considerably slow down the
> performance:
>
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
>
> We proposed to update virtio over MMIO to version 3[1] to add the
> following new features and enhance the performance.
>
> 1) Support Message Signaled Interrupt(MSI), which increases the
>     interrupt performance for virtio multi-queue devices
> 2) Support per-queue doorbell, so the guest kernel may directly write
>     to the doorbells provided by virtio devices.
>
> The following is the network tcp_rr performance testing report, tested
> with virtio-pci device, vanilla virtio-mmio device and patched
> virtio-mmio device (run test 3 times for each case):
>
> =09netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>
> =09=09Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
> =09trans/s=09    9536=096939=09=099500
> =09trans/s=09    9734=097029=09=099749
> =09trans/s=09    9894=097095=09=099318
>
> [1] https://lkml.org/lkml/2019/12/20/113
>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>   drivers/virtio/virtio_mmio.c     | 226 ++++++++++++++++++++++++++++++++=
++++---
>   include/uapi/linux/virtio_mmio.h |  28 +++++
>   2 files changed, 240 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e09edb5..065c083 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -68,8 +68,8 @@
>   #include <linux/virtio_config.h>
>   #include <uapi/linux/virtio_mmio.h>
>   #include <linux/virtio_ring.h>
> -
> -
> +#include <linux/msi.h>
> +#include <asm/irqdomain.h>
>  =20
>   /* The alignment to use between consumer and producer parts of vring.
>    * Currently hardcoded to the page size. */
> @@ -90,6 +90,12 @@ struct virtio_mmio_device {
>   =09/* a list of queues so we can dispatch IRQs */
>   =09spinlock_t lock;
>   =09struct list_head virtqueues;
> +
> +=09int doorbell_base;
> +=09int doorbell_scale;


It's better to use the terminology defined by spec, e.g=20
notify_base/notify_multiplexer etc.

And we usually use unsigned type for offset.


> +=09bool msi_enabled;
> +=09/* Name strings for interrupts. */
> +=09char (*vm_vq_names)[256];
>   };
>  =20
>   struct virtio_mmio_vq_info {
> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>   };
>  =20
>  =20
> +static void vm_free_msi_irqs(struct virtio_device *vdev);
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)=
;
>  =20
>   /* Configuration interface */
>  =20
> @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>   {
>   =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->vdev=
);
>  =20
> +=09if (vm_dev->version =3D=3D 3) {
> +=09=09int offset =3D vm_dev->doorbell_base +
> +=09=09=09     vm_dev->doorbell_scale * vq->index;
> +=09=09writel(vq->index, vm_dev->base + offset);


In virtio-pci we store the doorbell address in vq->priv to avoid doing=20
multiplication in fast path.


> +=09} else
>   =09/* We write the queue's selector into the notification register to
>   =09 * signal the other end */
> -=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +=09=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
>   =09return true;
>   }
>  =20
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
>   /* Notify all virtqueues on an interrupt. */
>   static irqreturn_t vm_interrupt(int irq, void *opaque)
>   {
> @@ -307,7 +331,12 @@ static irqreturn_t vm_interrupt(int irq, void *opaqu=
e)
>   =09return ret;
>   }
>  =20
> +static int vm_msi_irq_vector(struct device *dev, unsigned int nr)
> +{
> +=09struct msi_desc *entry =3D first_msi_entry(dev);
>  =20
> +=09return entry->irq + nr;
> +}
>  =20
>   static void vm_del_vq(struct virtqueue *vq)
>   {
> @@ -316,6 +345,12 @@ static void vm_del_vq(struct virtqueue *vq)
>   =09unsigned long flags;
>   =09unsigned int index =3D vq->index;
>  =20
> +=09if (vm_dev->version =3D=3D 3 && vm_dev->msi_enabled) {
> +=09=09int irq =3D vm_msi_irq_vector(&vq->vdev->dev, index + 1);
> +
> +=09=09free_irq(irq, vq);
> +=09}
> +
>   =09spin_lock_irqsave(&vm_dev->lock, flags);
>   =09list_del(&info->node);
>   =09spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -334,15 +369,41 @@ static void vm_del_vq(struct virtqueue *vq)
>   =09kfree(info);
>   }
>  =20
> -static void vm_del_vqs(struct virtio_device *vdev)
> +static void vm_free_irqs(struct virtio_device *vdev)
>   {
>   =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +=09if (vm_dev->version =3D=3D 3)
> +=09=09vm_free_msi_irqs(vdev);
> +=09else
> +=09=09free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +}
> +
> +static void vm_del_vqs(struct virtio_device *vdev)
> +{
>   =09struct virtqueue *vq, *n;
>  =20
>   =09list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>   =09=09vm_del_vq(vq);
>  =20
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
>   }
>  =20
>   static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsign=
ed index,
> @@ -455,6 +516,72 @@ static struct virtqueue *vm_setup_vq(struct virtio_d=
evice *vdev, unsigned index,
>   =09return ERR_PTR(err);
>   }
>  =20
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
>   static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   =09=09       struct virtqueue *vqs[],
>   =09=09       vq_callback_t *callbacks[],
> @@ -463,16 +590,16 @@ static int vm_find_vqs(struct virtio_device *vdev, =
unsigned nvqs,
>   =09=09       struct irq_affinity *desc)
>   {
>   =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> -=09int irq =3D platform_get_irq(vm_dev->pdev, 0);
>   =09int i, err, queue_idx =3D 0;
>  =20
> -=09if (irq < 0) {
> -=09=09dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> -=09=09return irq;
> +=09if (vm_dev->version =3D=3D 3) {
> +=09=09err =3D vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +=09=09=09=09names, ctx, desc);
> +=09=09if (!err)
> +=09=09=09return 0;
>   =09}
>  =20
> -=09err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
> -=09=09=09dev_name(&vdev->dev), vm_dev);
> +=09err =3D vm_request_single_irq(vdev);
>   =09if (err)
>   =09=09return err;
>  =20
> @@ -493,6 +620,73 @@ static int vm_find_vqs(struct virtio_device *vdev, u=
nsigned nvqs,
>   =09return 0;
>   }
>  =20
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


Can platform_msi_domain_alloc_irqs check msi_domain vs NULL?


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
>   static const char *vm_bus_name(struct virtio_device *vdev)
>   {
>   =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> @@ -567,7 +761,7 @@ static int virtio_mmio_probe(struct platform_device *=
pdev)
>  =20
>   =09/* Check device version */
>   =09vm_dev->version =3D readl(vm_dev->base + VIRTIO_MMIO_VERSION);
> -=09if (vm_dev->version < 1 || vm_dev->version > 2) {
> +=09if (vm_dev->version < 1 || vm_dev->version > 3) {
>   =09=09dev_err(&pdev->dev, "Version %ld not supported!\n",
>   =09=09=09=09vm_dev->version);
>   =09=09return -ENXIO;
> @@ -603,6 +797,12 @@ static int virtio_mmio_probe(struct platform_device =
*pdev)
>   =09=09dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Try=
ing to continue, but this might not work.\n");
>  =20
>   =09platform_set_drvdata(pdev, vm_dev);
> +=09if (vm_dev->version =3D=3D 3) {
> +=09=09u32 db =3D readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +=09=09vm_dev->doorbell_base =3D db & 0xffff;
> +=09=09vm_dev->doorbell_scale =3D (db >> 16) & 0xffff;
> +=09}
>  =20
>   =09rc =3D register_virtio_device(&vm_dev->vdev);
>   =09if (rc)
> @@ -619,8 +819,6 @@ static int virtio_mmio_remove(struct platform_device =
*pdev)
>   =09return 0;
>   }
>  =20
> -
> -


Unnecessary changes.


>   /* Devices list parameter */
>  =20
>   #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio=
_mmio.h
> index c4b0968..148895e 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,34 @@
>   #define VIRTIO_MMIO_QUEUE_USED_LOW=090x0a0
>   #define VIRTIO_MMIO_QUEUE_USED_HIGH=090x0a4
>  =20
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


I wonder what's the advantage of using registers instead of memory=20
mapped tables as PCI did. Is this because MMIO doesn't have capability=20
list which makes it hard to be extended if we have variable size of tables?


> +
> +/* RO: MSI feature enabled mask */
> +#define VIRTIO_MMIO_MSI_ENABLE_MASK=090x8000
> +/* RO: Maximum queue size available */
> +#define VIRTIO_MMIO_MSI_STATUS_QMASK=090x07ff
> +/* Reserved */
> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED=090x7800
> +
> +#define VIRTIO_MMIO_MSI_CMD_UPDATE=090x1


I believe we need a command to read the number of vectors supported by=20
the device, or 2048 is assumed to be a fixed size here?

Thanks


> +#define VIRTIO_MMIO_MSI_CMD_OP_MASK=090xf000
> +#define VIRTIO_MMIO_MSI_CMD_ARG_MASK=090x0fff
> +#define VIRTIO_MMIO_MSI_CMD(op, arg)=09((op) << 12 | (arg))
> +#define VIRITO_MMIO_MSI_CMD_ARG(cmd)=09((cmd) & VIRTIO_MMIO_MSI_CMD_ARG_=
MASK)
> +#define VIRTIO_MMIO_MSI_CMD_OP(cmd)=09\
> +=09=09(((cmd) & VIRTIO_MMIO_MSI_CMD_OP_MASK) >> 12)
> +
>   /* Configuration atomicity value */
>   #define VIRTIO_MMIO_CONFIG_GENERATION=090x0fc
>  =20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

