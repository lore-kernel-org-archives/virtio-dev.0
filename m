Return-Path: virtio-dev-return-5326-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B4199849F8
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Jan 2019 01:00:31 +0000 (UTC)
Date: Mon, 14 Jan 2019 20:00:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114195450-mutt-send-email-mst@kernel.org>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
 <1546844466-38079-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546844466-38079-3-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v3 2/3] virtio-balloon: improve update_balloon_size_func
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 07, 2019 at 03:01:05PM +0800, Wei Wang wrote:
> There is no need to update the balloon actual register when there is no
> ballooning request. This patch avoids update_balloon_size when diff is 0.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

It sounds reasonable but it does have a side effect of
not writing into actual anymore.

I am not sure actual never can get out of sync as a result.

So better deferred, pls send this in the next merge window.




> ---
>  drivers/virtio/virtio_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index fb12fe2..e33dc8e 100644
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

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

