Return-Path: virtio-return-2972-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 12:11:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307121158.34829f6b.cohuck@redhat.com>
In-Reply-To: <1519860484-7936-15-git-send-email-mst@redhat.com>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
	<1519860484-7936-15-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v9 14/16] VIRTIO_F_NOTIFICATION_DATA: extra data to
 devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 1 Mar 2018 01:31:37 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Motivation for the new feature is included in the text.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex      | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  introduction.tex |   4 +-
>  notifications.c  |   3 ++
>  3 files changed, 140 insertions(+), 8 deletions(-)
>  create mode 100644 notifications.c
> 
> diff --git a/content.tex b/content.tex
> index c57a918..4261913 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -283,9 +283,77 @@ Packed Virtqueues}).
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
> +\begin{description}
> +\item [VQ number]
> +\item [Offset]
> +      Within the ring where the next available ring entry
> +      will be written.
> +      Without VIRTIO_F_RING_PACKED this refers to the
> +      15 least significant bits of the available index.
> +      With VIRTIO_F_RING_PACKED this refers to the offset
> +      (in units of descritor entries)
> +      within the descriptor ring where the next available
> +      descriptor will be written.
> +\item [Wrap Counter]
> +      With VIRTIO_F_RING_PACKED this is the wrap counter
> +      referring to the next available descriptor.
> +      Without VIRTIO_F_RING_PACKED this is the most significant bit
> +      of the available index.
> +\end{description}
> +
> +Note that driver can trigger multiple notifications even without
> +making any more changes to the ring. When VIRTIO_F_NOTIFICATION_DATA
> +has been negotiated, these notifications would then have
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

Isn't that duplicating the information for the generic case?

(And if you wanted to specify something specific for the packed case,
shouldn't it go into packed-ring.tex?)

> +
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>  
>  We start with an overview of device initialization, then expand on the

(...)

> +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> +the driver notifies the device by writing the following
> +32-bit value to the Queue Notify address:
> +\begin{lstlisting}
> +le32 vqn : 16,
> +     next_off : 15,
> +     next_wrap : 1;

Don't we want to write this as

le32 vqn : 16;
le32 next_off :15;
le32 next_wrap : 1;

?

> +\end{lstlisting}
> +
> +See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> +for the definition of the components.
> +
> +See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability} for how to calculate the
> +Queue Notify address.
>  
>  \subsubsection{Virtqueue Interrupts From The Device}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Virtqueue Interrupts From The Device}
>  
> @@ -1500,8 +1604,19 @@ All register values are organized as Little Endian.
>    }
>    \hline 
>    \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> -    Writing a queue index to this register notifies the device that
> -    there are new buffers to process in the queue.
> +    Writing a value this register notifies the device that
> +    there are new buffers to process in a queue.
> +
> +    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> +    the value written is the queue index.
> +
> +    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> +    the value has the following format:
> +
> +    \lstinputlisting{notifications.c}

Doesn't mmio require this to be le explicitly?

> +
> +    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> +    for the definition of the components.
>    }
>    \hline 
>    \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
> @@ -2340,12 +2455,22 @@ GPR  &   Input Value     & Output Value \\
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
> +the value has the following format:
> +\lstinputlisting{notifications.c}

And we probably want to make this be explicitly.

> +
> +See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> +for the definition of the components.
> +
>  \devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
>  The device MUST ignore bits 0-31 (counting from the left) of GPR2.
>  This aligns passing the subchannel ID with the way it is passed
> @@ -5260,6 +5385,10 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>    \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
>    that all buffers are used by the device in the same
>    order in which they have been made available.
> +  \item[VIRTIO_F_NOTIFICATION_DATA(36)] This feature indicates
> +  that drivers pass extra data (besides identifying the Virtqueue)
> +  in their device notifications.
> +  See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> diff --git a/introduction.tex b/introduction.tex
> index 3cb7a70..d0b770e 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -163,8 +163,8 @@ from the least significant to the most significant bit.
>  
>  For example:
>  \begin{lstlisting}
> -be16 A : 15;
> -be16 B : 1;
> +be16 A : 15,
> +     B : 1;

Why are you dropping the second be16?

>  \end{lstlisting}
>  documents the value A stored in the low 15 bit of a 16 bit
>  integer and the value B stored in the high bit of the 16 bit
> diff --git a/notifications.c b/notifications.c
> new file mode 100644
> index 0000000..2ae96d4
> --- /dev/null
> +++ b/notifications.c
> @@ -0,0 +1,3 @@
> +u32 vqn : 16,
> +    next_off : 15,
> +    next_wrap : 1;

I'm wondering how useful the u32 notation is here.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

