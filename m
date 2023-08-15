Return-Path: <virtio-dev-return-13542-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877E7C001B0
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:48:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D3499330AD
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:48:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2C489863EF
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:48:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B4DD398638E; Tue, 15 Aug 2023 10:48:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A17F598634B;
	Tue, 15 Aug 2023 10:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375983787"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375983787"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877304613"
Message-ID: <6d41cf4f-8cc2-6bad-7b22-2369fd6a620c@intel.com>
Date: Tue, 15 Aug 2023 18:48:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
 <CACGkMEvmYqKTk1Hveo96oKYw4hbEDJD2x5Ye3_nkeBTH0rcMMw@mail.gmail.com>
 <CACGkMEt4mYmf+6+WC=WEZqiJgO2tNo96Ekr5bbyN6akxpjwFqw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEt4mYmf+6+WC=WEZqiJgO2tNo96Ekr5bbyN6akxpjwFqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC PATCH 1/5] virtio: introduce SUSPEND bit in device status



On 8/15/2023 8:37 AM, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 8:26 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>>> This patch introudces a new status bit in the device status: SUSPEND.
>>>
>>> This SUSPEND bit can be used by the driver to suspend a device,
>>> in order to stablize the device states and virtqueue states.
>>>
>>> Its main use case is live migration.
>> I think patch 3 needs to be squashed into this one.
Patch 3 mentions Virtqueue State that is introduced in patch 2,
so I think patch 3 should placed after patch 2.

Thanks
>>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Eugenio PÃrez <eperezma@redhat.com>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>> ---
>>>   content.tex | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index 0a62dce..1bb4401 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>   \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>>>     drive the device.
>>>
>>> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
>>> +  device has been suspended by the driver.
>>> +
>>>   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>>>     an error from which it can't recover.
>>>   \end{description}
>>> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>   recover by issuing a reset.
>>>   \end{note}
>>>
>>> +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
>>> +
>>> +When set SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
>>> +
>>>   \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>>>
>>>   The device MUST NOT consume buffers or send any used buffer
>>> @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>>>   MUST send a device configuration change notification to the driver.
>>>
>>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
>> Is there any value to allow SUSPEND to be set without DRIVER_OK?
If live migration happens when the guest initializing the device,
maybe the guest driver has already configured some virtqueues or
modified the config space. At that point, We should allow to suspend
the device, because the hypervisor should not reset the device at
that moment.

SUSPEND requires FEATURES_OK because VIRTIO_F_SUSPEND has to be negotiated.
>>
>>> +
>>> +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
>> typo.
Yes
>>
>> Thanks
> Btw, it's not clear to me if driver is allowed to clear this bit.
Patch 1 mentions that DRIVER_OK clears SUSPEND, so that the driver
can resume the device if LM fails.

Thanks
>
> Thanks
>
>>> +
>>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST clear SUSPEND
>>> +and resumes operation upon DRIVER_OK.
>>> +
>>>   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>>>
>>>   Each virtio device offers all the features it understands.  During
>>> @@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>>          \ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>>>          handling features reserved for future use.
>>>
>>> +  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver can
>>> +   SUSPEND the device.
>>> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
>>> +
>>>   \end{description}
>>>
>>>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>>> --
>>> 2.35.3
>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

