Return-Path: virtio-dev-return-6826-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27BAE98423F
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Mar 2020 19:58:30 +0000 (UTC)
Date: Sun, 1 Mar 2020 14:58:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200301145811-mutt-send-email-mst@kernel.org>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200301143302.8556-3-yuri.benditovich@daynix.com>
Subject: [virtio-dev] Re: [PATCH v3 2/3] virtio-net: Introduce RSS receive steering feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Mar 01, 2020 at 04:33:01PM +0200, Yuri Benditovich wrote:
> RSS (Receive-side scaling) defines hash calculation
> rules and decision on receive virtqueue according to
> the calculated hash, provided mask to apply and
> provided indirection table containing indices of
> receive virqueues. The driver sends the control
> command to enable multiqueue and provide parameters
> for receive steering.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index 19e76b3e3a64..188ad3eecdc8 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  =09=09=09=09=09 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=09/* Set MAC address */
> =20
> +#define VIRTIO_NET_F_RSS=09  60=09/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT=09  61=09/* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY=09  62=09/* Act as standby for another devi=
ce
>  =09=09=09=09=09 * with the same MAC.
> @@ -70,6 +71,17 @@
>  #define VIRTIO_NET_S_LINK_UP=091=09/* Link is up */
>  #define VIRTIO_NET_S_ANNOUNCE=092=09/* Announcement is needed */
> =20
> +/* supported/enabled hash types */
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> +
>  struct virtio_net_config {
>  =09/* The config defining mac address (if VIRTIO_NET_F_MAC) */
>  =09__u8 mac[ETH_ALEN];
> @@ -93,6 +105,12 @@ struct virtio_net_config {
>  =09 * Any other value stands for unknown.
>  =09 */
>  =09__u8 duplex;
> +=09/* maximum size of RSS key */
> +=09__u8 rss_max_key_size;
> +=09/* maximum number of indirection table entries */
> +=09__le16 rss_max_indirection_table_length;
> +=09/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> +=09__le32 supported_hash_types;
>  } __attribute__((packed));
> =20
>  /*
> @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
> =20
>  /*
>   * Control Receive Flow Steering
> - *
> + */
> +#define VIRTIO_NET_CTRL_MQ   4
> +/*
>   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
>   * enables Receive Flow Steering, specifying the number of the transmit =
and
>   * receive queues that will be used. After the command is consumed and a=
cked by
> @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
>  =09__virtio16 virtqueue_pairs;
>  };
> =20
> -#define VIRTIO_NET_CTRL_MQ   4
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> =20
> +/*
> + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> + * the receive steering to use a hash calculated for incoming packet
> + * to decide on receive virtqueue to place the packet. The command
> + * also provides parameters to calculate a hash and receive virtqueue.
> + */
> +struct virtio_net_rss_config {
> +=09__le32 hash_types;
> +=09__le16 indirection_table_mask;
> +=09__le16 unclassified_queue;
> +=09__le16 indirection_table[1/* + indirection_table_mask */];
> +=09__le16 max_tx_vq;
> +=09__u8 hash_key_length;
> +=09__u8 hash_key_data[/* hash_key_length */];
> +};
> +
> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> +


Extra space here.

>  /*
>   * Control network offloads
>   *
> --=20
> 2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

