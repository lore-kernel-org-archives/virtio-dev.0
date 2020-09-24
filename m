Return-Path: virtio-dev-return-7803-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05357985D89
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Sep 2020 09:38:24 +0000 (UTC)
Date: Thu, 24 Sep 2020 05:38:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200924053159-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924092129.GH27174@8bytes.org>
Subject: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Joerg Roedel <joro@8bytes.org>
Cc: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > OK so this looks good. Can you pls repost with the minor tweak
> > suggested and all acks included, and I will queue this?
> 
> My NACK still stands, as long as a few questions are open:
> 
> 	1) The format used here will be the same as in the ACPI table? I
> 	   think the answer to this questions must be Yes, so this leads
> 	   to the real question:

I am not sure it's a must.
We can always tweak the parser if there are slight differences
between ACPI and virtio formats.

But we do want the virtio format used here to be approved by the virtio
TC, so it won't change.

Eric, Jean-Philippe, does one of you intend to create a github issue
and request a ballot for the TC? It's been posted end of August with no
changes ...

> 	2) Has the ACPI table format stabalized already? If and only if
> 	   the answer is Yes I will Ack these patches. We don't need to
> 	   wait until the ACPI table format is published in a
> 	   specification update, but at least some certainty that it
> 	   will not change in incompatible ways anymore is needed.
> 

Not that I know, but I don't see why it's a must.

> So what progress has been made with the ACPI table specification, is it
> just a matter of time to get it approved or are there concerns?
> 
> Regards,
> 
> 	Joerg


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

