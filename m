Return-Path: virtio-dev-return-6879-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B8EC985F0C
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Mar 2020 13:48:06 +0000 (UTC)
MIME-Version: 1.0
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com> <CAJPjb1LNV-Ow-SwkH31bXOQr73KX-xoYrKvP5GiXjiFCycOGMQ@mail.gmail.com>
 <CAOEp5OemKXMzSseTr-0XmrXuHvHrazsQ6kAirAyisqjMRV_5=w@mail.gmail.com>
In-Reply-To: <CAOEp5OemKXMzSseTr-0XmrXuHvHrazsQ6kAirAyisqjMRV_5=w@mail.gmail.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Tue, 3 Mar 2020 08:47:36 -0500
Message-ID: <CAJPjb1L3fjYoyQ_4YXFXmJtBF1hLjej3nxQdfe53+kUPVQjcxA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3 2/3] virtio-net: Introduce RSS receive
 steering feature
Content-Type: multipart/alternative; boundary="00000000000096e225059ff38dc5"
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000096e225059ff38dc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

OK my bad, missed the update to the working copy of the spec.

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Mon, Mar 2, 2020 at 8:04 AM Yuri Benditovich <yuri.benditovich@daynix.co=
m>
wrote:

> On Mon, Mar 2, 2020 at 2:17 PM Rob Miller <rob.miller@broadcom.com> wrote=
:
> >
> > I think it would be good to have a means to negotiate which types of RS=
S
> that a device is willing to do. Perhaps a CTRLQ command to get RSS
> capabilities then only set those. For example, if a device wishes not to
> RSS on UDPx but will RSS on TCPx, and a HASH request on TCP|USP, this wou=
ld
> result in a failure.
> >
> > Also, what is the definitions of the xxx_EX options?
> >
>
> The device indicates its capabilities in its configuration space.
> The exact details are in the latest master branch of the virtio-spec
> (the discussion was in virtio-comment list).
> These commits are to align Linux kernel header to what the spec defines.
>
> > Rob Miller
> > rob.miller@broadcom.com
> > (919)721-3339
> >
> >
> > On Sun, Mar 1, 2020 at 9:33 AM Yuri Benditovich <
> yuri.benditovich@daynix.com> wrote:
> >>
> >> RSS (Receive-side scaling) defines hash calculation
> >> rules and decision on receive virtqueue according to
> >> the calculated hash, provided mask to apply and
> >> provided indirection table containing indices of
> >> receive virqueues. The driver sends the control
> >> command to enable multiqueue and provide parameters
> >> for receive steering.
> >>
> >> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> >> ---
> >>  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++-=
-
> >>  1 file changed, 40 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/virtio_net.h
> b/include/uapi/linux/virtio_net.h
> >> index 19e76b3e3a64..188ad3eecdc8 100644
> >> --- a/include/uapi/linux/virtio_net.h
> >> +++ b/include/uapi/linux/virtio_net.h
> >> @@ -57,6 +57,7 @@
> >>                                          * Steering */
> >>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
> >>
> >> +#define VIRTIO_NET_F_RSS         60    /* Supports RSS RX steering */
> >>  #define VIRTIO_NET_F_RSC_EXT     61    /* extended coalescing info */
> >>  #define VIRTIO_NET_F_STANDBY     62    /* Act as standby for another
> device
> >>                                          * with the same MAC.
> >> @@ -70,6 +71,17 @@
> >>  #define VIRTIO_NET_S_LINK_UP   1       /* Link is up */
> >>  #define VIRTIO_NET_S_ANNOUNCE  2       /* Announcement is needed */
> >>
> >> +/* supported/enabled hash types */
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> >> +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> >> +
> >>  struct virtio_net_config {
> >>         /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> >>         __u8 mac[ETH_ALEN];
> >> @@ -93,6 +105,12 @@ struct virtio_net_config {
> >>          * Any other value stands for unknown.
> >>          */
> >>         __u8 duplex;
> >> +       /* maximum size of RSS key */
> >> +       __u8 rss_max_key_size;
> >> +       /* maximum number of indirection table entries */
> >> +       __le16 rss_max_indirection_table_length;
> >> +       /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> >> +       __le32 supported_hash_types;
> >>  } __attribute__((packed));
> >>
> >>  /*
> >> @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
> >>
> >>  /*
> >>   * Control Receive Flow Steering
> >> - *
> >> + */
> >> +#define VIRTIO_NET_CTRL_MQ   4
> >> +/*
> >>   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> >>   * enables Receive Flow Steering, specifying the number of the
> transmit and
> >>   * receive queues that will be used. After the command is consumed an=
d
> acked by
> >> @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
> >>         __virtio16 virtqueue_pairs;
> >>  };
> >>
> >> -#define VIRTIO_NET_CTRL_MQ   4
> >>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> >>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> >>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> >>
> >> +/*
> >> + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> >> + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> >> + * the receive steering to use a hash calculated for incoming packet
> >> + * to decide on receive virtqueue to place the packet. The command
> >> + * also provides parameters to calculate a hash and receive virtqueue=
.
> >> + */
> >> +struct virtio_net_rss_config {
> >> +       __le32 hash_types;
> >> +       __le16 indirection_table_mask;
> >> +       __le16 unclassified_queue;
> >> +       __le16 indirection_table[1/* + indirection_table_mask */];
> >> +       __le16 max_tx_vq;
> >> +       __u8 hash_key_length;
> >> +       __u8 hash_key_data[/* hash_key_length */];
> >> +};
> >> +
> >> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> >> +
> >>  /*
> >>   * Control network offloads
> >>   *
> >> --
> >> 2.17.1
> >>
> >>
> >> ---------------------------------------------------------------------
> >> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >>
>

--00000000000096e225059ff38dc5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK my bad, missed the update to the working copy of the sp=
ec.<div><br clear=3D"all"><div><div dir=3D"ltr" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr">Rob Miller<div><a href=3D"mailto:rob.miller@broadc=
om.com" target=3D"_blank">rob.miller@broadcom.com</a></div><div>(919)721-33=
39</div></div></div></div><br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2020 at 8:04 AM Yuri Ben=
ditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com" target=3D"_blan=
k">yuri.benditovich@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Mon, Mar 2, 2020 at 2:17 PM Rob Miller &lt=
;<a href=3D"mailto:rob.miller@broadcom.com" target=3D"_blank">rob.miller@br=
oadcom.com</a>&gt; wrote:<br>
&gt;<br>
&gt; I think it would be good to have a means to negotiate which types of R=
SS that a device is willing to do. Perhaps a CTRLQ command to get RSS capab=
ilities then only set those. For example, if a device wishes not to RSS on =
UDPx but will RSS on TCPx, and a HASH request on TCP|USP, this would result=
 in a failure.<br>
&gt;<br>
&gt; Also, what is the definitions of the xxx_EX options?<br>
&gt;<br>
<br>
The device indicates its capabilities in its configuration space.<br>
The exact details are in the latest master branch of the virtio-spec<br>
(the discussion was in virtio-comment list).<br>
These commits are to align Linux kernel header to what the spec defines.<br=
>
<br>
&gt; Rob Miller<br>
&gt; <a href=3D"mailto:rob.miller@broadcom.com" target=3D"_blank">rob.mille=
r@broadcom.com</a><br>
&gt; (919)721-3339<br>
&gt;<br>
&gt;<br>
&gt; On Sun, Mar 1, 2020 at 9:33 AM Yuri Benditovich &lt;<a href=3D"mailto:=
yuri.benditovich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com<=
/a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; RSS (Receive-side scaling) defines hash calculation<br>
&gt;&gt; rules and decision on receive virtqueue according to<br>
&gt;&gt; the calculated hash, provided mask to apply and<br>
&gt;&gt; provided indirection table containing indices of<br>
&gt;&gt; receive virqueues. The driver sends the control<br>
&gt;&gt; command to enable multiqueue and provide parameters<br>
&gt;&gt; for receive steering.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.bendito=
vich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++=
++++++++--<br>
&gt;&gt;=C2=A0 1 file changed, 40 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/=
virtio_net.h<br>
&gt;&gt; index 19e76b3e3a64..188ad3eecdc8 100644<br>
&gt;&gt; --- a/include/uapi/linux/virtio_net.h<br>
&gt;&gt; +++ b/include/uapi/linux/virtio_net.h<br>
&gt;&gt; @@ -57,6 +57,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 * Steering */<br>
&gt;&gt;=C2=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=C2=A0 /* Set MAC addre=
ss */<br>
&gt;&gt;<br>
&gt;&gt; +#define VIRTIO_NET_F_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A060=C2=
=A0 =C2=A0 /* Supports RSS RX steering */<br>
&gt;&gt;=C2=A0 #define VIRTIO_NET_F_RSC_EXT=C2=A0 =C2=A0 =C2=A061=C2=A0 =C2=
=A0 /* extended coalescing info */<br>
&gt;&gt;=C2=A0 #define VIRTIO_NET_F_STANDBY=C2=A0 =C2=A0 =C2=A062=C2=A0 =C2=
=A0 /* Act as standby for another device<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 * with the same MAC.<br>
&gt;&gt; @@ -70,6 +71,17 @@<br>
&gt;&gt;=C2=A0 #define VIRTIO_NET_S_LINK_UP=C2=A0 =C2=A01=C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Link is up */<br>
&gt;&gt;=C2=A0 #define VIRTIO_NET_S_ANNOUNCE=C2=A0 2=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Announcement is needed */<br>
&gt;&gt;<br>
&gt;&gt; +/* supported/enabled hash types */<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (1 &lt;&lt; 0)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 &lt;&lt; 1)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 &lt;&lt; 2)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (1 &lt;&lt; 3)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 &lt;&lt; 4)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 &lt;&lt; 5)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 &lt;&lt; 6)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 7)<br>
&gt;&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 8)<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 struct virtio_net_config {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The config defining mac addres=
s (if VIRTIO_NET_F_MAC) */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 mac[ETH_ALEN];<br>
&gt;&gt; @@ -93,6 +105,12 @@ struct virtio_net_config {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Any other value stands for unk=
nown.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 duplex;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* maximum size of RSS key */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 rss_max_key_size;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* maximum number of indirection table=
 entries */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 rss_max_indirection_table_lengt=
h;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* bitmask of supported VIRTIO_NET_RSS=
_HASH_ types */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 supported_hash_types;<br>
&gt;&gt;=C2=A0 } __attribute__((packed));<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 /*<br>
&gt;&gt; @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 /*<br>
&gt;&gt;=C2=A0 =C2=A0* Control Receive Flow Steering<br>
&gt;&gt; - *<br>
&gt;&gt; + */<br>
&gt;&gt; +#define VIRTIO_NET_CTRL_MQ=C2=A0 =C2=A04<br>
&gt;&gt; +/*<br>
&gt;&gt;=C2=A0 =C2=A0* The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET<br>
&gt;&gt;=C2=A0 =C2=A0* enables Receive Flow Steering, specifying the number=
 of the transmit and<br>
&gt;&gt;=C2=A0 =C2=A0* receive queues that will be used. After the command =
is consumed and acked by<br>
&gt;&gt; @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__virtio16 virtqueue_pairs;<br>
&gt;&gt;=C2=A0 };<br>
&gt;&gt;<br>
&gt;&gt; -#define VIRTIO_NET_CTRL_MQ=C2=A0 =C2=A04<br>
&gt;&gt;=C2=A0 =C2=A0#define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0<br>
&gt;&gt;=C2=A0 =C2=A0#define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1<br>
&gt;&gt;=C2=A0 =C2=A0#define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x8000<br>
&gt;&gt;<br>
&gt;&gt; +/*<br>
&gt;&gt; + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect =
as<br>
&gt;&gt; + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configur=
es<br>
&gt;&gt; + * the receive steering to use a hash calculated for incoming pac=
ket<br>
&gt;&gt; + * to decide on receive virtqueue to place the packet. The comman=
d<br>
&gt;&gt; + * also provides parameters to calculate a hash and receive virtq=
ueue.<br>
&gt;&gt; + */<br>
&gt;&gt; +struct virtio_net_rss_config {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 hash_types;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 indirection_table_mask;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 unclassified_queue;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 indirection_table[1/* + indirec=
tion_table_mask */];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 max_tx_vq;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 hash_key_length;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 hash_key_data[/* hash_key_length =
*/];<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 /*<br>
&gt;&gt;=C2=A0 =C2=A0* Control network offloads<br>
&gt;&gt;=C2=A0 =C2=A0*<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------------------------------------------=
---<br>
&gt;&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@l=
ists.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-o=
pen.org</a><br>
&gt;&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help=
@lists.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.o=
rg</a><br>
&gt;&gt;<br>
</blockquote></div>

--00000000000096e225059ff38dc5--

