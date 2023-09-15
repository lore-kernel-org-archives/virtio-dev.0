Return-Path: <virtio-dev-return-13774-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F6BEE021A
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 04:41:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6DA702A8EA
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 04:41:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 677C898666A
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 04:41:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C36A98665E; Fri, 15 Sep 2023 04:41:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45DF3986659;
	Fri, 15 Sep 2023 04:41:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410094790"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="410094790"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075663033"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="1075663033"
Message-ID: <a93fffb3-d87b-9bd2-81c0-f909116b4f64@intel.com>
Date: Fri, 15 Sep 2023 12:41:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914073454-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230914073454-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/14/2023 7:37 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
>> This series introduces
>> 1)a new SUSPEND bit in the device status
>> Which is used to suspend the device, so that the device states
>> and virtqueue states are stabilized.
>>
>> 2)virtqueue state and its accessor, to get and set last_avail_idx
>> and last_used_idx of virtqueues.
>>
>> The main usecase of these new facilities is Live Migration.
>>
>> Future work: dirty page tracking and in-flight descriptors.
>>
>> This series addresses many comments from Jason, Stefan and Eugenio
>> from RFC series.
>
> after going over this in detail, it is like I worried: this
> tries to do too much through a single register and
> the ownership is muddied significantly.
Not sure about what ownership, device usually STOPPED after
guest freezes, so the hypervisor owns the device status
and LM facilities at that moment.
>
> I feel a separate capability for suspend/resume that would
> be independent of device status would be preferable.
The implementation of the live migration basic facilities are transport 
specific, for PCI:
1)Dirty page tracking will have its own capability
2)In-flight descriptors tracker will have its own capability
3)vq states stored in common config space

Only SUSPEND is implemented in the device status, and this is a valid 
device status.
There are already 6 device status bits, and IMHO this series 
implementing SUSPEND does not
introduce more complexities.
>
>> Zhu Lingshan (5):
>>    virtio: introduce vq state as basic facility
>>    virtio: introduce SUSPEND bit in device status
>>    virtqueue: constraints for virtqueue state
>>    virtqueue: ignore resetting vqs when SUSPEND
>>    virtio-pci: implement VIRTIO_F_QUEUE_STATE
>>
>>   content.tex       | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>>   transport-pci.tex |  18 +++++++
>>   2 files changed, 136 insertions(+)
>>
>> -- 
>> 2.35.3
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

