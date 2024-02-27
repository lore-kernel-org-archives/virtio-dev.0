Return-Path: <virtio-dev-return-14359-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D73C5478C
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 02:22:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F2FDD1318CA
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 02:22:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7EE398644E
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 02:22:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ABB509863B6; Tue, 27 Feb 2024 02:22:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C21B9863DE
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2024 02:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7149034"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7149034"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11655956"
Message-ID: <e03d003e-ca23-4dd2-aeac-6df79ee5c1e6@intel.com>
Date: Tue, 27 Feb 2024 10:22:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: parav@nvidia.com
References: <20240227015345.3614965-1-stevensd@chromium.org>
 <20240227015345.3614965-2-stevensd@chromium.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240227015345.3614965-2-stevensd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v5 1/1] Add SUSPEND bit to device status



On 2/27/2024 9:53 AM, David Stevens wrote:
> Add a SUSPEND bit to the device status field to allow drivers to suspend
> virtio devices. On systems where drivers don't directly manage interrupt
> routing (e.g. Linux), this allows the drivers to suspend their devices
> and prevent interrupts from being sent when the interrupt routing system
> does not expect interrupts.
> ---
>   content.tex | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 84 insertions(+), 5 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 0a62dce5f65f..2183c63c45ea 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>   
>   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>     an error from which it can't recover.
> +
> +\item[SUSPEND (16)] Indicates that the device has been suspended by the
> +  driver. Only valid when the VIRTIO_F_SUSPEND feature bit is negotiated.
>   \end{description}
>   
>   The \field{device status} field starts out as 0, and is reinitialized to 0 by
> @@ -60,9 +63,11 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>   initialization sequence specified in
>   \ref{sec:General Initialization And Device Operation / Device
>   Initialization}.
> -The driver MUST NOT clear a
> -\field{device status} bit.  If the driver sets the FAILED bit,
> -the driver MUST later reset the device before attempting to re-initialize.
> +
> +The driver MUST NOT clear a \field{device status} bit, except for the
> +SUSPEND bit as described in \ref{sec:General Initialization And Device
> +Operation / Device Suspend}. If the driver sets the FAILED bit, the
> +driver MUST later reset the device before attempting to re-initialize.
Comparing to add a new exception, why not just re-setting DRIVER_OK to 
let the device
clearing SUSPEND? This issue has been addressed when Eugenio working on 
a similar STOP_BIT

https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.html

Not sure it is my email client bug, it shows the authorship has been 
reset and
all sign-off-by are removed. We have been working on this since 2021, 
how about
just include our updated patch(WIP) in a new series?

Thanks
>   
>   The driver SHOULD NOT rely on completion of operations of a
>   device if DEVICE_NEEDS_RESET is set.
> @@ -73,6 +78,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>   recover by issuing a reset.
>   \end{note}
>   
> +If VIRTIO_F_SUSPEND is negotiated, the driver MUST manage the SUSPEND bit
> +as described in \ref{sec:General Initialization And Device Operation /
> +Device Suspend}. Otherwise, the driver MUST NOT set the SUSPEND bit.
> +
>   \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>   
>   The device MUST NOT consume buffers or send any used buffer
> @@ -82,6 +91,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>   MUST send a device configuration change notification to the driver.
>   
> +If VIRTIO_F_SUSPEND is negotiated, the device MUST manage the SUSPEND bit
> +as described in \ref{sec:General Initialization And Device Operation /
> +Device Suspend}. Otherwise, the device MUST ignore the SUSPEND bit.
> +
>   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>   
>   Each virtio device offers all the features it understands.  During
> @@ -99,10 +112,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>   \begin{description}
>   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>   
> -\item[24 to 41] Feature bits reserved for extensions to the queue and
> +\item[24 to 42] Feature bits reserved for extensions to the queue and
>     feature negotiation mechanisms
>   
> -\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[43 to 49, and 128 and above] Feature bits reserved for future extensions.
>   \end{description}
>   
>   \begin{note}
> @@ -629,6 +642,67 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
>   
>   Thus a driver MUST ensure a virtqueue isn't live (by device reset) before removing exposed buffers.
>   
> +\section{Device Suspend}\label{sec:General Initialization And Device Operation / Device Suspend}
> +
> +When the VIRTIO_F_SUSPEND feature is negotiated, the driver can set the
> +SUSPEND bit in \field{device status} to suspend a live device, and can
> +clear the SUSPEND bit to resume a suspended device. A suspended device
> +should pause its operation, but it must maintain it state such that it
> +can immediately continue operation upon being resumed.
> +
> +Suspending a device via the SUSPEND bit is a seperate process from any
> +transport-specific suspend mechanism.
> +
> +\drivernormative{\subsection}{Device Suspend}{General Initialization And Device Operation / Device Suspend}
> +
> +The driver MUST NOT set the SUSPEND bit if the DRIVER_OK bit is not set.
> +
> +After writing a new value to the SUSPEND bit, the driver MUST wait for
> +the device to acknowledged the transition by reading from \field{device
> +status} until the returned value of the SUSPEND bit matches the written
> +value. During this period, the driver MAY abort the transition by writing
> +a new value to the SUSPEND bit or by resetting the device.
> +
> +A driver MUST NOT access the device configuration space of a suspended
> +device, except for \field{device status}.
> +
> +A driver MAY suspend a device that has buffers in its virtqueues. While
> +the device is suspended, a driver MUST NOT modify any available buffers
> +or their descriptors.
> +
> +A driver MUST NOT make any new buffers available to a suspended device.
> +
> +If a transport-specific suspend mechanism is available, the driver SHOULD
> +use it to put the device into a deeper suspend state after setting the
> +SUSPEND bit.
> +
> +\drivernormative{\subsection}{Device Suspend}{General Initialization And Device Operation / Device Suspend}
> +
> +A device MUST ignore writes to the SUSPEND bit if the DRIVER_OK bit is
> +not set.
> +
> +A device MUST maintain its state while suspended such that all driver
> +visible state after resuming exactly matches driver visible state
> +before suspending.
> +
> +A device MUST ignore all writes to its configuration space while
> +suspended, except for writes to \field{device status}.
> +
> +A device MUST NOT send notifications, access any virtqueues, or modify
> +any fields in its configuration space while suspended.
> +
> +A device MAY send notifications, access any virtqueues, or modify its
> +configuration space after the driver writes the SUSPEND bit but before
> +the device acknowledges the transition by returning a \field{device
> +status} value with the SUSPEND bit set. A device SHOULD finish processing
> +and send the used buffer notification for any buffers it is able to
> +before acknowledging the transition, but MAY retain buffers that cannot
> +be immiedately processed (e.g. empty buffers in a network recieveq).
> +
> +A device SHOULD take steps to minimize its resource consumption while
> +suspended, although what this involves is specific to the particular
> +device implementation.
> +
>   \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
>   
>   Virtio can use various different buses, thus the standard is split
> @@ -872,6 +946,11 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>   	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>   	handling features reserved for future use.
>   
> +  \item[VIRTIO_F_SUSPEND(42)] This feature indicates that the driver can
> +    suspend the device via the SUSPEND bit in \field{device status} (see
> +    \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}).
> +
> +
>   \end{description}
>   
>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

