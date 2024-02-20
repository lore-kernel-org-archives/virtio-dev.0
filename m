Return-Path: <virtio-dev-return-14335-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A2C48BC3
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Feb 2024 03:44:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 949D222363
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Feb 2024 03:44:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 719259864BB
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Feb 2024 03:44:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56FBE98648B; Tue, 20 Feb 2024 03:44:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 41EA59864A3
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2024 03:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2633501"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2633501"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4897426"
Message-ID: <f9f6e3ac-781e-48e0-a46b-988023c74514@intel.com>
Date: Tue, 20 Feb 2024 11:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 stevensd@chromium.org, virtio-dev@lists.oasis-open.org
References: <20240218132306.83456-1-lingshan.zhu@intel.com>
 <20240218090935-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240218090935-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH] virtio: introduce SUSPEND bit in device status



On 2/18/2024 10:11 PM, Michael S. Tsirkin wrote:
> On Sun, Feb 18, 2024 at 09:23:06PM +0800, Zhu Lingshan wrote:
>> This commit allows the driver to suspend the device by
>> introducing a new status bit SUSPEND in device_status.
>>
>> This commit also introduce a new feature bit VIRTIO_F_SUSPEND
>> which indicating whether the device support SUSPEND.
>>
>> This SUSPEND bit is transport-independent.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>
>
> Could we get some kind of dscription how this has taken into
> consideration the proposal from David Stevens?
sure thing, we can work with David together for a solution.
>
> I find it really tiring when there are competing patches with authors
> ignoring each other's work and leaving it up to reviewers to
> figure out how do the patches compare.
>
>> ---
>>   content.tex | 34 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index 0a62dce..3d656b5 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>   
>>   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>>     an error from which it can't recover.
>> +
>> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
>> +  device has been suspended by the driver.
>>   \end{description}
>>   
>>   The \field{device status} field starts out as 0, and is reinitialized to 0 by
>> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>   recover by issuing a reset.
>>   \end{note}
>>   
>> +The driver SHOULD NOT set SUSPEND if FEATURES_OK is not set.
>> +
>> +When setting SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
>> +
>>   \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>>   
>>   The device MUST NOT consume buffers or send any used buffer
>> @@ -82,6 +89,25 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>>   MUST send a device configuration change notification to the driver.
>>   
>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
>> +
>> +The device MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
>> +
>> +The device SHOULD allow settings to \field{device status} even when SUSPEND is set.
>> +
>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD clear SUSPEND
>> +and resumes operation upon DRIVER_OK.
>> +
>> +If VIRTIO_F_SUSPEND is negotiated, when the driver sets SUSPEND,
>> +the device SHOULD perform the following actions before presenting SUSPEND bit in the \field{device status}:
>> +
>> +\begin{itemize}
>> +\item Stop consuming buffers of any virtqueues and mark all finished descriptors as used.
>> +\item Wait until all descriptors that being processed to finish and mark them as used.
>> +\item Flush all used buffer and send used buffer notifications to the driver.
>> +\item Pause its operation except \field{device status} and preserve configurations in its Device Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
>> +\end{itemize}
>> +
>>   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>>   
>>   Each virtio device offers all the features it understands.  During
>> @@ -99,10 +125,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>>   \begin{description}
>>   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>>   
>> -\item[24 to 41] Feature bits reserved for extensions to the queue and
>> +\item[24 to 42] Feature bits reserved for extensions to the queue and
>>     feature negotiation mechanisms
>>   
>> -\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>> +\item[43 to 49, and 128 and above] Feature bits reserved for future extensions.
>>   \end{description}
>>   
>>   \begin{note}
>> @@ -872,6 +898,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>>   	handling features reserved for future use.
>>   
>> +  \item[VIRTIO_F_SUSPEND(42)] This feature indicates that the driver can
>> +   SUSPEND the device.
>> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
>> +
>>   \end{description}
>>   
>>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>> -- 
>> 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

