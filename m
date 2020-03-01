Return-Path: virtio-dev-return-6827-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0EFB9843EF
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Mar 2020 20:06:09 +0000 (UTC)
Date: Sun, 1 Mar 2020 15:06:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200301145828-mutt-send-email-mst@kernel.org>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200301143302.8556-2-yuri.benditovich@daynix.com>
Subject: [virtio-dev] Re: [PATCH v3 1/3] virtio-net: Introduce extended RSC feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Mar 01, 2020 at 04:33:00PM +0200, Yuri Benditovich wrote:
> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is negotiatede and 'gso_type' field in received packet is not
> GSO_NONE, the device reports number of coalesced packets in
> 'csum_start' field and number of duplicated acks in 'csum_offset'
> field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index a3715a3224c1..19e76b3e3a64 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  =09=09=09=09=09 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=09/* Set MAC address */
> =20
> +#define VIRTIO_NET_F_RSC_EXT=09  61=09/* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY=09  62=09/* Act as standby for another devi=
ce
>  =09=09=09=09=09 * with the same MAC.
>  =09=09=09=09=09 */
> @@ -104,6 +105,7 @@ struct virtio_net_config {
>  struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM=091=09/* Use csum_start, csum_offset=
 */
>  #define VIRTIO_NET_HDR_F_DATA_VALID=092=09/* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO=094=09/* rsc info in csum_ fields */
>  =09__u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE=09=090=09/* Not a GSO frame */
>  #define VIRTIO_NET_HDR_GSO_TCPV4=091=09/* GSO frame, IPv4 TCP (TSO) */
> @@ -113,8 +115,24 @@ struct virtio_net_hdr_v1 {
>  =09__u8 gso_type;
>  =09__virtio16 hdr_len;=09/* Ethernet + IP + tcp/udp hdrs */
>  =09__virtio16 gso_size;=09/* Bytes to append to hdr_len per frame */
> -=09__virtio16 csum_start;=09/* Position to start checksumming from */
> -=09__virtio16 csum_offset;=09/* Offset after that to place checksum */
> +=09union {
> +=09=09struct {
> +=09=09=09__virtio16 csum_start;
> +=09=09=09__virtio16 csum_offset;
> +=09=09};


Pls add comments for this one as well.

> +=09=09struct {
> +=09=09=09/* Position to start checksumming from */
> +=09=09=09__virtio16 start;
> +=09=09=09/* Offset after that to place checksum */
> +=09=09=09__virtio16 offset;
> +=09=09} csum;

Can we add a comment for csum field pls? E.g.
=09/* Checksum calculation */

> +=09=09struct {
> +=09=09=09/* num of coalesced packets */


num -> Number? Don't abbreviate and upper case for consistency.

> +=09=09=09__le16 packets;

packets -> coalesced_packets? Or is coalesced segments in fact better?

> +=09=09=09/* num of duplicated acks */

num -> Number? Don't abbreviate and upper case for consistency.


> +=09=09=09__le16 dup_acks;
> +=09=09} rsc;

/* Receive Segment Coalescing report */

> +=09};
>  =09__virtio16 num_buffers;=09/* Number of merged rx buffers */
>  };
> =20
> --=20
> 2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

