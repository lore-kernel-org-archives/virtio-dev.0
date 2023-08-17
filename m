Return-Path: <virtio-dev-return-13565-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3835AC27C7A
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 08:43:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8A2A145B2D
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 08:43:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79672986445
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 08:43:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6749E9863FE; Thu, 17 Aug 2023 08:43:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 550559863F0;
	Thu, 17 Aug 2023 08:43:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371650273"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="371650273"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908322010"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="908322010"
Message-ID: <a4acfe61-0eff-d487-a62e-5bb523bf3d54@intel.com>
Date: Thu, 17 Aug 2023 16:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: "Uminski, Piotr" <Piotr.Uminski@intel.com>,
 Jason Wang <jasowang@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com>
 <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
 <SN6PR11MB3517EF23D99CE4FDA8DDB22DFF1AA@SN6PR11MB3517.namprd11.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <SN6PR11MB3517EF23D99CE4FDA8DDB22DFF1AA@SN6PR11MB3517.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state



On 8/17/2023 4:31 PM, Uminski, Piotr wrote:
>
>> -----Original Message-----
>> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
>> open.org> On Behalf Of Zhu, Lingshan
>> Sent: Tuesday, August 15, 2023 1:30 PM
>> To: Jason Wang <jasowang@redhat.com>
>> Cc: mst@redhat.com; eperezma@redhat.com; cohuck@redhat.com; virtio-
>> comment@lists.oasis-open.org; virtio-dev@lists.oasis-open.org
>> Subject: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints for
>> virtqueue state
>>
>>
>>
>> On 8/15/2023 8:34 AM, Jason Wang wrote:
>>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan <lingshan.zhu@intel.com>
>> wrote:
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
>>>>    See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap
>> Counters}.
>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio
>> Device / Virtqueue State}
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set
>> SUSPEND in \field{device status}
>>>> +first before getting or setting Virtqueue State of any virtqueues.
>>> I don't get why this is a must. It could be useful for debugging.
>> To avoid race conditions with the device and make the device
>> implementation easier
> It should be possible to set Virtqueue State in two states:
>   - Before DRIVER_OK - as a part of the queue creation at target system
> -  After SUSPEND - when the device was activated and then suspended
> Setting state on active device can produce random results and should be forbidden.
> We may allow to get Virtqueue State on active device, without SUSPEND. However, we should not mandate the device
> to report correct value - on some implementations it may be impossible without suspend.
I agree
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but
>> VIRTIO_RING_F_PACKED not been negotiated,
>>> typo
>> yes
>>>> +the driver MUST NOT access \field{Used State} of any virtqueues, it should
>> use the
>>>> +used index in the used ring.
>>>> +
>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio
>> Device / Virtqueue State}
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set in
>> \field{device status},
>>>> +the device MUST ignore any accesses against Virtqueue State of any
>> virtqueues.
>>> Btw, do we need to clarify the behavior of ring reset after suspending?
>> I think once suspended, the device should ignore resetting a queue
>>>> +
>>>> +When VIRTIO_F_QUEUE_STATE has been negotiated but
>> VIRTIO_RING_F_PACKED is not,
>>>> +the device MUST ignore any accesses against \field{Used State}.
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST reset
>>>> +the Virtqueue State of every virtqueue upon a reset.
>>> Need to define the meaning of "reset" this is important for packed virtqueue.
>> I will remove this as Stefan suggested.
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been
>> negotiaged, when SUSPEND is set,
>>>> +the device MUST record the Virtqueue State of every enabled virtqueue
>>>> +in \field{Available State} and \field{Used State} respectively,
>>>> +and correspondingly restore the Virtqueue State of every enabled virtqueue
>>>> +from \field{Avaiable State} and \field{Used State} when DRIVER_OK is set.
>>> We can just let the device report those states in any case then we
>>> don't need to care about those details, or did you see any blockers?
>> Agree, I will add the definition of used_state of splitted vq in the
>> next version
>>
>> Thanks
>>> Thanks
>>>
>>>> +
>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but
>> VIRTIO_RING_F_PACKED has been not, when SUSPEND is set,
>>>> +the device MUST record the available state of every enabled virtqueue in
>> \field{Available State},
>>>> +and restore the available state of every enabled virtqueue from
>> \field{Avaiable State}
>>>> +when DRIVER_OK is set.
>>>> +
>>>>    \input{admin.tex}
>>>>
>>>>    \chapter{General Initialization And Device Operation}\label{sec:General
>> Initialization And Device Operation}
>>>> --
>>>> 2.35.3
>>>>
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

