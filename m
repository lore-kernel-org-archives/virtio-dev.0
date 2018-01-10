Return-Path: virtio-return-2831-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 16:50:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180110165018.158e80c1.cohuck@redhat.com>
In-Reply-To: <1515596714-18578-1-git-send-email-mst@redhat.com>
References: <1515596714-18578-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH RFC] content: generalize transport ring part
 naming
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 10 Jan 2018 17:05:40 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Replace descriptor table/available ring/used ring
> with descriptor area/driver area/device area
> in all transports.
> 
> Document what's in which area for each format.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Cornelia, this is more or less what you suggested, isn't it?
> 
> 
>  content.tex     | 61 +++++++++++++++++++++++++++++++++++++--------------------
>  packed-ring.tex |  6 +++---
>  split-ring.tex  |  6 +++---
>  3 files changed, 46 insertions(+), 27 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index f93c9ca..37b50c3 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -254,6 +254,24 @@ they have been made available. These devices can offer the
>  VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
>  might allow optimizations or simplify driver code.
>  
> +Each virtqueue can consist of up to 3 parts:
> +\begin{itemize}
> +\item Descriptor Area - used for describing buffers
> +\item Driver Area - extra data supplied by driver to the device
> +\item Device Area - extra data supplied by device to driver
> +\end{itemize}
> +
> +\begin{note}
> +Note that previous versions of this spec used different names for
> +these parts (following \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}):
> +\begin{itemize}
> +\item Descriptor Table - for the Descriptor Area
> +\item Available Ring - fir the Driver Area

s/fir/for/

> +\item Used Ring - for the Device Area
> +\end{itemize}
> +
> +\end{note}
> +
>  Two formats are supported: Split Virtqueues (see \ref{sec:Basic
>  Facilities of a Virtio Device / Split
>  Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device /
> @@ -683,8 +701,8 @@ struct virtio_pci_common_cfg {
>          le16 queue_enable;              /* read-write */
>          le16 queue_notify_off;          /* read-only for driver */
>          le64 queue_desc;                /* read-write */
> -        le64 queue_avail;               /* read-write */
> -        le64 queue_used;                /* read-write */
> +        le64 queue_driver;              /* read-write */
> +        le64 queue_device;              /* read-write */
>  };
>  \end{lstlisting}
>  
> @@ -744,13 +762,13 @@ struct virtio_pci_common_cfg {
>          \end{note}
>  
>  \item[\field{queue_desc}]
> -        The driver writes the physical address of Descriptor Table here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> +        The driver writes the physical address of Descriptor Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  
> -\item[\field{queue_avail}]
> -        The driver writes the physical address of Available Ring here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> +\item[\field{queue_driver}]
> +        The driver writes the physical address of Driver Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  
> -\item[\field{queue_used}]
> -        The driver writes the physical address of Used Ring here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> +\item[\field{queue_device}]
> +        The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  \end{description}
>  
>  \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> @@ -1512,24 +1530,24 @@ All register values are organized as Little Endian.
>      See also p. \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}.
>    }
>    \hline 
> -  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Table 64 bit long physical address}{0x080}{0x084}{W}{%
> +  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{%
>      Writing to these two registers (lower 32 bits of the address
>      to \field{QueueDescLow}, higher 32 bits to \field{QueueDescHigh}) notifies
> -    the device about location of the Descriptor Table of the queue
> +    the device about location of the Descriptor Area of the queue
>      selected by writing to \field{QueueSel} register.
>    }
>    \hline 
> -  \mmiodreg{QueueAvailLow}{QueueAvailHigh}{Virtual queue's Available Ring 64 bit long physical address}{0x090}{0x094}{W}{%
> +  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
>      Writing to these two registers (lower 32 bits of the address
>      to \field{QueueAvailLow}, higher 32 bits to \field{QueueAvailHigh}) notifies
> -    the device about location of the Available Ring of the queue
> +    the device about location of the Driver Area of the queue
>      selected by writing to \field{QueueSel}.
>    }
>    \hline 
> -  \mmiodreg{QueueUsedLow}{QueueUsedHigh}{Virtual queue's Used Ring 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
> +  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
>      Writing to these two registers (lower 32 bits of the address
>      to \field{QueueUsedLow}, higher 32 bits to \field{QueueUsedHigh}) notifies
> -    the device about location of the Used Ring of the queue
> +    the device about location of the Device Area of the queue
>      selected by writing to \field{QueueSel}.
>    }
>    \hline 
> @@ -1647,11 +1665,11 @@ The driver will typically initialize the virtual queue in the following way:
>  \item Notify the device about the queue size by writing the size to
>     \field{QueueNum}.
>  
> -\item Write physical addresses of the queue's Descriptor Table,
> -   Available Ring and Used Ring to (respectively) the
> +\item Write physical addresses of the queue's Descriptor Area,
> +   Driver Area and Device Area to (respectively) the
>     \field{QueueDescLow}/\field{QueueDescHigh},
> -   \field{QueueAvailLow}/\field{QueueAvailHigh} and
> -   \field{QueueUsedLow}/\field{QueueUsedHigh} register pairs.
> +   \field{QueueDriverLow}/\field{QueueDriverHigh} and
> +   \field{QueueDeviceLow}/\field{QueueDeviceHigh} register pairs.
>  
>  \item Write 0x1 to \field{QueueReady}.
>  \end{enumerate}
> @@ -2041,13 +2059,14 @@ struct vq_info_block {
>          be32 res0;
>          be16 index;
>          be16 num;
> -        be64 avail;
> -        be64 used;
> +        be64 driver;
> +        be64 device;
>  };
>  \end{lstlisting}
>  
> -\field{desc}, \field{avail} and \field{used} contain the guest addresses for the descriptor table,
> -available ring and used ring for queue \field{index}, respectively. The actual
> +\field{desc}, \field{driver} and \field{device} contain the guest
> +addresses for the descriptor area,
> +available area and used area for queue \field{index}, respectively. The actual
>  virtqueue size (number of allocated buffers) is transmitted in \field{num}.
>  
>  \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
> diff --git a/packed-ring.tex b/packed-ring.tex
> index a2cf8ec..eb6136a 100644
> --- a/packed-ring.tex
> +++ b/packed-ring.tex
> @@ -15,9 +15,9 @@ allocated by driver.
>  Each packed virtqueue consists of three parts:
>  
>  \begin{itemize}
> -\item Descriptor Ring
> -\item Device Event Suppression
> -\item Driver Event Suppression
> +\item Descriptor Ring - occupies the Descriptor Area
> +\item Device Event Suppression - occupies the Driver Area
> +\item Driver Event Suppression - occupies the Device Area
>  \end{itemize}
>  
>  Where Descriptor Ring in turn consists of descriptors,
> diff --git a/split-ring.tex b/split-ring.tex
> index 2770289..f976e45 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -15,9 +15,9 @@ of the queue.
>  Each virtqueue consists of three parts:
>  
>  \begin{itemize}
> -\item Descriptor Table
> -\item Available Ring
> -\item Used Ring
> +\item Descriptor Table - occupies the Descriptor Area
> +\item Available Ring - occupies the Driver Area
> +\item Used Ring - occupies the Device Area
>  \end{itemize}
>  
>  where each part is physically-contiguous in guest memory,

Looks good to me.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

