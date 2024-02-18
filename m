Return-Path: <virtio-dev-return-14327-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4429C4829E
	for <virtio-dev@archiver.kernel.org>; Sun, 18 Feb 2024 10:59:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E8B9F2AF86
	for <virtio-dev@archiver.kernel.org>; Sun, 18 Feb 2024 10:59:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7C31986471
	for <virtio-dev@archiver.kernel.org>; Sun, 18 Feb 2024 10:59:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A936A985E3F; Sun, 18 Feb 2024 10:59:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95956986144
	for <virtio-dev@lists.oasis-open.org>; Sun, 18 Feb 2024 10:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="13449121"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="13449121"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="8847565"
Message-ID: <08168769-ff8b-4ef1-8587-279f69f1268d@intel.com>
Date: Sun, 18 Feb 2024 18:59:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 David Stevens <stevensd@chromium.org>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org, parav@nvidia.com
References: <20240216082432.709956-1-stevensd@chromium.org>
 <20240216082432.709956-2-stevensd@chromium.org>
 <20240216035144-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240216035144-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v4 1/1] Add suspend support for virtio
 PCI devices



On 2/16/2024 4:56 PM, Michael S. Tsirkin wrote:
> On Fri, Feb 16, 2024 at 05:24:32PM +0900, David Stevens wrote:
>> Add a virtio power management PCI capability to allow drivers to suspend
>> virtio PCI devices. This allows drivers to suspend devices at the virtio
>> level before suspending them at the PCI transport layer. This allows
>> drivers to do a two phase suspend, which prevents notifications from
>> being ignored or lost if interrupts are reconfigured at the PCI
>> transport layer immediately before or after the device is put into the
>> PCI PM D3 low power state.
>> ---
>>   transport-pci.tex | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/transport-pci.tex b/transport-pci.tex
>> index a5c6719ea871..ce77708a9b69 100644
>> --- a/transport-pci.tex
>> +++ b/transport-pci.tex
>> @@ -188,6 +188,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>>   #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>>   /* Vendor-specific data */
>>   #define VIRTIO_PCI_CAP_VENDOR_CFG        9
>> +/* Power management configuration */
>> +#define VIRTIO_PCI_CAP_PM_CFG            10
>>   \end{lstlisting}
>>   
>>           Any other value is reserved for future use.
>> @@ -804,6 +806,55 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
>>   specified by some other Virtio Structure PCI Capability
>>   of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
>>   
>> +\subsubsection{Power management capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Power management capability}
>> +
>> +The VIRTIO_PCI_CAP_PM_CFG capability refers to a single byte. The
>> +driver can write to the byte to set the power state of the device,
>> +and it can read from the byte to get the current power state of the
>> +device.
>> +
>> +The valid power states are:
>> +
>> +\begin{lstlisting}
>> +/* Device is operating normally */
>> +#define VIRTIO_PM_STATE_ACTIVE    0
>> +/* Device operation is suspended */
>> +#define VIRTIO_PM_STATE_SUSPENDED 1
>> +\end{lstlisting}
>> +
>> +The device power state has no effect when \field{device status} does
>> +not have the DRIVER_OK bit set or does have the DEVICE_NEEDS_RESET bit
>> +set.
>
> Given this is only after DRIVER_OK, wouldn't a feature bit + status bit
> make more sense? This will make it transport-independent and simplify
> discovery.
I agree with Michael, I have ever proposed a solution suspending the device
by setting _SUSPEND in the device_status field. I will send this suspending
patch again(will cc you) in a few days.

Thanks
Zhu Lingshan
>
>> +\devicenormative{\paragraph}{Power management capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Power management capability}
>> +
>> +A device MUST maintain its state while suspended such that all driver
>> +visible state after resuming exactly matches driver visible state
>> +before suspending.
>> +
>> +A device MUST NOT send notifications while suspended.
>> +
>> +A device MAY operate on any buffers in its virtqueue while suspended.
> How is this reconsiled with state matching exactly? buffers are
> driver-visible ...
>
>> +A device MUST set its power state to VIRTIO_PM_STATE_ACTIVE on reset.
>> +
>> +A device SHOULD take steps to minimize its resource consumption while
>> +suspended, although what this involves is specific to the particular
>> +device implementation.
>> +
>> +\drivernormative{\paragraph}{Power management capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Power management capability}
>> +
>> +A driver MUST NOT access a suspended device's BARs corresponding to
>> +any virtio structures, except for the power management byte.
>> +
>> +A driver MAY suspend a device that has buffers in one of its
>> +virtqueues, but it MUST NOT modify any such buffers while the device
>> +is suspended.
>> +
>> +A driver MUST read from the power management byte after writing to the
>> +byte to verify that the device successfully entered the target power
>> +state.
> Verify how? By checking the value returned? And what should it do with the value
> does not match?
>
>
>> +
>>   \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
>>   
>>   Transitional devices MUST present part of configuration
>> -- 
>> 2.44.0.rc0.258.g7320e95886-goog
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

