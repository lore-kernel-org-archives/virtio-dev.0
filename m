Return-Path: <virtio-dev-return-9859-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2931986449
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Aug 2022 08:35:53 +0000 (UTC)
Message-ID: <453a50f7-ab7d-3474-cab6-2e83a3c3acbf@nvidia.com>
Date: Wed, 31 Aug 2022 16:35:40 +0800
References: <20220830022634.69686-1-gavinl@nvidia.com>
 <20220830022634.69686-3-gavinl@nvidia.com>
 <ed397c98-316c-4785-0d16-81605246c2cb@oracle.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <ed397c98-316c-4785-0d16-81605246c2cb@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-net: use mtu size as buffer
 length for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Si-Wei Liu <si-wei.liu@oracle.com>, stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com
Cc: gavi@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/31/2022 4:33 PM, Si-Wei Liu wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/29/2022 7:26 PM, Gavin Li wrote:
>> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
>> packets even when GUEST_* offloads are not present on the device.
>> However, if guest GSO is not supported, it would be sufficient to
>> allocate segments to cover just up the MTU size and no further.
>> Allocating the maximum amount of segments results in a large waste of
>> buffer space in the queue, which limits the number of packets that can
>> be buffered and can result in reduced performance.
>>
>> Therefore, if guest GSO is not supported, use the MTU to calculate the
>> optimal amount of segments required.
>>
>> When guest offload is enabled at runtime, RQ already has packets of=20
>> bytes
>> less than 64K. So when packet of 64KB arrives, all the packets of such
>> size will be dropped. and RQ is now not usable.
>>
>> So this means that during set_guest_offloads() phase, RQs have to be
>> destroyed and recreated, which requires almost driver reload.
>>
>> If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it should
>> always treat them as GSO enabled.
>>
>> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
>> 1 VQ, queue size 1024, before and after the change, with the iperf
>> server running over the virtio-net interface.
>>
>> MTU(Bytes)/Bandwidth (Gbit/s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Before=C2=A0=C2=A0 After
>> =C2=A0=C2=A0 1500=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22.5=C2=A0=
=C2=A0=C2=A0=C2=A0 22.4
>> =C2=A0=C2=A0 9000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12.8=C2=A0=
=C2=A0=C2=A0=C2=A0 25.9
>>
>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> ---
>> changelog:
>> v2->v3
>> - Addressed comments from Si-Wei
>> - Simplify the condition check to enable the optimization
>> v1->v2
>> - Addressed comments from Jason, Michael, Si-Wei.
>> - Remove the flag of guest GSO support, set sg_num for big packets and
>> =C2=A0=C2=A0 use it directly
>> - Recalculate sg_num for big packets in virtnet_set_guest_offloads
>> - Replace the round up algorithm with DIV_ROUND_UP
>> ---
>> =C2=A0 drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++-----------=
--
>> =C2=A0 1 file changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e1904877d461..d2721e71af18 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -225,6 +225,9 @@ struct virtnet_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* I like... big packets and I cannot lie=
! */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool big_packets;
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* number of sg entries allocated for big pack=
ets */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int big_packets_sg_num;
> Sorry for nit picking, but in my opinion big_packets_num_skbfrags might
> be a better name than big_packets_sg_num, where the comment could be
> written as "number of skb fragments for big packets" rather than "number
> of sg entries allocated for big packets".
ACK
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Host will merge rx buffers for big pac=
kets (shake it! shake=20
>> it!) */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool mergeable_rx_bufs;
>>
>> @@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct=20
>> virtnet_info *vi, struct receive_queue *rq,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, err, offset;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, vi->big_packets_sg_num +=
 2);
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0 /* page in rq->sg[MAX_SKB_FRAGS + 1] is list t=
ail */
>> -=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* page in rq->sg[vi->big_packets_sg_num + 1] =
is list tail */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D vi->big_packets_sg_num + 1; i > 1; =
--i) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 first =3D get_a_page(rq, gfp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!first) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list)
>> @@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info=20
>> *vi, struct receive_queue *rq,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* chain first in list head */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first->private =3D (unsigned long)list;
>> -=C2=A0=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MA=
X_SKB_FRAGS + 2,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg,=20
>> vi->big_packets_sg_num + 2,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first, gfp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 give_pages(rq, first);
>> @@ -3690,13 +3693,27 @@ static bool virtnet_check_guest_gso(const=20
>> struct virtnet_info *vi)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO));
>> =C2=A0 }
>>
>> +static void virtnet_set_big_packets_fields(struct virtnet_info *vi,=20
>> const int mtu)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 bool guest_gso =3D virtnet_check_guest_gso(vi)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* If device can receive ANY guest GSO packets=
, regardless of mtu,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocate packets of maximum size, othe=
rwise limit it to only
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * mtu size worth only.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (mtu > ETH_DATA_LEN || guest_gso) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vi->big_packets =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vi->big_packets_sg_num =3D guest_gso ? MAX_SKB_FRAGS :=20
>> DIV_ROUND_UP(mtu, PAGE_SIZE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> =C2=A0 static int virtnet_probe(struct virtio_device *vdev)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, err =3D -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct net_device *dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtnet_info *vi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 max_queue_pairs;
>> -=C2=A0=C2=A0=C2=A0=C2=A0 int mtu;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int mtu =3D 0;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Find if host supports multiqueue/rss v=
irtio_net device */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_queue_pairs =3D 1;
>> @@ -3784,10 +3801,6 @@ static int virtnet_probe(struct virtio_device=20
>> *vdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&vi->config_work, virtnet_confi=
g_changed_work);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&vi->refill_lock);
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0 /* If we can receive ANY GSO packets, we must =
allocate large=20
>> ones. */
>> -=C2=A0=C2=A0=C2=A0=C2=A0 if (virtnet_check_guest_gso(vi))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vi->big_packets =3D true;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NET_F=
_MRG_RXBUF))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vi->mergeable_rx_bufs =3D true;
>>
>> @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct virtio_device=20
>> *vdev)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev->mtu =3D mtu;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev->max_mtu =3D mtu;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* TODO: size buffers correctly in this case. */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (dev->mtu > ETH_DATA_LEN)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vi->big_packets =3D tru=
e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0 virtnet_set_big_packets_fields(vi, mtu);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vi->any_header_sg)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev->needed_headroom =3D vi->hdr_len;
>>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

