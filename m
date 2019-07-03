Return-Path: virtio-comment-return-780-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 3 Jul 2019 15:23:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190703152325.003b4933.cohuck@redhat.com>
In-Reply-To: <20190627192830.5285-5-dgilbert@redhat.com>
References: <20190627192830.5285-1-dgilbert@redhat.com>
	<20190627192830.5285-5-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [PATCH v5 4/5] shared memory: Define PCI capability
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 27 Jun 2019 20:28:29 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Define the PCI capability used for enumerating shared memory regions.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  content.tex | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 63e9179..fcf0d81 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -689,6 +689,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  #define VIRTIO_PCI_CAP_DEVICE_CFG        4
>  /* PCI configuration access */
>  #define VIRTIO_PCI_CAP_PCI_CFG           5
> +/* Shared memory region */
> +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>  \end{lstlisting}
>  
>          Any other value is reserved for future use.
> @@ -1075,6 +1077,24 @@ \subsubsection{Device-specific configuration}\label{sec:Virtio Transport Options
>  
>  The \field{offset} for the device-specific configuration MUST be 4-byte aligned.
>  
> +\subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> +
> +Shared memory regions \ref{sec:Basic Facilities of a Virtio
> +Device / Shared Memory Regions} are enumerated on the PCI transport
> +as a sequence of VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities, one per region.
> +
> +The capability is defined by a struct virtio_pci_cap64 and
> +utilises the \field{cap.id} to allow multiple shared memory
> +regions per device.

Maybe add a sentence here

"The identifier in \field{cap.id} does not denote a certain order of
preference; it is only used to uniquely identify a region."

(as per discussion of patch 2)

> +
> +\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> +
> +The region defined by the combination of the \field {cap.offset},
> +\field {cap.offset_hi}, and \field {cap.length}, \field
> +{cap.length_hi} fields MUST be contained within the declared bar.
> +
> +The \field{cap.id} MUST be unique for any one device instance.
> +
>  \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
>  
>  The VIRTIO_PCI_CAP_PCI_CFG capability

Else, looks good to me.

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

