Return-Path: <virtio-dev-return-13917-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D1EE706FA
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8C56622381
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BF4698668C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:20:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B18198667F; Thu, 21 Sep 2023 09:20:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B18F998667E;
	Thu, 21 Sep 2023 09:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446938995"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="446938995"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077837288"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="1077837288"
Message-ID: <e8d00e8c-fe32-83fc-fd13-edf3458b8c33@intel.com>
Date: Thu, 21 Sep 2023 17:18:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
References: <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/20/2023 9:41 PM, Parav Pandit wrote:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Wednesday, September 20, 2023 6:12 PM
>> And Parav same goes for you - can you summarize Zhu Lingshan's position?
> Below is my summary about Zhu Lingshan's position:
>
> One line summary of his position in my view:
>
> 0. Use inband device migration only, use mediation, mediation is secure, but AQ is not secure.
>
> Details of his position in my view:
>
> 1. Device migration must be done through VF itself by suspending specific vqs and the VF device both.
Not exactly, my series implements basic facilities for live migration, 
admin vq solution can reuse them
for sure. admin vq solution can work for some use cases, but for others, 
you still need to resolve
the issues we talked before.
> 2. When device migration is done using #1, it must be done using mediation approach in hypervisor.
for fundamentals of virtualization, it is trap and emulate, I think 
Jason have told you many times.
>
> 3. When migration is done using inband mediation it is more secure than AQ approach.
> (as opposed to AQ of the owner device who enables/disables SR-IOV).
VF owns it and the hypervisor owns the VF, so no side channel.
>
> 4. AQ is not secure.
> But,
so many times discussions....
> 5. AQ and admin commands can be built on top of his proposal #1, even if AQ is less secure. Opposing statements...
The security leaks and attacking surface are introduced by AQ, not the 
basic facilities,
>
> 6. Dirty page tracking and inflight descriptors tracking to be done in his v1. but he does not want to review such coverage in [1].
Will be done in V2, and they are still config space solution, with help 
of the hypervisor.
>
> 8. Since his series does not cover any device context migration and does not talk anything about it,
> I deduce that he plans to use cvq for setting ups RSS and other fields using inband CVQ of the VF.
> This further limit the solution to only net device, ignoring rest of the other 20+ device types, where all may not have the CVQ.
Any difference from current vhost solution?
>
> 9. trapping and emulation of following objects: AQ, CVQ, virtio config space, PCI FLR flow in hypervisor is secure, but when if AQ of the PF do far small work of it, AQ is not secure.
for cvq, you should read Eugenio's patcheset, it is secure. For others, 
we have discussed for many times, no need to repeat.
>
> 10. Any traps proposed in #9 mostly do not work with future TDISP as TDISP do not bifurcate the device, so ignore them for now to promote inband migration.
TDISP devices can not be migrated for now, and the TDISP spec make clear 
examples of attacking models, your admin vq LM on the PF exactly match 
the model.

Sorry I have to repeat this again, this is the last time.
>
> 11. He do not show interest in collaboration (even after requesting few times) to see if we can produce common commands that may work for both passthrough (without mediation) and using mediation for nested case.
as repeated for many times, we are implementing basic facilities, and 
you can reuse the basic facilities for live migration in admin vq 
design, do you want to cooperate?
>
> 12. Some how register access on single physical card for the PFs and VFs gives better QoS guarantee than virtqueue as registers can scale infinitely no matter how many VFs or for multiple VQs because it is per VF.
that is per-device facilities.
>
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

