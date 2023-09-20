Return-Path: <virtio-dev-return-13875-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66C1CE79CE
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:28:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27DF27BAF0
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:28:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B126986676
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:28:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0C649986669; Wed, 20 Sep 2023 11:28:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F29E498666A
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 11:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="360452400"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="360452400"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="836810360"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="836810360"
Message-ID: <8b53c622-0c13-00e6-e53a-7ca065457a8b@intel.com>
Date: Wed, 20 Sep 2023 19:28:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E095D0F3F86A9D1C3DADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB54817E095D0F3F86A9D1C3DADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/20/2023 6:55 PM, Parav Pandit wrote:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Wednesday, September 20, 2023 4:06 PM
>> I freely admit the finer points of this extended flamewar have been lost on me,
>> and I wager I'm not the only one. I thought you wanted to migrate the device
>> just by accessing the device itself (e.g. the VF) without accessing other devices
>> (e.g. the PF), while Parav wants it in a separate device so the whole of the
>> device itself can passed through to guest. Isn't this, fundamentally, the issue?
> Right. An admin device doing the work of device migration. Today it is the owner PF.
> In future it can be other admin device who is deleted this task of migration, who can be group owner.
> All the admin commands that we plumb here just works great in that CC/TDI future, because only thing changes is the admin device issuing this command.
>
>>> the bar is only a proxy, doesn't fix anything. and even larger side
>>> channel attacking surface: vf-->pf-->vf
>> In this model there's no pf. BAR belongs to vf itself and you submit commands
>> for the VF through its BAR.
>> Just separate from the pci config space.
>>
>> The whole attacking surface discussion is also puzzling.  We either are or are
>> not discussing confidential computing/TDI.  I couldn't figure it out. This needs a
>> separate thread I think.
> True. Many of Lingshan thoughts/comments gets mixed I feel.
> Because he proposes trap+emulation/mediation-based solution by hypervisor and none of that is secure anyway in CC/TDI concept.
> He keeps attacking AQ as some side channel attack, while somehow trap+emulation also done by hypervisor is secure, which obviously does not make sense in CC/TDI concept.
> Both scores equal where hypervisor trust is of concern.
Please answer directly:

What if a malicious SW suspend the guest when it is running through 
admin vq live migration facility

What if a malicious SW dump guest memory by tracking guest dirty pages 
by admin vq live migration faclity
>
> And admin command approach [1] has clear direction for CC to delete those admin commands to a dedicated trusted entity instead of hypervisor.
>
> I try to explain these few times, but..
>
> Anyways, if AQ has some comments better to reply in its thread at [1].
>
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead
>
> I will post v1 for [1] with more mature device context this week along with future provisioning item note.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

