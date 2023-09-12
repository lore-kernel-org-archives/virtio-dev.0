Return-Path: <virtio-dev-return-13709-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA12CA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:14:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BD01012D351
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:14:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B04599865CA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:14:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A317D986485; Tue, 12 Sep 2023 10:14:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 914BB98648C;
	Tue, 12 Sep 2023 10:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381034078"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381034078"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990455169"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="990455169"
Message-ID: <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
Date: Tue, 12 Sep 2023 18:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 5:35 PM, Parav Pandit wrote:
>
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 12, 2023 2:38 PM
>> supplementary: As Jason ever pointed out: the two solution can co-exist for
>> sure, I am implementing basic facilities, admin vq can free feel to reuse them like
>> forwarding messages to them, and this can help support nested.
> Sure. Sounds good.
>
> At lest two device vendors + other industry bodies including led by Intel are moving away from the register-based implementation in virtualization area.
This series is self-contained, it is an register based solution. It 
introduces basic facilities, doesn't depend on others like AQ.
> And registers that you expose are not supporting device reset and FLR sequence. So please add some text for that in PCI transport section about violation.
> And guideline for driver on how it should not touch them to make this usable.
> This will make the nested solution more clear.
PCI FLR is out of this scope, for virtio you can still reset the device 
by writing 0.
>
> Do you find the administration commands we proposed in [1] useful for nested case?
> If not, both will likely diverge.
Not till now.
>
> We would like to avoid suspending individual VQs in the passthrough case, as things are controlled at the device level.
> It also reduces driver -> device interaction for large queue count ranging from 1 to 32K.
>
> So at present I see very little overlap between the two. I will look more again on 9/13 if passthrough proposal can utilize anything from your series.
It does not suspending an individual VQ, when suspend, all VQs are STOPPED.
>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

