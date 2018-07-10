Return-Path: virtio-dev-return-4662-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 104EC985B04
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Jul 2018 05:51:29 +0000 (UTC)
References: <20180709072241.8886-1-tiwei.bie@intel.com>
 <20180709072241.8886-6-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <27ae72ad-247b-e8f0-aa37-a75a719e0e01@redhat.com>
Date: Tue, 10 Jul 2018 13:51:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180709072241.8886-6-tiwei.bie@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v1 5/5] virtio_ring: enable packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年07月09日 15:22, Tiwei Bie wrote:
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   drivers/s390/virtio/virtio_ccw.c | 8 ++++++++
>   drivers/virtio/virtio_ring.c     | 2 ++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 8f5c1d7f751a..ff5b85736d8d 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -765,6 +765,11 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
>   	return rc;
>   }
>   
> +static void ccw_transport_features(struct virtio_device *vdev)
> +{
> +	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
> +}

I think we need a better comment to explain why it was disabled here.

Thanks

> +
>   static int virtio_ccw_finalize_features(struct virtio_device *vdev)
>   {
>   	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> @@ -791,6 +796,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
>   	/* Give virtio_ring a chance to accept features. */
>   	vring_transport_features(vdev);
>   
> +	/* Give virtio_ccw a chance to accept features. */
> +	ccw_transport_features(vdev);
> +
>   	features->index = 0;
>   	features->features = cpu_to_le32((u32)vdev->features);
>   	/* Write the first half of the feature bits to the host. */
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4b3f9e1a3cab..64f20023f088 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1968,6 +1968,8 @@ void vring_transport_features(struct virtio_device *vdev)
>   			break;
>   		case VIRTIO_F_IOMMU_PLATFORM:
>   			break;
> +		case VIRTIO_F_RING_PACKED:
> +			break;
>   		default:
>   			/* We don't understand this bit. */
>   			__virtio_clear_bit(vdev, i);


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

