Return-Path: virtio-dev-return-4523-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C7294581920A
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Jun 2018 10:52:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20180621190655.56391-1-jean-philippe.brucker@arm.com>
 <20180621190655.56391-4-jean-philippe.brucker@arm.com>
 <20180622035442-mutt-send-email-mst@kernel.org>
Message-ID: <72f85cc1-f899-3575-1354-c3a4854cd47e@arm.com>
Date: Mon, 25 Jun 2018 18:52:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180622035442-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 3/5] iommu/virtio: Add probe request
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 22/06/18 01:55, Michael S. Tsirkin wrote:
>> +#define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
>> +#define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
>> +
>> +struct virtio_iommu_probe_resv_mem {
>> +	__u8					subtype;
>> +	__u8					reserved[3];
>> +	__le64					start;
>> +	__le64					end;
>> +} __packed;
> 
> 
> start/end are not aligned you need to pad more.

The complete structure is actually the 32-bit header
virtio_iommu_probe_property, followed by the content
virtio_iommu_probe_resv_mem:

struct {
	le16	type
	le16	length
	u8	subtype
	u8	reserved[3]
	le64	start
	le64	end
};

I'll redefine virtio_iommu_probe_resv_mem to include this header.
Otherwise, without __packed, a compiler introduces padding when
concatenating header and content.

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

