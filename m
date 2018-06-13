Return-Path: virtio-return-3129-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Jun 2018 11:59:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180613115908.29af1c54.cohuck@redhat.com>
In-Reply-To: <1528733518-24950-6-git-send-email-pasic@linux.ibm.com>
References: <1528733518-24950-1-git-send-email-pasic@linux.ibm.com>
	<1528733518-24950-6-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v2 5/6] mmio: map common notifications terminology to
 MMIO
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Jun 2018 18:11:57 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> The various notifications are introduced and specified in the common
> (i.e. transport agnostic) portion of this specification. How
> notifications are realised for a given transport is something each
> transport has to specify.
> 
> Let's make the relationship between the virtio over MIIO terms and the
> common terms more obvious.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  content.tex |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 98efdd2..213ecdf 100644
> --- a/content.tex
> +++ b/content.tex

(...)

> @@ -1716,26 +1716,28 @@ The driver will typically initialize the virtual queue in the following way:
>  \item Write 0x1 to \field{QueueReady}.
>  \end{enumerate}
>  
> -\subsubsection{Notifying The Device}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifying The Device}
> +\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Available Buffer Notifications}
>  
> -The driver notifies the device about new buffers being available in
> -a queue by writing the index of the updated queue to \field{QueueNotify}.
> +The driver sends an available buffer notification to the device by
> +writing the index of the queue to \field{QueueNotify} to be notified.

That reads a bit awkward.

"...by writing the index of the queue to be notified to \field{QueueNotify}."?

>  
>  \subsubsection{Notifications From The Device}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
>  
>  The memory mapped virtio device is using a single, dedicated
>  interrupt signal, which is asserted when at least one of the
>  bits described in the description of \field{InterruptStatus}
> -is set. This is how the device notifies the
> -driver about a new used buffer being available in the queue
> -or about a change in the device configuration.
> +is set. This is how the device sends a used buffer notification
> +or a configuration change notification to the device.
>  
>  \drivernormative{\paragraph}{Notifications From The Device}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
>  After receiving an interrupt, the driver MUST read
> -\field{InterruptStatus} to check what caused the interrupt
> -(see the register description). After the interrupt is handled,
> -the driver MUST acknowledge it by writing a bit mask
> -corresponding to the handled events to the InterruptACK register.
> +

Extra empty line?

> +\field{InterruptStatus} to check what caused the interrupt (see the
> +register description).  The used buffer notification bit being set
> +SHOULD be interpreted as a used buffer notification for each active
> +virtqueue.  After the interrupt is handled, the driver MUST acknowledge
> +it by writing a bit mask corresponding to the handled events to the
> +InterruptACK register.
>  
>  \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
>  


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

