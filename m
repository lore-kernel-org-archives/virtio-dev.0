Return-Path: virtio-return-3193-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 26 Nov 2018 12:33:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181126123318.0dea2dc9.cohuck@redhat.com>
In-Reply-To: <20181121033312.23041-1-mst@redhat.com>
References: <20181121033312.23041-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] [PATCH v2] VIRTIO_F_NOTIFICATION_DATA: extra data
 to devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, David Riddoch <driddoch@solarflare.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 20 Nov 2018 22:35:32 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Some devices benefit from ability to find out the number of available
> descriptors in the ring: for efficiency or as a debugging aid.
> 
> To help with these optimizations, add a new feature:
> VIRTIO_F_NOTIFICATION_DATA. When negotiated, driver notifications to the
> device include this extra information.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes from v1:
> - rebased on master
> - included support for MMIO
> - minor wording fixes
> 
>  content.tex        | 122 ++++++++++++++++++++++++++++++++++++++++++---
>  notifications-be.c |   5 ++
>  notifications-le.c |   5 ++
>  3 files changed, 124 insertions(+), 8 deletions(-)
>  create mode 100644 notifications-be.c
>  create mode 100644 notifications-le.c
> 
> diff --git a/content.tex b/content.tex
> index 4fef3ad..38c9182 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -331,6 +331,46 @@ Virtqueue format, or both.
>  \input{split-ring.tex}
>  
>  \input{packed-ring.tex}
> +
> +\subsection{Driver notifications} \label{sec:Virtqueues / Driver notifications}
> +The driver is sometimes required to send an available buffer
> +notification to the device.
> +
> +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> +this notification involves sending the
> +virtqueue number to the device (method depending on the transport).
> +
> +However, some devices benefit from the ability to find out the
> +amount of available data in the queue without accessing the virtqueue in memory:
> +for efficiency or as a debugging aid.
> +
> +To help with these optimizations, when VIRTIO_F_NOTIFICATION_DATA
> +has been negotiated, driver notifications to the device include
> +the following information:
> +
> +\begin{description}
> +\item [vqn] VQ number to be notified.
> +\item [next_off] Offset
> +      within the ring where the next available ring entry
> +      will be written.
> +      Without VIRTIO_F_RING_PACKED this refers to the
> +      15 least significant bits of the available index.

What about "If VIRTIO_F_RING_PACKED has not been negotiated, ..." (and
"has been negotiated" in the reverse case) instead? The without/with
wording looks fine as well, though.

> +      With VIRTIO_F_RING_PACKED this refers to the offset
> +      (in units of descriptor entries)
> +      within the descriptor ring where the next available
> +      descriptor will be written.
> +\item [next_wrap] Wrap Counter.
> +      With VIRTIO_F_RING_PACKED this is the wrap counter
> +      referring to the next available descriptor.
> +      Without VIRTIO_F_RING_PACKED this is the most significant bit
> +      (bit 15) of the available index.
> +\end{description}
> +
> +Note that the driver can send multiple notifications even without
> +making any more buffers available. When VIRTIO_F_NOTIFICATION_DATA
> +has been negotiated, these notifications would then have
> +identical \field{next_off} and \field{next_wrap} values.
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>  
>  We start with an overview of device initialization, then expand on the

(...)

> @@ -1548,8 +1619,19 @@ All register values are organized as Little Endian.
>    }
>    \hline 
>    \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> -    Writing a queue index to this register notifies the device that
> -    there are new buffers to process in the queue.
> +    Writing a value this register notifies the device that

s/this/to this/

> +    there are new buffers to process in a queue.
> +
> +    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> +    the value written is the queue index.
> +
> +    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> +    the value has the following format:
> +
> +    \lstinputlisting{notifications-le.c}
> +
> +    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> +    for the definition of the components.
>    }
>    \hline 
>    \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%

(...)

> @@ -5495,6 +5597,10 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>    \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
>    the device supports Single Root I/O Virtualization.
>    Currently only PCI devices support this feature.
> +  \item[VIRTIO_F_NOTIFICATION_DATA(38)] This feature indicates
> +  that drivers passes extra data (besides identifying the Virtqueue)

s/drivers/the driver/
s/Virtqueue/virtqueue/

> +  in their device notifications.

s/their/its/

> +  See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}

(...)

Otherwise, looks good.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

