Return-Path: virtio-dev-return-7809-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77EBE985DC3
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 Sep 2020 08:48:27 +0000 (UTC)
Date: Fri, 25 Sep 2020 10:48:06 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200925084806.GB490533@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
Subject: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> Add a topology description to the virtio-iommu driver and enable x86
> platforms.
> 
> Since [v2] we have made some progress on adding ACPI support for
> virtio-iommu, which is the preferred boot method on x86. It will be a
> new vendor-agnostic table describing para-virtual topologies in a
> minimal format. However some platforms don't use either ACPI or DT for
> booting (for example microvm), and will need the alternative topology
> description method proposed here. In addition, since the process to get
> a new ACPI table will take a long time, this provides a boot method even
> to ACPI-based platforms, if only temporarily for testing and
> development.
> 
> v3:
> * Add patch 1 that moves virtio-iommu to a subfolder.
> * Split the rest:
>   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
>     support.
>   * Patch 4 adds definitions.
>   * Patch 5 adds parser in topology.c.
> * Address other comments.
> 
> Linux and QEMU patches available at:
> https://jpbrucker.net/git/linux virtio-iommu/devel
> https://jpbrucker.net/git/qemu virtio-iommu/devel

I'm parking this work again, until we make progress on the ACPI table, or
until a platform without ACPI and DT needs it. Until then, I've pushed v4
to my virtio-iommu/topo branch and will keep it rebased on master.

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

