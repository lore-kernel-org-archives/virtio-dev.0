Return-Path: virtio-dev-return-6738-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BE58985DC3
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Feb 2020 07:40:15 +0000 (UTC)
Date: Wed, 12 Feb 2020 02:40:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200212023540-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2 3/5] virtio-mmio: create a generic MSI irq domain
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com, jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 10, 2020 at 05:05:19PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> Create a generic irq domain for all architectures which
> supports virtio-mmio. The device offering VIRTIO_F_MMIO_MSI
> feature bit can use this irq domain.
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  drivers/base/platform-msi.c      |  4 +-
>  drivers/virtio/Kconfig           |  9 ++++
>  drivers/virtio/virtio_mmio_msi.h | 93 ++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/msi.h              |  1 +
>  4 files changed, 105 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/virtio/virtio_mmio_msi.h
>=20
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 8da314b..45752f1 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -31,12 +31,11 @@ struct platform_msi_priv_data {
>  /* The devid allocator */
>  static DEFINE_IDA(platform_msi_devid_ida);
> =20
> -#ifdef GENERIC_MSI_DOMAIN_OPS
>  /*
>   * Convert an msi_desc to a globaly unique identifier (per-device
>   * devid + msi_desc position in the msi_list).
>   */
> -static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>  {
>  =09u32 devid;
> =20
> @@ -45,6 +44,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct m=
si_desc *desc)
>  =09return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
>  }
> =20
> +#ifdef GENERIC_MSI_DOMAIN_OPS
>  static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc=
 *desc)
>  {
>  =09arg->desc =3D desc;
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 078615c..551a9f7 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -84,6 +84,15 @@ config VIRTIO_MMIO
> =20
>   =09 If unsure, say N.
> =20
> +config VIRTIO_MMIO_MSI
> +=09bool "Memory-mapped virtio device MSI"
> +=09depends on VIRTIO_MMIO && GENERIC_MSI_IRQ_DOMAIN && GENERIC_MSI_IRQ
> +=09help
> +=09 This allows device drivers to support msi interrupt handling for
> +=09 virtio-mmio devices. It can improve performance greatly.
> +
> +=09 If unsure, say N.
> +
>  config VIRTIO_MMIO_CMDLINE_DEVICES
>  =09bool "Memory mapped virtio devices parameter parsing"
>  =09depends on VIRTIO_MMIO
> diff --git a/drivers/virtio/virtio_mmio_msi.h b/drivers/virtio/virtio_mmi=
o_msi.h
> new file mode 100644
> index 0000000..27cb2af
> --- /dev/null
> +++ b/drivers/virtio/virtio_mmio_msi.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
> +
> +#ifdef CONFIG_VIRTIO_MMIO_MSI
> +
> +#include <linux/msi.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +
> +static irq_hw_number_t mmio_msi_hwirq;
> +static struct irq_domain *mmio_msi_domain;

So each instance of including this header will create its own
copy of the variables. That won't do the right thing.


> +
> +struct irq_domain *__weak arch_msi_root_irq_domain(void)
> +{
> +=09return NULL;
> +}
> +
> +void __weak irq_msi_compose_msg(struct irq_data *data, struct msi_msg *m=
sg)
> +{
> +}
> +
> +static void mmio_msi_mask_irq(struct irq_data *data)
> +{
> +}
> +
> +static void mmio_msi_unmask_irq(struct irq_data *data)
> +{
> +}
> +
> +static struct irq_chip mmio_msi_controller =3D {
> +=09.name=09=09=09=3D "VIRTIO-MMIO-MSI",
> +=09.irq_mask=09=09=3D mmio_msi_mask_irq,
> +=09.irq_unmask=09=09=3D mmio_msi_unmask_irq,
> +=09.irq_ack=09=09=3D irq_chip_ack_parent,
> +=09.irq_retrigger=09=09=3D irq_chip_retrigger_hierarchy,
> +=09.irq_compose_msi_msg=09=3D irq_msi_compose_msg,
> +=09.flags=09=09=09=3D IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int mmio_msi_prepare(struct irq_domain *domain, struct device *de=
v,
> +=09=09=09=09int nvec, msi_alloc_info_t *arg)
> +{
> +=09memset(arg, 0, sizeof(*arg));
> +=09return 0;
> +}
> +
> +static void mmio_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *de=
sc)
> +{
> +=09mmio_msi_hwirq =3D platform_msi_calc_hwirq(desc);
> +}
> +
> +static irq_hw_number_t mmio_msi_get_hwirq(struct msi_domain_info *info,
> +=09=09=09=09=09      msi_alloc_info_t *arg)
> +{
> +=09return mmio_msi_hwirq;
> +}
> +
> +static struct msi_domain_ops mmio_msi_domain_ops =3D {
> +=09.msi_prepare=09=3D mmio_msi_prepare,
> +=09.set_desc=09=3D mmio_msi_set_desc,
> +=09.get_hwirq=09=3D mmio_msi_get_hwirq,
> +};
> +
> +static struct msi_domain_info mmio_msi_domain_info =3D {
> +=09.flags          =3D MSI_FLAG_USE_DEF_DOM_OPS |
> +=09=09=09  MSI_FLAG_USE_DEF_CHIP_OPS |
> +=09=09=09  MSI_FLAG_ACTIVATE_EARLY,
> +=09.ops            =3D &mmio_msi_domain_ops,
> +=09.chip           =3D &mmio_msi_controller,
> +=09.handler        =3D handle_edge_irq,
> +=09.handler_name   =3D "edge",
> +};
> +
> +static inline void mmio_msi_create_irq_domain(void)
> +{
> +=09struct fwnode_handle *fn;
> +=09struct irq_domain *parent =3D arch_msi_root_irq_domain();
> +
> +=09fn =3D irq_domain_alloc_named_fwnode("VIRTIO-MMIO-MSI");
> +=09if (fn && parent) {
> +=09=09mmio_msi_domain =3D
> +=09=09=09platform_msi_create_irq_domain(fn,
> +=09=09=09=09&mmio_msi_domain_info, parent);
> +=09=09irq_domain_free_fwnode(fn);
> +=09}
> +}

It does not look like anyone cleans up this domain.
So how does this work with a modular virtio mmio?
what happens when you unload the module?


> +#else
> +static inline void mmio_msi_create_irq_domain(void) {}
> +#endif
> +
> +#endif
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8ad679e..ee5f566 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -362,6 +362,7 @@ int platform_msi_domain_alloc(struct irq_domain *doma=
in, unsigned int virq,
>  void platform_msi_domain_free(struct irq_domain *domain, unsigned int vi=
rq,
>  =09=09=09      unsigned int nvec);
>  void *platform_msi_get_host_data(struct irq_domain *domain);
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc);
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
> =20
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> --=20
> 1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

