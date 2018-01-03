Return-Path: virtio-dev-return-2898-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C394F58191AA
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 09:43:14 -0800 (PST)
Date: Wed, 3 Jan 2018 19:43:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180103191101-mutt-send-email-mst@kernel.org>
References: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
 <1514939738-22423-2-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514939738-22423-2-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] Re: [PATCH net-next 1/2] virtio_net: Introduce VIRTIO_NET_F_MASTER
 feature bit
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 02, 2018 at 04:35:37PM -0800, Sridhar Samudrala wrote:
> This feature bit can be used by hypervisor to indicate virtio_net device to
> act as a master for a directly attached passthru device with the same MAC
> address.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/virtio_net.c        | 3 ++-
>  include/uapi/linux/virtio_net.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6fb7b658a6cc..46844a1d9a62 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2796,7 +2796,8 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
>  	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
> -	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
> +	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> +	VIRTIO_NET_F_MASTER
>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index fc353b518288..a9b4e0836786 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_MASTER	62	/* act as master for a VF device */

Well the virtio hardware doesn't really know whether it's a master or
the slave of a bond. In fact quite possibly down the road we'll add a
virtual device on top as others seem to want to do - that other one will
be the master then.

And we do nothing do check it's a VF.

So maybe a better name would be

#define VIRTIO_NET_F_BACKUP	62	/* Act as backup for another device with the same MAC */

>  
>  #ifndef VIRTIO_NET_NO_LEGACY
>  #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
> -- 
> 2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

