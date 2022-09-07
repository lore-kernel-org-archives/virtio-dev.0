Return-Path: <virtio-dev-return-9907-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17D14986533
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 08:09:12 +0000 (UTC)
Message-ID: <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
Date: Wed, 7 Sep 2022 16:08:54 +0800
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <20220907012608-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, gavi@nvidia.com, parav@nvidia.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 9/7/2022 1:31 PM, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Sep 01, 2022 at 05:10:38AM +0300, Gavin Li wrote:
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
>> When guest offload is enabled at runtime, RQ already has packets of byte=
s
>> less than 64K. So when packet of 64KB arrives, all the packets of such
>> size will be dropped. and RQ is now not usable.
>>
>> So this means that during set_guest_offloads() phase, RQs have to be
>> destroyed and recreated, which requires almost driver reload.
>>
>> If VIRTIO_NET_F_CTRL_GUEST_OFFLOADS has been negotiated, then it should
>> always treat them as GSO enabled.
>>
>> Accordingly, for now the assumption is that if guest GSO has been
>> negotiated then it has been enabled, even if it's actually been disabled
>> at runtime through VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
>>
>> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
>> 1 VQ, queue size 1024, before and after the change, with the iperf
>> server running over the virtio-net interface.
>>
>> MTU(Bytes)/Bandwidth (Gbit/s)
>>               Before   After
>>    1500        22.5     22.4
>>    9000        12.8     25.9
>>
>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
> Which configurations were tested?
I tested it with DPDK vDPA + qemu vhost. Do you mean the feature set of=20
the VM?
> Did you test devices without VIRTIO_NET_F_MTU ?
No.=C2=A0 It will need code changes.
>
>> ---
>> changelog:
>> v4->v5
>> - Addressed comments from Michael S. Tsirkin
>> - Improve commit message
>> v3->v4
>> - Addressed comments from Si-Wei
>> - Rename big_packets_sg_num with big_packets_num_skbfrags
>> v2->v3
>> - Addressed comments from Si-Wei
>> - Simplify the condition check to enable the optimization
>> v1->v2
>> - Addressed comments from Jason, Michael, Si-Wei.
>> - Remove the flag of guest GSO support, set sg_num for big packets and
>>    use it directly
>> - Recalculate sg_num for big packets in virtnet_set_guest_offloads
>> - Replace the round up algorithm with DIV_ROUND_UP
>> ---
>>   drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++-------------
>>   1 file changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index f831a0290998..dbffd5f56fb8 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -225,6 +225,9 @@ struct virtnet_info {
>>        /* I like... big packets and I cannot lie! */
>>        bool big_packets;
>>
>> +     /* number of sg entries allocated for big packets */
>> +     unsigned int big_packets_num_skbfrags;
>> +
>>        /* Host will merge rx buffers for big packets (shake it! shake it=
!) */
>>        bool mergeable_rx_bufs;
>>
>> @@ -1331,10 +1334,10 @@ static int add_recvbuf_big(struct virtnet_info *=
vi, struct receive_queue *rq,
>>        char *p;
>>        int i, err, offset;
>>
>> -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>> +     sg_init_table(rq->sg, vi->big_packets_num_skbfrags + 2);
>>
>> -     /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
>> -     for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
>> +     /* page in rq->sg[vi->big_packets_num_skbfrags + 1] is list tail *=
/
>> +     for (i =3D vi->big_packets_num_skbfrags + 1; i > 1; --i) {
>>                first =3D get_a_page(rq, gfp);
>>                if (!first) {
>>                        if (list)
>> @@ -1365,7 +1368,7 @@ static int add_recvbuf_big(struct virtnet_info *vi=
, struct receive_queue *rq,
>>
>>        /* chain first in list head */
>>        first->private =3D (unsigned long)list;
>> -     err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
>> +     err =3D virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_sk=
bfrags + 2,
>>                                  first, gfp);
>>        if (err < 0)
>>                give_pages(rq, first);
>> @@ -3690,13 +3693,27 @@ static bool virtnet_check_guest_gso(const struct=
 virtnet_info *vi)
>>                virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO);
>>   }
>>
>> +static void virtnet_set_big_packets_fields(struct virtnet_info *vi, con=
st int mtu)
>
> I'd rename this to just virtnet_set_big_packets.
ACK
>
>
>> +{
>> +     bool guest_gso =3D virtnet_check_guest_gso(vi);
>> +
>> +     /* If device can receive ANY guest GSO packets, regardless of mtu,
>> +      * allocate packets of maximum size, otherwise limit it to only
>> +      * mtu size worth only.
>> +      */
>> +     if (mtu > ETH_DATA_LEN || guest_gso) {
>> +             vi->big_packets =3D true;
>> +             vi->big_packets_num_skbfrags =3D guest_gso ? MAX_SKB_FRAGS=
 : DIV_ROUND_UP(mtu, PAGE_SIZE);
>> +     }
>> +}
>> +
>>   static int virtnet_probe(struct virtio_device *vdev)
>>   {
>>        int i, err =3D -ENOMEM;
>>        struct net_device *dev;
>>        struct virtnet_info *vi;
>>        u16 max_queue_pairs;
>> -     int mtu;
>> +     int mtu =3D 0;
>>
>>        /* Find if host supports multiqueue/rss virtio_net device */
>>        max_queue_pairs =3D 1;
>> @@ -3784,10 +3801,6 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
>>        INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>>        spin_lock_init(&vi->refill_lock);
>>
>> -     /* If we can receive ANY GSO packets, we must allocate large ones.=
 */
>> -     if (virtnet_check_guest_gso(vi))
>> -             vi->big_packets =3D true;
>> -
>>        if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>>                vi->mergeable_rx_bufs =3D true;
>>
>> @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct virtio_device *v=
dev)
>>
>>                dev->mtu =3D mtu;
>>                dev->max_mtu =3D mtu;
>> -
>> -             /* TODO: size buffers correctly in this case. */
>> -             if (dev->mtu > ETH_DATA_LEN)
>> -                     vi->big_packets =3D true;
>>        }
>>
>> +     virtnet_set_big_packets_fields(vi, mtu);
>> +
> If VIRTIO_NET_F_MTU is off, then mtu is uninitialized.
> You should move it to within if () above to fix.
mtu was initialized to 0 at the beginning of probe if VIRTIO_NET_F_MTU=20
is off.

In this case,=C2=A0 big_packets_num_skbfrags will be set according to guest=
 gso.

If guest gso is supported, it will be set to MAX_SKB_FRAGS else zero----=20
do you

think this is a bug to be fixed?

>
>>        if (vi->any_header_sg)
>>                dev->needed_headroom =3D vi->hdr_len;
>>
>> --
>> 2.31.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

