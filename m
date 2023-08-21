Return-Path: <virtio-dev-return-13578-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D427EE49AA
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 10:32:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6738D2AD6B
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 10:32:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53F1E986265
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 10:32:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4433D983FE9; Mon, 21 Aug 2023 10:32:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3169898622C;
	Mon, 21 Aug 2023 10:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="363714798"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="363714798"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="765319082"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="765319082"
Message-ID: <b93edb87-1d5d-ec4d-6827-e85daa87ceb7@intel.com>
Date: Mon, 21 Aug 2023 18:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Si-Wei Liu <si-wei.liu@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com>
 <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
 <CAJaqyWd=hCvknO5MQ0Nu4iwxPMfjHGHNJHiwzxAaRLcgZ1HKxg@mail.gmail.com>
 <23b9082d-050a-6f82-754e-d309c48972d5@intel.com>
 <CAJaqyWeye4fOTB5pPtwpzusgZRL6d36EzDD61zoD8Uf+0v4FQw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CAJaqyWeye4fOTB5pPtwpzusgZRL6d36EzDD61zoD8Uf+0v4FQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state



On 8/21/2023 5:26 PM, Eugenio Perez Martin wrote:
> On Fri, Aug 18, 2023 at 11:44 AM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>
>>
>> On 8/17/2023 11:19 PM, Eugenio Perez Martin wrote:
>>> On Tue, Aug 15, 2023 at 1:30 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>>>
>>>> On 8/15/2023 8:34 AM, Jason Wang wrote:
>>>>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>>>>>> This commit specifies the constraints of the virtqueue state,
>>>>>> and the actions should be taken by the device when SUSPEND
>>>>>> and DRIVER_OK is set
>>>>>>
>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>>> ---
>>>>>>     content.tex | 31 +++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 31 insertions(+)
>>>>>>
>>>>>> diff --git a/content.tex b/content.tex
>>>>>> index 43bd5de..f6ac581 100644
>>>>>> --- a/content.tex
>>>>>> +++ b/content.tex
>>>>>> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
>>>>>>
>>>>>>     See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
>>>>>>
>>>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
>>>>>> +
>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set SUSPEND in \field{device status}
>>>>>> +first before getting or setting Virtqueue State of any virtqueues.
>>>>> I don't get why this is a must. It could be useful for debugging.
>>>> To avoid race conditions with the device and make the device
>>>> implementation easier
>>>>>> +
>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but VIRTIO_RING_F_PACKED not been negotiated,
>>>>> typo
>>>> yes
>>>>>> +the driver MUST NOT access \field{Used State} of any virtqueues, it should use the
>>>>>> +used index in the used ring.
>>>>>> +
>>>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
>>>>>> +
>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set in \field{device status},
>>>>>> +the device MUST ignore any accesses against Virtqueue State of any virtqueues.
>>>>> Btw, do we need to clarify the behavior of ring reset after suspending?
>>>> I think once suspended, the device should ignore resetting a queue
>>> Actually shadow virtqueue could benefit from the ability to change vq
>>> properties (addresses) while the device is suspended, and then just
>>> resume it. I've been told that ring reset is overkill for that.
>> If ring reset is overkill, is SUSPEND even more overkill?
> It depends on the cost of recreating the vq in the device I think. But
> it has more to do with *what* is changed in the vq, as it seems some
> parameters (vq size) has more impact than others like vq address. The
> way to stop the device does not affect, but ring reset offers the
> possibility of change all of the parameters already.
>
> Adding Si-Wei and Dragos here, as they pointed it out in the
> virtio-networking upstream meeting.
>
>>> But probably it is better to address it on top, with another feature flag.
>> I think if we want to changing the vq properties, there must be a
>> mechanism to
>> stop the queue then resume the queue.
>>
>> How about allow setting queue_enable = 0 to stop it and =1 to resume and
>> force it reinitialize?
>>
> Yes, I think that is better suited. But maybe this is better to be
> added on top, so we maintain this series small.
OK, I can work out a patch in this series implementing it.
And as discussed in another thread with Jason in this series, it
is better to forbid resetting a vq after SUSPEND.

Thanks
>
> Thanks!
>
>> Thanks
>> Zhu Lingshan
>>>>>> +
>>>>>> +When VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED is not,
>>>>>> +the device MUST ignore any accesses against \field{Used State}.
>>>>>> +
>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST reset
>>>>>> +the Virtqueue State of every virtqueue upon a reset.
>>>>> Need to define the meaning of "reset" this is important for packed virtqueue.
>>>> I will remove this as Stefan suggested.
>>>>>> +
>>>>>> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been negotiaged, when SUSPEND is set,
>>>>>> +the device MUST record the Virtqueue State of every enabled virtqueue
>>>>>> +in \field{Available State} and \field{Used State} respectively,
>>>>>> +and correspondingly restore the Virtqueue State of every enabled virtqueue
>>>>>> +from \field{Avaiable State} and \field{Used State} when DRIVER_OK is set.
>>>>> We can just let the device report those states in any case then we
>>>>> don't need to care about those details, or did you see any blockers?
>>>> Agree, I will add the definition of used_state of splitted vq in the
>>>> next version
>>>>
>>>> Thanks
>>>>> Thanks
>>>>>
>>>>>> +
>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED has been not, when SUSPEND is set,
>>>>>> +the device MUST record the available state of every enabled virtqueue in \field{Available State},
>>>>>> +and restore the available state of every enabled virtqueue from \field{Avaiable State}
>>>>>> +when DRIVER_OK is set.
>>>>>> +
>>>>>>     \input{admin.tex}
>>>>>>
>>>>>>     \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>>>>> --
>>>>>> 2.35.3
>>>>>>
>
> This publicly archived list offers a means to provide input to the
>
> OASIS Virtual I/O Device (VIRTIO) TC.
>
>
>
> In order to verify user consent to the Feedback License terms and
>
> to minimize spam in the list archive, subscription is required
>
> before posting.
>
>
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>
> List help: virtio-comment-help@lists.oasis-open.org
>
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>
> Committee: https://www.oasis-open.org/committees/virtio/
>
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

