Return-Path: virtio-dev-return-5305-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FDAB985D1D
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 16:29:53 +0000 (UTC)
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
 <1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 9 Jan 2019 17:29:19 +0100
MIME-Version: 1.0
In-Reply-To: <1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Message-Id: <ed55e8b4-1274-a57e-bc84-c857f9d661fe@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v1 1/2] virtio_pci: use queue idx instead of array idx to
 set up the vq
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Cc: stable@vger.kernel.org
Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")


On 28.12.2018 03:26, Wei Wang wrote:
> When find_vqs, there will be no vq[i] allocation if its corresponding
> names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> with names[2] being NULL because the related feature bit is turned off,
> so technically there are 3 queues on the device, and name[4] should
> correspond to the 3rd queue on the device.
> 
> So we use queue_idx as the queue index, which is increased only when the
> queue exists.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 465a6f5..d0584c0 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -285,7 +285,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	u16 msix_vec;
> -	int i, err, nvectors, allocated_vectors;
> +	int i, err, nvectors, allocated_vectors, queue_idx = 0;
>  
>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
> @@ -321,7 +321,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  			msix_vec = allocated_vectors++;
>  		else
>  			msix_vec = VP_MSIX_VQ_VECTOR;
> -		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
> +		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
>  				     ctx ? ctx[i] : false,
>  				     msix_vec);
>  		if (IS_ERR(vqs[i])) {
> @@ -356,7 +356,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
>  		const char * const names[], const bool *ctx)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	int i, err;
> +	int i, err, queue_idx = 0;
>  
>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
> @@ -374,7 +374,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
>  			vqs[i] = NULL;
>  			continue;
>  		}
> -		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
> +		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
>  				     ctx ? ctx[i] : false,
>  				     VIRTIO_MSI_NO_VECTOR);
>  		if (IS_ERR(vqs[i])) {
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

