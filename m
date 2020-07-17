Return-Path: virtio-dev-return-7579-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F3AB986096
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 08:50:52 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:50:37 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200717085037.GB4850@myrica>
References: <20200709154049.599993-1-jean-philippe@linaro.org>
 <174235a8-1560-86ad-f31a-799b15484d39@redhat.com>
MIME-Version: 1.0
In-Reply-To: <174235a8-1560-86ad-f31a-799b15484d39@redhat.com>
Subject: [virtio-dev] Re: [PATCH virtio] virtio-iommu: Add built-in topology description
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Auger Eric <eric.auger@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, joro@8bytes.org, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 15, 2020 at 10:52:30AM +0200, Auger Eric wrote:
> > +If the VIRTIO_IOMMU_F_TOPOLOGY feature is negotiated, \field{topo_config}
> > +describes the topology description array. \field{topo_config.offset} is
> > +the offset between the beginning of the device-specific configuration
> > +space (struct virtio_iommu_config) and the array. The array is composed of
> > +\field{topo_config.num_items} topology structures. A topology structure
> > +defines the endpoint ID of one or more endpoints managed by the
> > +virtio-iommu device. Each structure has a \field{length} field, which
> > +defines the offset to the next structure.
> 
> If this is an offset, then you may precise what the offset is relative
> to (I guess the beginning of the current topology structure).

Ok, changing it to "which defines the offset from the beginning of the
structure to the beginning of the next one".

> Otherwise
> the structure only has fixed size elements so is its length expected to
> vary?

Length is only for backward compatibility: if a future version of the spec
appends new elements to the structure, then the current driver can ignore
those elements and jump to the next structure (like argsz in VFIO, and the
PROBE property length).

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

