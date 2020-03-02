Return-Path: virtio-dev-return-6831-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 91F3E985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 08:53:28 +0000 (UTC)
MIME-Version: 1.0
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com> <20200301145811-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200301145811-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 2 Mar 2020 10:53:14 +0200
Message-ID: <CAOEp5Oc07THyvZghMBjns=aTVEPMxb4w6LFGFtUsS93h4xsSJQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 2/3] virtio-net: Introduce RSS receive steering feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Mar 1, 2020 at 9:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 01, 2020 at 04:33:01PM +0200, Yuri Benditovich wrote:
> > RSS (Receive-side scaling) defines hash calculation
> > rules and decision on receive virtqueue according to
> > the calculated hash, provided mask to apply and
> > provided indirection table containing indices of
> > receive virqueues. The driver sends the control
> > command to enable multiqueue and provide parameters
> > for receive steering.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
> >  1 file changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> > index 19e76b3e3a64..188ad3eecdc8 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -57,6 +57,7 @@
> >                                        * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> >
> > +#define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> >  #define VIRTIO_NET_F_RSC_EXT   61    /* extended coalescing info */
> >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another dev=
ice
> >                                        * with the same MAC.
> > @@ -70,6 +71,17 @@
> >  #define VIRTIO_NET_S_LINK_UP 1       /* Link is up */
> >  #define VIRTIO_NET_S_ANNOUNCE        2       /* Announcement is needed=
 */
> >
> > +/* supported/enabled hash types */
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> > +
> >  struct virtio_net_config {
> >       /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> >       __u8 mac[ETH_ALEN];
> > @@ -93,6 +105,12 @@ struct virtio_net_config {
> >        * Any other value stands for unknown.
> >        */
> >       __u8 duplex;
> > +     /* maximum size of RSS key */
> > +     __u8 rss_max_key_size;
> > +     /* maximum number of indirection table entries */
> > +     __le16 rss_max_indirection_table_length;
> > +     /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> > +     __le32 supported_hash_types;
> >  } __attribute__((packed));
> >
> >  /*
> > @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
> >
> >  /*
> >   * Control Receive Flow Steering
> > - *
> > + */
> > +#define VIRTIO_NET_CTRL_MQ   4
> > +/*
> >   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> >   * enables Receive Flow Steering, specifying the number of the transmi=
t and
> >   * receive queues that will be used. After the command is consumed and=
 acked by
> > @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
> >       __virtio16 virtqueue_pairs;
> >  };
> >
> > -#define VIRTIO_NET_CTRL_MQ   4
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> >
> > +/*
> > + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> > + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> > + * the receive steering to use a hash calculated for incoming packet
> > + * to decide on receive virtqueue to place the packet. The command
> > + * also provides parameters to calculate a hash and receive virtqueue.
> > + */
> > +struct virtio_net_rss_config {
> > +     __le32 hash_types;
> > +     __le16 indirection_table_mask;
> > +     __le16 unclassified_queue;
> > +     __le16 indirection_table[1/* + indirection_table_mask */];
> > +     __le16 max_tx_vq;
> > +     __u8 hash_key_length;
> > +     __u8 hash_key_data[/* hash_key_length */];
> > +};
> > +
> > + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> > +
>
>
> Extra space here.

Where exactly you want to remove the empty line?
The format here is exactly as in other places:
comment - structure - space - command - space


>
> >  /*
> >   * Control network offloads
> >   *
> > --
> > 2.17.1
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

