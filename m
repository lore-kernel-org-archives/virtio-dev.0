Return-Path: <virtio-dev-return-14365-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C43FC47DD9
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 06:45:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 978ED6008C
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 06:45:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DA709865C9
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 06:45:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 536EF986339; Wed, 28 Feb 2024 06:45:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F8AE98645C
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Feb 2024 06:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25954145"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="25954145"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="38150305"
Message-ID: <7050294e-1d62-4487-b74b-b173bc586776@intel.com>
Date: Wed, 28 Feb 2024 14:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 parav@nvidia.com
References: <20240227015345.3614965-1-stevensd@chromium.org>
 <20240227015345.3614965-2-stevensd@chromium.org>
 <e03d003e-ca23-4dd2-aeac-6df79ee5c1e6@intel.com>
 <CAD=HUj6gM5HUp=gGt1u=OcQRBe3A=ig5ws=ZLkJEy=Jr-caAvQ@mail.gmail.com>
 <e4caa5e3-2cd3-465e-aa9c-275b4426d31d@intel.com>
 <CAD=HUj66_gBBbf5EZ2dDrc51hKQ83zJotgS8vRanrxbD0oy_vw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CAD=HUj66_gBBbf5EZ2dDrc51hKQ83zJotgS8vRanrxbD0oy_vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v5 1/1] Add SUSPEND bit to device status



On 2/28/2024 9:18 AM, David Stevens wrote:
> On Tue, Feb 27, 2024 at 5:52 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>> On 2/27/2024 3:59 PM, David Stevens wrote:
>>> On Tue, Feb 27, 2024 at 11:22 AM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>>> On 2/27/2024 9:53 AM, David Stevens wrote:
>>>>> Add a SUSPEND bit to the device status field to allow drivers to suspend
>>>>> virtio devices. On systems where drivers don't directly manage interrupt
>>>>> routing (e.g. Linux), this allows the drivers to suspend their devices
>>>>> and prevent interrupts from being sent when the interrupt routing system
>>>>> does not expect interrupts.
>>>>> ---
>>>>>     content.tex | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>>>>>     1 file changed, 84 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/content.tex b/content.tex
>>>>> index 0a62dce5f65f..2183c63c45ea 100644
>>>>> --- a/content.tex
>>>>> +++ b/content.tex
>>>>> @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>
>>>>>     \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>>>>>       an error from which it can't recover.
>>>>> +
>>>>> +\item[SUSPEND (16)] Indicates that the device has been suspended by the
>>>>> +  driver. Only valid when the VIRTIO_F_SUSPEND feature bit is negotiated.
>>>>>     \end{description}
>>>>>
>>>>>     The \field{device status} field starts out as 0, and is reinitialized to 0 by
>>>>> @@ -60,9 +63,11 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>     initialization sequence specified in
>>>>>     \ref{sec:General Initialization And Device Operation / Device
>>>>>     Initialization}.
>>>>> -The driver MUST NOT clear a
>>>>> -\field{device status} bit.  If the driver sets the FAILED bit,
>>>>> -the driver MUST later reset the device before attempting to re-initialize.
>>>>> +
>>>>> +The driver MUST NOT clear a \field{device status} bit, except for the
>>>>> +SUSPEND bit as described in \ref{sec:General Initialization And Device
>>>>> +Operation / Device Suspend}. If the driver sets the FAILED bit, the
>>>>> +driver MUST later reset the device before attempting to re-initialize.
>>>> Comparing to add a new exception, why not just re-setting DRIVER_OK to
>>>> let the device
>>>> clearing SUSPEND? This issue has been addressed when Eugenio working on
>>>> a similar STOP_BIT
>>>>
>>>> https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.html
>>> I don't think the device status bit is bit-addressable, so it's not
>>> possible to re-set DRIVER_OK without also either re-setting or
>>> clearing SUSPEND.
>> Please correct me if I misunderstand your point,
>> I think it can be addressed, for example, in PCI it is an u8,
>> the device can clear a bit in it.
>>
>> It may be easier to let the device to clear the SUSPEND bit.
> If it's a u8, then the driver will be writing all 8 bits at the same
> time. So I don't see how it's possible for the driver to set one bit
> without also setting/clearing all the other bits at the same time.
> When you say the driver can re-set DRIVER_OK, it can either write 0x1F
> or 0xF. If we don't allow clearing the suspend bit, then it has to
> write 0x1F. But that's exactly what the driver wrote to suspend the
> device in the first place - how is the device supposed to tell the
> difference? I guess we could add something to the spec saying that's
> how the device is supposed to interpret it. But at that point, that's
> really the same as allowing the driver to clear the suspend bit, just
> with more complexity.
Thanks for the explanation, I get your point now.
I agree allowing clear a bit can resume the device running. however this
makes an exception and require the device to examine every bits that the 
driver set.

Letting the device clear the SUSPEND bit also require the device to examine
every bits. Based on the device status(Init, Running or SUSPENDED), the 
device
can behave differently:
+If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD 
clear SUSPEND
+and resumes operation upon DRIVER_OK.

But no need to make exceptions in the spec. Maybe this is a little less 
complex?

Allowing clear a bit by the driver also needs to deal with reset:
https://lists.oasis-open.org/archives/virtio-dev/202111/msg00025.html

Thanks

>
> -David


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

