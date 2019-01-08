Return-Path: SRS0=cDPr=PQ=linuxfoundation.org=gregkh@kernel.org
Date: Tue, 08 Jan 2019 00:10:43 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/3] virtio-balloon: improve update_balloon_size_func
Message-ID: <20190108071043.GB32048@kroah.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com> <1546923005-40517-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546923005-40517-3-git-send-email-wei.w.wang@intel.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 08, 2019 at 12:50:04PM +0800, Wei Wang wrote:
> There is no need to update the balloon actual register when there is no
> ballooning request. This patch avoids update_balloon_size when diff is 0.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/virtio/virtio_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 45d32f5..d48c12c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -457,9 +457,12 @@ static void update_balloon_size_func(struct work_struct *work)
>  			  update_balloon_size_work);
>  	diff = towards_target(vb);
>  
> +	if (!diff)
> +		return;
> +
>  	if (diff > 0)
>  		diff -= fill_balloon(vb, diff);
> -	else if (diff < 0)
> +	else
>  		diff += leak_balloon(vb, -diff);
>  	update_balloon_size(vb);
>  
> -- 
> 2.7.4
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
