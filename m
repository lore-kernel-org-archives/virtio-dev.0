Return-Path: virtio-dev-return-6721-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5B35985D08
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 11:19:16 +0000 (UTC)
Date: Tue, 11 Feb 2020 06:19:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200211061758-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2 2/5] virtio-mmio: refactor common functionality
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com, jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 10, 2020 at 05:05:18PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> Common functionality is refactored into virtio_mmio_common.h
> in order to MSI support in later patch set.
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>

What does this proliferation of header files achieve?
common with what?

> ---
>  drivers/virtio/virtio_mmio.c        | 21 +--------------------
>  drivers/virtio/virtio_mmio_common.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/virtio/virtio_mmio_common.h
>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1733ab97..41e1c93 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -61,13 +61,12 @@
>  #include <linux/io.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> -#include <linux/virtio.h>
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
> +#include "virtio_mmio_common.h"
> =20
> =20
> =20
> @@ -77,24 +76,6 @@
> =20
> =20
> =20
> -#define to_virtio_mmio_device(_plat_dev) \
> -=09container_of(_plat_dev, struct virtio_mmio_device, vdev)
> -
> -struct virtio_mmio_device {
> -=09struct virtio_device vdev;
> -=09struct platform_device *pdev;
> -
> -=09void __iomem *base;
> -=09unsigned long version;
> -
> -=09/* a list of queues so we can dispatch IRQs */
> -=09spinlock_t lock;
> -=09struct list_head virtqueues;
> -
> -=09unsigned short notify_base;
> -=09unsigned short notify_multiplier;
> -};
> -
>  struct virtio_mmio_vq_info {
>  =09/* the actual virtqueue */
>  =09struct virtqueue *vq;
> diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_=
mmio_common.h
> new file mode 100644
> index 0000000..90cb304
> --- /dev/null
> +++ b/drivers/virtio/virtio_mmio_common.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> +/*
> + * Virtio MMIO driver - common functionality for all device versions
> + *
> + * This module allows virtio devices to be used over a memory-mapped dev=
ice.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/virtio.h>
> +
> +#define to_virtio_mmio_device(_plat_dev) \
> +=09container_of(_plat_dev, struct virtio_mmio_device, vdev)
> +
> +struct virtio_mmio_device {
> +=09struct virtio_device vdev;
> +=09struct platform_device *pdev;
> +
> +=09void __iomem *base;
> +=09unsigned long version;
> +
> +=09/* a list of queues so we can dispatch IRQs */
> +=09spinlock_t lock;
> +=09struct list_head virtqueues;
> +
> +=09unsigned short notify_base;
> +=09unsigned short notify_multiplier;
> +};
> +
> +#endif
> --=20
> 1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

