Return-Path: virtio-dev-return-5243-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FA4D985C1A
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 17:28:58 +0000 (UTC)
Date: Thu, 3 Jan 2019 18:28:49 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190103160804.21438-3-cohuck@redhat.com>
References: <20190103160804.21438-1-cohuck@redhat.com>
	<20190103160804.21438-3-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190103182849.7b0b0f0b@oc2783563651>
Subject: [virtio-dev] Re: [PATCH 2/2] virtio: document virtio_config_ops restrictions
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu,  3 Jan 2019 17:08:04 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Some transports (e.g. virtio-ccw) implement virtio operations that
> seem to be a simple read/write as something more involved that
> cannot be done from an atomic context.
> 
> Give at least a hint about that.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/linux/virtio_config.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 7087ef946ba7..987b6491b946 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -12,6 +12,11 @@ struct irq_affinity;
>  
>  /**
>   * virtio_config_ops - operations for configuring a virtio device
> + * Note: Do not assume that a transport implements all of the operations
> + *       getting/setting a value as a simple read/write! Generally speaking,
> + *       any of @get/@set, @get_status/@set_status, or @get_features/
> + *       @finalize_features are NOT safe to be called from an atomic
> + *       context.

I think the only exception is @bus_name (and maybe @generation, I don't
know) because it does not have to 'speak' with the hypervisor. If a
transport operation has to 'speak' with the hypervisor, we do it by
making it interpret a channel program. That means not safe to be called
form atomic context. Or am I missing something?

Regards,
Halil


>   * @get: read the value of a configuration field
>   *	vdev: the virtio_device
>   *	offset: the offset of the configuration field


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

