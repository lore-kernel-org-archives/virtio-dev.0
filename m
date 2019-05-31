Return-Path: virtio-dev-return-5767-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB60C986015
	for <virtio-dev@lists.oasis-open.org>; Fri, 31 May 2019 16:59:32 +0000 (UTC)
Date: Fri, 31 May 2019 17:59:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531165918.GL3169@work-vm>
References: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
 <1557600460-18966-5-git-send-email-ndragazis@arrikto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557600460-18966-5-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] Re: [PATCH v3 4/4] vhost-user: update shared memory capability
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Nikos Dragazis (ndragazis@arrikto.com) wrote:
> The virtio vhost-user device has shared memory resources. Therefore, it
> uses the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability to standardize
> those resources through the PCI Configuration Space. This patch
> synchronizes the virtio vhost-user device spec with the following shared
> memory resources PATCH:
> 
> https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  virtio-vhost-user.tex | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index 7a8cd9c..d1305dd 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -320,7 +320,22 @@ \subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-use
>  \subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
>  
>  The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG
> -capability.
> +capability. Using the additional \field{offset_hi} and \field{length_hi}
> +fields following the SHARED_MEMORY_CFG capability structure, the shared
> +memory region's 64-bit BAR offset is calculated as follows:
> +
> +\begin{lstlisting}
> +        offset_hi << 32 + cap.offset
> +\end{lstlisting}
> +
> +and the shared memory region's 64-bit length is calculated as follows:
> +
> +\begin{lstlisting}
> +        length_hi << 32 + cap.length
> +\end{lstlisting}
> +
> +The \field{cap.offset} and \field{cap.length} fields are taken from the
> +SHARED_MEMORY_CFG capability structure.

Yes, or this could just reference the:
{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}

section once it's merged.

Do you actually need to specify that it's found by PCI though?
Could you just define it as using Shared Memory Regions,
reference {sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
and then it would be defined to work with PCI, MMIO or CCW if they
define the shared memory region support.

Dave


>  \devicenormative{\paragraph}{Shared Memory capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
>  The device MUST present exactly one shared memory capability.
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

