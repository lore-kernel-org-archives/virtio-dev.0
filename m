Return-Path: virtio-dev-return-7763-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD91D985EE1
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Sep 2020 15:31:03 +0000 (UTC)
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-5-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a9f99946-cdfc-a0f5-b742-2b89a6bd9569@redhat.com>
Date: Fri, 4 Sep 2020 17:30:47 +0200
MIME-Version: 1.0
In-Reply-To: <20200821131540.2801801-5-jean-philippe@linaro.org>
Subject: [virtio-dev] Re: [PATCH v3 4/6] iommu/virtio: Add topology definitions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jean,

On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> Add struct definitions for describing endpoints managed by the
> virtio-iommu. When VIRTIO_IOMMU_F_TOPOLOGY is offered, an array of
> virtio_iommu_topo_* structures in config space describes the endpoints,
> identified either by their PCI BDF or their physical MMIO address.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  include/uapi/linux/virtio_iommu.h | 44 +++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..70cba30644d5 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
> +#define VIRTIO_IOMMU_F_TOPOLOGY			6
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> @@ -27,6 +28,17 @@ struct virtio_iommu_range_32 {
>  	__le32					end;
>  };
>  
> +struct virtio_iommu_topo_config {
> +	/* Number of topology description structures */
> +	__le16					count;
> +	/*
> +	 * Offset to the first topology description structure
> +	 * (virtio_iommu_topo_*) from the start of the virtio_iommu config
> +	 * space. Aligned on 8 bytes.
> +	 */
> +	__le16					offset;
> +};
> +
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
>  	__le64					page_size_mask;
> @@ -36,6 +48,38 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	struct virtio_iommu_topo_config		topo_config;
> +};
> +
> +#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
> +#define VIRTIO_IOMMU_TOPO_MMIO			0x2
> +
> +struct virtio_iommu_topo_pci_range {
> +	/* VIRTIO_IOMMU_TOPO_PCI_RANGE */
> +	__u8					type;
> +	__u8					reserved;
> +	/* Length of this structure */
> +	__le16					length;
> +	/* First endpoint ID in the range */
> +	__le32					endpoint_start;
> +	/* PCI domain number */
> +	__le16					segment;
> +	/* PCI Bus:Device.Function range */
> +	__le16					bdf_start;
> +	__le16					bdf_end;
> +	__le16					padding;
> +};
> +
> +struct virtio_iommu_topo_mmio {
> +	/* VIRTIO_IOMMU_TOPO_MMIO */
> +	__u8					type;
> +	__u8					reserved;
> +	/* Length of this structure */
> +	__le16					length;
> +	/* Endpoint ID */
> +	__le32					endpoint;
> +	/* Address of the first MMIO region */
> +	__le64					address;
>  };
>  
>  /* Request types */
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

