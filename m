Return-Path: virtio-dev-return-6719-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35924985D08
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 11:14:53 +0000 (UTC)
Date: Tue, 11 Feb 2020 06:14:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200211061148-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <946b71e77a34666a9b8c419c5a467d1628b50fa0.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <946b71e77a34666a9b8c419c5a467d1628b50fa0.1581305609.git.zhabin@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2 5/5] x86: virtio-mmio: support virtio-mmio with MSI
 for x86
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com, jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 10, 2020 at 05:05:21PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> virtio-mmio supports a generic MSI irq domain for all archs. This
> patch adds the x86 architecture support.
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/kernel/apic/msi.c | 11 ++++++++++-

Patches like this need to CC x86 maintainers.


>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 159bd0c..2fcd602 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -45,7 +45,11 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg,=
 struct msi_msg *msg)
>  =09=09MSI_DATA_VECTOR(cfg->vector);
>  }
> =20
> -static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *m=
sg)
> +/*
> + * x86 PCI-MSI/HPET/DMAR related method.
> + * Also can be used as arch specific method for virtio-mmio MSI.
> + */
> +void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  =09__irq_msi_compose_msg(irqd_cfg(data), msg);
>  }
> @@ -166,6 +170,11 @@ static void irq_msi_update_msg(struct irq_data *irqd=
, struct irq_cfg *cfg)
>  =09return ret;
>  }
> =20
> +struct irq_domain *arch_msi_root_irq_domain(void)
> +{
> +=09return x86_vector_domain;
> +}
> +
>  /*
>   * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
>   * which implement the MSI or MSI-X Capability Structure.


So there's a new non-static functions with no callers here,
and a previously static irq_msi_compose_msg is not longer
static. No callers so how does this help anyone?
And how does this achieve the goal of enabling virtio mmio?


> --=20
> 1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

