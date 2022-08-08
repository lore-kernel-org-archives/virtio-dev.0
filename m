Return-Path: <virtio-dev-return-9706-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28A389861E4
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 Aug 2022 07:31:29 +0000 (UTC)
Message-ID: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
Date: Mon, 8 Aug 2022 15:31:11 +0800
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
Cc: parav@nvidia.com, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/1/2022 9:45 PM, Gavin Li wrote:
>> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
>> packets even when GUEST_* offloads are not present on the device.
>> However, if GSO is not supported,
> GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
> been be called.
ACK
>
>> =C2=A0 it would be sufficient to allocate
>> segments to cover just up the MTU size and no further. Allocating the
>> maximum amount of segments results in a large waste of buffer space in
>> the queue, which limits the number of packets that can be buffered and
>> can result in reduced performance.
>>
>> Therefore, if GSO is not supported,
> Ditto.
ACK
>
>> use the MTU to calculate the
>> optimal amount of segments required.
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
>> =C2=A0 drivers/net/virtio_net.c | 20 ++++++++++++++++----
>> =C2=A0 1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index ec8e1b3108c3..d36918c1809d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -222,6 +222,9 @@ struct virtnet_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* I like... big packets and I cannot lie=
! */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool big_packets;
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* Indicates GSO support */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 bool gso_is_supported;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Host will merge rx buffers for big pac=
kets (shake it! shake=20
>> it!) */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool mergeable_rx_bufs;
>>
>> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct=20
>> virtnet_info *vi, struct receive_queue *rq,
>> =C2=A0 static int add_recvbuf_big(struct virtnet_info *vi, struct=20
>> receive_queue *rq,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gf=
p_t gfp)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sg_num =3D MAX_SKB_FRAGS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *first, *list =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, err, offset;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!vi->gso_is_supported) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int mtu =3D vi->dev->mtu;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sg_num =3D (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu=20
>> / PAGE_SIZE;
> DIV_ROUND_UP() can be used?
ACK
>
> Since this branch slightly adds up cost to the datapath, I wonder if
> this sg_num can be saved and set only once (generally in virtnet_probe
> time) in struct virtnet_info?
Not sure how to do it and align it with align with new mtu during=20
.ndo_change_mtu()---as you mentioned in the following mail. Any idea?=20
ndo_change_mtu might be in vendor specific code and unmanageable. In my=20
case, the mtu can only be changed in the xml of the guest vm.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, sg_num + 2);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* page in rq->sg[MAX_SKB_FRAGS + 1] is l=
ist tail */
> Comment doesn't match code.
ACK
>> -=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D sg_num + 1; i > 1; --i) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 first =3D get_a_page(rq, gfp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!first) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list)
>> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info=20
>> *vi, struct receive_queue *rq,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* chain first in list head */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first->private =3D (unsigned long)list;
>> -=C2=A0=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg, MA=
X_SKB_FRAGS + 2,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg, sg=
_num + 2,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first, gfp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 give_pages(rq, first);
>> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device=20
>> *vdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NET_F=
_GUEST_TSO4) ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_featur=
e(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_featur=
e(vdev, VIRTIO_NET_F_GUEST_ECN) ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_feature(vde=
v, VIRTIO_NET_F_GUEST_UFO))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_feature(vde=
v, VIRTIO_NET_F_GUEST_UFO)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vi->big_packets =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vi->gso_is_supported =3D true;
> Please do the same for virtnet_clear_guest_offloads(), and
> correspondingly virtnet_restore_guest_offloads() as well. Not sure why
> virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
> successful return, seems like a bug to me.
ACK. The two calls virtnet_set_guest_offloads and=20
virtnet_set_guest_offloads is also called by virtnet_set_features. Do=20
you think if I can do this in virtnet_set_guest_offloads?
>
>
> Thanks,
> -Siwei
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NET_F=
_MRG_RXBUF))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vi->mergeable_rx_bufs =3D true;
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

