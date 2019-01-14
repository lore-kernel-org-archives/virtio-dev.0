Return-Path: virtio-dev-return-5320-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BEB7984378
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Jan 2019 14:10:09 +0000 (UTC)
Date: Mon, 14 Jan 2019 15:09:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190114150958.39a4a56a.cohuck@redhat.com>
In-Reply-To: <20190103160804.21438-2-cohuck@redhat.com>
References: <20190103160804.21438-1-cohuck@redhat.com>
	<20190103160804.21438-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 1/2] virtio: fix virtio_config_ops description
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, Wei Wang <wei.w.wang@intel.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu,  3 Jan 2019 17:08:03 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> - get_features has returned 64 bits since commit d025477368792
>   ("virtio: add support for 64 bit features.")
> - properly mark all optional callbacks
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/linux/virtio_config.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 32baf8e26735..7087ef946ba7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -22,7 +22,7 @@ struct irq_affinity;
>   *	offset: the offset of the configuration field
>   *	buf: the buffer to read the field value from.
>   *	len: the length of the buffer
> - * @generation: config generation counter
> + * @generation: config generation counter (optional)
>   *	vdev: the virtio_device
>   *	Returns the config generation counter
>   * @get_status: read the status byte
> @@ -48,17 +48,17 @@ struct irq_affinity;
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
> - *	Returns the first 32 feature bits (all we currently need).
> + *	Returns the first 64 feature bits (all we currently need).
>   * @finalize_features: confirm what device features we'll be using.
>   *	vdev: the virtio_device
>   *	This gives the final feature bits for the device: it can change
>   *	the dev->feature bits if it wants.
>   *	Returns 0 on success or error status
> - * @bus_name: return the bus name associated with the device
> + * @bus_name: return the bus name associated with the device (optional)
>   *	vdev: the virtio_device
>   *      This returns a pointer to the bus name a la pci_name from which
>   *      the caller can then copy.
> - * @set_vq_affinity: set the affinity for a virtqueue.
> + * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
>   */
>  typedef void vq_callback_t(struct virtqueue *);

Ping. Any feedback on that patch?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

