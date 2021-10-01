Return-Path: <virtio-dev-return-8759-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 125219843EC
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Oct 2021 12:01:11 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210930091759.525267-1-parav@nvidia.com>
References: <20210930091759.525267-1-parav@nvidia.com>
Date: Fri, 01 Oct 2021 14:01:02 +0200
Message-ID: <87y27d2bup.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org
Cc: mgurtovoy@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 30 2021, Parav Pandit <parav@nvidia.com> wrote:

> Motivation:
> ==========
> Currently when driver initiates a device reset operation, a device may
> not be able finish the reset operation immediately. In such case driver
> waits for an arbitrary amount of time in a hope that device will finish
> the reset. Depending on the device type and its backend implementation a
> device timeout can be different. Trying to wait for all device type in
> same value may not be efficient or adequate.
>
> Proposal:
> ========
> Hence, enhance the specification to let device report a device reset
> timeout value in milliseconds. Such hint helps driver to know how long
> should it wait for device reset to finish.
>
> This proposal introduces optional device reset timeout field for MMIO
> and PCI transports. Such transports have a use case where virtio devices
> are implemented in hardware and made available to the guest.
>
> A device reset timeout field has following attributes.
> (a) It is an optional field to maintain backward compatibility.
> (b) It is valid only when device advertises a new feature bit
>     VIRTIO_F_DEV_RESET_TO
> (b) When it is not advertised, this field is invalid and driver should
>     choose the reasonable reset timeout.
> (c) It is a 16-bit field covering wide range of timeout from 10
> milliseconds to several hundred seconds.
>
> This proposal is an improvement over a past proposal [1].
> Instead of just passing a flag for wait, this proposal offers upper bound
> wait time making the device reset timeout and overall device initialization
> more predictable.
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202108/msg00161.html
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> ---
> changelog:
> v1->v2:
> - address comments from Max
> - added comment that it is device specific for the new field
> - added description to say that device reset timeout of zero is invalid
> - fixed unit of the field in description
> v0->v1:
> - address comments from Shahaf, Max, Oren
> - several grammar corrections
> - changed timer granularity from 1msec to 10mec
> - changed device reset timeout field from le32 to le16
> - added VIRTIO_F_DEV_RESET_TO device feature bit
> ---
>  content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 37c45d3..d52daf9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -73,6 +73,15 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
>  
> +Once the driver initiates a reset, the device may not be able to finish the reset
> +immediately. Such device provides a hint to the driver about how long a
> +device may take to complete the reset. Driver should wait at least for the
> +time specified by the device to let device finish the reset or if
> +the device status field to become 0 within the specified time interval.

Would such a timeout also apply to the virtqueue reset that is discussed
elsewhere on the virtio lists?

Can transports specify what can actually time out? For example, for an
asynchronous transport like ccw, it might make sense to have the timeout
apply to the interrupt that is supposed to come in for the RESET command
(the driver then can try to terminate the running command, if desired.)

> +Such driver initialization sequence specified in
> +\ref{sec:General Initialization And Device Operation / Device
> +Initialization}.

I'm sorry, I don't parse that statement.

> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>  
>  The device MUST NOT consume buffers or send any used buffer
> @@ -210,11 +219,20 @@ \section{Device Reset}\label{sec:Basic Facilities of a Virtio Device / Device Re
>  indicating completion of the reset by reinitializing \field{device status}
>  to 0, until the driver re-initializes the device.
>  
> +A device may not be able to complete reset action when the driver initiates a reset operation.
> +Such a device should provide the hint as to how long a device may take to finish the reset operation.
> +This hint is provided by the device using device reset timeout field in units of 10 milliseconds.

Is this supposed to go into the device config space? Or can each
transport decide how to expose the value?

> +
>  \drivernormative{\subsection}{Device Reset}{Basic Facilities of a Virtio Device / Device Reset}
>  
>  The driver SHOULD consider a driver-initiated reset complete when it
>  reads \field{device status} as 0.
>  
> +When a device reports a non-zero device reset timeout value, the driver SHOULD wait for the device
> +to finish the reset action during the initialization sequence before giving up on the device. When
> +device reset timeout is not provided by the device, driver SHOULD choose a reasonable timeout
> +value for reset operation to complete.

Is the driver allowed to not time the reset action out at all?

What does "giving up on the device" imply? Can the driver perform some
recovery actions (e.g for ccw, the driver may be able to terminate the
running reset command and re-try)?

What about a reset that is done outside of the initialization sequence?

(...)

> @@ -6673,6 +6711,11 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    transport specific.
>    For more details about driver notifications over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>  
> +  \item[VIRTIO_F_DEV_RESET_TO(40)] This feature indicates that the device

I think we should spell this out as VIRTIO_F_DEV_RESET_TIMEOUT (RESET_TO
makes me wonder what we try to reset the device to.)

> +  advertises a maximum reset timeout which the driver should use during device reset stage.
> +  For more details about device reset timeout over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}.
> +  For more details about device reset timeout over MMIO see \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}.
> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

