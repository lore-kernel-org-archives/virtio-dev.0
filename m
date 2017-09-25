Return-Path: virtio-dev-return-2567-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B18358182C4
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Sep 2017 06:43:17 -0700 (PDT)
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <f9b02ce1-057f-df4f-90d7-52616ad60b88@redhat.com>
 <6b56fd96-fee5-d105-5261-2e7274b4aa15@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190DDD022@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <32dc50dc-6c7f-9f08-f824-f149360ebc08@arm.com>
Date: Mon, 25 Sep 2017 14:47:27 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190DDD022@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.4
To: "Tian, Kevin" <kevin.tian@intel.com>, Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 21/09/17 07:41, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Wednesday, September 6, 2017 7:49 PM
>>
>>
>>> 2.6.8.2.1
>>> Multiple overlapping RESV_MEM properties are merged together. Device
>>> requirement? if same types I assume?
>>
>> Combination rules apply to device and driver. When the driver puts
>> multiple endpoints in the same domain, combination rules apply. They will
>> become important once the guest attempts to do things like combining
>> endpoints with different PASID capabilities in the same domain. I'm
>> considering these endpoints to be behind different physical IOMMUs.
>>
>> For reserved regions, we specify what the driver should do and what the
>> device should enforce with regard to mapping IOVAs of overlapping regions.
>> For example, if a device has some virtual address RESV_T_MSI and an other
>> device has the same virtual address RESV_T_IDENTITY, what should the
>> driver do?
>>
>> I think it should apply the RESV_T_IDENTITY. RESV_T_MSI is just a special
>> case of RESV_T_RESERVED, it's a hint for the IRQ subsystem and doesn't
>> have a meaning within a domain. From DMA mappings point of view, it is
>> effectively the same as RESV_T_RESERVED. When merging
>> RESV_T_RESERVED and
>> RESV_T_IDENTITY, we should make it RESV_T_IDENTITY. Because it is
>> required
>> for one endpoint to work (the one with IDENTITY) and is not accessed by
>> the other (the driver must not allocate this IOVA range for DMA).
>>
>> More generally, I'd like to add the following combination table to the
>> spec, that shows the resulting reserved region type after merging regions
>> from two endpoints. N: no reserved region, R: RESV_T_RESERVED, M:
>> RESV_T_MSI, I: RESV_T_IDENTITY. It is symmetric so I didn't fill the
>> bottom half.
>>
>>       | N | R | M | I
>>     ------------------
>>     N | N | R | M | ?
>>     ------------------
>>     R |   | R | R | I
>>     ------------------
>>     M |   |   | M | I
>>     ------------------
>>     I |   |   |   | I
>>
>> The 'I' column is problematic. If one endpoint has an IDENTITY region and
>> the other doesn't have anything at that virtual address, then making that
>> region an identity mapping will result in the second endpoint being able
>> to access firmware memory. If using nested translation, stage-2 can help
>> us here. But in general we should allow the device to reject an attach
>> that would result in a N+I combination if the host considers it too dodgy.
>> I think the other combinations are safe enough.
>>
> 
> will overlap happen in real? Can we simplify the spec to have device
> not reporting overlapping regions?

I think it's likely to happen, to have two endpoints with different
overlapping types. Reporting is easy, but handling mismatched reserved
regions is hard. So what I can do is leave these combination rules as
implementation detail, and let the device reject any domain attach that
overlaps mismatched RESV regions.

After all, putting multiple devices in the same domain is a nice feature
but might not be widely used in reality. It's not worth spending too much
time describing all possible behaviors for it (but still worth thinking
about to avoid introducing security holes).

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

