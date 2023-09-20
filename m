Return-Path: <virtio-dev-return-13877-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275DDCE79D1
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:05:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 750EA12D34B
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:05:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5DBAB986675
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:05:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 46D6298666A; Wed, 20 Sep 2023 12:05:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3810A98666B
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 12:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359589116"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359589116"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920258214"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="920258214"
Message-ID: <dae4a52c-da5e-2cf6-82af-7d1871d690d5@intel.com>
Date: Wed, 20 Sep 2023 20:05:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>
References: <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E095D0F3F86A9D1C3DADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8b53c622-0c13-00e6-e53a-7ca065457a8b@intel.com>
 <20230920072947-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230920072947-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/20/2023 7:52 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 20, 2023 at 07:28:39PM +0800, Zhu, Lingshan wrote:
>>
>> On 9/20/2023 6:55 PM, Parav Pandit wrote:
>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Wednesday, September 20, 2023 4:06 PM
>>>> I freely admit the finer points of this extended flamewar have been lost on me,
>>>> and I wager I'm not the only one. I thought you wanted to migrate the device
>>>> just by accessing the device itself (e.g. the VF) without accessing other devices
>>>> (e.g. the PF), while Parav wants it in a separate device so the whole of the
>>>> device itself can passed through to guest. Isn't this, fundamentally, the issue?
>>> Right. An admin device doing the work of device migration. Today it is the owner PF.
>>> In future it can be other admin device who is deleted this task of migration, who can be group owner.
>>> All the admin commands that we plumb here just works great in that CC/TDI future, because only thing changes is the admin device issuing this command.
>>>
>>>>> the bar is only a proxy, doesn't fix anything. and even larger side
>>>>> channel attacking surface: vf-->pf-->vf
>>>> In this model there's no pf. BAR belongs to vf itself and you submit commands
>>>> for the VF through its BAR.
>>>> Just separate from the pci config space.
>>>>
>>>> The whole attacking surface discussion is also puzzling.  We either are or are
>>>> not discussing confidential computing/TDI.  I couldn't figure it out. This needs a
>>>> separate thread I think.
>>> True. Many of Lingshan thoughts/comments gets mixed I feel.
>>> Because he proposes trap+emulation/mediation-based solution by hypervisor and none of that is secure anyway in CC/TDI concept.
>>> He keeps attacking AQ as some side channel attack, while somehow trap+emulation also done by hypervisor is secure, which obviously does not make sense in CC/TDI concept.
>>> Both scores equal where hypervisor trust is of concern.
>> Please answer directly:
> And here you go discussing this in the same thread. I feel you guys are
> wasting bytes copying the list with this most people lost track
> if not interest.
I agree, although I have to reply because Parav said I am "attacking" AQ 
which is
not a good wording.

And I need to show its not attacking, this is discussions on
LM topics, there may be some debating, and I surely need to provide proof.
>
>> What if a malicious SW suspend the guest when it is running through admin vq
>> live migration facility
> I doubt suspend is a problem - looks like a denial of service to me
> and that is not considered part of the threat model at least going by
> the documents confidential computing guys are posting on lkml.
Yes this is a denial of service and it can be a problem if the service 
is a critical service
like a remote attestation server.

So suspending the VM by admin vq LM commands can attack the system.
>
>
>> What if a malicious SW dump guest memory by tracking guest dirty pages by
>> admin vq live migration faclity
> All this does is tell you which pages did device access though.
> It looks like on many architectures this information is readily
> available anyway due to host page tables being under the hypervisor
> control, since this is how it's migrated. Problem? How is memory
> migrated otherwise?
It tracks dirty pages, may record them in a bitmap.

Without CoCo, procdump or qemu dump-guest-memory can dump the guest 
memory pages,
but it does not know which part of memory is guest secrets.

For example, if a malicious SW wants to sniff the guest networking, the 
bitmap
of the dirty pages can help to locate the network DMA pages. This also apply
to disk IOs

So this enlarges the attacking surface.

Current live migration solution does not use any PFs tracking dirty pages,
so no such side channel.
>
>>> And admin command approach [1] has clear direction for CC to delete those admin commands to a dedicated trusted entity instead of hypervisor.
>>>
>>> I try to explain these few times, but..
>>>
>>> Anyways, if AQ has some comments better to reply in its thread at [1].
>>>
>>> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead
>>>
>>> I will post v1 for [1] with more mature device context this week along with future provisioning item note.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

