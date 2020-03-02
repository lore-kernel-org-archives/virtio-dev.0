Return-Path: virtio-dev-return-6842-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C132E985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 12:09:40 +0000 (UTC)
MIME-Version: 1.0
References: <20200301143302.8556-1-yuri.benditovich@daynix.com> <20200301143302.8556-2-yuri.benditovich@daynix.com>
In-Reply-To: <20200301143302.8556-2-yuri.benditovich@daynix.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Mon, 2 Mar 2020 07:09:12 -0500
Message-ID: <CAJPjb1KQ7YrX24FMW8yNR7fGHM3+7FP63kKaBjXgJAnihr5jmQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3 1/3] virtio-net: Introduce extended RSC feature
Content-Type: multipart/alternative; boundary="000000000000bfaa68059fde0f3d"
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000bfaa68059fde0f3d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Can we add some words about the new fields in the  virtio_net_hdr
structure, such as SHOULD, MUST,...

Also, should the  virtio_net_hdr be bumped to v2?

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Sun, Mar 1, 2020 at 9:33 AM Yuri Benditovich <yuri.benditovich@daynix.co=
m>
wrote:

> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is negotiatede and 'gso_type' field in received packet is not
> GSO_NONE, the device reports number of coalesced packets in
> 'csum_start' field and number of duplicated acks in 'csum_offset'
> field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/virtio_net.h
> b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..19e76b3e3a64 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>                                          * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
>
> +#define VIRTIO_NET_F_RSC_EXT     61    /* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY     62    /* Act as standby for another
> device
>                                          * with the same MAC.
>                                          */
> @@ -104,6 +105,7 @@ struct virtio_net_config {
>  struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1       /* Use csum_start,
> csum_offset */
>  #define VIRTIO_NET_HDR_F_DATA_VALID    2       /* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO      4       /* rsc info in csum_
> fields */
>         __u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE                0       /* Not a GSO fram=
e
> */
>  #define VIRTIO_NET_HDR_GSO_TCPV4       1       /* GSO frame, IPv4 TCP
> (TSO) */
> @@ -113,8 +115,24 @@ struct virtio_net_hdr_v1 {
>         __u8 gso_type;
>         __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
>         __virtio16 gso_size;    /* Bytes to append to hdr_len per frame *=
/
> -       __virtio16 csum_start;  /* Position to start checksumming from */
> -       __virtio16 csum_offset; /* Offset after that to place checksum */
> +       union {
> +               struct {
> +                       __virtio16 csum_start;
> +                       __virtio16 csum_offset;
> +               };
> +               struct {
> +                       /* Position to start checksumming from */
> +                       __virtio16 start;
> +                       /* Offset after that to place checksum */
> +                       __virtio16 offset;
> +               } csum;
> +               struct {
> +                       /* num of coalesced packets */
> +                       __le16 packets;
> +                       /* num of duplicated acks */
> +                       __le16 dup_acks;
> +               } rsc;
> +       };
>         __virtio16 num_buffers; /* Number of merged rx buffers */
>  };
>
> --
> 2.17.1
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--000000000000bfaa68059fde0f3d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Can we add some words about the new field=
s in the=C2=A0

virtio_net_hdr=C2=A0 structure, such as SHOULD, MUST,...</div><div dir=3D"l=
tr"><br></div><div dir=3D"ltr">Also, should the=C2=A0

virtio_net_hdr be bumped to v2?<br><div><br clear=3D"all"><div><div dir=3D"=
ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Rob Miller<div><a href=3D"mailto:rob.miller@broadcom.com" target=
=3D"_blank">rob.miller@broadcom.com</a></div><div>(919)721-3339</div></div>=
</div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sun, Mar 1, 2020 at 9:33 AM Yuri Benditovich &lt;<=
a href=3D"mailto:yuri.benditovich@daynix.com">yuri.benditovich@daynix.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">VI=
RTIO_NET_F_RSC_EXT feature bit indicates that the device<br>
is able to provide extended RSC information. When the feature<br>
is negotiatede and &#39;gso_type&#39; field in received packet is not<br>
GSO_NONE, the device reports number of coalesced packets in<br>
&#39;csum_start&#39; field and number of duplicated acks in &#39;csum_offse=
t&#39;<br>
field and sets VIRTIO_NET_HDR_F_RSC_INFO in &#39;flags&#39; field.<br>
<br>
Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@dayn=
ix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
---<br>
=C2=A0include/uapi/linux/virtio_net.h | 22 ++++++++++++++++++++--<br>
=C2=A01 file changed, 20 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h<br>
index a3715a3224c1..19e76b3e3a64 100644<br>
--- a/include/uapi/linux/virtio_net.h<br>
+++ b/include/uapi/linux/virtio_net.h<br>
@@ -57,6 +57,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
Steering */<br>
=C2=A0#define VIRTIO_NET_F_CTRL_MAC_ADDR 23=C2=A0 /* Set MAC address */<br>
<br>
+#define VIRTIO_NET_F_RSC_EXT=C2=A0 =C2=A0 =C2=A061=C2=A0 =C2=A0 /* extende=
d coalescing info */<br>
=C2=A0#define VIRTIO_NET_F_STANDBY=C2=A0 =C2=A0 =C2=A062=C2=A0 =C2=A0 /* Ac=
t as standby for another device<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
with the same MAC.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/=
<br>
@@ -104,6 +105,7 @@ struct virtio_net_config {<br>
=C2=A0struct virtio_net_hdr_v1 {<br>
=C2=A0#define VIRTIO_NET_HDR_F_NEEDS_CSUM=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Use csum_start, csum_offset */<br>
=C2=A0#define VIRTIO_NET_HDR_F_DATA_VALID=C2=A0 =C2=A0 2=C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Csum is valid */<br>
+#define VIRTIO_NET_HDR_F_RSC_INFO=C2=A0 =C2=A0 =C2=A0 4=C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* rsc info in csum_ fields */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u8 flags;<br>
=C2=A0#define VIRTIO_NET_HDR_GSO_NONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Not a GSO frame */<br>
=C2=A0#define VIRTIO_NET_HDR_GSO_TCPV4=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* GSO frame, IPv4 TCP (TSO) */<br>
@@ -113,8 +115,24 @@ struct virtio_net_hdr_v1 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u8 gso_type;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __virtio16 hdr_len;=C2=A0 =C2=A0 =C2=A0/* Ether=
net + IP + tcp/udp hdrs */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __virtio16 gso_size;=C2=A0 =C2=A0 /* Bytes to a=
ppend to hdr_len per frame */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0__virtio16 csum_start;=C2=A0 /* Position to sta=
rt checksumming from */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0__virtio16 csum_offset; /* Offset after that to=
 place checksum */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__virtio16 csum_start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__virtio16 csum_offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Position to start checksumming from */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__virtio16 start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Offset after that to place checksum */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__virtio16 offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} csum;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* num of coalesced packets */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__le16 packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* num of duplicated acks */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__le16 dup_acks;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} rsc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __virtio16 num_buffers; /* Number of merged rx =
buffers */<br>
=C2=A0};<br>
<br>
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
</blockquote></div></div>

--000000000000bfaa68059fde0f3d--

