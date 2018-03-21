Return-Path: virtio-dev-return-3622-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A790F5818D93
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Mar 2018 23:44:33 -0700 (PDT)
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 21 Mar 2018 06:43:35 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19108B0FE@SHSMSX101.ccr.corp.intel.com>
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
 <20180214145340.1223-2-jean-philippe.brucker@arm.com>
In-Reply-To: <20180214145340.1223-2-jean-philippe.brucker@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH 1/4] iommu: Add virtio-iommu driver
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Wednesday, February 14, 2018 10:54 PM
>=20
> The virtio IOMMU is a para-virtualized device, allowing to send IOMMU
> requests such as map/unmap over virtio-mmio transport without
> emulating
> page tables. This implementation handles ATTACH, DETACH, MAP and
> UNMAP
> requests.
>=20
> The bulk of the code transforms calls coming from the IOMMU API into
> corresponding virtio requests. Mappings are kept in an interval tree
> instead of page tables.
>=20
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[...]
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> new file mode 100644
> index 000000000000..a9c9245e8ba2
> --- /dev/null
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -0,0 +1,960 @@
> +/*
> + * Virtio driver for the paravirtualized IOMMU
> + *
> + * Copyright (C) 2018 ARM Limited
> + * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/amba/bus.h>
> +#include <linux/delay.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/freezer.h>
> +#include <linux/interval_tree.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/wait.h>
> +
> +#include <uapi/linux/virtio_iommu.h>
> +
> +#define MSI_IOVA_BASE			0x8000000
> +#define MSI_IOVA_LENGTH			0x100000

this is ARM specific, and according to virtio-iommu spec isn't it
better probed on the endpoint instead of hard-coding here?

Thanks
Kevin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

