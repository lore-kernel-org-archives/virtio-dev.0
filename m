Return-Path: <virtio-dev-return-8918-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82742986451
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 Nov 2021 16:02:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211015014414.98335-2-xuanzhuo@linux.alibaba.com>
References: <20211015014414.98335-1-xuanzhuo@linux.alibaba.com>
 <20211015014414.98335-2-xuanzhuo@linux.alibaba.com>
Date: Thu, 04 Nov 2021 17:02:15 +0100
Message-ID: <87v917aozc.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6 1/3] virtio: introduce virtqueue reset as basic facility
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 15 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

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

(...)

> +\devicenormative{\paragraph}{Virtqueue Reset}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset / Virtqueue Reset}
> +
> +After a queue has been reset by the driver, the device MUST NOT execute
> +any requests from that virtqueue, or notify the driver for it.
> +
> +The device MUST reset any state of a virtqueue to be reset to the default state,

s/to be reset//

> +including the available state and the used state.

(...)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

