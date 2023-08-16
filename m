Return-Path: <virtio-dev-return-13562-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC62C04A6A
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 05:07:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 613E63451
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 05:07:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5913A98643D
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 05:07:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A39D983EB2; Wed, 16 Aug 2023 05:07:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37C979863D1;
	Wed, 16 Aug 2023 05:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372440774"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="372440774"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824101183"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="824101183"
Message-ID: <a9e75f5f-fb88-5196-2888-477b3f425509@intel.com>
Date: Wed, 16 Aug 2023 13:07:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com>
 <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
 <CACGkMEtAF9Rc7PQqEToFmjixHB8sb4yxWM7r80g92q8kCCor0A@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEtAF9Rc7PQqEToFmjixHB8sb4yxWM7r80g92q8kCCor0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state



On 8/16/2023 10:11 AM, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 7:30 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>
>>
>> On 8/15/2023 8:34 AM, Jason Wang wrote:
>>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>>>> This commit specifies the constraints of the virtqueue state,
>>>> and the actions should be taken by the device when SUSPEND
>>>> and DRIVER_OK is set
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>> ---
>>>>    content.tex | 31 +++++++++++++++++++++++++++++++
>>>>    1 file changed, 31 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index 43bd5de..f6ac581 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
>>>>
>>>>    See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
>>>>
>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set SUSPEND in \field{device status}
>>>> +first before getting or setting Virtqueue State of any virtqueues.
>>> I don't get why this is a must. It could be useful for debugging.
>> To avoid race conditions with the device and make the device
>> implementation easier
> replied in another thread.
>
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but VIRTIO_RING_F_PACKED not been negotiated,
>>> typo
>> yes
>>>> +the driver MUST NOT access \field{Used State} of any virtqueues, it should use the
>>>> +used index in the used ring.
>>>> +
>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set in \field{device status},
>>>> +the device MUST ignore any accesses against Virtqueue State of any virtqueues.
>>> Btw, do we need to clarify the behavior of ring reset after suspending?
>> I think once suspended, the device should ignore resetting a queue
> This needs to be clarified.
OK, I will clarify this in the resting queue section.

This reminds me I should add: When SUSPEND is set, the \field{device 
status} is still operational for
both the device and the driver. Because after SUSPEND, the driver may 
set DRIVER_OK and the device may
set NEEDS_RESET.

Thanks
>
> Thanks
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

