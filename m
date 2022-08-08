Return-Path: <virtio-dev-return-9707-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D28F9861E4
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 Aug 2022 07:34:35 +0000 (UTC)
Message-ID: <d696fa2d-a198-5481-aefd-1727cdab5c32@nvidia.com>
Date: Mon, 8 Aug 2022 15:34:18 +0800
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <62682efb-f5ed-65de-d209-566738479025@oracle.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <62682efb-f5ed-65de-d209-566738479025@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
Cc: parav@nvidia.com, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/6/2022 7:26 AM, Si-Wei Liu wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/5/2022 3:11 PM, Si-Wei Liu wrote:
>>
>>
>> On 8/1/2022 9:45 PM, Gavin Li wrote:
>>> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
>>> packets even when GUEST_* offloads are not present on the device.
>>> However, if GSO is not supported,
>> GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
>> been be called.
>>
>>> =C2=A0 it would be sufficient to allocate
>>> segments to cover just up the MTU size and no further. Allocating the
>>> maximum amount of segments results in a large waste of buffer space in
>>> the queue, which limits the number of packets that can be buffered and
>>> can result in reduced performance.
>>>
>>> Therefore, if GSO is not supported,
>> Ditto.
>>
>>> use the MTU to calculate the
>>> optimal amount of segments required.
>>>
>>> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
>>> 1 VQ, queue size 1024, before and after the change, with the iperf
>>> server running over the virtio-net interface.
>>>
>>> MTU(Bytes)/Bandwidth (Gbit/s)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Before=C2=A0=C2=A0 After
>>> =C2=A0=C2=A0 1500=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22.5=C2=A0=
=C2=A0=C2=A0=C2=A0 22.4
>>> =C2=A0=C2=A0 9000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12.8=C2=A0=
=C2=A0=C2=A0=C2=A0 25.9
>>>
>>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> ---
>>> =C2=A0 drivers/net/virtio_net.c | 20 ++++++++++++++++----
>>> =C2=A0 1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index ec8e1b3108c3..d36918c1809d 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -222,6 +222,9 @@ struct virtnet_info {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* I like... big packets and I cannot li=
e! */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool big_packets;
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* Indicates GSO support */
>>> +=C2=A0=C2=A0=C2=A0 bool gso_is_supported;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Host will merge rx buffers for big pa=
ckets (shake it! shake
>>> it!) */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool mergeable_rx_bufs;
>>> =C2=A0 @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
>>> virtnet_info *vi, struct receive_queue *rq,
>>> =C2=A0 static int add_recvbuf_big(struct virtnet_info *vi, struct
>>> receive_queue *rq,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_t gfp)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 unsigned int sg_num =3D MAX_SKB_FRAGS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *first, *list =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, err, offset;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>>> +=C2=A0=C2=A0=C2=A0 if (!vi->gso_is_supported) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mtu =3D vi->de=
v->mtu;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sg_num =3D (mtu % PAGE_SIZE=
) ? mtu / PAGE_SIZE + 1 : mtu /
>>> PAGE_SIZE;
>> DIV_ROUND_UP() can be used?
>>
>> Since this branch slightly adds up cost to the datapath, I wonder if
>> this sg_num can be saved and set only once (generally in virtnet_probe
>> time
> ... , but can align with new mtu during .ndo_change_mtu(), too.
ACK but don't know how to do this.
>> ) in struct virtnet_info?
>
> Thanks,
> -Siwei
>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, sg_num + 2);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* page in rq->sg[MAX_SKB_FR=
AGS + 1] is list tail */
>> Comment doesn't match code.
>>> -=C2=A0=C2=A0=C2=A0 for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D sg_num + 1; i > 1; --i) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first =3D get_a_=
page(rq, gfp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!first) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (list)
>>> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
>>> *vi, struct receive_queue *rq,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* chain first in list head =
*/
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first->private =3D (unsigned long)list;
>>> -=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB=
_FRAGS + 2,
>>> +=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg, sg_num =
+ 2,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first, gfp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 give_pages(rq, f=
irst);
>>> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
>>> *vdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NET_=
F_GUEST_TSO4) ||
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_featu=
re(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_featu=
re(vdev, VIRTIO_NET_F_GUEST_ECN) ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_feature(vdev, VI=
RTIO_NET_F_GUEST_UFO))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_feature(vdev, VI=
RTIO_NET_F_GUEST_UFO)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vi->big_packets =
=3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vi->gso_is_supported =3D tr=
ue;
>> Please do the same for virtnet_clear_guest_offloads(), and
>> correspondingly virtnet_restore_guest_offloads() as well. Not sure why
>> virtnet_clear_guest_offloads() or the caller doesn't unset big_packet
>> on successful return, seems like a bug to me.
>>
>>
>> Thanks,
>> -Siwei
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev,=
 VIRTIO_NET_F_MRG_RXBUF))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vi->mergeable_rx=
_bufs =3D true;
>>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

