Return-Path: <virtio-dev-return-8793-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF767986495
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Oct 2021 09:25:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211005171801.595250-1-parav@nvidia.com>
References: <20211005171801.595250-1-parav@nvidia.com>
Date: Wed, 06 Oct 2021 11:25:13 +0200
Message-ID: <87v92azerq.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org
Cc: mgurtovoy@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 05 2021, Parav Pandit <parav@nvidia.com> wrote:

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
> v0->v1:
> - v0: https://lists.oasis-open.org/archives/virtio-dev/202109/msg00133.html
> - Addressed below comments from Cornelia Huck
> - renamed VIRTIO_F_DEV_RESET_TO to VIRTIO_F_DEV_RESET_TIMEOUT
> - removed references to device initialization sequence during device
>   reset flow
> - rewrote 'giving up on device'
> ---
>  content.tex | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 37c45d3..c87833d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -73,6 +73,12 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
>  
> +Once the driver initiates a reset, the device may not be able to finish the reset
> +immediately. Such device provides a hint to the driver about how long a
> +device may take to complete the reset.

Maybe

"To accommodate that situation, the device can provide a hint to the
driver about how long it might take the device to complete the reset."

> Driver should wait at least for the

s/Driver/The driver/

> +time specified by the device to let device finish the reset or if
> +the device status field to become 0 within the specified time interval.

Hm, status == 0 is supposed to signal completion of the reset anyway,
no? What about rewording this to

"...for the device status field to become 0, signifying completion of
the reset operation."

?

> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>  
>  The device MUST NOT consume buffers or send any used buffer
> @@ -210,11 +216,20 @@ \section{Device Reset}\label{sec:Basic Facilities of a Virtio Device / Device Re
>  indicating completion of the reset by reinitializing \field{device status}
>  to 0, until the driver re-initializes the device.
>  
> +A device may not be able to complete reset action when the driver initiates a reset operation.

"...may not be able to complete the reset action immediately..." ?

> +Such a device should provide the hint as to how long a device may take to finish the reset operation.

s/the hint/a hint/

> +This hint is provided by the device using device reset timeout field in units of 10 milliseconds.

Maybe

"This hint is provided by the device via a device reset timeout value in
units of 10 milliseconds."

?

> +
>  \drivernormative{\subsection}{Device Reset}{Basic Facilities of a Virtio Device / Device Reset}
>  
>  The driver SHOULD consider a driver-initiated reset complete when it
>  reads \field{device status} as 0.
>  
> +When a device reports a non-zero device reset timeout value, the driver SHOULD wait for the device
> +to finish the reset action before considering the reset operation to have failed. When

"...the driver SHOULD NOT consider the reset operation to have failed
unless the specified timeout has expired." ?

> +device reset timeout is not provided by the device, driver SHOULD choose a reasonable timeout

Maybe "When no device reset timeout is provided..." ?
s/driver/the driver/

> +value for reset operation to complete.

s/reset operation/the reset operation/

> +
>  \section{Device Configuration Space}\label{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
>  
>  Device configuration space is generally used for rarely-changing or
> @@ -859,6 +874,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
>          le16 queue_notify_data;         /* read-only for driver */
> +        /* About the whole device. */
> +        le16 device_reset_timeout;      /* read-only for driver */

Is a 16 bit value reasonable for all devices? It very likely is (that's
10 minutes or so), but having to extend it later may be annoying. What
values would you expect for the devices you know of today?

>  };
>  \end{lstlisting}
>  
> @@ -938,6 +955,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          may benefit from providing another value, for example an internal virtqueue
>          identifier, or an internal offset related to the virtqueue number.
>          \end{note}
> +
> +\item[\field{device_reset_timeout}]
> +        This field exists only if the VIRTIO_F_DEV_RESET_TIMEOUT is advertised by the device.

s/if the/if/

> +        This field provides the hint to the driver indicating how much maximum time a
> +        device can take to complete the reset once the driver initiates the device reset
> +        operation. This field unit is in 10 milliseconds. For example, a field value of
> +        3 indicates device reset timeout is 30 milliseconds. When VIRTIO_F_DEV_RESET_TIMEOUT
> +	feature is set by the device this field must contain a non zero value.

s/feature is set/is offered/ ?

> +
>  \end{description}
>  
>  \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> @@ -1804,6 +1830,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      accesses apply to the queue selected by writing to \field{QueueSel}.
>    }
>    \hline 
> +  \mmioreg{DeviceResetTimeout}{Device reset timeout}{0x04c}{R}{%
> +    This register exists only if the VIRTIO_F_DEV_RESET_TIMEOUT is advertised by the device.
> +    It provides the hint to the driver indicating how much maximum time a
> +    device can take to complete the reset once the driver initiates the device reset operation.
> +    This field unit is in 10 milliseconds. For example, a field value of 3 indicates device
> +    reset timeout is 30 milliseconds. When VIRTIO_F_DEV_RESET_TIMEOUT feature is set by the device
> +    this field must contain a non zero value.

Same nits here as for the PCI definition above.

> +  }
> +  \hline
>    \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
>      Writing a value to this register notifies the device that
>      there are new buffers to process in a queue.
> @@ -6673,6 +6708,11 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    transport specific.
>    For more details about driver notifications over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>  
> +  \item[VIRTIO_F_DEV_RESET_TIMEOUT(40)] This feature indicates that the device
> +  advertises a maximum reset timeout which the driver should use during device reset stage.

"...advertises a timeout value for the device reset operation." ?

> +  For more details about device reset timeout over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}.
> +  For more details about device reset timeout over MMIO see \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}.
> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}

Not quite sure yet how to model this for CCW, but it should not present
any problems (I'm not aware of any devices addressed via CCW that would
currently need this anyway... an advertised timeout value for *any* CCW
operation that involves channel I/O would make more sense, I think. But
that's beyond the scope of this proposal, and I'm not sure if we would
be able to come up with anything sane considering the other variables
like delays on the channel etc. involved, anyway.)

So on the whole, I think this basically looks good.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

