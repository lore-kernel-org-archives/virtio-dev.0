Return-Path: virtio-dev-return-7801-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1266985D89
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Sep 2020 08:33:26 +0000 (UTC)
Date: Thu, 24 Sep 2020 10:33:06 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200924083306.GB170808@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-6-jean-philippe@linaro.org>
 <a52f8a2e-3453-eadf-9761-fd92a20c20f5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a52f8a2e-3453-eadf-9761-fd92a20c20f5@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Auger Eric <eric.auger@redhat.com>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 04, 2020 at 06:05:35PM +0200, Auger Eric wrote:
> > +static inline int viommu_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> > +					     struct viommu_cap_config *cap)
> not sure the inline is useful here

No, I'll drop it

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

