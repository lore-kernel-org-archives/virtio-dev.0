Return-Path: <virtio-dev-return-9791-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F2879863BA
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Aug 2022 16:27:08 +0000 (UTC)
Date: Tue, 16 Aug 2022 02:30:59 +0000
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Message-ID: <YvsBYyPFnKRhvPfp@bullseye>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <d81818b868216c774613dd03641fcfe63cc55a45.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <d81818b868216c774613dd03641fcfe63cc55a45.1660362668.git.bobby.eshleman@bytedance.com>
Subject: [virtio-dev] Re: [PATCH 2/6] vsock: return errors other than -ENOMEM to socket
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Bobby Eshleman <bobby.eshleman@bytedance.com>, Cong Wang <cong.wang@bytedance.com>, Jiang Wang <jiang.wang@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

CC'ing virtio-dev@lists.oasis-open.org

On Mon, Aug 15, 2022 at 10:56:05AM -0700, Bobby Eshleman wrote:
> This commit allows vsock implementations to return errors
> to the socket layer other than -ENOMEM. One immediate effect
> of this is that upon the sk_sndbuf threshold being reached -EAGAIN
> will be returned and userspace may throttle appropriately.
> 
> Resultingly, a known issue with uperf is resolved[1].
> 
> Additionally, to preserve legacy behavior for non-virtio
> implementations, hyperv/vmci force errors to be -ENOMEM so that behavior
> is unchanged.
> 
> [1]: https://gitlab.com/vsock/vsock/-/issues/1
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
>  include/linux/virtio_vsock.h            | 3 +++
>  net/vmw_vsock/af_vsock.c                | 3 ++-
>  net/vmw_vsock/hyperv_transport.c        | 2 +-
>  net/vmw_vsock/virtio_transport_common.c | 3 ---
>  net/vmw_vsock/vmci_transport.c          | 9 ++++++++-
>  5 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 17ed01466875..9a37eddbb87a 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -8,6 +8,9 @@
>  #include <net/sock.h>
>  #include <net/af_vsock.h>
>  
> +/* Threshold for detecting small packets to copy */
> +#define GOOD_COPY_LEN  128
> +
>  enum virtio_vsock_metadata_flags {
>  	VIRTIO_VSOCK_METADATA_FLAGS_REPLY		= BIT(0),
>  	VIRTIO_VSOCK_METADATA_FLAGS_TAP_DELIVERED	= BIT(1),
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index e348b2d09eac..1893f8aafa48 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1844,8 +1844,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>  			written = transport->stream_enqueue(vsk,
>  					msg, len - total_written);
>  		}
> +
>  		if (written < 0) {
> -			err = -ENOMEM;
> +			err = written;
>  			goto out_err;
>  		}
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index fd98229e3db3..e99aea571f6f 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -687,7 +687,7 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
>  	if (bytes_written)
>  		ret = bytes_written;
>  	kfree(send_buf);
> -	return ret;
> +	return ret < 0 ? -ENOMEM : ret;
>  }
>  
>  static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 920578597bb9..d5780599fe93 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -23,9 +23,6 @@
>  /* How long to wait for graceful shutdown of a connection */
>  #define VSOCK_CLOSE_TIMEOUT (8 * HZ)
>  
> -/* Threshold for detecting small packets to copy */
> -#define GOOD_COPY_LEN  128
> -
>  static const struct virtio_transport *
>  virtio_transport_get_ops(struct vsock_sock *vsk)
>  {
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index b14f0ed7427b..c927a90dc859 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1838,7 +1838,14 @@ static ssize_t vmci_transport_stream_enqueue(
>  	struct msghdr *msg,
>  	size_t len)
>  {
> -	return vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
> +	int err;
> +
> +	err = vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
> +
> +	if (err < 0)
> +		err = -ENOMEM;
> +
> +	return err;
>  }
>  
>  static s64 vmci_transport_stream_has_data(struct vsock_sock *vsk)
> -- 
> 2.35.1
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

