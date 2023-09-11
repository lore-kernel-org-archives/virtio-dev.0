Return-Path: <virtio-dev-return-13663-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0BDEE57DF
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:58:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 339482AC9E
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:58:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C6DC9865B3
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:58:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 205789863B6; Mon, 11 Sep 2023 06:58:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DB7098635C;
	Mon, 11 Sep 2023 06:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358313627"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358313627"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858206175"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="858206175"
Message-ID: <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
Date: Mon, 11 Sep 2023 14:58:10 +0800
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
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/11/2023 2:47 PM, Parav Pandit wrote:
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Monday, September 11, 2023 12:01 PM
>>
>> On Mon, Sep 11, 2023 at 12:12 PM Parav Pandit <parav@nvidia.com> wrote:
>>> Hi Michael,
>>>
>>>> From: virtio-comment@lists.oasis-open.org
>>>> <virtio-comment@lists.oasis- open.org> On Behalf Of Jason Wang
>>>> Sent: Monday, September 11, 2023 8:31 AM
>>>>
>>>> On Wed, Sep 6, 2023 at 4:33 PM Michael S. Tsirkin <mst@redhat.com>
>> wrote:
>>>>> On Wed, Sep 06, 2023 at 04:16:37PM +0800, Zhu Lingshan wrote:
>>>>>> This patch adds two new le16 fields to common configuration
>>>>>> structure to support VIRTIO_F_QUEUE_STATE in PCI transport layer.
>>>>>>
>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>>
>>>>> I do not see why this would be pci specific at all.
>>>> This is the PCI interface for live migration. The facility is not specific to PCI.
>>>>
>>>> It can choose to reuse the common configuration or not, but the
>>>> semantic is general enough to be used by other transports. We can
>>>> introduce one for MMIO for sure.
>>>>
>>>>> But besides I thought work on live migration will use admin queue.
>>>>> This was explicitly one of the motivators.
>>> Please find the proposal that uses administration commands for device
>> migration at [1] for passthrough devices.
>>> [1]
>>> https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.h
>>> tml
>> This proposal couples live migration with several requirements, and suffers from
>> the exact issues I've mentioned below.
>>
> It does not.
> Can you please list which one?
>   
>> In some cases, it's even worse (coupling with PCI/SR-IOV, second state machine
>> other than the device status).
>>
> There is no state machine in [1].
> It is not coupled with PCI/SR-IOV either.
> It supports PCI/SR-IOV transport and in future other transports too when they evolve.
>
>>>   > I think not. Using admin virtqueue will end up with several problems:
>>>> 1) the feature is not self contained so at the end we need transport
>>>> specific facility to migrate the admin virtqueue
>>> You mixed up.
>>> Admin queue of the owner device is not migrated.
> If you actually read more, it is for the member device migration and not the owner.
> Hence, owner device admin queue is not migrated.
Then how to serve bare-metal migration? Migrate by itself?
>   
>> Why not? Ling Shan's proposal makes everything work including migrating the
>> owner or in the case there's even no owner.
>>
> I don’t see in his proposal how all the features and functionality supported is achieved.
I will include in-flight descriptor tracker and diry-page traking in V2, 
anything else missed?
It can migrate the device itself, why don't you think so, can you name 
some issues we can work on
for improvements?
>
>> In this proposal, the facility (suspending, queue state, inflight
>> descriptors) is decoupled from the transport specific API. Each transport can
>> implement one or more types of interfaces. A MMIO based interface is
>> proposed but It doesn't prevent you from adding admin commands for those
>> facilities on top.
>>
> Even in proposal [1] most things are transport agonistic.
> Member device proposal covers several aspects already of downtime, peer to peer, dirty page tracking, efficient querying VQ state and more.
If you want to implement LM by admin vq, the facilities in my series can 
be re-used. E.g., forward your suspend to SUSPEND bit.
>
>
>>> Admin queue of the member device is migrated like any other queue using
>> above [1].
>>>> 2) won't work in the nested environment, or we need complicated
>>>> SR-IOV emulation in order to work
>>>>
>>>>> Poking at the device from the driver to migrate it is not going to
>>>>> work if the driver lives within guest.
>>>> This is by design to allow live migration to work in the nested layer.
>>>> And it's the way we've used for CPU and MMU. Anything may virtio
>>>> different here?
>>> Nested and non-nested use cases likely cannot be addressed by single
>> solution/interface.
>>
>> I think Ling Shan's proposal addressed them both.
>>
> I don’t see how all above points are covered.
Why?


And how do you migrate nested VMs by admin vq?

How many admin vqs and the bandwidth are
reserved for migrate all VMs?

Remember CSP migrates all VMs on a host for powersaving or upgrade.
>
>   
>>> So both are orthogonal requirements to me.
>>>
>>> One can defined some administration commands to issue on the AQ of the
>> member device itself for nested case.
>>
>> This is not easy, DMA needs to be isolated so this means you need to either
>> emulate SR-IOV and use AQ on virtual PF in the guest or using PASID.
>>
> This is why nested and non-nested cannot be treated equally and I don’t see this all covered in Ling proposal either.
> For passthrough device use case [1] has covered the necessary pieces.
>
>> Customers don't want to have admin stuff, SR-IOV or PASID in the guest in order
>> to migrate a single virtio device in the nest.
> As proposed in [1] for pass through devices no customer needs to do SR-IOV or PASID in the guest for non-nest.
>
> Nested is some special case and likely need mediated based scheme using administration commands.
>
> In best case we can produce common commands, if that fits.
> Else both proposals are orthogonal addressing different use cases.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

