Return-Path: virtio-dev-return-6723-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84705985D08
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 11:33:18 +0000 (UTC)
Date: Tue, 11 Feb 2020 06:33:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200211062205-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com, jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> The standard virtio-mmio devices use notification register to signal
> backend. This will cause vmexits and slow down the performance when we
> passthrough the virtio-mmio devices to guest virtual machines.
> We proposed to update virtio over MMIO spec to add the per-queue
> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
> configure notify location for each queue.
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


Hmm. Any way to make this static so we don't need
base and multiplier?

> ---
>  drivers/virtio/virtio_mmio.c       | 37 ++++++++++++++++++++++++++++++++=
+++--
>  include/uapi/linux/virtio_config.h |  8 +++++++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97d5725..1733ab97 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -90,6 +90,9 @@ struct virtio_mmio_device {
>  =09/* a list of queues so we can dispatch IRQs */
>  =09spinlock_t lock;
>  =09struct list_head virtqueues;
> +
> +=09unsigned short notify_base;
> +=09unsigned short notify_multiplier;
>  };
> =20
>  struct virtio_mmio_vq_info {
> @@ -98,6 +101,9 @@ struct virtio_mmio_vq_info {
> =20
>  =09/* the list node for the virtqueues list */
>  =09struct list_head node;
> +
> +=09/* Notify Address*/
> +=09unsigned int notify_addr;
>  };
> =20
> =20
> @@ -119,13 +125,23 @@ static u64 vm_get_features(struct virtio_device *vd=
ev)
>  =09return features;
>  }
> =20
> +static void vm_transport_features(struct virtio_device *vdev, u64 featur=
es)
> +{
> +=09if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
> +=09=09__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
> +}
> +
>  static int vm_finalize_features(struct virtio_device *vdev)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09u64 features =3D vdev->features;
> =20
>  =09/* Give virtio_ring a chance to accept features. */
>  =09vring_transport_features(vdev);
> =20
> +=09/* Give virtio_mmio a chance to accept features. */
> +=09vm_transport_features(vdev, features);
> +
>  =09/* Make sure there is are no mixed devices */
>  =09if (vm_dev->version =3D=3D 2 &&
>  =09=09=09!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
> @@ -272,10 +288,13 @@ static void vm_reset(struct virtio_device *vdev)
>  static bool vm_notify(struct virtqueue *vq)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->vdev)=
;
> +=09struct virtio_mmio_vq_info *info =3D vq->priv;
> =20
> -=09/* We write the queue's selector into the notification register to
> +=09/* We write the queue's selector into the Notify Address to
>  =09 * signal the other end */
> -=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +=09if (info)
> +=09=09writel(vq->index, vm_dev->base + info->notify_addr);
> +
>  =09return true;
>  }
> =20
> @@ -434,6 +453,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_d=
evice *vdev, unsigned index,
>  =09vq->priv =3D info;
>  =09info->vq =3D vq;
> =20
> +=09if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION))
> +=09=09info->notify_addr =3D vm_dev->notify_base +
> +=09=09=09=09vm_dev->notify_multiplier * vq->index;
> +=09else
> +=09=09info->notify_addr =3D VIRTIO_MMIO_QUEUE_NOTIFY;
> +
>  =09spin_lock_irqsave(&vm_dev->lock, flags);
>  =09list_add(&info->node, &vm_dev->virtqueues);
>  =09spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -471,6 +496,14 @@ static int vm_find_vqs(struct virtio_device *vdev, u=
nsigned nvqs,
>  =09=09return irq;
>  =09}
> =20
> +=09if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
> +=09=09unsigned int notify =3D readl(vm_dev->base +
> +=09=09=09=09VIRTIO_MMIO_QUEUE_NOTIFY);


that register is documented as:

/* Queue notifier - Write Only */
#define VIRTIO_MMIO_QUEUE_NOTIFY        0x050

so at least you need to update the doc.

> +
> +=09=09vm_dev->notify_base =3D notify & 0xffff;
> +=09=09vm_dev->notify_multiplier =3D (notify >> 16) & 0xffff;

are 16 bit base/limit always enough?
In fact won't we be short on 16 bit address space
in a rather short order if queues use up a page
of space at a time?


> +=09}
> +
>  =09err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
>  =09=09=09dev_name(&vdev->dev), vm_dev);
>  =09if (err)
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virt=
io_config.h
> index ff8e7dc..5d93c01 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -52,7 +52,7 @@
>   * rest are per-device feature bits.
>   */
>  #define VIRTIO_TRANSPORT_F_START=0928
> -#define VIRTIO_TRANSPORT_F_END=09=0938
> +#define VIRTIO_TRANSPORT_F_END=09=0940
> =20
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -88,4 +88,10 @@
>   * Does the device support Single Root I/O Virtualization?
>   */
>  #define VIRTIO_F_SR_IOV=09=09=0937
> +
> +/*
> + * This feature indicates the enhanced notification support on MMIO tran=
sport
> + * layer.

Let's replace this with an actual description of the enhancement please
otherwise it will not make sense in a couple of months.

e.g. "Per queue notification address"?


> + */
> +#define VIRTIO_F_MMIO_NOTIFICATION=0939
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> --=20
> 1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

