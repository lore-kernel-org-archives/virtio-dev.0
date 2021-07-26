Return-Path: <virtio-dev-return-8384-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2ED51985DF2
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jul 2021 11:03:13 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
Date: Mon, 26 Jul 2021 13:03:02 +0200
Message-ID: <87h7gh5od5.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain
To: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 23 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wrote:

> Changes since v0:
>
> Introduce a new feature bit, VIRTIO_F_MMIO_RESET_WAIT, which controls whether a driver polls
> for reset completion or not.

Nit: changelog should go into a "---" section, next to the diffstat (git
format-patch should give you the correct base to edit.)

>
> ===
>
> Reset of a virtio-mmio device is accomplished by writing 0 to its Status register.
> For devices that are emulated in software, writes to Status register are trapped
> and resumed only after the reset operation is complete. Thus a driver can be
> assured of reset completion as soon as its write completes.
>
> That may not be the case for virtio-mmio devices implemented in hardware
> directly. A write could complete before the reset operation inside device is
> completed. Introduce a new feature, VIRTIO_F_MMIO_RESET_WAIT, that such devices
> will offer as means to indicate to driver that they need to poll for reset
> completion, indicated by a read of Status register returning 0.
>
> Signed-off-by: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
>
> diff --git a/content.tex b/content.tex
> index 5c70a3c..1990a5c 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1924,7 +1924,10 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  do not represent events which took place MUST be zero.
>
>  Upon reset, the device MUST clear all bits in \field{InterruptStatus} and ready bits in the
> -\field{QueueReady} register for all queues in the device.
> +\field{QueueReady} register for all queues in the device. The device MUST also offer
> +VIRTIO_F_MMIO_RESET_WAIT if it requires driver to poll for reset completion

s/driver/the driver/

> +indicated by a read of \field{Status} returning 0. Such a device MUST also fail to accept
> +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT.

So, this basically means that an older driver that does not know the new
feature bit will not work with devices offering this bit, even if it did
poll? This seems acceptable, I just wanted to spell it out.

>
>  The device MUST change value returned in \field{ConfigGeneration} if there is any risk of a
>  driver seeing an inconsistent configuration state.
> @@ -1944,6 +1947,10 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  8 bit wide fields, 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide and
>  aligned accesses for 32 and 64 bit wide fields.
>
> +The driver MUST accept VIRTIO_F_MMIO_RESET_WAIT if offered by device. During

s/device/the device/

> +reset of such a device that offers VIRTIO_F_MMIO_RESET_WAIT, driver MUST poll for

s/driver/the driver/

But maybe use "if VIRTIO_F_MMIO_RESET_WAIT has been negotiated" instead?
This is implied by the statements above, but the deciding factor here is
that the feature has been negotiated, and not that it has been offered.


> +reset completion indicated by a read of \field{Status} returning 0.
> +
>  The driver MUST ignore a device with \field{MagicValue} which is not 0x74726976,
>  although it MAY report an error.
>
> @@ -6672,6 +6679,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    transport specific.
>    For more details about driver notifications over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>
> +  \item[VIRTIO_F_MMIO_RESET_WAIT(40)] This feature could be offered by a device
> +  using MMIO transport and indicates that the driver needs to poll for reset

"This feature is specific to the MMIO transport and indicates that the
device requires the driver to poll..."

?

> +  completion indicated by a read of \field{Status} returning 0.
> +
>  \end{description}
>
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> @@ -6708,6 +6719,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>
>  A driver SHOULD accept VIRTIO_F_NOTIF_CONFIG_DATA if it is offered.
>
> +A driver SHOULD accept VIRTIO_F_MMIO_RESET_WAIT if it is offered.
> +

But this was specified as MUST above, wasn't it?

>  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>
>  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

