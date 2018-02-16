Return-Path: virtio-return-2908-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 16 Feb 2018 18:00:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216180004.1c466a6e.cohuck@redhat.com>
In-Reply-To: <20180216092622-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
	<20180216092622-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v8 14/16] VIRTIO_F_NOTIFICATION_DATA: extra data to
 devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Feb 2018 09:26:22 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Motivation for the new feature is included in the text.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 130 insertions(+), 6 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index c57a918..ca6d2d9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -283,9 +283,76 @@ Packed Virtqueues}).
>  Every driver and device supports either the Packed or the Split
>  Virtqueue format, or both.
>  
> +\subsection{Driver notifications} \label{sec:Virtqueues / Driver notifications}
> +Driver is sometimes required to notify the device after
> +making changes to the virtqueue.
> +
> +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> +this notification involves sending the
> +virtqueue number to the device (depending on the transport).
> +
> +However, some devices benefit from ability to find out the number of
> +available descriptors in the ring, and whether to send
> +interrupts to drivers without accessing virtqueue in memory:
> +for efficiency or as a debugging aid.
> +
> +To help with these optimizations, when VIRTIO_F_NOTIFICATION_DATA
> +has been negotiated, driver notifications to the device include
> +the following information:
> +
> +\begin{itemize}
> +\item VQ number
> +\item Offset
> +      Within the ring where the next available ring entry
> +      will be written.
> +      Without VIRTIO_F_RING_PACKED this refers to the
> +      15 least significant bits of the available index.
> +      With VIRTIO_F_RING_PACKED this refers to the offset
> +      (in units of descritor entries)
> +      within the descriptor ring where the next available
> +      descriptor will be written.
> +\item Wrap Counter
> +      With VIRTIO_F_RING_PACKED this is the wrap counter
> +      referring to the next available descriptor.
> +      Without VIRTIO_F_RING_PACKED this is the most significant bit
> +      of the available index.
> +\end{itemize}

This looks a bit odd in the resulting pdf...

> +
> +Note that driver can trigger multiple notifications even without
> +making any more changes to the ring. These would then have
> +identical \field{Offset} and \field{Wrap Counter} values.
> +
>  \input{split-ring.tex}
>  
>  \input{packed-ring.tex}
> +
> +\subsubsection{Driver notifications}
> +
> +\label{sec:Packed Virtqueues / Driver notifications}
> +Whenever not suppressed by Device Event Suppression,
> +driver is required to notify the device after
> +making changes to the virtqueue.
> +
> +Some devices benefit from ability to find out the number of
> +available descriptors in the ring, and whether to send
> +interrupts to drivers without accessing virtqueue in memory:
> +for efficiency or as a debugging aid.
> +
> +To help with these optimizations, driver notifications
> +to the device include the following information:
> +
> +\begin{itemize}
> +\item VQ number
> +\item Offset (in units of descriptor size) within the ring
> +      where the next available descriptor will be written
> +\item Wrap Counter referring to the next available
> +      descriptor
> +\end{itemize}
> +
> +Note that driver can trigger multiple notifications even without
> +making any more changes to the ring. These would then have
> +identical \field{Offset} and \field{Wrap Counter} values.

So, this in effect makes NOTIFICATION_DATA mandatory for the packed
ring... or is this just a leftover hunk?

(...)

> @@ -2340,12 +2449,23 @@ GPR  &   Input Value     & Output Value \\
>  \hline
>    2   &  Subchannel ID    & Host Cookie  \\
>  \hline
> -  3   & Virtqueue number  &              \\
> +  3   & Notification data &              \\
>  \hline
>    4   &   Host Cookie     &              \\
>  \hline
>  \end{tabular}
>  
> +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> +the \field{Notification data} includes the Virtqueue number.
> +
> +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> +the \field{Notification data} is calculated as follows:
> +
> +\begin{lstlisting}
> +u32 notification_data = vqn | (next_off << 16) | (next_wrap << 31);
> +\end{lstlisting}

It would be good to add a reference to the part where the components of
the notification data are defined.

Otherwise, I think this looks fine (did not really look at the details
for pci or mmio).

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

