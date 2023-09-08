Return-Path: <virtio-dev-return-13655-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4CFEE57E5
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 08:41:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A14C12D354
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 08:41:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EADD1986608
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 08:41:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DBD3298413A; Fri,  8 Sep 2023 08:41:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C980998643A;
	Fri,  8 Sep 2023 08:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408588184"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="408588184"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="885587428"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="885587428"
Message-ID: <6fa57d42-5a42-ffa4-d4a6-1aacb063002d@intel.com>
Date: Fri, 8 Sep 2023 16:41:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Content-Language: en-US
To: Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com>
 <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
 <CAJaqyWd=hCvknO5MQ0Nu4iwxPMfjHGHNJHiwzxAaRLcgZ1HKxg@mail.gmail.com>
 <23b9082d-050a-6f82-754e-d309c48972d5@intel.com>
 <CAJaqyWeye4fOTB5pPtwpzusgZRL6d36EzDD61zoD8Uf+0v4FQw@mail.gmail.com>
 <4f88bf69-7436-4f26-6be8-76347355d59c@intel.com>
 <CAJaqyWeLeyBJSn2EH9-vfbyVCAcCKDuhp-1G+3QZGpVMf7KTDw@mail.gmail.com>
 <20ccafc0-f896-07df-f688-6f5d250a0b05@intel.com>
 <cba0b7f2-e40d-80b6-adb8-a2b4a4eb1bd8@oracle.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <cba0b7f2-e40d-80b6-adb8-a2b4a4eb1bd8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state



On 9/8/2023 2:23 PM, Si-Wei Liu wrote:
>
>
> On 9/7/2023 2:34 AM, Zhu, Lingshan wrote:
>>
>>
>> On 9/7/2023 4:09 PM, Eugenio Perez Martin wrote:
>>> On Tue, Sep 5, 2023 at 11:08 AM Zhu, Lingshan 
>>> <lingshan.zhu@intel.com> wrote:
>>>>
>>>>
>>>> On 8/21/2023 5:26 PM, Eugenio Perez Martin wrote:
>>>>> On Fri, Aug 18, 2023 at 11:44 AM Zhu, Lingshan 
>>>>> <lingshan.zhu@intel.com> wrote:
>>>>>>
>>>>>> On 8/17/2023 11:19 PM, Eugenio Perez Martin wrote:
>>>>>>> On Tue, Aug 15, 2023 at 1:30 PM Zhu, Lingshan 
>>>>>>> <lingshan.zhu@intel.com> wrote:
>>>>>>>> On 8/15/2023 8:34 AM, Jason Wang wrote:
>>>>>>>>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan 
>>>>>>>>> <lingshan.zhu@intel.com> wrote:
>>>>>>>>>> This commit specifies the constraints of the virtqueue state,
>>>>>>>>>> and the actions should be taken by the device when SUSPEND
>>>>>>>>>> and DRIVER_OK is set
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>>>>>>> ---
>>>>>>>>>>      content.tex | 31 +++++++++++++++++++++++++++++++
>>>>>>>>>>      1 file changed, 31 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/content.tex b/content.tex
>>>>>>>>>> index 43bd5de..f6ac581 100644
>>>>>>>>>> --- a/content.tex
>>>>>>>>>> +++ b/content.tex
>>>>>>>>>> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
>>>>>>>>>>
>>>>>>>>>>      See also \ref{sec:Packed Virtqueues / Driver and Device 
>>>>>>>>>> Ring Wrap Counters}.
>>>>>>>>>>
>>>>>>>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic 
>>>>>>>>>> Facilities of a Virtio Device / Virtqueue State}
>>>>>>>>>> +
>>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST 
>>>>>>>>>> set SUSPEND in \field{device status}
>>>>>>>>>> +first before getting or setting Virtqueue State of any 
>>>>>>>>>> virtqueues.
>>>>>>>>> I don't get why this is a must. It could be useful for debugging.
>>>>>>>> To avoid race conditions with the device and make the device
>>>>>>>> implementation easier
>>>>>>>>>> +
>>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but 
>>>>>>>>>> VIRTIO_RING_F_PACKED not been negotiated,
>>>>>>>>> typo
>>>>>>>> yes
>>>>>>>>>> +the driver MUST NOT access \field{Used State} of any 
>>>>>>>>>> virtqueues, it should use the
>>>>>>>>>> +used index in the used ring.
>>>>>>>>>> +
>>>>>>>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic 
>>>>>>>>>> Facilities of a Virtio Device / Virtqueue State}
>>>>>>>>>> +
>>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is 
>>>>>>>>>> not set in \field{device status},
>>>>>>>>>> +the device MUST ignore any accesses against Virtqueue State 
>>>>>>>>>> of any virtqueues.
>>>>>>>>> Btw, do we need to clarify the behavior of ring reset after 
>>>>>>>>> suspending?
>>>>>>>> I think once suspended, the device should ignore resetting a queue
>>>>>>> Actually shadow virtqueue could benefit from the ability to 
>>>>>>> change vq
>>>>>>> properties (addresses) while the device is suspended, and then just
>>>>>>> resume it. I've been told that ring reset is overkill for that.
>>>>>> If ring reset is overkill, is SUSPEND even more overkill?
>>>>> It depends on the cost of recreating the vq in the device I think. 
>>>>> But
>>>>> it has more to do with *what* is changed in the vq, as it seems some
>>>>> parameters (vq size) has more impact than others like vq address. The
>>>>> way to stop the device does not affect, but ring reset offers the
>>>>> possibility of change all of the parameters already.
>>>>>
>>>>> Adding Si-Wei and Dragos here, as they pointed it out in the
>>>>> virtio-networking upstream meeting.
>>>>>
>>>>>>> But probably it is better to address it on top, with another 
>>>>>>> feature flag.
>>>>>> I think if we want to changing the vq properties, there must be a
>>>>>> mechanism to
>>>>>> stop the queue then resume the queue.
>>>>>>
>>>>>> How about allow setting queue_enable = 0 to stop it and =1 to 
>>>>>> resume and
>>>>>> force it reinitialize?
>>>>>>
>>>>> Yes, I think that is better suited. But maybe this is better to be
>>>>> added on top, so we maintain this series small.
>>>> Hi Eugenio,
>>>>
>>>> I have a second thought while implementing above queue_enable = 0,
>>>> it doesn't provide more advantages over queue_reset:
>>>>
>>>> 1) queue_reset can help to stop a queue and the vq properties can be
>>>> reconfigured during queue_reset --> queue_enable.
>>>>
>>>> 2) once the driver sees SUSPEND presented by the device, it assume the
>>>> device states and vq states are stable, at that point the driver can
>>>> read reliable device configurations. So vq reset should be ignored
>>>> once SUSPEND is present and if we implement queue stop, it should be
>>>> ignored too when SUSPEND.
>>>>
>>> The relation between SUSPEND and ring_reset needs to be described in
>>> this series, yes. This is a good start, but I'm not sure if this one
>>> meets all the requirements for SW assisted live migration.
>>>
>>> We can always add new feature flags to define a different interaction
>>> in the future, like for devices that can support the change of vq
>>> attributes in the suspend. To not steal the merit, this idea was
>>> proposed by Si-Wei in a recent virtio-networking meeting.
>> If so, we even don't need a new feature bit. We can just allow
>> resetting vqs after the device presenting SUSPEND.
> For the single bit of feature interaction with queue_reset this looks 
> fine, but queue_reset is perhaps not the only feature that needs to 
> interact with SUSPEND. While on the other hand I suspect it's probably 
> not easy to converge on everything all at once for the moment. Just to 
> avoid the lure of hijacking this thread for other things, it'd be 
> easier I feel to define a pristine SUSPEND method starting with the 
> most restrictive mandates, describing every possible means to 
> prohibiting *any* change to the config space for device in suspension. 
> This not just keeps the (backward) compatibility on the table which is 
> consistent with the assumption of various SUSPEND implementations 
> available today, but would make it possible to customize different 
> flavors of interactions guarded by different feature flag in the 
> future. For instance, today queue_reset may mostly work the best on 
> software device implementation where one can introduce a specific 
> SUSPEND_RING_RESET_ALLOWED feature flag to unlock/override part of the 
> restriction from the pristine SUSPEND feature when both are negotiated 
> and used together. In future, if there's any need to revisit this part 
> for e.g. hardware device implementation of queue_reset might not be 
> able to meet certain desired performance (downtime) goal, then a new 
> feature might have to be introduced to define another hardware-biased 
> means of interaction with suspended device.
Hi Siwei

OK, I got it, there can be a new feature bit for resetting a queue after 
SUSPEND, and other interactions can follow the same way, more flexible.
>
>>
>> The device presenting SUSPEND indicates that the device config space
>> is stabilized at that moment, ready for the driver to fetch fields 
>> data there.
>>
>> Then the driver is allowed to reset, re-config and re-enable the vqs.
> Maybe not for this case, but for completeness I found a very relevant 
> question is, as your patch defines SUSPEND in the context of live 
> migration, how do you envision to resume/restart the device 
> immediately in place on the source host (say migration is cancelled 
> after all devices are suspended, or migration failed at the last 
> minute for some reason)? Reset the device and start to recover 
> everything from scratch? Or do queue_reset then queue_enable on every 
> virtqueue while keeping the other device states (those already 
> populated through ctrl vq) around? Or suppose right now we have a 
> symmetric RESUME feature that keeps every device state including the 
> queue state in place. Which option a hardware vendor would like to 
> pick if user/customer would like to have the best/least downtime? Does 
> the hardware's choice matter much for software device implementation?
>
> As can be seen amongst these options, there's perhaps no single best 
> solution between software and hardware devices, or even between 
> different hardware vendors. So instead of ruling out possibility for 
> future extension to flavor other implementations, be it hardware or 
> software, I feel it's probably not the best thing for now to get 
> SUSPEND hard wired to queue_reset or RESUME. Device reset is the base 
> case that every device has to implement, that I feel might be the only 
> failsafe method to get the device out of the suspension state with 
> pristine SUSPEND.
In case of failed or cancelled Live Migration, the driver can reset the 
re-config the device to resume it for sure.

In this series, we also say:
If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD 
clear SUSPEND and resumes operation upon DRIVER_OK.

>
>>
>> The only requirement is: The driver is responsible for maintain
>> the integrity and validity of the config space fields, because
>> the device is ready-only to the config space at that moment(SUSPEND-ed)
>> and the driver should be responsible for its actions, perform proper
>> synchronizations, e.g., re-read.
> It looks fine, though as stated above, please leave it to a different 
> feature flag with another patch to define the queue_reset interaction 
> with SUSPEND.
Sure, we will introduce a new feature bit for resetting vq.

Thanks for your advice
Zhu Lingshan
>
> Thanks,
> -Siwei
>
>>
>> Does this work for you?
>>
>> Thanks
>>>
>>>> 3) the device should only accept resetting a queue when !SUSPEND and
>>>> the driver can flush the queue buffers before resetting it to avoid
>>>> losing buffers,
>>>> and we will have tracker for in-flight descriptors later.
>>>>
>>>> Any thoughts?
>>>>
>>>> Thanks
>>>>> Thanks!
>>>>>
>>>>>> Thanks
>>>>>> Zhu Lingshan
>>>>>>>>>> +
>>>>>>>>>> +When VIRTIO_F_QUEUE_STATE has been negotiated but 
>>>>>>>>>> VIRTIO_RING_F_PACKED is not,
>>>>>>>>>> +the device MUST ignore any accesses against \field{Used State}.
>>>>>>>>>> +
>>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST 
>>>>>>>>>> reset
>>>>>>>>>> +the Virtqueue State of every virtqueue upon a reset.
>>>>>>>>> Need to define the meaning of "reset" this is important for 
>>>>>>>>> packed virtqueue.
>>>>>>>> I will remove this as Stefan suggested.
>>>>>>>>>> +
>>>>>>>>>> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been 
>>>>>>>>>> negotiaged, when SUSPEND is set,
>>>>>>>>>> +the device MUST record the Virtqueue State of every enabled 
>>>>>>>>>> virtqueue
>>>>>>>>>> +in \field{Available State} and \field{Used State} respectively,
>>>>>>>>>> +and correspondingly restore the Virtqueue State of every 
>>>>>>>>>> enabled virtqueue
>>>>>>>>>> +from \field{Avaiable State} and \field{Used State} when 
>>>>>>>>>> DRIVER_OK is set.
>>>>>>>>> We can just let the device report those states in any case 
>>>>>>>>> then we
>>>>>>>>> don't need to care about those details, or did you see any 
>>>>>>>>> blockers?
>>>>>>>> Agree, I will add the definition of used_state of splitted vq 
>>>>>>>> in the
>>>>>>>> next version
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but 
>>>>>>>>>> VIRTIO_RING_F_PACKED has been not, when SUSPEND is set,
>>>>>>>>>> +the device MUST record the available state of every enabled 
>>>>>>>>>> virtqueue in \field{Available State},
>>>>>>>>>> +and restore the available state of every enabled virtqueue 
>>>>>>>>>> from \field{Avaiable State}
>>>>>>>>>> +when DRIVER_OK is set.
>>>>>>>>>> +
>>>>>>>>>>      \input{admin.tex}
>>>>>>>>>>
>>>>>>>>>>      \chapter{General Initialization And Device 
>>>>>>>>>> Operation}\label{sec:General Initialization And Device 
>>>>>>>>>> Operation}
>>>>>>>>>> -- 
>>>>>>>>>> 2.35.3
>>>>>>>>>>
>>>>> This publicly archived list offers a means to provide input to the
>>>>>
>>>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>>>
>>>>>
>>>>>
>>>>> In order to verify user consent to the Feedback License terms and
>>>>>
>>>>> to minimize spam in the list archive, subscription is required
>>>>>
>>>>> before posting.
>>>>>
>>>>>
>>>>>
>>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>>>>
>>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>>>>
>>>>> List help: virtio-comment-help@lists.oasis-open.org
>>>>>
>>>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>>>>
>>>>> Feedback License: 
>>>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>>>>
>>>>> List Guidelines: 
>>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
>>>>>
>>>>> Committee: https://www.oasis-open.org/committees/virtio/
>>>>>
>>>>> Join OASIS: https://www.oasis-open.org/join/
>>>>>
>>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

