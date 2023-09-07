Return-Path: <virtio-dev-return-13646-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57D3EE14C3
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 01:51:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1469BEEA11
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 01:51:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 087C6986603
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 01:51:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F05499865EB; Thu,  7 Sep 2023 01:51:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB3209865E9;
	Thu,  7 Sep 2023 01:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441218883"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="441218883"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="831943461"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="831943461"
Message-ID: <f63abf80-8a8d-9adc-d2f7-3f4d8ed481ec@intel.com>
Date: Thu, 7 Sep 2023 09:51:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906042851-mutt-send-email-mst@kernel.org>
 <aa6101cc-caf6-95e9-89cd-614ac7a43e55@intel.com>
 <20230906094742-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230906094742-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/6/2023 9:49 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 06, 2023 at 04:38:44PM +0800, Zhu, Lingshan wrote:
>>
>> On 9/6/2023 4:29 PM, Michael S. Tsirkin wrote:
>>> On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
>>>> This series introduces
>>>> 1)a new SUSPEND bit in the device status
>>>> Which is used to suspend the device, so that the device states
>>>> and virtqueue states are stabilized.
>>>>
>>>> 2)virtqueue state and its accessor, to get and set last_avail_idx
>>>> and last_used_idx of virtqueues.
>>>>
>>>> The main usecase of these new facilities is Live Migration.
>>>>
>>>> Future work: dirty page tracking and in-flight descriptors.
>>> oh that answers my question - it's not covered.
>>> I don't think we can merge this without in-flight descriptor
>>> support.
>> When SUSPEND, we require the device wait until all descriptors that
>> being processed to finish and mark them as used.(In patch 2)
>> at this point there may be no in-flight descriptors, so this is still
>> self-consistent. The tracker for in-flight descriptors is excluded to
>> make this series small and focus.
> Does not work generally.
> Imagine RX ring of a network device for example. You can wait
> as long as you can but if there's no incoming network traffic
> buffers will not be used.
Yes we will include a patch tracking in-flight descriptors in V2.
>
> Also please, keep to the spec terminology. buffers are used not
> descriptors. Best to keep it straight errors will not leak into
> spec.
OK
>
>
>>>
>>>
>>>> This series addresses many comments from Jason, Stefan and Eugenio
>>>> from RFC series.
>>>>
>>>> Zhu Lingshan (5):
>>>>     virtio: introduce vq state as basic facility
>>>>     virtio: introduce SUSPEND bit in device status
>>>>     virtqueue: constraints for virtqueue state
>>>>     virtqueue: ignore resetting vqs when SUSPEND
>>>>     virtio-pci: implement VIRTIO_F_QUEUE_STATE
>>>>
>>>>    content.tex       | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>    transport-pci.tex |  18 +++++++
>>>>    2 files changed, 136 insertions(+)
>>>>
>>>> -- 
>>>> 2.35.3
>>>>
>>>>
>>>> This publicly archived list offers a means to provide input to the
>>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>>
>>>> In order to verify user consent to the Feedback License terms and
>>>> to minimize spam in the list archive, subscription is required
>>>> before posting.
>>>>
>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>>> List help: virtio-comment-help@lists.oasis-open.org
>>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>>>> Committee: https://www.oasis-open.org/committees/virtio/
>>>> Join OASIS: https://www.oasis-open.org/join/
>>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

