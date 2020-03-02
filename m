Return-Path: virtio-dev-return-6852-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6EDF985CD2
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 13:04:35 +0000 (UTC)
MIME-Version: 1.0
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com> <CAJPjb1LNV-Ow-SwkH31bXOQr73KX-xoYrKvP5GiXjiFCycOGMQ@mail.gmail.com>
In-Reply-To: <CAJPjb1LNV-Ow-SwkH31bXOQr73KX-xoYrKvP5GiXjiFCycOGMQ@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 2 Mar 2020 15:04:21 +0200
Message-ID: <CAOEp5OemKXMzSseTr-0XmrXuHvHrazsQ6kAirAyisqjMRV_5=w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3 2/3] virtio-net: Introduce RSS receive
 steering feature
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Rob Miller <rob.miller@broadcom.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 2, 2020 at 2:17 PM Rob Miller <rob.miller@broadcom.com> wrote:
>
> I think it would be good to have a means to negotiate which types of RSS =
that a device is willing to do. Perhaps a CTRLQ command to get RSS capabili=
ties then only set those. For example, if a device wishes not to RSS on UDP=
x but will RSS on TCPx, and a HASH request on TCP|USP, this would result in=
 a failure.
>
> Also, what is the definitions of the xxx_EX options?
>

The device indicates its capabilities in its configuration space.
The exact details are in the latest master branch of the virtio-spec
(the discussion was in virtio-comment list).
These commits are to align Linux kernel header to what the spec defines.

> Rob Miller
> rob.miller@broadcom.com
> (919)721-3339
>
>
> On Sun, Mar 1, 2020 at 9:33 AM Yuri Benditovich <yuri.benditovich@daynix.=
com> wrote:
>>
>> RSS (Receive-side scaling) defines hash calculation
>> rules and decision on receive virtqueue according to
>> the calculated hash, provided mask to apply and
>> provided indirection table containing indices of
>> receive virqueues. The driver sends the control
>> command to enable multiqueue and provide parameters
>> for receive steering.
>>
>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>> ---
>>  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
>>  1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio=
_net.h
>> index 19e76b3e3a64..188ad3eecdc8 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -57,6 +57,7 @@
>>                                          * Steering */
>>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
>>
>> +#define VIRTIO_NET_F_RSS         60    /* Supports RSS RX steering */
>>  #define VIRTIO_NET_F_RSC_EXT     61    /* extended coalescing info */
>>  #define VIRTIO_NET_F_STANDBY     62    /* Act as standby for another de=
vice
>>                                          * with the same MAC.
>> @@ -70,6 +71,17 @@
>>  #define VIRTIO_NET_S_LINK_UP   1       /* Link is up */
>>  #define VIRTIO_NET_S_ANNOUNCE  2       /* Announcement is needed */
>>
>> +/* supported/enabled hash types */
>> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
>> +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
>> +
>>  struct virtio_net_config {
>>         /* The config defining mac address (if VIRTIO_NET_F_MAC) */
>>         __u8 mac[ETH_ALEN];
>> @@ -93,6 +105,12 @@ struct virtio_net_config {
>>          * Any other value stands for unknown.
>>          */
>>         __u8 duplex;
>> +       /* maximum size of RSS key */
>> +       __u8 rss_max_key_size;
>> +       /* maximum number of indirection table entries */
>> +       __le16 rss_max_indirection_table_length;
>> +       /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
>> +       __le32 supported_hash_types;
>>  } __attribute__((packed));
>>
>>  /*
>> @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
>>
>>  /*
>>   * Control Receive Flow Steering
>> - *
>> + */
>> +#define VIRTIO_NET_CTRL_MQ   4
>> +/*
>>   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
>>   * enables Receive Flow Steering, specifying the number of the transmit=
 and
>>   * receive queues that will be used. After the command is consumed and =
acked by
>> @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
>>         __virtio16 virtqueue_pairs;
>>  };
>>
>> -#define VIRTIO_NET_CTRL_MQ   4
>>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
>>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
>>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
>>
>> +/*
>> + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
>> + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
>> + * the receive steering to use a hash calculated for incoming packet
>> + * to decide on receive virtqueue to place the packet. The command
>> + * also provides parameters to calculate a hash and receive virtqueue.
>> + */
>> +struct virtio_net_rss_config {
>> +       __le32 hash_types;
>> +       __le16 indirection_table_mask;
>> +       __le16 unclassified_queue;
>> +       __le16 indirection_table[1/* + indirection_table_mask */];
>> +       __le16 max_tx_vq;
>> +       __u8 hash_key_length;
>> +       __u8 hash_key_data[/* hash_key_length */];
>> +};
>> +
>> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
>> +
>>  /*
>>   * Control network offloads
>>   *
>> --
>> 2.17.1
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

