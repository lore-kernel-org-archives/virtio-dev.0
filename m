Return-Path: virtio-dev-return-5248-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89AF6985DA4
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Jan 2019 11:02:59 +0000 (UTC)
Date: Fri, 4 Jan 2019 12:02:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190104120251.2a6c0ac1.cohuck@redhat.com>
In-Reply-To: <1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
References: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
	<1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 1/2] virtio-balloon: tweak config_changed
 implementation
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri,  4 Jan 2019 15:11:52 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> virtio-ccw has deadlock issues with reading the config space inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> The config_read_bitmap is used as a flag to the workqueue callbacks
> about the related config fields that need to be read.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 81 +++++++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 28 deletions(-)
> 

(...)

> @@ -77,6 +81,8 @@ struct virtio_balloon {
>  	/* Prevent updating balloon when it is being canceled. */
>  	spinlock_t stop_update_lock;
>  	bool stop_update;
> +	/* Bitmap to indicate if reading the related config fields are needed */

s/are/is/

> +	unsigned long config_read_bitmap;
>  
>  	/* The list of allocated free pages, waiting to be given back to mm */
>  	struct list_head free_page_list;

(...)

Bitmap handling looks sane to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

