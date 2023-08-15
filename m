Return-Path: <virtio-dev-return-13541-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5493EC001B0
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:31:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B52DF2B050
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:31:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD0859863D8
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:31:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A19AA98637D; Tue, 15 Aug 2023 10:31:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F89398634B;
	Tue, 15 Aug 2023 10:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="351838042"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="351838042"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736867221"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="736867221"
Message-ID: <56c6411d-2ee9-f2c2-4da7-8d708f7729a2@intel.com>
Date: Tue, 15 Aug 2023 18:31:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
 <20230814143039.GD3146793@fedora>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230814143039.GD3146793@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 1/5] virtio: introduce SUSPEND bit in
 device status



On 8/14/2023 10:30 PM, Stefan Hajnoczi wrote:
> On Tue, Aug 15, 2023 at 03:29:00AM +0800, Zhu Lingshan wrote:
>> This patch introudces a new status bit in the device status: SUSPEND.
>>
>> This SUSPEND bit can be used by the driver to suspend a device,
>> in order to stablize the device states and virtqueue states.
>>
>> Its main use case is live migration.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Eugenio PÃrez <eperezma@redhat.com>
> There is an character encoding issue in Eugenio's surname.
Oh, I copied his SOB form his email, I will copy from git log to fix this,
thanks for point out it.
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   content.tex | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
> This patch hints at the asynchronous nature of the SUSPEND bit (the
> driver must re-read the Device Status Field) but doesn't explain the
> rationale or any limits.
>
> For example, is there a timeout or should the driver re-read the Device
> Status Field forever?
It depends on the driver, normally we expect this operation can be done 
successfully
like how the driver/device handles FEATURES_OK.

Once failed due to:
1) driver timeout, the driver can reset the device
2) device failure, the device can set NEEDS_RESET.
>
> Does the driver need to re-read the Device Status Field after clearing
> the SUSPEND bit?
I think the driver should re-read, I will add this in the next version.
>
>> diff --git a/content.tex b/content.tex
>> index 0a62dce..1bb4401 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>   \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>>     drive the device.
>>   
>> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
>> +  device has been suspended by the driver.
>> +
>>   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>>     an error from which it can't recover.
>>   \end{description}
>> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>   recover by issuing a reset.
>>   \end{note}
>>   
>> +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
>> +
>> +When set SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
> "When setting SUSPEND, ..." would be grammatically correct. Another
> option is "After setting the SUSPEND bit, ...".
Will fix in the next version.
>
>> +
>>   \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>>   
>>   The device MUST NOT consume buffers or send any used buffer
>> @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>>   MUST send a device configuration change notification to the driver.
>>   
>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
>> +
>> +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
>> +
>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST clear SUSPEND
>> +and resumes operation upon DRIVER_OK.
> I can't parse this sentence. If the driver writes SUSPEND | DRIVER_OK |
> ... to the Device Status Field, then the device accepts DRIVER_OK and
> clears SUSPEND?
>
> Why?
I expect DRIVER_OK can clear SUSPEND, so that the device can resume running
in case of a failed live migration.

Maybe I should say: DRIVER_OK clears SUSPEND, and if DRIVER_OK is set to
a suspended device, the device should resume operation

Thanks
>
>> +
>>   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>>   
>>   Each virtio device offers all the features it understands.  During
>> @@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>>   	handling features reserved for future use.
>>   
>> +  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver can
>> +   SUSPEND the device.
>> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
>> +
>>   \end{description}
>>   
>>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>> -- 
>> 2.35.3
>>
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
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

