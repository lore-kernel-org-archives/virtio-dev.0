Return-Path: <virtio-dev-return-9838-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D93B986520
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Aug 2022 08:53:00 +0000 (UTC)
Message-ID: <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
Date: Fri, 26 Aug 2022 01:52:19 -0700
References: <20220825123840.20239-1-gavinl@nvidia.com>
 <20220825123840.20239-3-gavinl@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <20220825123840.20239-3-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH RESEND v2 2/2] virtio-net: use mtu size as
 buffer length for big packets
Content-Type: multipart/alternative;
 boundary="------------D0WHH0JdGtzNmlRYGuycaOhH"
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com
Cc: gavi@nvidia.com, parav@nvidia.com, Si-wei Liu <Si-Wei.Liu@Oracle.COM>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------D0WHH0JdGtzNmlRYGuycaOhH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the delay. Didn't notice as this thread was not addressed to 
my work email. Please copy to my work email if it needs my immediate 
attention.

On 8/25/2022 5:38 AM, Gavin Li wrote:
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if guest GSO is not supported, it would be sufficient to
> allocate segments to cover just up the MTU size and no further.
> Allocating the maximum amount of segments results in a large waste of
> buffer space in the queue, which limits the number of packets that can
> be buffered and can result in reduced performance.
>
> Therefore, if guest GSO is not supported, use the MTU to calculate the
> optimal amount of segments required.
>
> When guest offload is enabled at runtime, RQ already has packets of bytes
> less than 64K. So when packet of 64KB arrives, all the packets of such
> size will be dropped. and RQ is now not usable.
>
> So this means that during set_guest_offloads() phase, RQs have to be
> destroyed and recreated, which requires almost driver reload.
Yes, this needs VIRTIO_F_RING_RESET and disable_vq_and_reset() to be 
done on RQ and refill it with appropriate size of buffer. Not for this 
patch anyway.
>
> If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it should
> always treat them as GSO enabled.
>
> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> 1 VQ, queue size 1024, before and after the change, with the iperf
> server running over the virtio-net interface.
>
> MTU(Bytes)/Bandwidth (Gbit/s)
>               Before   After
>    1500        22.5     22.4
>    9000        12.8     25.9
>
> Signed-off-by: Gavin Li<gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz<gavi@nvidia.com>
> Reviewed-by: Parav Pandit<parav@nvidia.com>
> ---
> changelog:
> v1->v2
> - Addressed comments from Jason, Michael, Si-Wei.
> - Remove the flag of guest GSO support, set sg_num for big packets and
>    use it directly
> - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> - Replace the round up algorithm with DIV_ROUND_UP
> ---
>   drivers/net/virtio_net.c | 41 +++++++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e1904877d461..ec8c135a26d6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -225,6 +225,9 @@ struct virtnet_info {
>   	/* I like... big packets and I cannot lie! */
>   	bool big_packets;
>   
> +	/* number of sg entries allocated for big packets */
> +	unsigned int big_packets_sg_num;
> +
>   	/* Host will merge rx buffers for big packets (shake it! shake it!) */
>   	bool mergeable_rx_bufs;
>   
> @@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   	char *p;
>   	int i, err, offset;
>   
> -	sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +	sg_init_table(rq->sg, vi->big_packets_sg_num + 2);
>   
> -	/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
> -	for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> +	/* page in rq->sg[vi->big_packets_sg_num + 1] is list tail */
> +	for (i = vi->big_packets_sg_num + 1; i > 1; --i) {
>   		first = get_a_page(rq, gfp);
>   		if (!first) {
>   			if (list)
> @@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   
>   	/* chain first in list head */
>   	first->private = (unsigned long)list;
> -	err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +	err = virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_sg_num + 2,
>   				  first, gfp);
>   	if (err < 0)
>   		give_pages(rq, first);
> @@ -3690,13 +3693,31 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
>   		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO));
>   }
>   
> +static void virtnet_set_big_packets_fields(struct virtnet_info *vi, const int mtu)
> +{
> +	bool guest_gso = virtnet_check_guest_gso(vi);
> +
> +	/* If we can receive ANY GSO packets, we must allocate large ones. */
> +	if (mtu > ETH_DATA_LEN || guest_gso) {
> +		vi->big_packets = true;
> +		/* if the guest offload is offered by the device, user can modify
> +		 * offload capability. In such posted buffers may short fall of size.
> +		 * Hence allocate for max size.
> +		 */
> +		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> +			vi->big_packets_sg_num = MAX_SKB_FRAGS;
MAX_SKB_FRAGS is needed when any of the guest_gso capability is offered. 
This is per spec regardless if VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is 
negotiated or not. Quoting spec:

> If VIRTIO_NET_F_MRG_RXBUF is not negotiated:
>
>   * If VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6 or
>     VIRTIO_NET_F_GUEST_UFO are negotiated, the driver SHOULD populate
>     the receive queue(s) with buffers of at least 65562 bytes.
>

I would just simply put:

vi->big_packets_sg_num = guest_gso ? MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);

There needs to be another patch to address the 
virtnet_set_guest_offloads() case. For now just leave with a TODO 
comment and keep it as-is (don't start with full MAX_SKB_FRAGS segments).
> +		else
> +			vi->big_packets_sg_num = DIV_ROUND_UP(mtu, PAGE_SIZE);
> +	}
> +}
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   	int i, err = -ENOMEM;
>   	struct net_device *dev;
>   	struct virtnet_info *vi;
>   	u16 max_queue_pairs;
> -	int mtu;
> +	int mtu = 0;
>   
>   	/* Find if host supports multiqueue/rss virtio_net device */
>   	max_queue_pairs = 1;
> @@ -3784,10 +3805,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>   	spin_lock_init(&vi->refill_lock);
>   
> -	/* If we can receive ANY GSO packets, we must allocate large ones. */
> -	if (virtnet_check_guest_gso(vi))
> -		vi->big_packets = true;
> -
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>   		vi->mergeable_rx_bufs = true;
>   
> @@ -3853,12 +3870,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>   
>   		dev->mtu = mtu;
>   		dev->max_mtu = mtu;
> -
> -		/* TODO: size buffers correctly in this case. */
> -		if (dev->mtu > ETH_DATA_LEN)
> -			vi->big_packets = true;
>   	}
>   
Can we add a comment here to note that this essentially has to be 
dev->max_mtu when F_MTU is negotiated. The implicit assumption of mtu 
being 0 when F_MTU is not negotiated is not so obvious to readers.

Thanks,
-Siwei
> +	virtnet_set_big_packets_fields(vi, mtu);
> +
>   	if (vi->any_header_sg)
>   		dev->needed_headroom = vi->hdr_len;
>   

--------------D0WHH0JdGtzNmlRYGuycaOhH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Sorry for the delay. Didn't notice as this thread was not addressed
    to my work email. Please copy to my work email if it needs my
    immediate attention.<br>
    <br>
    <div class="moz-cite-prefix">On 8/25/2022 5:38 AM, Gavin Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
packets even when GUEST_* offloads are not present on the device.
However, if guest GSO is not supported, it would be sufficient to
allocate segments to cover just up the MTU size and no further.
Allocating the maximum amount of segments results in a large waste of
buffer space in the queue, which limits the number of packets that can
be buffered and can result in reduced performance.

Therefore, if guest GSO is not supported, use the MTU to calculate the
optimal amount of segments required.

When guest offload is enabled at runtime, RQ already has packets of bytes
less than 64K. So when packet of 64KB arrives, all the packets of such
size will be dropped. and RQ is now not usable.

So this means that during set_guest_offloads() phase, RQs have to be
destroyed and recreated, which requires almost driver reload.</pre>
    </blockquote>
    Yes, this needs VIRTIO_F_RING_RESET and disable_vq_and_reset() to be
    done on RQ and refill it with appropriate size of buffer. Not for
    this patch anyway.<br>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">

If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it should
always treat them as GSO enabled.

Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
1 VQ, queue size 1024, before and after the change, with the iperf
server running over the virtio-net interface.

MTU(Bytes)/Bandwidth (Gbit/s)
             Before   After
  1500        22.5     22.4
  9000        12.8     25.9

Signed-off-by: Gavin Li <a class="moz-txt-link-rfc2396E" href="mailto:gavinl@nvidia.com">&lt;gavinl@nvidia.com&gt;</a>
Reviewed-by: Gavi Teitz <a class="moz-txt-link-rfc2396E" href="mailto:gavi@nvidia.com">&lt;gavi@nvidia.com&gt;</a>
Reviewed-by: Parav Pandit <a class="moz-txt-link-rfc2396E" href="mailto:parav@nvidia.com">&lt;parav@nvidia.com&gt;</a>
---
changelog:
v1-&gt;v2
- Addressed comments from Jason, Michael, Si-Wei.
- Remove the flag of guest GSO support, set sg_num for big packets and
  use it directly
- Recalculate sg_num for big packets in virtnet_set_guest_offloads
- Replace the round up algorithm with DIV_ROUND_UP
---
 drivers/net/virtio_net.c | 41 +++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e1904877d461..ec8c135a26d6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -225,6 +225,9 @@ struct virtnet_info {
 	/* I like... big packets and I cannot lie! */
 	bool big_packets;
 
+	/* number of sg entries allocated for big packets */
+	unsigned int big_packets_sg_num;
+
 	/* Host will merge rx buffers for big packets (shake it! shake it!) */
 	bool mergeable_rx_bufs;
 
@@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 	char *p;
 	int i, err, offset;
 
-	sg_init_table(rq-&gt;sg, MAX_SKB_FRAGS + 2);
+	sg_init_table(rq-&gt;sg, vi-&gt;big_packets_sg_num + 2);
 
-	/* page in rq-&gt;sg[MAX_SKB_FRAGS + 1] is list tail */
-	for (i = MAX_SKB_FRAGS + 1; i &gt; 1; --i) {
+	/* page in rq-&gt;sg[vi-&gt;big_packets_sg_num + 1] is list tail */
+	for (i = vi-&gt;big_packets_sg_num + 1; i &gt; 1; --i) {
 		first = get_a_page(rq, gfp);
 		if (!first) {
 			if (list)
@@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 
 	/* chain first in list head */
 	first-&gt;private = (unsigned long)list;
-	err = virtqueue_add_inbuf(rq-&gt;vq, rq-&gt;sg, MAX_SKB_FRAGS + 2,
+	err = virtqueue_add_inbuf(rq-&gt;vq, rq-&gt;sg, vi-&gt;big_packets_sg_num + 2,
 				  first, gfp);
 	if (err &lt; 0)
 		give_pages(rq, first);
@@ -3690,13 +3693,31 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
 		virtio_has_feature(vi-&gt;vdev, VIRTIO_NET_F_GUEST_UFO));
 }
 
+static void virtnet_set_big_packets_fields(struct virtnet_info *vi, const int mtu)
+{
+	bool guest_gso = virtnet_check_guest_gso(vi);
+
+	/* If we can receive ANY GSO packets, we must allocate large ones. */
+	if (mtu &gt; ETH_DATA_LEN || guest_gso) {
+		vi-&gt;big_packets = true;
+		/* if the guest offload is offered by the device, user can modify
+		 * offload capability. In such posted buffers may short fall of size.
+		 * Hence allocate for max size.
+		 */
+		if (virtio_has_feature(vi-&gt;vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
+			vi-&gt;big_packets_sg_num = MAX_SKB_FRAGS;</pre>
    </blockquote>
    MAX_SKB_FRAGS is needed when any of the guest_gso capability is
    offered. This is per spec regardless if
    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated or not. Quoting spec:<br>
    <br>
    <blockquote type="cite"><span style="color: rgb(0, 0, 0);
        font-family: Arial, Helvetica, sans-serif; font-size: 13.3333px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: left; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">If VIRTIO_NET_F_MRG_RXBUF is not
        negotiated:</span>
      <ul class="itemize2" style="color: rgb(0, 0, 0); font-family:
        Arial, Helvetica, sans-serif; font-size: 13.3333px; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;">
        <li class="itemize">If VIRTIO_NET_F_GUEST_TSO4,
          VIRTIO_NET_F_GUEST_TSO6 or VIRTIO_NET_F_GUEST_UFO are
          negotiated, the driver SHOULD populate the receive queue(s)
          with buffers of at least 65562 bytes.</li>
      </ul>
    </blockquote>
    <br>
    I would just simply put:<br>
    <pre class="moz-quote-pre" wrap="">vi-&gt;big_packets_sg_num = guest_gso ? MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);

</pre>
    There needs to be another patch to address the
    virtnet_set_guest_offloads() case.
    For now just leave with a TODO comment and keep it as-is (don't
    start with full MAX_SKB_FRAGS segments). <br>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
+		else
+			vi-&gt;big_packets_sg_num = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	}
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
 	struct net_device *dev;
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
-	int mtu;
+	int mtu = 0;
 
 	/* Find if host supports multiqueue/rss virtio_net device */
 	max_queue_pairs = 1;
@@ -3784,10 +3805,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	INIT_WORK(&amp;vi-&gt;config_work, virtnet_config_changed_work);
 	spin_lock_init(&amp;vi-&gt;refill_lock);
 
-	/* If we can receive ANY GSO packets, we must allocate large ones. */
-	if (virtnet_check_guest_gso(vi))
-		vi-&gt;big_packets = true;
-
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi-&gt;mergeable_rx_bufs = true;
 
@@ -3853,12 +3870,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		dev-&gt;mtu = mtu;
 		dev-&gt;max_mtu = mtu;
-
-		/* TODO: size buffers correctly in this case. */
-		if (dev-&gt;mtu &gt; ETH_DATA_LEN)
-			vi-&gt;big_packets = true;
 	}
 </pre>
    </blockquote>
    Can we add a comment here to note that this essentially has to be
    dev-&gt;max_mtu when F_MTU is negotiated. The implicit assumption of
    mtu being 0 when F_MTU is not negotiated is not so obvious to
    readers.<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:20220825123840.20239-3-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
+	virtnet_set_big_packets_fields(vi, mtu);
+
 	if (vi-&gt;any_header_sg)
 		dev-&gt;needed_headroom = vi-&gt;hdr_len;
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D0WHH0JdGtzNmlRYGuycaOhH--

