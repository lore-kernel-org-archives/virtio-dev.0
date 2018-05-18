Return-Path: virtio-dev-return-4093-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DA7358191C4
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 May 2018 01:14:57 -0700 (PDT)
Date: Fri, 18 May 2018 10:14:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180518101438.6748a49d.cohuck@redhat.com>
In-Reply-To: <20180518073855.21070-1-tiwei.bie@intel.com>
References: <20180518073855.21070-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [RFC] content: support SR-IOV
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 18 May 2018 15:38:55 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> Reserve a feature bit for virtio devices which support SR-IOV.

Reserving a feature bit for this makes sense, but...

> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> More details can be found from this thread:
> https://patchwork.kernel.org/patch/10285541/
> 
>  content.tex | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 7a92cb1..62214fa 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -95,10 +95,10 @@ Feature bits are allocated as follows:
>  \begin{description}
>  \item[0 to 23] Feature bits for the specific device type
>  
> -\item[24 to 33] Feature bits reserved for extensions to the queue and
> +\item[24 to 36] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
>  
> -\item[34 and above] Feature bits reserved for future extensions.
> +\item[37 and above] Feature bits reserved for future extensions.
>  \end{description}
>  
>  \begin{note}
> @@ -5348,6 +5348,8 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>    \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
>    that all buffers are used by the device in the same
>    order in which they have been made available.
> +  \item[VIRTIO_F_SR_IOV(36)] This feature indicates that
> +  the device supports Single Root I/O Virtualization.

...shouldn't this mention 'PCI' somewhere? This feature does not make
sense on any transport but PCI.

>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> @@ -5363,6 +5365,10 @@ addresses to the device.
>  
>  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
>  
> +A driver SHOULD accept VIRTIO_F_SR_IOV if it is offered.
> +If VIRTIO_F_SR_IOV has been negotiated, a driver can
> +access device's SR-IOV capability structure.
> +
>  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>  
>  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> @@ -5376,6 +5382,10 @@ accepted.
>  If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
>  buffers in the same order in which they have been available.
>  
> +A device SHOULD offer VIRTIO_F_SR_IOV if it presents a SR-IOV
> +capability structure.  A device MAY fail to operate further
> +if VIRTIO_F_SR_IOV is not accepted.
> +
>  \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
>  
>  Transitional devices MAY offer the following:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

