Return-Path: virtio-dev-return-7810-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9A77985DC3
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 Sep 2020 10:22:27 +0000 (UTC)
Date: Fri, 25 Sep 2020 06:22:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200925062122-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
 <20200924083918-mutt-send-email-mst@kernel.org>
 <20200924125046.GR27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924125046.GR27174@8bytes.org>
Subject: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Joerg Roedel <joro@8bytes.org>
Cc: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 24, 2020 at 02:50:46PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 08:41:21AM -0400, Michael S. Tsirkin wrote:
> > But this has nothing to do with Linux.  There is also no guarantee that
> > the two committees will decide to use exactly the same format. Once one
> > of them sets the format in stone, we can add support for that format to
> > linux. If another one is playing nice and uses the same format, we can
> > use the same parsers. If it doesn't linux will have to follow suit.
> 
> Or Linux decides to support only one of the formats, which would then be
> ACPI.
> 
> Regards,
> 
> 	Joerg

It's really up to hypervisors not guests, linux as a guest can for sure
refuse to work somewhere, but that's normally not very attractive.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

