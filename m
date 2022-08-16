Return-Path: <virtio-dev-return-9793-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A3F89863BA
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Aug 2022 16:27:52 +0000 (UTC)
Date: Tue, 16 Aug 2022 02:31:47 +0000
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Message-ID: <YvsBk/UnAgvrqMNR@bullseye>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <3d1f32c4da81f8a0870e126369ba12bc8c4ad048.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <3d1f32c4da81f8a0870e126369ba12bc8c4ad048.1660362668.git.bobby.eshleman@bytedance.com>
Subject: [virtio-dev] Re: [PATCH 4/6] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Bobby Eshleman <bobby.eshleman@bytedance.com>, Cong Wang <cong.wang@bytedance.com>, Jiang Wang <jiang.wang@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

CC'ing virtio-dev@lists.oasis-open.org

On Mon, Aug 15, 2022 at 10:56:07AM -0700, Bobby Eshleman wrote:
> This commit adds a feature bit for virtio vsock to support datagrams.
> 
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
>  drivers/vhost/vsock.c             | 3 ++-
>  include/uapi/linux/virtio_vsock.h | 1 +
>  net/vmw_vsock/virtio_transport.c  | 8 ++++++--
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index b20ddec2664b..a5d1bdb786fe 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -32,7 +32,8 @@
>  enum {
>  	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
>  			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> -			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
> +			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET) |
> +			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
>  };
>  
>  enum {
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 64738838bee5..857df3a3a70d 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -40,6 +40,7 @@
>  
>  /* The feature bitmap for virtio vsock */
>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
> +#define VIRTIO_VSOCK_F_DGRAM		2	/* Host support dgram vsock */
>  
>  struct virtio_vsock_config {
>  	__le64 guest_cid;
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index c6212eb38d3c..073314312683 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -35,6 +35,7 @@ static struct virtio_transport virtio_transport; /* forward declaration */
>  struct virtio_vsock {
>  	struct virtio_device *vdev;
>  	struct virtqueue *vqs[VSOCK_VQ_MAX];
> +	bool has_dgram;
>  
>  	/* Virtqueue processing is deferred to a workqueue */
>  	struct work_struct tx_work;
> @@ -709,7 +710,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>  	}
>  
>  	vsock->vdev = vdev;
> -
>  	vsock->rx_buf_nr = 0;
>  	vsock->rx_buf_max_nr = 0;
>  	atomic_set(&vsock->queued_replies, 0);
> @@ -726,6 +726,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
>  		vsock->seqpacket_allow = true;
>  
> +	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
> +		vsock->has_dgram = true;
> +
>  	vdev->priv = vsock;
>  
>  	ret = virtio_vsock_vqs_init(vsock);
> @@ -820,7 +823,8 @@ static struct virtio_device_id id_table[] = {
>  };
>  
>  static unsigned int features[] = {
> -	VIRTIO_VSOCK_F_SEQPACKET
> +	VIRTIO_VSOCK_F_SEQPACKET,
> +	VIRTIO_VSOCK_F_DGRAM
>  };
>  
>  static struct virtio_driver virtio_vsock_driver = {
> -- 
> 2.35.1
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

