Return-Path: <virtio-dev-return-8710-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2509A98615E
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Sep 2021 03:41:23 +0000 (UTC)
MIME-Version: 1.0
References: <20210916075333.26772-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210916075333.26772-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Sep 2021 11:41:06 +0800
Message-ID: <CACGkMEvuSP=HoOKZteU1bObFbueCK8mL6zLg3WONVVe_rduNoQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH] virtio: introduce VIRTIO_F_RING_RESET for reset queue
Content-Type: text/plain; charset="UTF-8"
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 16, 2021 at 3:53 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> This patch allows the driver to reset a queue individually.
>
> This is very common on general network equipment. By disabling a queue,
> you can quickly reclaim the buffer currently on the queue. If necessary,
> we can reinitialize the queue separately.
>
> For example, when virtio-net implements support for AF_XDP, we need to
> disable a queue to release all the original buffers when AF_XDP setup.
> And quickly release all the AF_XDP buffers that have been placed in the
> queue when AF_XDP exits.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  content.tex | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 3aeb4a4..235cbf9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1001,7 +1001,13 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  After writing 0 to \field{device_status}, the driver MUST wait for a read of
>  \field{device_status} to return 0 before reinitializing the device.
>
> -The driver MUST NOT write a 0 to \field{queue_enable}.
> +If the VIRTIO_F_RING_RESET feature bit is not negotiated,
> +the driver MUST NOT write a 0 to \field{queue_enable}.

I guess what you actually mean is "write a 1"?

> +
> +Otherwise, if the VIRTIO_F_RING_RESET feature bit is negotiated,
> +the driver can stop using the queue by writing a 0 to \field{queue_enable} and

I believe it's actually preventing the device from using the queue.

> +MUST read the value back to ensure synchronization. Then optionally re-enable
> +the queue.

See above, write 1 should enable the queue not zero?

>
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>
> @@ -1964,9 +1970,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  \field{QueueNum}, \field{QueueDescLow}, \field{QueueDescHigh},
>  \field{QueueDriverLow}, \field{QueueDriverHigh}, \field{QueueDeviceLow}, \field{QueueDeviceHigh}.
>
> -To stop using the queue the driver MUST write zero (0x0) to this
> +If the VIRTIO_F_RING_RESET feature bit is not negotiated,
> +to stop using the queue the driver MUST write zero (0x0) to this
>  \field{QueueReady} and MUST read the value back to ensure
> -synchronization.
> +synchronization. But the queue cannot be re-enabled.
> +
> +Otherwise, if the VIRTIO_F_RING_RESET feature bit is negotiated,
> +the driver can stop using the queue by writing a 0 to \field{QueueReady} and
> +MUST read the value back to ensure synchronization. Then optionally re-enable
> +the queue.
>
>  The driver MUST ignore undefined bits in \field{InterruptStatus}.
>
> @@ -6673,6 +6685,20 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    transport specific.
>    For more details about driver notifications over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>
> +  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
> +  that the driver can reset a queue individually.
> +
> +  "reset a queue" is divided into two parts. We can stop a queue first, and then
> +  re-enable the queue. The re-enable part is optional.
> +
> +  In the process of independently stopping a queue, we MUST first notify the
> +  device and confirm that we have successfully stopped a queue. Then we destroy
> +  the state and memory of the queue.

I think we need to define the "stop" here. E.g queue_enable has the
following description:

"The driver uses this to selectively prevent the device from executing
requests from this virtqueue"

And as we discussed, if we "stop" and "re-enable" does the queue
continue from the previous state?

> +
> +  Re-enable the queue, just like the process of a queue during the reset process.
> +  Reallocate memory and set the state.

Who will do the reallocation and set? Is it the driver or the device?

> For example, the avail index MUST be the
> +  same as the reset process, set to 0.

I guess the "avail index" should be the one stored in the device, not
the one in the memory. We then need to clarify this.

I was thinking we probably need to clarify the queue state [1] and I
wonder if it's better to introduce a new field like "queue_reset"
instead of reusing queue_enable.

(Not a native speaker but using queue_enble feels like the queue can
resume with the previous states).

Thanks

[1] https://markmail.org/message/os2hoamjd6theoje

> +
>  \end{description}
>
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> --
> 2.31.0
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

