Return-Path: virtio-dev-return-7461-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89B9F986105
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jun 2020 10:08:02 +0000 (UTC)
Date: Thu, 11 Jun 2020 06:07:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200611060249-mutt-send-email-mst@kernel.org>
References: <20200611093518.5737-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200611093518.5737-1-david@redhat.com>
Subject: [virtio-dev] Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-mem: add memory via add_memory_driver_managed()


On Thu, Jun 11, 2020 at 11:35:18AM +0200, David Hildenbrand wrote:
> Virtio-mem managed memory is always detected and added by the virtio-mem
> driver, never using something like the firmware-provided memory map.
> This is the case after an ordinary system reboot, and has to be guaranteed
> after kexec. Especially, virtio-mem added memory resources can contain
> inaccessible parts ("unblocked memory blocks"), blindly forwarding them
> to a kexec kernel is dangerous, as unplugged memory will get accessed
> (esp. written).
> 
> Let's use the new way of adding special driver-managed memory introduced
> in commit 75ac4c58bc0d ("mm/memory_hotplug: introduce
> add_memory_driver_managed()").
> 
> This will result in no entries in /sys/firmware/memmap ("raw firmware-
> provided memory map"), the memory resource will be flagged
> IORESOURCE_MEM_DRIVER_MANAGED (esp., kexec_file_load() will not place
> kexec images on this memory), and it is exposed as "System RAM
> (virtio_mem)" in /proc/iomem, so esp. kexec-tools can properly handle it.
> 
> Example /proc/iomem before this change:
>   [...]
>   140000000-333ffffff : virtio0
>     140000000-147ffffff : System RAM
>   334000000-533ffffff : virtio1
>     338000000-33fffffff : System RAM
>     340000000-347ffffff : System RAM
>     348000000-34fffffff : System RAM
>   [...]
> 
> Example /proc/iomem after this change:
>   [...]
>   140000000-333ffffff : virtio0
>     140000000-147ffffff : System RAM (virtio_mem)
>   334000000-533ffffff : virtio1
>     338000000-33fffffff : System RAM (virtio_mem)
>     340000000-347ffffff : System RAM (virtio_mem)
>     348000000-34fffffff : System RAM (virtio_mem)
>   [...]
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: teawater <teawaterz@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Based on latest Linus' tree (and not a tag) because
> - virtio-mem has just been merged via the vhost tree
> - add_memory_driver_managed() has been merged a week ago via the -mm tree
> 
> I'd like to have this patch in 5.8, with the initial merge of virtio-mem
> if possible (so the user space representation of virtio-mem added memory
> resources won't change anymore).

So my plan is to rebase on top of -rc1 and merge this for rc2 then.
I don't like rebase on top of tip as the results are sometimes kind of
random.
And let's add a Fixes: tag as well, this way people will remember to
pick this.
Makes sense?


> ---
>  drivers/virtio/virtio_mem.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 50c689f250450..d2eab3558a9e1 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -101,6 +101,11 @@ struct virtio_mem {
>  
>  	/* The parent resource for all memory added via this device. */
>  	struct resource *parent_resource;
> +	/*
> +	 * Copy of "System RAM (virtio_mem)" to be used for
> +	 * add_memory_driver_managed().
> +	 */
> +	const char *resource_name;
>  
>  	/* Summary of all memory block states. */
>  	unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
> @@ -414,8 +419,20 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(addr);
>  
> +	/*
> +	 * When force-unloading the driver and we still have memory added to
> +	 * Linux, the resource name has to stay.
> +	 */
> +	if (!vm->resource_name) {
> +		vm->resource_name = kstrdup_const("System RAM (virtio_mem)",
> +						  GFP_KERNEL);
> +		if (!vm->resource_name)
> +			return -ENOMEM;
> +	}
> +
>  	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
> -	return add_memory(nid, addr, memory_block_size_bytes());
> +	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
> +					 vm->resource_name);
>  }
>  
>  /*
> @@ -1890,10 +1907,12 @@ static void virtio_mem_remove(struct virtio_device *vdev)
>  	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
>  	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
>  	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL] ||
> -	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE])
> +	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE]) {
>  		dev_warn(&vdev->dev, "device still has system memory added\n");
> -	else
> +	} else {
>  		virtio_mem_delete_resource(vm);
> +		kfree_const(vm->resource_name);
> +	}
>  
>  	/* remove all tracking data - no locking needed */
>  	vfree(vm->mb_state);
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

