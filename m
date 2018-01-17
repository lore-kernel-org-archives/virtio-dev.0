Return-Path: virtio-dev-return-2988-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 525C05818EB1
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 Jan 2018 10:16:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com> <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 17 Jan 2018 10:15:52 -0800
Message-ID: <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 11, 2018 at 9:58 PM, Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:
> This feature bit can be used by hypervisor to indicate virtio_net device to
> act as a backup for another device with the same MAC address.
>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/virtio_net.c        | 2 +-
>  include/uapi/linux/virtio_net.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 12dfc5fee58e..f149a160a8c5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2829,7 +2829,7 @@ static struct virtio_device_id id_table[] = {
>         VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>         VIRTIO_NET_F_CTRL_MAC_ADDR, \
>         VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> -       VIRTIO_NET_F_SPEED_DUPLEX
> +       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_BACKUP
>
>  static unsigned int features[] = {
>         VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 5de6ed37695b..c7c35fd1a5ed 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,9 @@
>                                          * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
>
> +#define VIRTIO_NET_F_BACKUP      62    /* Act as backup for another device
> +                                        * with the same MAC.
> +                                        */
>  #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duplex */
>
>  #ifndef VIRTIO_NET_NO_LEGACY

I'm not a huge fan of the name "backup" since that implies that the
Virtio interface is only used if the VF is not present, and there are
multiple instances such as dealing with east/west or
broadcast/multicast traffic where it may be desirable to use the
para-virtual interface rather then deal with PCI overhead/bottleneck
to send the packet.

What if instead of BACKUP we used the name SIDE_CHANNEL? Basically it
is a bit of double entendre as we are using the physical MAC address
to provide configuration information, and then in addition this
interface acts as a secondary channel for passing frames to and from
the guest rather than just using the VF.

Just a thought.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

