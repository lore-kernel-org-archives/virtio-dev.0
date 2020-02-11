Return-Path: virtio-dev-return-6718-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9872985D08
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 11:11:29 +0000 (UTC)
Date: Tue, 11 Feb 2020 06:11:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200211055738-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt feature support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com, jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 10, 2020 at 05:05:20PM +0800, Zha Bin wrote:
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
> We proposed to add MSI support for virtio over MMIO via new feature
> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>=20
> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> uses msi_sharing[1] to indicate the event and vector mapping.
> Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>=20
> [1] https://lkml.org/lkml/2020/1/21/31
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  drivers/virtio/virtio_mmio.c        | 299 ++++++++++++++++++++++++++++++=
++++--
>  drivers/virtio/virtio_mmio_common.h |   8 +
>  drivers/virtio/virtio_mmio_msi.h    |  82 ++++++++++
>  include/uapi/linux/virtio_config.h  |   7 +-
>  include/uapi/linux/virtio_mmio.h    |  31 ++++
>  5 files changed, 411 insertions(+), 16 deletions(-)

So that's > 100 exatra lines in headers that you for some reason
don't count when comparing code size :).


I think an effort can be made to reduce the complexity here.
Otherwise you will end up with a clone of PCI
sooner than you think. In fact, disabling all legacy:

$ wc -l drivers/virtio/virtio_pci_modern.c
734 drivers/virtio/virtio_pci_modern.c
$ wc -l drivers/virtio/virtio_pci_common.c
635 drivers/virtio/virtio_pci_common.c

So you have almost matched that with your patch.


>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 41e1c93..b24ce21 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -67,8 +67,7 @@
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
>  #include "virtio_mmio_common.h"
> -
> -
> +#include "virtio_mmio_msi.h"
> =20
>  /* The alignment to use between consumer and producer parts of vring.
>   * Currently hardcoded to the page size. */
> @@ -85,9 +84,13 @@ struct virtio_mmio_vq_info {
> =20
>  =09/* Notify Address*/
>  =09unsigned int notify_addr;
> -};
> =20
> +=09/* MSI vector (or none) */
> +=09unsigned int msi_vector;
> +};
> =20
> +static void vm_free_msi_irqs(struct virtio_device *vdev);
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)=
;
> =20
>  /* Configuration interface */
> =20
> @@ -110,6 +113,9 @@ static void vm_transport_features(struct virtio_devic=
e *vdev, u64 features)
>  {
>  =09if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
>  =09=09__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
> +
> +=09if (features & BIT_ULL(VIRTIO_F_MMIO_MSI))
> +=09=09__virtio_set_bit(vdev, VIRTIO_F_MMIO_MSI);
>  }
> =20
>  static int vm_finalize_features(struct virtio_device *vdev)
> @@ -307,7 +313,33 @@ static irqreturn_t vm_interrupt(int irq, void *opaqu=
e)
>  =09return ret;
>  }
> =20
> +static irqreturn_t vm_vring_interrupt(int irq, void *opaque)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D opaque;
> +=09struct virtio_mmio_vq_info *info;
> +=09irqreturn_t ret =3D IRQ_NONE;
> +=09unsigned long flags;
> +
> +=09spin_lock_irqsave(&vm_dev->lock, flags);
> +=09list_for_each_entry(info, &vm_dev->virtqueues, node) {
> +=09=09if (vring_interrupt(irq, info->vq) =3D=3D IRQ_HANDLED)
> +=09=09=09ret =3D IRQ_HANDLED;
> +=09}
> +=09spin_unlock_irqrestore(&vm_dev->lock, flags);
> +
> +=09return ret;
> +}
> +
> +
> +/* Handle a configuration change */
> +static irqreturn_t vm_config_changed(int irq, void *opaque)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D opaque;
> +
> +=09virtio_config_changed(&vm_dev->vdev);
> =20
> +=09return IRQ_HANDLED;
> +}
> =20
>  static void vm_del_vq(struct virtqueue *vq)
>  {
> @@ -316,6 +348,15 @@ static void vm_del_vq(struct virtqueue *vq)
>  =09unsigned long flags;
>  =09unsigned int index =3D vq->index;
> =20
> +=09if (vm_dev->msi_enabled && !vm_dev->msi_share) {
> +=09=09if (info->msi_vector !=3D VIRTIO_MMIO_MSI_NO_VECTOR) {
> +=09=09=09int irq =3D mmio_msi_irq_vector(&vq->vdev->dev,
> +=09=09=09=09=09info->msi_vector);
> +
> +=09=09=09free_irq(irq, vq);
> +=09=09}
> +=09}
> +
>  =09spin_lock_irqsave(&vm_dev->lock, flags);
>  =09list_del(&info->node);
>  =09spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -334,20 +375,56 @@ static void vm_del_vq(struct virtqueue *vq)
>  =09kfree(info);
>  }
> =20
> -static void vm_del_vqs(struct virtio_device *vdev)
> +static void vm_free_irqs(struct virtio_device *vdev)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +=09if (vm_dev->msi_enabled)
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
> +static inline void mmio_msi_set_enable(struct virtio_mmio_device *vm_dev=
,
> +=09=09=09=09=09int enable)
> +{
> +=09u32 state;
> +
> +=09state =3D readl(vm_dev->base + VIRTIO_MMIO_MSI_STATE);
> +=09if (enable && (state & VIRTIO_MMIO_MSI_ENABLED_MASK))
> +=09=09return;
> +
> +=09writel(VIRTIO_MMIO_MSI_CMD_ENABLE,
> +=09=09vm_dev->base + VIRTIO_MMIO_MSI_COMMAND);
> +}
> +
> +static void mmio_msi_config_vector(struct virtio_mmio_device *vm_dev, u3=
2 vec)
> +{
> +=09writel(vec, vm_dev->base + VIRTIO_MMIO_MSI_VEC_SEL);
> +=09writel(VIRTIO_MMIO_MSI_CMD_MAP_CONFIG, vm_dev->base +
> +=09=09=09VIRTIO_MMIO_MSI_COMMAND);
> +}
> +
> +static void mmio_msi_queue_vector(struct virtio_mmio_device *vm_dev, u32=
 vec)
> +{
> +=09writel(vec, vm_dev->base + VIRTIO_MMIO_MSI_VEC_SEL);
> +=09writel(VIRTIO_MMIO_MSI_CMD_MAP_QUEUE, vm_dev->base +
> +=09=09=09VIRTIO_MMIO_MSI_COMMAND);
>  }
> =20
>  static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigne=
d index,
>  =09=09=09=09  void (*callback)(struct virtqueue *vq),
> -=09=09=09=09  const char *name, bool ctx)
> +=09=09=09=09  const char *name, bool ctx, u32 msi_vector)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
>  =09struct virtio_mmio_vq_info *info;
> @@ -440,6 +517,11 @@ static struct virtqueue *vm_setup_vq(struct virtio_d=
evice *vdev, unsigned index,
>  =09else
>  =09=09info->notify_addr =3D VIRTIO_MMIO_QUEUE_NOTIFY;
> =20
> +=09info->msi_vector =3D msi_vector;
> +=09/* Set queue event and vector mapping for MSI share mode. */
> +=09if (vm_dev->msi_share && msi_vector !=3D VIRTIO_MMIO_MSI_NO_VECTOR)
> +=09=09mmio_msi_queue_vector(vm_dev, msi_vector);
> +
>  =09spin_lock_irqsave(&vm_dev->lock, flags);
>  =09list_add(&info->node, &vm_dev->virtqueues);
>  =09spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -461,12 +543,11 @@ static struct virtqueue *vm_setup_vq(struct virtio_=
device *vdev, unsigned index,
>  =09return ERR_PTR(err);
>  }
> =20
> -static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> -=09=09       struct virtqueue *vqs[],
> -=09=09       vq_callback_t *callbacks[],
> -=09=09       const char * const names[],
> -=09=09       const bool *ctx,
> -=09=09       struct irq_affinity *desc)
> +static int vm_find_vqs_intx(struct virtio_device *vdev, unsigned int nvq=
s,
> +=09=09=09struct virtqueue *vqs[],
> +=09=09=09vq_callback_t *callbacks[],
> +=09=09=09const char * const names[],
> +=09=09=09const bool *ctx)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
>  =09int irq =3D platform_get_irq(vm_dev->pdev, 0);
> @@ -487,8 +568,6 @@ static int vm_find_vqs(struct virtio_device *vdev, un=
signed nvqs,
> =20
>  =09err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
>  =09=09=09dev_name(&vdev->dev), vm_dev);
> -=09if (err)
> -=09=09return err;
> =20
>  =09for (i =3D 0; i < nvqs; ++i) {
>  =09=09if (!names[i]) {
> @@ -497,14 +576,202 @@ static int vm_find_vqs(struct virtio_device *vdev,=
 unsigned nvqs,
>  =09=09}
> =20
>  =09=09vqs[i] =3D vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> -=09=09=09=09     ctx ? ctx[i] : false);
> +=09=09=09=09     ctx ? ctx[i] : false,
> +=09=09=09=09     VIRTIO_MMIO_MSI_NO_VECTOR);
>  =09=09if (IS_ERR(vqs[i])) {
>  =09=09=09vm_del_vqs(vdev);
>  =09=09=09return PTR_ERR(vqs[i]);
>  =09=09}
>  =09}
> =20
> +=09return err;
> +}
> +
> +static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nvqs=
,
> +=09=09=09struct virtqueue *vqs[], vq_callback_t *callbacks[],
> +=09=09=09const char * const names[], bool per_vq_vectors,
> +=09=09=09const bool *ctx, struct irq_affinity *desc)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09int i, err, allocated_vectors, nvectors;
> +=09u32 msi_vec;
> +=09u32 max_vec_num =3D readl(vm_dev->base + VIRTIO_MMIO_MSI_VEC_NUM);
> +
> +=09/* For MSI non-sharing, the max vector number MUST greater than nvqs.
> +=09 * Otherwise, go back to legacy interrupt.
> +=09 */
> +=09if (per_vq_vectors && max_vec_num < (nvqs + 1))
> +=09=09return -EINVAL;
> +
> +=09if (per_vq_vectors) {
> +=09=09nvectors =3D 1;
> +=09=09for (i =3D 0; i < nvqs; ++i)
> +=09=09=09if (callbacks[i])
> +=09=09=09=09++nvectors;
> +=09} else {
> +=09=09nvectors =3D 2;
> +=09}
> +
> +=09vm_dev->msi_share =3D !per_vq_vectors;
> +
> +=09/* Allocate nvqs irqs for queues and one irq for configuration */
> +=09err =3D vm_request_msi_vectors(vdev, nvectors);
> +=09if (err !=3D 0)
> +=09=09return err;
> +
> +=09allocated_vectors =3D vm_dev->msi_used_vectors;
> +=09for (i =3D 0; i < nvqs; i++) {
> +=09=09if (!names[i]) {
> +=09=09=09vqs[i] =3D NULL;
> +=09=09=09continue;
> +=09=09}
> +=09=09if (!callbacks[i])
> +=09=09=09msi_vec =3D VIRTIO_MMIO_MSI_NO_VECTOR;
> +=09=09else if (per_vq_vectors)
> +=09=09=09msi_vec =3D allocated_vectors++;
> +=09=09else
> +=09=09=09msi_vec =3D 1;
> +=09=09vqs[i] =3D vm_setup_vq(vdev, i, callbacks[i], names[i],
> +=09=09=09=09ctx ? ctx[i] : false, msi_vec);
> +=09=09if (IS_ERR(vqs[i])) {
> +=09=09=09err =3D PTR_ERR(vqs[i]);
> +=09=09=09goto error_find;
> +=09=09}
> +
> +=09=09if (!per_vq_vectors ||
> +=09=09=09=09msi_vec =3D=3D VIRTIO_MMIO_MSI_NO_VECTOR)
> +=09=09=09continue;
> +
> +=09=09/* allocate per-vq irq if available and necessary */
> +=09=09snprintf(vm_dev->vm_vq_names[msi_vec],
> +=09=09=09sizeof(*vm_dev->vm_vq_names),
> +=09=09=09"%s-%s",
> +=09=09=09dev_name(&vm_dev->vdev.dev), names[i]);
> +=09=09err =3D request_irq(mmio_msi_irq_vector(&vqs[i]->vdev->dev,
> +=09=09=09=09=09msi_vec),
> +=09=09=09=09vring_interrupt, 0,
> +=09=09=09=09vm_dev->vm_vq_names[msi_vec], vqs[i]);
> +
> +=09=09if (err)
> +=09=09=09goto error_find;
> +=09}
> +
>  =09return 0;
> +
> +error_find:
> +=09vm_del_vqs(vdev);
> +=09return err;
> +}
> +
> +static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> +=09=09       struct virtqueue *vqs[],
> +=09=09       vq_callback_t *callbacks[],
> +=09=09       const char * const names[],
> +=09=09       const bool *ctx,
> +=09=09       struct irq_affinity *desc)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09int err;
> +
> +=09if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
> +=09=09unsigned int notify =3D readl(vm_dev->base +
> +=09=09=09=09VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +=09=09vm_dev->notify_base =3D notify & 0xffff;
> +=09=09vm_dev->notify_multiplier =3D (notify >> 16) & 0xffff;
> +=09}
> +
> +=09if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_MSI)) {
> +=09=09bool dyn_mapping =3D !!(readl(vm_dev->base +
> +=09=09=09=09=09VIRTIO_MMIO_MSI_STATE) &
> +=09=09=09=09VIRTIO_MMIO_MSI_SHARING_MASK);
> +=09=09if (!dyn_mapping)
> +=09=09=09err =3D vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +=09=09=09=09names, true, ctx, desc);
> +=09=09else
> +=09=09=09err =3D vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +=09=09=09=09names, false, ctx, desc);
> +=09=09if (!err)
> +=09=09=09return 0;
> +=09}
> +
> +=09return vm_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> +}
> +
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)
> +{
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09unsigned int v;
> +=09int irq, err;
> +
> +=09if (vm_dev->msi_enabled)
> +=09=09return -EINVAL;
> +
> +=09vm_dev->vm_vq_names =3D kmalloc_array(nirqs, sizeof(*vm_dev->vm_vq_na=
mes),
> +=09=09=09=09=09GFP_KERNEL);
> +=09if (!vm_dev->vm_vq_names)
> +=09=09return -ENOMEM;
> +
> +=09mmio_get_msi_domain(vdev);
> +=09err =3D mmio_msi_domain_alloc_irqs(&vdev->dev, nirqs);
> +=09if (err) {
> +=09=09kfree(vm_dev->vm_vq_names);
> +=09=09vm_dev->vm_vq_names =3D NULL;
> +=09=09return err;
> +=09}
> +
> +=09mmio_msi_set_enable(vm_dev, 1);
> +=09vm_dev->msi_enabled =3D true;
> +
> +=09v =3D vm_dev->msi_used_vectors;
> +=09/* The first MSI vector is used for configuration change event. */
> +=09snprintf(vm_dev->vm_vq_names[v], sizeof(*vm_dev->vm_vq_names),
> +=09=09=09"%s-config", dev_name(&vdev->dev));
> +=09irq =3D mmio_msi_irq_vector(&vdev->dev, v);
> +=09err =3D request_irq(irq, vm_config_changed, 0, vm_dev->vm_vq_names[v]=
,
> +=09=09=09vm_dev);
> +=09if (err)
> +=09=09goto error_request_irq;
> +
> +=09/* Set the configuration event mapping. */
> +=09if (vm_dev->msi_share)
> +=09=09mmio_msi_config_vector(vm_dev, v);
> +
> +=09++vm_dev->msi_used_vectors;
> +
> +=09if (vm_dev->msi_share) {
> +=09=09v =3D vm_dev->msi_used_vectors;
> +=09=09snprintf(vm_dev->vm_vq_names[v], sizeof(*vm_dev->vm_vq_names),
> +=09=09=09 "%s-virtqueues", dev_name(&vm_dev->vdev.dev));
> +=09=09err =3D request_irq(mmio_msi_irq_vector(&vdev->dev, v),
> +=09=09=09=09  vm_vring_interrupt, 0, vm_dev->vm_vq_names[v],
> +=09=09=09=09  vm_dev);
> +=09=09if (err)
> +=09=09=09goto error_request_irq;
> +=09=09++vm_dev->msi_used_vectors;
> +=09}
> +
> +=09return 0;
> +
> +error_request_irq:
> +=09vm_free_msi_irqs(vdev);
> +
> +=09return err;
> +}
> +
> +static void vm_free_msi_irqs(struct virtio_device *vdev)
> +{
> +=09int i;
> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +=09mmio_msi_set_enable(vm_dev, 0);
> +=09for (i =3D 0; i < vm_dev->msi_used_vectors; i++)
> +=09=09free_irq(mmio_msi_irq_vector(&vdev->dev, i), vm_dev);
> +=09mmio_msi_domain_free_irqs(&vdev->dev);
> +=09kfree(vm_dev->vm_vq_names);
> +=09vm_dev->vm_vq_names =3D NULL;
> +=09vm_dev->msi_enabled =3D false;
> +=09vm_dev->msi_used_vectors =3D 0;
>  }
> =20
>  static const char *vm_bus_name(struct virtio_device *vdev)
> @@ -609,6 +876,8 @@ static int virtio_mmio_probe(struct platform_device *=
pdev)
> =20
>  =09platform_set_drvdata(pdev, vm_dev);
> =20
> +=09mmio_msi_create_irq_domain();
> +
>  =09rc =3D register_virtio_device(&vm_dev->vdev);
>  =09if (rc)
>  =09=09put_device(&vm_dev->vdev.dev);
> diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_=
mmio_common.h
> index 90cb304..ccf6320 100644
> --- a/drivers/virtio/virtio_mmio_common.h
> +++ b/drivers/virtio/virtio_mmio_common.h
> @@ -26,6 +26,14 @@ struct virtio_mmio_device {
> =20
>  =09unsigned short notify_base;
>  =09unsigned short notify_multiplier;
> +
> +=09/* Name strings for interrupts. This size should be enough. */
> +=09char (*vm_vq_names)[256];
> +
> +=09/* used vectors */
> +=09unsigned int msi_used_vectors;
> +=09bool msi_share;
> +=09bool msi_enabled;
>  };
> =20
>  #endif
> diff --git a/drivers/virtio/virtio_mmio_msi.h b/drivers/virtio/virtio_mmi=
o_msi.h
> index 27cb2af..10038cb 100644
> --- a/drivers/virtio/virtio_mmio_msi.h
> +++ b/drivers/virtio/virtio_mmio_msi.h
> @@ -8,6 +8,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/platform_device.h>
> +#include "virtio_mmio_common.h"
> =20
>  static irq_hw_number_t mmio_msi_hwirq;
>  static struct irq_domain *mmio_msi_domain;
> @@ -21,12 +22,41 @@ void __weak irq_msi_compose_msg(struct irq_data *data=
, struct msi_msg *msg)
>  {
>  }
> =20
> +static void __iomem *vm_dev_base(struct msi_desc *desc)
> +{
> +=09if (desc) {
> +=09=09struct device *dev =3D desc->dev;
> +=09=09struct virtio_device *vdev =3D dev_to_virtio(dev);
> +=09=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +=09=09return vm_dev->base;
> +=09}
> +
> +=09return NULL;
> +}
> +
> +static void mmio_msi_set_mask_bit(struct irq_data *data, u32 flag)
> +{
> +=09struct msi_desc *desc =3D irq_data_get_msi_desc(data);
> +=09void __iomem *base =3D vm_dev_base(desc);
> +=09unsigned int offset =3D data->irq - desc->irq;
> +
> +=09if (base) {
> +=09=09u32 op =3D flag ? VIRTIO_MMIO_MSI_CMD_MASK :
> +=09=09=09VIRTIO_MMIO_MSI_CMD_UNMASK;
> +=09=09writel(offset, base + VIRTIO_MMIO_MSI_VEC_SEL);
> +=09=09writel(op, base + VIRTIO_MMIO_MSI_COMMAND);
> +=09}
> +}
> +
>  static void mmio_msi_mask_irq(struct irq_data *data)
>  {
> +=09mmio_msi_set_mask_bit(data, 1);
>  }
> =20
>  static void mmio_msi_unmask_irq(struct irq_data *data)
>  {
> +=09mmio_msi_set_mask_bit(data, 0);
>  }
> =20
>  static struct irq_chip mmio_msi_controller =3D {
> @@ -86,8 +116,60 @@ static inline void mmio_msi_create_irq_domain(void)
>  =09=09irq_domain_free_fwnode(fn);
>  =09}
>  }
> +
> +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *ms=
g)
> +{
> +=09void __iomem *base =3D vm_dev_base(desc);
> +
> +=09if (base) {
> +=09=09writel(desc->platform.msi_index, base +
> +=09=09=09=09VIRTIO_MMIO_MSI_VEC_SEL);
> +=09=09writel(msg->address_lo, base + VIRTIO_MMIO_MSI_ADDRESS_LOW);
> +=09=09writel(msg->address_hi, base + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
> +=09=09writel(msg->data, base + VIRTIO_MMIO_MSI_DATA);
> +=09=09writel(VIRTIO_MMIO_MSI_CMD_CONFIGURE,
> +=09=09=09base + VIRTIO_MMIO_MSI_COMMAND);
> +=09}
> +}
> +
> +static inline int mmio_msi_domain_alloc_irqs(struct device *dev,
> +=09=09=09=09unsigned int nvec)
> +{
> +=09return platform_msi_domain_alloc_irqs(dev, nvec,
> +=09=09=09mmio_write_msi_msg);
> +}
> +
> +static inline void mmio_msi_domain_free_irqs(struct device *dev)
> +{
> +=09return platform_msi_domain_free_irqs(dev);
> +}
> +
> +static inline void mmio_get_msi_domain(struct virtio_device *vdev)
> +{
> +=09if (!vdev->dev.msi_domain)
> +=09=09vdev->dev.msi_domain =3D mmio_msi_domain;
> +}
> +
> +static inline int mmio_msi_irq_vector(struct device *dev, unsigned int n=
r)
> +{
> +=09struct msi_desc *entry =3D first_msi_entry(dev);
> +
> +=09return entry->irq + nr;
> +}
> +
>  #else
>  static inline void mmio_msi_create_irq_domain(void) {}
> +static inline int mmio_msi_irq_vector(struct device *dev, unsigned int n=
r)
> +{
> +=09return -EINVAL;
> +}
> +static inline void mmio_get_msi_domain(struct virtio_device *vdev) {}
> +static inline int mmio_msi_domain_alloc_irqs(struct device *dev,
> +=09=09=09=09unsigned int nvec)
> +{
> +=09return -EINVAL;
> +}
> +static inline void mmio_msi_domain_free_irqs(struct device *dev) {}
>  #endif
> =20
>  #endif
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virt=
io_config.h
> index 5d93c01..5eb3900 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -52,7 +52,7 @@
>   * rest are per-device feature bits.
>   */
>  #define VIRTIO_TRANSPORT_F_START=0928
> -#define VIRTIO_TRANSPORT_F_END=09=0940
> +#define VIRTIO_TRANSPORT_F_END=09=0941
> =20
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -94,4 +94,9 @@
>   * layer.
>   */
>  #define VIRTIO_F_MMIO_NOTIFICATION=0939
> +
> +/*
> + * This feature indicates the MSI support on MMIO layer.
> + */
> +#define VIRTIO_F_MMIO_MSI=09=0940
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio=
_mmio.h
> index c4b0968..777cb0e 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,21 @@
>  #define VIRTIO_MMIO_QUEUE_USED_LOW=090x0a0
>  #define VIRTIO_MMIO_QUEUE_USED_HIGH=090x0a4
> =20
> +/* MSI max vector number that device supports - Read Only */
> +#define VIRTIO_MMIO_MSI_VEC_NUM=09=090x0c0
> +/* MSI state register  - Read Only */
> +#define VIRTIO_MMIO_MSI_STATE=09=090x0c4
> +/* MSI command register - Write Only */
> +#define VIRTIO_MMIO_MSI_COMMAND=09=090x0c8
> +/* MSI vector selector  - Write Only */
> +#define VIRTIO_MMIO_MSI_VEC_SEL=09=090x0d0
> +/* MSI low 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_LOW=090x0d4
> +/* MSI high 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_HIGH=090x0d8
> +/* MSI 32 bit data */
> +#define VIRTIO_MMIO_MSI_DATA=09=090x0dc
> +
>  /* Configuration atomicity value */
>  #define VIRTIO_MMIO_CONFIG_GENERATION=090x0fc
> =20
> @@ -130,6 +145,22 @@
>  #define VIRTIO_MMIO_CONFIG=09=090x100
> =20
> =20
> +/* MSI commands */
> +#define VIRTIO_MMIO_MSI_CMD_ENABLE=090x1
> +#define VIRTIO_MMIO_MSI_CMD_DISABLE=090x2
> +#define VIRTIO_MMIO_MSI_CMD_CONFIGURE=090x3
> +#define VIRTIO_MMIO_MSI_CMD_MASK=090x4
> +#define VIRTIO_MMIO_MSI_CMD_UNMASK=090x5
> +#define VIRTIO_MMIO_MSI_CMD_MAP_CONFIG=090x6
> +#define VIRTIO_MMIO_MSI_CMD_MAP_QUEUE=090x7
> +
> +/* MSI NO_VECTOR */
> +#define VIRTIO_MMIO_MSI_NO_VECTOR=090xffffffff
> +
> +/* MSI state enabled state mask */
> +#define VIRTIO_MMIO_MSI_ENABLED_MASK=09(1 << 31)
> +/* MSI state MSI sharing mask */
> +#define VIRTIO_MMIO_MSI_SHARING_MASK=09(1 << 30)
> =20

You should be able to drop MAP commands,
replace vector number with vq number.

I also don't really see a burning need for separate
enable/disable/configure/mask/unmask commands.
Just two registers mask and enable should be enough?
Will remove need for NO_VECTOR hack too.

what is sharing that hypervisor needs to worry about it?
just make all interrupts shared, or all unshared.
does it matter for performance?

>  /*
>   * Interrupt flags (re: interrupt status & acknowledge registers)
> --=20
> 1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

