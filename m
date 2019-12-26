Return-Path: virtio-dev-return-6572-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D246B985D91
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Dec 2019 08:22:10 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <c0919551d21bf519b05e00e6a924cbde95c5df32.1577240905.git.zhabin@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <24ef34fd-f4fe-f0eb-33e1-42fad623eee9@redhat.com>
Date: Thu, 26 Dec 2019 16:21:11 +0800
MIME-Version: 1.0
In-Reply-To: <c0919551d21bf519b05e00e6a924cbde95c5df32.1577240905.git.zhabin@linux.alibaba.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 1/2] x86/msi: Enhance x86 to support platform_msi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>
> The x86 platform currently only supports specific MSI/MSI-x for PCI
> devices. To enable MSI to the platform devices such as virtio-mmio
> device, this patch enhances x86 with platform MSI by leveraging the
> already built-in platform-msi driver (drivers/base/platform-msi.c)
> and makes it as a configurable option.
>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>   arch/x86/Kconfig                 |  6 ++++
>   arch/x86/include/asm/hw_irq.h    |  5 +++
>   arch/x86/include/asm/irqdomain.h |  9 +++++
>   arch/x86/kernel/apic/msi.c       | 74 +++++++++++++++++++++++++++++++++=
+++++++
>   drivers/base/platform-msi.c      |  4 +--
>   include/linux/msi.h              |  1 +
>   6 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e89499..c1178f2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1074,6 +1074,12 @@ config X86_IO_APIC
>   =09def_bool y
>   =09depends on X86_LOCAL_APIC || X86_UP_IOAPIC
>  =20
> +config X86_PLATFORM_MSI
> +=09def_bool y
> +=09depends on X86_LOCAL_APIC && X86_64
> +=09select GENERIC_MSI_IRQ
> +=09select GENERIC_MSI_IRQ_DOMAIN
> +
>   config X86_REROUTE_FOR_BROKEN_BOOT_IRQS
>   =09bool "Reroute for broken boot IRQs"
>   =09depends on X86_IO_APIC
> diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.=
h
> index 4154bc5..5c96b49 100644
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -113,6 +113,11 @@ struct irq_alloc_info {
>   =09=09=09struct msi_desc *desc;
>   =09=09};
>   #endif
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +=09=09struct {
> +=09=09=09irq_hw_number_t=09platform_msi_hwirq;
> +=09=09};
> +#endif
>   =09};
>   };
>  =20
> diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqd=
omain.h
> index c066ffa..b53f51f 100644
> --- a/arch/x86/include/asm/irqdomain.h
> +++ b/arch/x86/include/asm/irqdomain.h
> @@ -56,4 +56,13 @@ extern void mp_irqdomain_deactivate(struct irq_domain =
*domain,
>   static inline void arch_init_msi_domain(struct irq_domain *domain) { }
>   #endif
>  =20
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +extern struct irq_domain *platform_msi_get_def_irq_domain(void);
> +#else
> +static inline struct irq_domain *platform_msi_get_def_irq_domain(void)
> +{
> +=09return NULL;
> +}
> +#endif
> +
>   #endif
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 7f75334..ef558c7 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -22,6 +22,10 @@
>   #include <asm/irq_remapping.h>
>  =20
>   static struct irq_domain *msi_default_domain;
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +static struct irq_domain *platform_msi_default_domain;
> +static struct msi_domain_info platform_msi_domain_info;
> +#endif
>  =20
>   static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *=
msg)
>   {
> @@ -146,6 +150,17 @@ void __init arch_init_msi_domain(struct irq_domain *=
parent)
>   =09}
>   =09if (!msi_default_domain)
>   =09=09pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +=09fn =3D irq_domain_alloc_named_fwnode("PLATFORM-MSI");
> +=09if (fn) {
> +=09=09platform_msi_default_domain =3D
> +=09=09=09platform_msi_create_irq_domain(fn,
> +=09=09=09=09&platform_msi_domain_info, parent);
> +=09=09irq_domain_free_fwnode(fn);
> +=09}
> +=09if (!platform_msi_default_domain)
> +=09=09pr_warn("failed to initialize irqdomain for PLATFORM-MSI.\n");
> +#endif
>   }
>  =20
>   #ifdef CONFIG_IRQ_REMAP
> @@ -384,3 +399,62 @@ int hpet_assign_irq(struct irq_domain *domain, struc=
t hpet_channel *hc,
>   =09return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
>   }
>   #endif
> +
> +#ifdef CONFIG_X86_PLATFORM_MSI
> +static void platform_msi_mask_irq(struct irq_data *data)
> +{
> +}
> +
> +static void platform_msi_unmask_irq(struct irq_data *data)
> +{
> +}
> +
> +static struct irq_chip platform_msi_controller =3D {
> +=09.name=09=09=09=3D "PLATFORM-MSI",
> +=09.irq_mask=09=09=3D platform_msi_mask_irq,
> +=09.irq_unmask=09=09=3D platform_msi_unmask_irq,
> +=09.irq_ack=09=09=3D irq_chip_ack_parent,
> +=09.irq_retrigger=09=09=3D irq_chip_retrigger_hierarchy,
> +=09.irq_compose_msi_msg=09=3D irq_msi_compose_msg,
> +=09.flags=09=09=09=3D IRQCHIP_SKIP_SET_WAKE,


Except for irq_msi_compose_msg all the rest were arch independent. Can=20
we have allow arch to specify irq_compose_msi_msg then we can unfiy the=20
rest for all archs?


> +};
> +
> +static int platform_msi_prepare(struct irq_domain *domain, struct device=
 *dev,
> +=09=09=09=09int nvec, msi_alloc_info_t *arg)
> +{
> +=09memset(arg, 0, sizeof(*arg));
> +=09return 0;
> +}
> +
> +static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc=
 *desc)
> +{
> +=09arg->platform_msi_hwirq =3D platform_msi_calc_hwirq(desc);
> +}
> +
> +static irq_hw_number_t platform_msi_get_hwirq(struct msi_domain_info *in=
fo,
> +=09=09=09=09=09      msi_alloc_info_t *arg)
> +{
> +=09return arg->platform_msi_hwirq;
> +}
> +
> +static struct msi_domain_ops platform_msi_domain_ops =3D {
> +=09.msi_prepare=09=3D platform_msi_prepare,
> +=09.set_desc=09=3D platform_msi_set_desc,
> +=09.get_hwirq=09=3D platform_msi_get_hwirq,
> +};
> +
> +static struct msi_domain_info platform_msi_domain_info =3D {
> +=09.flags          =3D MSI_FLAG_USE_DEF_DOM_OPS |
> +=09=09=09  MSI_FLAG_USE_DEF_CHIP_OPS |
> +=09=09=09  MSI_FLAG_ACTIVATE_EARLY,
> +=09.ops            =3D &platform_msi_domain_ops,
> +=09.chip           =3D &platform_msi_controller,
> +=09.handler        =3D handle_edge_irq,
> +=09.handler_name   =3D "edge",
> +};


Is this better to have a virtio-mmio specific domain and irq_chip? It=20
looks to me the advantages are:

- works for all archs
- allow virtio-mmio specific method to do e.g mask/unmask.

Thanks


> +
> +struct irq_domain *platform_msi_get_def_irq_domain(void)
> +{
> +=09return platform_msi_default_domain;
> +}
> +#endif
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 8da314b..45752f1 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -31,12 +31,11 @@ struct platform_msi_priv_data {
>   /* The devid allocator */
>   static DEFINE_IDA(platform_msi_devid_ida);
>  =20
> -#ifdef GENERIC_MSI_DOMAIN_OPS
>   /*
>    * Convert an msi_desc to a globaly unique identifier (per-device
>    * devid + msi_desc position in the msi_list).
>    */
> -static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>   {
>   =09u32 devid;
>  =20
> @@ -45,6 +44,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct m=
si_desc *desc)
>   =09return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
>   }
>  =20
> +#ifdef GENERIC_MSI_DOMAIN_OPS
>   static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_des=
c *desc)
>   {
>   =09arg->desc =3D desc;
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8ad679e..ee5f566 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -362,6 +362,7 @@ int platform_msi_domain_alloc(struct irq_domain *doma=
in, unsigned int virq,
>   void platform_msi_domain_free(struct irq_domain *domain, unsigned int v=
irq,
>   =09=09=09      unsigned int nvec);
>   void *platform_msi_get_host_data(struct irq_domain *domain);
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc);
>   #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  =20
>   #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

