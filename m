Return-Path: virtio-dev-return-5755-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B9EA2985C79
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 May 2019 09:18:53 +0000 (UTC)
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190512123022-mutt-send-email-mst@kernel.org>
 <20190527092604.GB21613@8bytes.org>
 <20190527111345-mutt-send-email-mst@kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <99ff5494-bfdf-f4ef-b2d2-c177add385c6@arm.com>
Date: Tue, 28 May 2019 10:18:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190527111345-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v7 0/7] Add virtio-iommu driver
To: "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 27/05/2019 16:15, Michael S. Tsirkin wrote:
> On Mon, May 27, 2019 at 11:26:04AM +0200, Joerg Roedel wrote:
>> On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
>>> OK this has been in next for a while.
>>>
>>> Last time IOMMU maintainers objected. Are objections
>>> still in force?
>>>
>>> If not could we get acks please?
>>
>> No objections against the code, I only hesitated because the Spec was
>> not yet official.
>>
>> So for the code:
>>
>> 	Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> Last spec patch had a bunch of comments not yet addressed.
> But I do not remember whether comments are just about wording
> or about the host/guest interface as well.
> Jean-Philippe could you remind me please?

It's mostly wording, but there is a small change in the config space
layout and two new feature bits. I'll send a new version of the driver
when possible.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

