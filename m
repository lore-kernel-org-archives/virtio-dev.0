Return-Path: virtio-dev-return-7813-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 153BD985DC3
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 Sep 2020 13:45:10 +0000 (UTC)
Date: Fri, 25 Sep 2020 09:44:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200925094405-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
 <20200925112629.GA1337555@myrica>
MIME-Version: 1.0
In-Reply-To: <20200925112629.GA1337555@myrica>
Subject: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 25, 2020 at 01:26:29PM +0200, Jean-Philippe Brucker wrote:
> On Fri, Sep 25, 2020 at 06:22:57AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 25, 2020 at 10:48:06AM +0200, Jean-Philippe Brucker wrote:
> > > On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > > > Add a topology description to the virtio-iommu driver and enable x86
> > > > platforms.
> > > > 
> > > > Since [v2] we have made some progress on adding ACPI support for
> > > > virtio-iommu, which is the preferred boot method on x86. It will be a
> > > > new vendor-agnostic table describing para-virtual topologies in a
> > > > minimal format. However some platforms don't use either ACPI or DT for
> > > > booting (for example microvm), and will need the alternative topology
> > > > description method proposed here. In addition, since the process to get
> > > > a new ACPI table will take a long time, this provides a boot method even
> > > > to ACPI-based platforms, if only temporarily for testing and
> > > > development.
> > > > 
> > > > v3:
> > > > * Add patch 1 that moves virtio-iommu to a subfolder.
> > > > * Split the rest:
> > > >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> > > >     support.
> > > >   * Patch 4 adds definitions.
> > > >   * Patch 5 adds parser in topology.c.
> > > > * Address other comments.
> > > > 
> > > > Linux and QEMU patches available at:
> > > > https://jpbrucker.net/git/linux virtio-iommu/devel
> > > > https://jpbrucker.net/git/qemu virtio-iommu/devel
> > > 
> > > I'm parking this work again, until we make progress on the ACPI table, or
> > > until a platform without ACPI and DT needs it. Until then, I've pushed v4
> > > to my virtio-iommu/topo branch and will keep it rebased on master.
> > > 
> > > Thanks,
> > > Jean
> > 
> > I think you guys need to work on virtio spec too, not too much left to
> > do there ...
> 
> I know it's ready and I'd really like to move on with this, but I'd rather
> not commit it to the spec until we know it's going to be used at all. As
> Gerd pointed out the one example we had, microvm, now supports ACPI. Since
> we've kicked off the ACPI work anyway it isn't clear that the built-in
> topology will be useful.
> 
> Thanks,
> Jean

Many power platforms are OF based, thus without ACPI or DT support.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

