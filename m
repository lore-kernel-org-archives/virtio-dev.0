Return-Path: virtio-dev-return-4000-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EBA35818EFB
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 20:02:12 -0700 (PDT)
References: <20180428022356.29355-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2cebdb43-e0ca-8d73-1a23-4e88436d01d4@redhat.com>
Date: Sat, 28 Apr 2018 11:01:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180428022356.29355-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v1] VIRTIO_F_IO_BARRIER: use I/O barriers in
 driver
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, virtio-dev@lists.oasis-open.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年04月28日 10:23, Tiwei Bie wrote:
> There will be hardware virtio devices in the future, which
> require drivers to use the barriers suitable for I/O devices,
> compared with software virtio devices which just require
> drivers to use the barriers suitable for CPU cores.
>
> To fix the ordering issue for hardware virtio devices, add
> a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> will use the barriers suitable for I/O devices.
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> RFC -> v1:
> - Use plural (Stefan);
> - Add more details (Stefan);
>
>   content.tex | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index ae5fa4c..a1c09c4 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5445,6 +5445,13 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>     that drivers pass extra data (besides identifying the Virtqueue)
>     in their device notifications.
>     See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
> +  \item[VIRTIO_F_IO_BARRIER(37)] This feature indicates that the device
> +  needs the driver to use the barriers suitable for hardware devices.

Users may ask what the specific kinds of barrier here (e.g mmio barrier 
or dma barrier). Do we need to clarify that?

Thanks

> +  Some transports require barriers to ensure devices have a consistent
> +  view of memory.  When devices are implemented in software a weaker
> +  form of barrier may be sufficient and yield better performance.
> +  This feature indicates whether a stronger form of barrier suitable
> +  for hardware devices is necessary.
>   \end{description}
>   
>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> @@ -5460,6 +5467,10 @@ addresses to the device.
>   
>   A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
>   
> +A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> +If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> +the barriers suitable for hardware devices.
> +
>   \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>   
>   A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> @@ -5473,6 +5484,9 @@ accepted.
>   If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
>   buffers in the same order in which they have been available.
>   
> +A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> +is not accepted.
> +
>   \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
>   
>   Transitional devices MAY offer the following:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

