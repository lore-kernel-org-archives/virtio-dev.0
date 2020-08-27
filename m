Return-Path: virtio-dev-return-7730-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32FA5985E29
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Aug 2020 08:01:45 +0000 (UTC)
Date: Thu, 27 Aug 2020 10:01:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200827080125.GC3399702@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200826092542-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200826092542-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, kevin.tian@intel.com, sebastien.boeuf@intel.com, bhelgaas@google.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 26, 2020 at 09:26:02AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> 
> OK should I park this in next now? Seems appropriate ...

Yes that sounds like a good idea. It could uncover new bugs since there is
more automated testing happening for x86.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

