Return-Path: virtio-dev-return-5690-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
References: <20190314153253.50945-1-jean-philippe.brucker@arm.com>
 <9ff6957a-b7bc-27e8-a7d1-cf9e3c956aa1@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <80ccc3c1-4e2d-7ee1-97c8-a2e13a90053c@redhat.com>
Date: Thu, 25 Apr 2019 13:29:17 +0200
MIME-Version: 1.0
In-Reply-To: <9ff6957a-b7bc-27e8-a7d1-cf9e3c956aa1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v2] Add virtio-iommu device specification
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: joro@8bytes.org, tnowicki@caviumnetworks.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,
On 4/23/19 1:15 PM, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 14/03/2019 15:32, Jean-Philippe Brucker wrote:
>> The IOMMU device allows a guest to manage DMA mappings for physical,
>> emulated and paravirtualized endpoints. Add device description for the
>> virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP and
>> UNMAP requests, as well as translation error reporting.
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> If there aren't any more comments on this version, could I request a
> vote? The virtio-iommu spec has been reviewed on the virtio-dev list by
> several of the people on Cc. The Linux driver has been in good shape for
> a while, but Joerg would like to see progress on this specification
> before merging it upstream. It's too late in the release cycle for Linux
> v5.2, but I'm hoping to get something in v5.3.
Is there any calendar for the "OASIS Virtual I/O Device (VIRTIO) TC" votes?

 I think the QEMU device
> will follow the Linux driver since it depends on API headers.
Yes sure I will respin the QEMU VIRTIO-IOMMU device accordingly.

Thanks

Eric
> 
> Thanks,
> Jean
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

