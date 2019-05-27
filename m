Return-Path: virtio-dev-return-5754-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D440985C6E
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 May 2019 15:15:37 +0000 (UTC)
Date: Mon, 27 May 2019 11:15:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190527111345-mutt-send-email-mst@kernel.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190512123022-mutt-send-email-mst@kernel.org>
 <20190527092604.GB21613@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527092604.GB21613@8bytes.org>
Subject: [virtio-dev] Re: [PATCH v7 0/7] Add virtio-iommu driver
To: Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com, bhelgaas@google.com, frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com, tnowicki@caviumnetworks.com, kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 27, 2019 at 11:26:04AM +0200, Joerg Roedel wrote:
> On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
> > OK this has been in next for a while.
> > 
> > Last time IOMMU maintainers objected. Are objections
> > still in force?
> > 
> > If not could we get acks please?
> 
> No objections against the code, I only hesitated because the Spec was
> not yet official.
> 
> So for the code:
> 
> 	Acked-by: Joerg Roedel <jroedel@suse.de>

Last spec patch had a bunch of comments not yet addressed.
But I do not remember whether comments are just about wording
or about the host/guest interface as well.
Jean-Philippe could you remind me please?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

