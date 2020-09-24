Return-Path: virtio-dev-return-7805-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42380985D89
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Sep 2020 10:25:04 +0000 (UTC)
Date: Thu, 24 Sep 2020 12:24:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200924102446.icsdv2yhof4nbnec@sirius.home.kraxel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924100255.GM27174@8bytes.org>
Subject: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, bhelgaas@google.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 24, 2020 at 12:02:55PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:38:13AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > > > OK so this looks good. Can you pls repost with the minor tweak
> > > > suggested and all acks included, and I will queue this?
> > > 
> > > My NACK still stands, as long as a few questions are open:
> > > 
> > > 	1) The format used here will be the same as in the ACPI table? I
> > > 	   think the answer to this questions must be Yes, so this leads
> > > 	   to the real question:
> > 
> > I am not sure it's a must.
> 
> It is, having only one parser for the ACPI and MMIO descriptions was one
> of the selling points for MMIO in past discussions and I think it makes
> sense to keep them in sync.

So that requirement basically kills the "we have something to play with
while the acpi table spec is in progress" argument.  Also note that qemu
microvm got acpi support meanwhile.

Are there other cases where neither ACPI nor DT are available?

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

