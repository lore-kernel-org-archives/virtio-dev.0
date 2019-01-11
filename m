Return-Path: virtio-dev-return-5316-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15E41985DBD
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Jan 2019 13:00:50 +0000 (UTC)
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181212103545.GV16835@8bytes.org>
 <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
 <20190111122846.GE5825@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <08283b53-2f87-05e7-e71c-8780b34d9018@arm.com>
Date: Fri, 11 Jan 2019 13:00:30 +0000
MIME-Version: 1.0
In-Reply-To: <20190111122846.GE5825@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v6 0/7] Add virtio-iommu driver
To: Joerg Roedel <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/01/2019 12:28, Joerg Roedel wrote:
> Hi Jean-Philippe,
> 
> On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
>> We already do deferred flush: UNMAP requests are added to the queue by
>> iommu_unmap(), and then flushed out by iotlb_sync(). So we switch to the
>> host only on iotlb_sync(), or when the request queue is full.
> 
> So the mappings can stay in place until iotlb_sync() returns? What
> happens when the guest sends a map-request for a region it sent and
> unmap request before, but did not call iotlb_sync inbetween?

At that point the unmap is still in the request queue, and the host will
handle it before getting to the map request. For correctness requests
are necessarily handled in-order by the host. So if the map and unmap
refer to the same domain and IOVA, the host will remove the old mapping
before creating the new one.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

