Return-Path: virtio-dev-return-7196-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13F23985E66
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Apr 2020 16:18:06 +0000 (UTC)
Date: Tue, 28 Apr 2020 12:17:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200428121232-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
Subject: [virtio-dev] Re: [PATCH 5/5] virtio: Add bounce DMA ops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: konrad.wilk@oracle.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 28, 2020 at 05:09:18PM +0530, Srivatsa Vaddagiri wrote:
> For better security, its desirable that a guest VM's memory is
> not accessible to any entity that executes outside the context of
> guest VM. In case of virtio, backend drivers execute outside the
> context of guest VM and in general will need access to complete
> guest VM memory.  One option to restrict the access provided to
> backend driver is to make use of a bounce buffer. The bounce
> buffer is accessible to both backend and frontend drivers. All IO
> buffers that are in private space of guest VM are bounced to be
> accessible to backend.
>=20
> This patch proposes a new memory pool to be used for this bounce
> purpose, rather than the default swiotlb memory pool. That will
> avoid any conflicts that may arise in situations where a VM needs
> to use swiotlb pool for driving any pass-through devices (in
> which case swiotlb memory needs not be shared with another VM) as
> well as virtio devices (which will require swiotlb memory to be
> shared with backend VM). As a possible extension to this patch,
> we can provide an option for virtio to make use of default
> swiotlb memory pool itself, where no such conflicts may exist in
> a given deployment.
>=20
> Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>


Okay, but how is all this virtio specific?  For example, why not allow
separate swiotlbs for any type of device?
For example, this might make sense if a given device is from a
different, less trusted vendor.
All this can then maybe be hidden behind the DMA API.



> ---
>  drivers/virtio/Makefile        |   2 +-
>  drivers/virtio/virtio.c        |   2 +
>  drivers/virtio/virtio_bounce.c | 150 +++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/virtio.h         |   4 ++
>  4 files changed, 157 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virtio/virtio_bounce.c
>=20
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 29a1386e..3fd3515 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_VIRTIO) +=3D virtio.o virtio_ring.o
> +obj-$(CONFIG_VIRTIO) +=3D virtio.o virtio_ring.o virtio_bounce.o
>  obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio_mmio.o
>  obj-$(CONFIG_VIRTIO_PCI) +=3D virtio_pci.o
>  virtio_pci-y :=3D virtio_pci_modern.o virtio_pci_common.o
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32..bc2f779 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -329,6 +329,7 @@ int register_virtio_device(struct virtio_device *dev)
> =20
>  =09dev->index =3D err;
>  =09dev_set_name(&dev->dev, "virtio%u", dev->index);
> +=09virtio_bounce_set_dma_ops(dev);
> =20
>  =09spin_lock_init(&dev->config_lock);
>  =09dev->config_enabled =3D false;
> @@ -431,6 +432,7 @@ EXPORT_SYMBOL_GPL(virtio_device_restore);
> =20
>  static int virtio_init(void)
>  {
> +=09virtio_map_bounce_buffer();
>  =09if (bus_register(&virtio_bus) !=3D 0)
>  =09=09panic("virtio bus registration failed");
>  =09return 0;
> diff --git a/drivers/virtio/virtio_bounce.c b/drivers/virtio/virtio_bounc=
e.c
> new file mode 100644
> index 0000000..3de8e0e
> --- /dev/null
> +++ b/drivers/virtio/virtio_bounce.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Virtio DMA ops to bounce buffers
> + *
> + *  Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + *
> + * This module allows bouncing of IO buffers to a region which will be
> + * accessible to backend drivers.
> + */
> +
> +#include <linux/virtio.h>
> +#include <linux/io.h>
> +#include <linux/swiotlb.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +
> +static phys_addr_t bounce_buf_paddr;
> +static void *bounce_buf_vaddr;
> +static size_t bounce_buf_size;
> +struct swiotlb_pool *virtio_pool;
> +
> +#define VIRTIO_MAX_BOUNCE_SIZE=09(16*4096)
> +
> +static void *virtio_alloc_coherent(struct device *dev, size_t size,
> +=09=09dma_addr_t *dma_handle, gfp_t gfp_flags, unsigned long attrs)
> +{
> +=09phys_addr_t addr;
> +
> +=09if (!virtio_pool)
> +=09=09return NULL;
> +
> +=09addr =3D swiotlb_alloc(virtio_pool, size, bounce_buf_paddr, ULONG_MAX=
);
> +=09if (addr =3D=3D DMA_MAPPING_ERROR)
> +=09=09return NULL;
> +
> +=09*dma_handle =3D (addr - bounce_buf_paddr);
> +
> +=09return bounce_buf_vaddr + (addr - bounce_buf_paddr);
> +}
> +
> +static void virtio_free_coherent(struct device *dev, size_t size, void *=
vaddr,
> +=09=09dma_addr_t dma_handle, unsigned long attrs)
> +{
> +=09phys_addr_t addr =3D (dma_handle + bounce_buf_paddr);
> +
> +=09swiotlb_free(virtio_pool, addr, size);
> +}
> +
> +static dma_addr_t virtio_map_page(struct device *dev, struct page *page,
> +=09=09unsigned long offset, size_t size,
> +=09=09enum dma_data_direction dir, unsigned long attrs)
> +{
> +=09void *ptr =3D page_address(page) + offset;
> +=09phys_addr_t paddr =3D virt_to_phys(ptr);
> +=09dma_addr_t handle;
> +
> +=09if (!virtio_pool)
> +=09=09return DMA_MAPPING_ERROR;
> +
> +=09handle =3D _swiotlb_tbl_map_single(virtio_pool, dev, bounce_buf_paddr=
,
> +=09=09=09=09=09 paddr, size, size, dir, attrs);
> +=09if (handle =3D=3D (phys_addr_t)DMA_MAPPING_ERROR)
> +=09=09return DMA_MAPPING_ERROR;
> +
> +=09return handle - bounce_buf_paddr;
> +}
> +
> +static void virtio_unmap_page(struct device *dev, dma_addr_t dev_addr,
> +=09=09size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +=09phys_addr_t addr =3D dev_addr + bounce_buf_paddr;
> +
> +=09_swiotlb_tbl_unmap_single(virtio_pool, dev, addr, size,
> +=09=09=09=09=09size, dir, attrs);
> +}
> +
> +size_t virtio_max_mapping_size(struct device *dev)
> +{
> +=09return VIRTIO_MAX_BOUNCE_SIZE;
> +}
> +
> +static const struct dma_map_ops virtio_dma_ops =3D {
> +=09.alloc=09=09=09=3D virtio_alloc_coherent,
> +=09.free=09=09=09=3D virtio_free_coherent,
> +=09.map_page=09=09=3D virtio_map_page,
> +=09.unmap_page=09=09=3D virtio_unmap_page,
> +=09.max_mapping_size=09=3D virtio_max_mapping_size,
> +};
> +
> +void virtio_bounce_set_dma_ops(struct virtio_device *vdev)
> +{
> +=09if (!bounce_buf_paddr)
> +=09=09return;
> +
> +=09set_dma_ops(vdev->dev.parent, &virtio_dma_ops);


I don't think DMA API maintainers will be happy with new users
of set_dma_ops.

> +}
> +
> +int virtio_map_bounce_buffer(void)
> +{
> +=09int ret;
> +
> +=09if (!bounce_buf_paddr)
> +=09=09return 0;
> +
> +=09/*
> +=09 * Map region as 'cacheable' memory. This will reduce access latency =
for
> +=09 * backend.
> +=09 */
> +=09bounce_buf_vaddr =3D memremap(bounce_buf_paddr,
> +=09=09=09=09bounce_buf_size, MEMREMAP_WB);
> +=09if (!bounce_buf_vaddr)
> +=09=09return -ENOMEM;
> +
> +=09memset(bounce_buf_vaddr, 0, bounce_buf_size);
> +=09virtio_pool =3D swiotlb_register_pool("virtio_swiotlb", bounce_buf_pa=
ddr,
> +=09=09=09=09bounce_buf_vaddr, bounce_buf_size);
> +=09if (IS_ERR(virtio_pool)) {
> +=09=09ret =3D PTR_ERR(virtio_pool);
> +=09=09virtio_pool =3D NULL;
> +=09=09memunmap(bounce_buf_vaddr);
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +int virtio_register_bounce_buffer(phys_addr_t base, size_t size)
> +{
> +=09if (bounce_buf_paddr || !base || size < PAGE_SIZE)
> +=09=09return -EINVAL;
> +
> +=09bounce_buf_paddr =3D base;
> +=09bounce_buf_size =3D size;
> +
> +=09return 0;
> +}
> +
> +static int __init virtio_bounce_setup(struct reserved_mem *rmem)
> +{
> +=09unsigned long node =3D rmem->fdt_node;
> +
> +=09if (!of_get_flat_dt_prop(node, "no-map", NULL))
> +=09=09return -EINVAL;
> +
> +=09return virtio_register_bounce_buffer(rmem->base, rmem->size);
> +}
> +
> +RESERVEDMEM_OF_DECLARE(virtio, "virtio_bounce_pool", virtio_bounce_setup=
);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index a493eac..c4970c5 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -134,12 +134,16 @@ void virtio_config_changed(struct virtio_device *de=
v);
>  void virtio_config_disable(struct virtio_device *dev);
>  void virtio_config_enable(struct virtio_device *dev);
>  int virtio_finalize_features(struct virtio_device *dev);
> +int virtio_register_bounce_buffer(phys_addr_t base, size_t size);
> +
>  #ifdef CONFIG_PM_SLEEP
>  int virtio_device_freeze(struct virtio_device *dev);
>  int virtio_device_restore(struct virtio_device *dev);
>  #endif
> =20
>  size_t virtio_max_dma_size(struct virtio_device *vdev);
> +extern int virtio_map_bounce_buffer(void);
> +extern void virtio_bounce_set_dma_ops(struct virtio_device *dev);
> =20
>  #define virtio_device_for_each_vq(vdev, vq) \
>  =09list_for_each_entry(vq, &vdev->vqs, list)
> --=20
> 2.7.4
>=20
> --=20
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

