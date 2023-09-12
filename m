Return-Path: <virtio-dev-return-13693-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94EDCA0ECE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:43:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2B1992A839
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:43:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 165DF9865B3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 06:43:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 05A33983E27; Tue, 12 Sep 2023 06:43:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8294986485;
	Tue, 12 Sep 2023 06:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363323643"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="363323643"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778677536"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="778677536"
Message-ID: <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com>
Date: Tue, 12 Sep 2023 14:43:18 +0800
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
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 2:11 PM, Parav Pandit wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Tuesday, September 12, 2023 9:48 AM
>>
>> On Mon, Sep 11, 2023 at 2:47 PM Parav Pandit <parav@nvidia.com> wrote:
>>>
>>>
>>>> From: Jason Wang <jasowang@redhat.com>
>>>> Sent: Monday, September 11, 2023 12:01 PM
>>>>
>>>> On Mon, Sep 11, 2023 at 12:12 PM Parav Pandit <parav@nvidia.com>
>> wrote:
>>>>> Hi Michael,
>>>>>
>>>>>> From: virtio-comment@lists.oasis-open.org
>>>>>> <virtio-comment@lists.oasis- open.org> On Behalf Of Jason Wang
>>>>>> Sent: Monday, September 11, 2023 8:31 AM
>>>>>>
>>>>>> On Wed, Sep 6, 2023 at 4:33 PM Michael S. Tsirkin
>>>>>> <mst@redhat.com>
>>>> wrote:
>>>>>>> On Wed, Sep 06, 2023 at 04:16:37PM +0800, Zhu Lingshan wrote:
>>>>>>>> This patch adds two new le16 fields to common configuration
>>>>>>>> structure to support VIRTIO_F_QUEUE_STATE in PCI transport layer.
>>>>>>>>
>>>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>>>>
>>>>>>> I do not see why this would be pci specific at all.
>>>>>> This is the PCI interface for live migration. The facility is not specific to
>> PCI.
>>>>>> It can choose to reuse the common configuration or not, but the
>>>>>> semantic is general enough to be used by other transports. We
>>>>>> can introduce one for MMIO for sure.
>>>>>>
>>>>>>> But besides I thought work on live migration will use admin queue.
>>>>>>> This was explicitly one of the motivators.
>>>>> Please find the proposal that uses administration commands for
>>>>> device
>>>> migration at [1] for passthrough devices.
>>>>> [1]
>>>>> https://lists.oasis-open.org/archives/virtio-comment/202309/msg000
>>>>> 61.h
>>>>> tml
>>>> This proposal couples live migration with several requirements, and
>>>> suffers from the exact issues I've mentioned below.
>>>>
>>> It does not.
>>> Can you please list which one?
>>>
>>>> In some cases, it's even worse (coupling with PCI/SR-IOV, second
>>>> state machine other than the device status).
>>>>
>>> There is no state machine in [1].
>> Isn't the migration modes of "active, stop, freeze" a state machine?
>>
> Huh, no. Each mode stops/starts specific thing.
> Just because one series is missing this and did only suspend/resume and other series covered P2P mode with modes, it does not make it state machine.
> If you call suspend resume as states, it is still 2 state state machines. :)
Why need P2P for Live Migration?
>
>>> It is not coupled with PCI/SR-IOV either.
>>> It supports PCI/SR-IOV transport and in future other transports too when they
>> evolve.
>> For example:
>>
>> +struct virtio_dev_ctx_pci_vq_cfg {
>> + le16 vq_index;
>> +        le16 queue_size;
>> +        le16 queue_msix_vector;
>> + le64 queue_descÍ
>> +        le64 queue_driverÍ
>> +        le64 queue_deviceÍ
>> +};
>> +\end{lstlisting}
>>
>> And does this mean we will have commands for MMIO and other transport?
> There are transports so yes, field structures from the device context will have PCI specific items.
>
>> (Most of the fields except the msix are general enough). And it's just a partial
>> implementation of the queue related functionality of the common cfg, so I
>> wonder how it can work.
>>
> As I already explained in cover letter, device context will evolve in v0->v1 to cover more.
> True, most fields are general, and it has some pci specific fields, which were not worth taking out to a different structure.
> And replicating small number of structs for MMIO is not a problem either as it is not complicating the transport either.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

