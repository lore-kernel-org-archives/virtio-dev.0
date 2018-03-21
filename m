Return-Path: virtio-dev-return-3624-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CDB7F5818F5E
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Mar 2018 06:10:57 -0700 (PDT)
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
 <20180214145340.1223-2-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19108B0FE@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <a11f1b52-c031-014c-8c23-1732f3d4666c@arm.com>
Date: Wed, 21 Mar 2018 13:14:04 +0000
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19108B0FE@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 1/4] iommu: Add virtio-iommu driver
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>
List-ID: <virtio-dev.lists.oasis-open.org>

On 21/03/18 06:43, Tian, Kevin wrote:
[...]
>> +
>> +#include <uapi/linux/virtio_iommu.h>
>> +
>> +#define MSI_IOVA_BASE			0x8000000
>> +#define MSI_IOVA_LENGTH			0x100000
> 
> this is ARM specific, and according to virtio-iommu spec isn't it
> better probed on the endpoint instead of hard-coding here?

These values are arbitrary, not really ARM-specific even if ARM is the
only user yet: we're just reserving a random IOVA region for mapping MSIs.
It is hard-coded because of the way iommu-dma.c works, but I don't quite
remember why that allocation isn't dynamic.

As said on the v0.6 spec thread, I'm not sure allocating the IOVA range in
the host is preferable. With nested translation the guest has to map it
anyway, and I believe dealing with IOVA allocation should be left to the
guest when possible.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

