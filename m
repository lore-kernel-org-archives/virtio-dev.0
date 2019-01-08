Return-Path: SRS0=cDPr=PQ=linuxfoundation.org=gregkh@kernel.org
Date: Tue, 08 Jan 2019 00:10:50 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 3/3] virtio_balloon: remove the unnecessary 0-initialization
Message-ID: <20190108071049.GC32048@kroah.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com> <1546923005-40517-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546923005-40517-4-git-send-email-wei.w.wang@intel.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 08, 2019 at 12:50:05PM +0800, Wei Wang wrote:
> We've changed to kzalloc the vb struct, so no need to 0-initialize
> this field one more time.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index d48c12c..048959a 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -925,7 +925,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
>  		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
> -		vb->num_free_page_blocks = 0;
>  		spin_lock_init(&vb->free_page_list_lock);
>  		INIT_LIST_HEAD(&vb->free_page_list);
>  		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> -- 
> 2.7.4
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
