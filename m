Return-Path: <virtio-dev-return-8758-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 093699843EC
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Oct 2021 11:27:37 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210930175008.88352-2-xuanzhuo@linux.alibaba.com>
References: <20210930175008.88352-1-xuanzhuo@linux.alibaba.com>
 <20210930175008.88352-2-xuanzhuo@linux.alibaba.com>
Date: Fri, 01 Oct 2021 13:27:29 +0200
Message-ID: <871r553rz2.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 1/3] virtio: introduce virtqueue reset
 as basic facility
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 01 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> This patch allows the driver to reset a queue individually.
>
> This is very common on general network equipment. By disabling a queue,
> you can quickly reclaim the buffer currently on the queue. If necessary,
> we can reinitialize the queue separately.
>
> For example, when virtio-net implements support for AF_XDP, we need to
> disable a queue to release all the original buffers when AF_XDP setup.
> And quickly release all the AF_XDP buffers that have been placed in the
> queue when AF_XDP exits.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  content.tex | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 37c45d3..dd095f4 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -350,6 +350,48 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>  Every driver and device supports either the Packed or the Split
>  Virtqueue format, or both.
>  
> +\subsection{Virtqueue Reset}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}
> +
> +When VIRTIO_F_RING_RESET is negotiated, the driver can reset a virtqueue
> +individually. The way to reset the virtqueue is transport specific.
> +
> +Virtqueue reset is divided into two parts. The driver first resets a queue and
> +can afterwards optionally re-enable it.
> +
> +\subsubsection{Virtqueue Reset}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset / Virtqueue Reset}
> +
> +\devicenormative{\paragraph}{Virtqueue Reset}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset / Virtqueue Reset}
> +
> +After a queue has been reset by the driver, the device MUST NOT execute
> +any requests from that virtqueue, or notify the driver for it.
> +
> +The device MUST reset any state of a virtqueue to be reset to the default state,

This sentence looks a bit strange; probably should be

"The device MUST reset any state of a virtqueue to the default state",
or
"The device MUST cause any state of a virtqueue to be reset to the
default state"

> +including the available state and the used state.

Otherwise, the generic description now looks good to me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

