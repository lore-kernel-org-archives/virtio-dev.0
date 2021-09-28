Return-Path: <virtio-dev-return-8734-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B39A98645B
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Sep 2021 10:43:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210928075535.100384-4-xuanzhuo@linux.alibaba.com>
References: <20210928075535.100384-1-xuanzhuo@linux.alibaba.com>
 <20210928075535.100384-4-xuanzhuo@linux.alibaba.com>
Date: Tue, 28 Sep 2021 12:43:30 +0200
Message-ID: <874ka556b1.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 3/3] virtio: mmio support virtqueue reset
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> mmio support virtqueue reset.
>
> MMIO Device Register Layout "QueueReady" to support virtqueue reset.
> The driver uses this to selectively reset the queue.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  content.tex | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index 1c35df5..3ff86b3 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1848,7 +1848,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      Writing to this register selects the virtual queue that the
>      following operations on \field{QueueNumMax}, \field{QueueNum}, \field{QueueReady},
>      \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
> -    \field{QueueDeviceLow} and \field{QueueDeviceHigh} apply to. The index
> +    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
>      number of the first queue is zero (0x0). 
>    }
>    \hline 
> @@ -1965,6 +1965,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      0xffffffffffffffff.
>    }
>    \hline 
> +  \mmioreg{QueueReset}{Virtual queue reset bit}{0x0c0}{RW}{%
> +    Writing one (0x1) to selectively reset the queue.  Reading from this

Hm...

"If VIRTIO_F_RING_RESET has been negotiated, writing one (0x1) to this
register selectively resets the queue."

?

> +    register returns the last value written to it. Both read and write accesses

Doesn't the register's value return to 0 if the queue is re-eanbled?

> +    apply to the queue selected by writing to \field{QueueSel}.
> +  }
> +  \hline
>    \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
>      Reading from this register returns a value describing a version of the device-specific configuration space (see \field{Config}).
>      The driver can then access the configuration space and, when finished, read \field{ConfigGeneration} again.
> @@ -2000,6 +2006,20 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  
>  The device MUST NOT access virtual queue contents when \field{QueueReady} is zero (0x0).
>  
> +If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> +\field{QueueReady} after the driver has reset the virtqueue via
> +\field{QueueReset}.
> +
> +If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> +\field{QueueReset} on reset.
> +
> +If VIRTIO_F_RING_RESET has been negotiated, The device MUST present a 0 in
> +\field{QueueReset} after the virtqueue is enabled with \field{QueueReady}.
> +
> +The device MUST reset the queue when 1 is written to \field{QueueReset}, and
> +present a 1 in \field{QueueReset} after the queue has been reset, until the
> +driver re-enables the queue via \field{QueueReady}. (see \ref{sec:Virtqueues / Virtqueue Reset}).

"...or until the device is reset."

> +
>  \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
>  The driver MUST NOT access memory locations not described in the
>  table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout}
> @@ -2042,6 +2062,13 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  The driver MUST write a value with a bit mask describing events it handled into \field{InterruptACK} when
>  it finishes handling an interrupt and MUST NOT set any of the undefined bits in the value.
>  
> +If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> +\field{QueueReset} to reset the queue, it MUST verify that the queue
> +has been reset by reading back \field{QueueReset} and ensuring that it
> +is 1. The driver MAY re-enable the queue by writing a 1 to
> +\field{QueueReady} after ensuring that the other virtqueue fields have
> +been set up correctly. (see \ref{sec:Virtqueues / Virtqueue Reset}).

Similar commments as for the PCI part regarding the various
queue-specific configuration values.

> +
>  \subsection{MMIO-specific Initialization And Device Operation}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation}
>  
>  \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}

This approach for MMIO looks sane to me (although I'm not an expert.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

