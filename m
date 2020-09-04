Return-Path: virtio-dev-return-7762-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63F26985EE1
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Sep 2020 15:30:05 +0000 (UTC)
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-2-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <894aa803-644b-b6f2-2a28-73c388430ac6@redhat.com>
Date: Fri, 4 Sep 2020 17:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200821131540.2801801-2-jean-philippe@linaro.org>
Subject: [virtio-dev] Re: [PATCH v3 1/6] iommu/virtio: Move to drivers/iommu/virtio/
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jean,

On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> Before adding new files to the virtio-iommu driver, move it to its own
> subfolder, similarly to other IOMMU drivers.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/Makefile                    | 3 +--
>  drivers/iommu/virtio/Makefile             | 2 ++
>  drivers/iommu/{ => virtio}/virtio-iommu.c | 0
>  MAINTAINERS                               | 2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iommu/virtio/Makefile
>  rename drivers/iommu/{ => virtio}/virtio-iommu.c (100%)
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 11f1771104f3..fc7523042512 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y += amd/ intel/ arm/
> +obj-y += amd/ intel/ arm/ virtio/
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> @@ -26,4 +26,3 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> -obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
> new file mode 100644
> index 000000000000..279368fcc074
> --- /dev/null
> +++ b/drivers/iommu/virtio/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio/virtio-iommu.c
> similarity index 100%
> rename from drivers/iommu/virtio-iommu.c
> rename to drivers/iommu/virtio/virtio-iommu.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..3602b223c9b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18451,7 +18451,7 @@ VIRTIO IOMMU DRIVER
>  M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
> -F:	drivers/iommu/virtio-iommu.c
> +F:	drivers/iommu/virtio/
>  F:	include/uapi/linux/virtio_iommu.h
not related to this patch but you may add an entry for
Documentation/devicetree/bindings/virtio/iommu.txt

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  
>  VIRTIO MEM DRIVER
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

