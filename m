Return-Path: <virtio-dev-return-13769-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD9EEAA42
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 02:57:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 942092B36F
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 02:57:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E2D198666B
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 02:57:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 82240986660; Fri, 15 Sep 2023 02:57:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 717C4986659;
	Fri, 15 Sep 2023 02:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="382963905"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="382963905"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="738167563"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="738167563"
Message-ID: <258989c9-8c5f-c72e-c03d-aabf11f9823d@intel.com>
Date: Fri, 15 Sep 2023 10:57:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-3-lingshan.zhu@intel.com>
 <20230914073023-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230914073023-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 2/5] virtio: introduce SUSPEND bit in device status



On 9/14/2023 7:34 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 06, 2023 at 04:16:34PM +0800, Zhu Lingshan wrote:
>> This patch introduces a new status bit in the device status: SUSPEND.
>>
>> This SUSPEND bit can be used by the driver to suspend a device,
>> in order to stabilize the device states and virtqueue states.
>>
>> Its main use case is live migration.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>> ---
>>   content.tex | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 0e492cd..0fab537 100644
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
>> +The driver SHOULD NOT set SUSPEND if FEATURES_OK is not set.
>> +
>> +When setting SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
>> +
>>   \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>>   
>>   The device MUST NOT consume buffers or send any used buffer
>> @@ -82,6 +89,26 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>>   MUST send a device configuration change notification to the driver.
>>   
>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
>> +
>> +The device MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
> why? let's just forbid driver from setting it.
OK
>
>> +
>> +The device SHOULD allow settings to \field{device status} even when SUSPEND is set.
>> +
>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD clear SUSPEND
>> +and resumes operation upon DRIVER_OK.
>> +
> sorry what?
In case of a failed or cancelled Live Migration, the device needs to 
resume operation.
However the spec forbids the driver to clear a device status bit, so 
re-writing
DRIVER_OK is expected to clear SUSPEND and the device resume operation.
>
>> +If VIRTIO_F_SUSPEND is negotiated, when the driver sets SUSPEND,
>> +the device SHOULD perform the following actions before presenting SUSPEND bit in the \field{device status}:
>> +
>> +\begin{itemize}
>> +\item Stop consuming buffers of any virtqueues and mark all finished descritors as used.
>> +\item Wait until all descriptors that being processed to finish and mark them as used.
>> +\item Flush all used buffer and send used buffer notifications to the driver.
> flush how?
This is device-type-specific, and we will include tracking inflight 
descriptors(buffers) in V2.
>
>> +\item Record Virtqueue State of each enabled virtqueue, see section \ref{sec:Virtqueues / Virtqueue State}
>
> record where?
This is transport specific, for PCI, patch 5 introduces two new fields 
for avail and used state
>
>> +\item Pause its operation except \field{device status} and preserve configurations in its Device Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
> pause in what sense? completely?  this does not seem realistic.
> e.g. pci express link has to stay active or device will die.
only pause virtio, I will rephrase the sentence as "pause its virtio 
operation".
Others like PCI link in the example is out of the spec and we don't need
to migrate them.
>
>
> also, presumably here it is except a bunch of other fields.
> e.g. what about queue select and all related queue fields?
For now they are forbidden.

As SiWei suggested, we will introduce a new feature bit to control whether
allowing resetting a VQ after SUSPEND. We can use more feature bits if
there are requirements to perform anything after SUSPEND. But for now
they are forbidden.
>
>> +\end{itemize}
>> +
>>   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>>   
>>   Each virtio device offers all the features it understands.  During
>> @@ -937,6 +964,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
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

