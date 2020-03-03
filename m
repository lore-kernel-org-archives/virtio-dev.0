Return-Path: virtio-dev-return-6882-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4B69985F1F
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Mar 2020 18:55:37 +0000 (UTC)
MIME-Version: 1.0
References: <20200302115003.14877-1-yuri.benditovich@daynix.com>
 <20200302115003.14877-3-yuri.benditovich@daynix.com> <CAJPjb1L3vZLCdOkgV-LTKg_Yp-PWxN4_OmrOVRS2D2NyMF-zvQ@mail.gmail.com>
In-Reply-To: <CAJPjb1L3vZLCdOkgV-LTKg_Yp-PWxN4_OmrOVRS2D2NyMF-zvQ@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 3 Mar 2020 20:55:27 +0200
Message-ID: <CAOEp5OdDWUKKvogDZ8vpbEuJh9BdCVpjZBTFOCuGhRdt8_bHRw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4 2/3] virtio-net: Introduce RSS receive
 steering feature
Content-Type: multipart/alternative; boundary="000000000000616837059ff7d9a7"
To: Rob Miller <rob.miller@broadcom.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000616837059ff7d9a7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2020 at 4:17 PM Rob Miller <rob.miller@broadcom.com> wrote:

> Given that this new feature clarifies RSS, should the existing references
> to RSS be updated in the spec to have RSS replaced with RFS (aka Receive
> Flow Steering)?
>

RSS is a flavor of receive flow steering in addition to already existing
'automatic'.


>
> Rob Miller
> rob.miller@broadcom.com
> (919)721-3339
>
>
> On Mon, Mar 2, 2020 at 6:52 AM Yuri Benditovich <
> yuri.benditovich@daynix.com> wrote:
>
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
>> diff --git a/include/uapi/linux/virtio_net.h
>> b/include/uapi/linux/virtio_net.h
>> index 6466c5979a93..aec6fac3666a 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -57,6 +57,7 @@
>>                                          * Steering */
>>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
>>
>> +#define VIRTIO_NET_F_RSS         60    /* Supports RSS RX steering */
>>  #define VIRTIO_NET_F_RSC_EXT     61    /* extended coalescing info */
>>  #define VIRTIO_NET_F_STANDBY     62    /* Act as standby for another
>> device
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
>> @@ -248,7 +266,9 @@ struct virtio_net_ctrl_mac {
>>
>>  /*
>>   * Control Receive Flow Steering
>> - *
>> + */
>> +#define VIRTIO_NET_CTRL_MQ   4
>> +/*
>>   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
>>   * enables Receive Flow Steering, specifying the number of the transmit
>> and
>>   * receive queues that will be used. After the command is consumed and
>> acked by
>> @@ -261,11 +281,29 @@ struct virtio_net_ctrl_mq {
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
>>

--000000000000616837059ff7d9a7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 3, 2020 at 4:17 PM Rob Mi=
ller &lt;<a href=3D"mailto:rob.miller@broadcom.com">rob.miller@broadcom.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr">Given=C2=A0that this new feature clarifies RSS, should the=
 existing references to RSS be updated in the spec to have RSS replaced wit=
h RFS (aka Receive Flow Steering)?</div></blockquote><div><br></div><div>RS=
S is a=C2=A0flavor of receive flow steering in addition to already existing=
 &#39;automatic&#39;.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div><br clear=3D"all"><div><div di=
r=3D"ltr"><div dir=3D"ltr">Rob Miller<div><a href=3D"mailto:rob.miller@broa=
dcom.com" target=3D"_blank">rob.miller@broadcom.com</a></div><div>(919)721-=
3339</div></div></div></div><br></div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2020 at 6:52 AM Yuri B=
enditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com" target=3D"_bl=
ank">yuri.benditovich@daynix.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">RSS (Receive-side scaling) defines hash ca=
lculation<br>
rules and decision on receive virtqueue according to<br>
the calculated hash, provided mask to apply and<br>
provided indirection table containing indices of<br>
receive virqueues. The driver sends the control<br>
command to enable multiqueue and provide parameters<br>
for receive steering.<br>
<br>
Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@dayn=
ix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
---<br>
=C2=A0include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++-=
-<br>
=C2=A01 file changed, 40 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h<br>
index 6466c5979a93..aec6fac3666a 100644<br>
--- a/include/uapi/linux/virtio_net.h<br>
+++ b/include/uapi/linux/virtio_net.h<br>
@@ -57,6 +57,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
Steering */<br>
=C2=A0#define VIRTIO_NET_F_CTRL_MAC_ADDR 23=C2=A0 /* Set MAC address */<br>
<br>
+#define VIRTIO_NET_F_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A060=C2=A0 =C2=A0 =
/* Supports RSS RX steering */<br>
=C2=A0#define VIRTIO_NET_F_RSC_EXT=C2=A0 =C2=A0 =C2=A061=C2=A0 =C2=A0 /* ex=
tended coalescing info */<br>
=C2=A0#define VIRTIO_NET_F_STANDBY=C2=A0 =C2=A0 =C2=A062=C2=A0 =C2=A0 /* Ac=
t as standby for another device<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
with the same MAC.<br>
@@ -70,6 +71,17 @@<br>
=C2=A0#define VIRTIO_NET_S_LINK_UP=C2=A0 =C2=A01=C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* Link is up */<br>
=C2=A0#define VIRTIO_NET_S_ANNOUNCE=C2=A0 2=C2=A0 =C2=A0 =C2=A0 =C2=A0/* An=
nouncement is needed */<br>
<br>
+/* supported/enabled hash types */<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1=
 &lt;&lt; 0)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
 &lt;&lt; 1)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
 &lt;&lt; 2)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1=
 &lt;&lt; 3)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
 &lt;&lt; 4)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
 &lt;&lt; 5)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
 &lt;&lt; 6)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;=
&lt; 7)<br>
+#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;=
&lt; 8)<br>
+<br>
=C2=A0struct virtio_net_config {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The config defining mac address (if VIRTIO_N=
ET_F_MAC) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u8 mac[ETH_ALEN];<br>
@@ -93,6 +105,12 @@ struct virtio_net_config {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Any other value stands for unknown.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u8 duplex;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* maximum size of RSS key */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 rss_max_key_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* maximum number of indirection table entries =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 rss_max_indirection_table_length;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* bitmask of supported VIRTIO_NET_RSS_HASH_ ty=
pes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 supported_hash_types;<br>
=C2=A0} __attribute__((packed));<br>
<br>
=C2=A0/*<br>
@@ -248,7 +266,9 @@ struct virtio_net_ctrl_mac {<br>
<br>
=C2=A0/*<br>
=C2=A0 * Control Receive Flow Steering<br>
- *<br>
+ */<br>
+#define VIRTIO_NET_CTRL_MQ=C2=A0 =C2=A04<br>
+/*<br>
=C2=A0 * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET<br>
=C2=A0 * enables Receive Flow Steering, specifying the number of the transm=
it and<br>
=C2=A0 * receive queues that will be used. After the command is consumed an=
d acked by<br>
@@ -261,11 +281,29 @@ struct virtio_net_ctrl_mq {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __virtio16 virtqueue_pairs;<br>
=C2=A0};<br>
<br>
-#define VIRTIO_NET_CTRL_MQ=C2=A0 =C2=A04<br>
=C2=A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
<br>
=C2=A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN=C2=A0 =C2=A0 =C2=A0 =C2=A0 1=
<br>
=C2=A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
x8000<br>
<br>
+/*<br>
+ * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as<br>
+ * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures<br>
+ * the receive steering to use a hash calculated for incoming packet<br>
+ * to decide on receive virtqueue to place the packet. The command<br>
+ * also provides parameters to calculate a hash and receive virtqueue.<br>
+ */<br>
+struct virtio_net_rss_config {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 hash_types;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 indirection_table_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 unclassified_queue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 indirection_table[1/* + indirection_tabl=
e_mask */];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 max_tx_vq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 hash_key_length;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 hash_key_data[/* hash_key_length */];<br>
+};<br>
+<br>
+ #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=
<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Control network offloads<br>
=C2=A0 *<br>
-- <br>
2.17.1<br>
<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div>
</blockquote></div></div>

--000000000000616837059ff7d9a7--

