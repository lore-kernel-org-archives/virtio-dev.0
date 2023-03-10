Return-Path: <virtio-dev-return-11593-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BE4C6FD19
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 08:32:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CCB6933576
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 08:32:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8724986722
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 08:32:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BA871986717; Fri, 10 Mar 2023 08:32:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1454986718;
	Fri, 10 Mar 2023 08:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="316332373"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="316332373"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="710203908"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="710203908"
Message-ID: <e32a28ae-b747-9536-d673-06c7cd977d21@intel.com>
Date: Fri, 10 Mar 2023 16:32:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiri Pirko <jiri@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "hang.yuan@intel.com" <hang.yuan@intel.com>,
 "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho> <20230306175020-mutt-send-email-mst@kernel.org>
 <ZAbmEmwsMMxKJqeB@nanopsycho> <20230307121529-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EEF6CD4B946233EE311FDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481EEF6CD4B946233EE311FDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management



On 3/8/2023 3:31 AM, Parav Pandit wrote:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Tuesday, March 7, 2023 12:20 PM
> [..]
>>>> For SR-IOV, it is not unusual for PFs to excercise control over VFs.
>>> I understand the concepts of SR-IOV. Yet I fail to see the need of
>>> such concept in virtio world. SR-IOV is very specific solution for PCI
>>> functions instantiation, and I believe that it is already considered
>>> quite limiting in many aspects. Does not make sense to me to introduce
>>> it for virtio. But again, I may be missing something crucial, I just
>>> would like to see the motivation, needs, usecases for this crystal
>>> clear, which is opposite to the current cover letter I'm afraid :/
>> First people are asking for it because it's out there, however limiting it is. In
>> fact Nvidia is - why don't you talk to Parav here and tell him that SR-IOV is
>> legacy and there's no need to support.
>>
> Jiri and I discussed offline today.
> SR-IOV is widely used today and in the coming future up to thousands of devices.
> Many vendors are building it or already built.
>
> SIOV as it stands today is still being crafted at various levels iommu, os, device, pci and more.
> Not there yet fully.
>
> Jiri and I built the Linux kernel interfaces for SFs which are equivalent to SIOVs that overcome some of the SR-IOV limitations.
> And Jiri's suggestion was to leverage some of the vision and practice from there.
>
> In other words, can AQ command be useful tomorrow for doing SIOV device add/remove, and provisioning from non-owning PF?
> The way AQ is crafted today is not there yet, but in the future, it can be extended.
I have submitted a series implementing "transport vq" which work for 
ADIs like SIOV devices, MST required a merge with admin q, so we are here.
>>>> There is interest in the community to include an interface to allow
>>>> this in the virtio spec, when the PF is a virtio device.  This is
>>>> what this patch does.
>>> Yeah, but why? As I asked before, what are the usecases? The fact
>>> there is interest in the community does not mean it makes sense to
>>> have it :)
>>>
>> If people want to build such hardware it will need some interface.
>> Far better to have it standard.
>>
>>
>> But generally e.g. intel already said they will reuse this same structure with a
>> different group type for SIOV support.
>> I'll mention this in the cover letter.
>>
> We have the following already identified use cases of a device agnostic VQ.
>
> 1. SR-IOV VF device provisioning at virtio layer (features and config)
> 2. SR IOV (SR-PCIM interface of the PCI spec) for VF provisioning, for example, MSI-X vectors
>
> 3. SR-IOV VF Live migration
> 4. Above #1 to #3 for SIOV devices instead of SRIOV devices
>
> 5. cmd q interface for PF/VF/SF/SIOV to transport their own features, config command over queue interface without any parent device
>
> #1 to #3 are well described in past. So, It is worth covering them in the cover letter and things will be clear for new eyes.
> #4 is broad use case and like #1 to #3 that will eventually happen.
> #5 likely needs more discussion, we can differ to a later point because AQ needs to progress in spec 1.3.
>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

