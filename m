Return-Path: <virtio-dev-return-9718-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1470B986332
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 18:06:46 +0000 (UTC)
Message-ID: <65d518e8-387a-64be-0408-de6804313284@oracle.com>
Date: Tue, 9 Aug 2022 11:06:29 -0700
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: multipart/alternative;
 boundary="------------qzVStYBRiJOLs31OZvug4027"
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
Cc: parav@nvidia.com, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------qzVStYBRiJOLs31OZvug4027
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 8/9/2022 12:06 AM, Gavin Li wrote:
>
>
> On 8/9/2022 7:56 AM, Si-Wei Liu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/8/2022 12:31 AM, Gavin Li wrote:
>>>
>>> On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 8/1/2022 9:45 PM, Gavin Li wrote:
>>>>> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
>>>>> packets even when GUEST_* offloads are not present on the device.
>>>>> However, if GSO is not supported,
>>>> GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
>>>> been be called.
>>> ACK
>>>>
>>>>> =C2=A0 it would be sufficient to allocate
>>>>> segments to cover just up the MTU size and no further. Allocating the
>>>>> maximum amount of segments results in a large waste of buffer=20
>>>>> space in
>>>>> the queue, which limits the number of packets that can be buffered=20
>>>>> and
>>>>> can result in reduced performance.
>>>>>
>>>>> Therefore, if GSO is not supported,
>>>> Ditto.
>>> ACK
>>>>
>>>>> use the MTU to calculate the
>>>>> optimal amount of segments required.
>>>>>
>>>>> Below is the iperf TCP test results over a Mellanox NIC, using=20
>>>>> vDPA for
>>>>> 1 VQ, queue size 1024, before and after the change, with the iperf
>>>>> server running over the virtio-net interface.
>>>>>
>>>>> MTU(Bytes)/Bandwidth (Gbit/s)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Before=C2=A0=C2=A0 After
>>>>> =C2=A0=C2=A0 1500=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22.5=C2=
=A0=C2=A0=C2=A0=C2=A0 22.4
>>>>> =C2=A0=C2=A0 9000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12.8=C2=
=A0=C2=A0=C2=A0=C2=A0 25.9
>>>>>
>>>>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>>>>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>>> ---
>>>>> =C2=A0 drivers/net/virtio_net.c | 20 ++++++++++++++++----
>>>>> =C2=A0 1 file changed, 16 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>> index ec8e1b3108c3..d36918c1809d 100644
>>>>> --- a/drivers/net/virtio_net.c
>>>>> +++ b/drivers/net/virtio_net.c
>>>>> @@ -222,6 +222,9 @@ struct virtnet_info {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* I like... big packets and I cannot =
lie! */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool big_packets;
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* Indicates GSO support */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 bool gso_is_supported;
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Host will merge rx buffers for big =
packets (shake it! shake
>>>>> it!) */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool mergeable_rx_bufs;
>>>>>
>>>>> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
>>>>> virtnet_info *vi, struct receive_queue *rq,
>>>>> =C2=A0 static int add_recvbuf_big(struct virtnet_info *vi, struct
>>>>> receive_queue *rq,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 gfp_t gfp)
>>>>> =C2=A0 {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sg_num =3D MAX_SKB_FRAGS;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *first, *list =3D NULL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, err, offset;
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!vi->gso_is_supported) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int mtu =3D vi->dev->mtu;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sg_num =3D (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu
>>>>> / PAGE_SIZE;
>>>> DIV_ROUND_UP() can be used?
>>> ACK
>>>>
>>>> Since this branch slightly adds up cost to the datapath, I wonder if
>>>> this sg_num can be saved and set only once (generally in virtnet_probe
>>>> time) in struct virtnet_info?
>>> Not sure how to do it and align it with align with new mtu during
>>> .ndo_change_mtu()---as you mentioned in the following mail. Any idea?
>>> ndo_change_mtu might be in vendor specific code and unmanageable. In
>>> my case, the mtu can only be changed in the xml of the guest vm.
>> Nope, for e.g. "ip link dev eth0 set mtu 1500" can be done from guest=20
>> on a virtio-net device with 9000 MTU (as defined in guest xml).=20
>> Basically
>> guest user can set MTU to any valid value lower than the original
>> HOST_MTU. In the vendor defined .ndo_change_mtu() op, dev_validate_mtu()
>> should have validated the MTU value before coming down to it. And I
>> suspect you might want to do virtnet_close() and virtnet_open()
>> before/after changing the buffer size on the fly (the netif_running()
>> case), implementing .ndo_change_mtu() will be needed anyway.
> a guest VM driver changing mtu to smaller one is valid use case.=20
> However, current optimization suggested in the patch doesn't degrade=20
> any performance. Performing close() and open() sequence is good idea,=20
> that I would like to take up next after this patch as its going to be=20
> more than one patch to achieve it.
Sure, it's fine to separate it out into another patch and optimize on=20
top later on. Though the previous comment of avoiding repeatedly=20
computing sg_num in datapath still holds: set sg_num only once in=20
probe() time then, in which case the sg_num needed can be simply=20
inferred from dev->max_mtu rather than dev->mtu.

-Siwei

>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 sg_init_table(rq->sg, sg_num + 2);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* page in rq->sg[MAX_SKB_FRAGS + 1] i=
s list tail */
>>>> Comment doesn't match code.
>>> ACK
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D MAX_SKB_FRAGS + 1; i > 1; --i) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D sg_num + 1; i > 1; --i) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 first =3D get_a_page(rq, gfp);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!first) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list)
>>>>> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
>>>>> *vi, struct receive_queue *rq,
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* chain first in list head */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first->private =3D (unsigned long)list=
;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg,=
 MAX_SKB_FRAGS + 2,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 err =3D virtqueue_add_inbuf(rq->vq, rq->sg,=
 sg_num + 2,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first, gfp);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 give_pages(rq, first);
>>>>> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
>>>>> *vdev)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NE=
T_F_GUEST_TSO4) ||
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_fea=
ture(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_fea=
ture(vdev, VIRTIO_NET_F_GUEST_ECN) ||
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_feature(=
vdev, VIRTIO_NET_F_GUEST_UFO))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_has_feature(=
vdev, VIRTIO_NET_F_GUEST_UFO)) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vi->big_packets =3D true;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vi->gso_is_supported =3D true;
>>>> Please do the same for virtnet_clear_guest_offloads(), and
>>>> correspondingly virtnet_restore_guest_offloads() as well. Not sure why
>>>> virtnet_clear_guest_offloads() or the caller doesn't unset=20
>>>> big_packet on
>>>> successful return, seems like a bug to me.
>>> ACK. The two calls virtnet_set_guest_offloads and
>>> virtnet_set_guest_offloads is also called by virtnet_set_features. Do
>>> you think if I can do this in virtnet_set_guest_offloads?
>> I think that it should be fine, though you may want to deal with the XDP
>> path not to regress it.
>>
>> -Siwei
>>
>>>>
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NE=
T_F_MRG_RXBUF))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vi->mergeable_rx_bufs =3D true;
>>>>
>>

--------------qzVStYBRiJOLs31OZvug4027
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 8/9/2022 12:06 AM, Gavin Li wrote:<br=
>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:465efc4c-f41f-494e-8f2d-a87deae90=
c5d@nvidia.com">
     =20
      <p><br>
      </p>
      <div class=3D"moz-cite-prefix">On 8/9/2022 7:56 AM, Si-Wei Liu
        wrote:<br>
      </div>
      <blockquote type=3D"cite" cite=3D"mid:c173ba21-ad86-6360-5db7-df81de0=
b0350@oracle.com">External
        email: Use caution opening links or attachments <br>
        <br>
        <br>
        On 8/8/2022 12:31 AM, Gavin Li wrote: <br>
        <blockquote type=3D"cite"> <br>
          On 8/6/2022 6:11 AM, Si-Wei Liu wrote: <br>
          <blockquote type=3D"cite">External email: Use caution opening
            links or attachments <br>
            <br>
            <br>
            On 8/1/2022 9:45 PM, Gavin Li wrote: <br>
            <blockquote type=3D"cite">Currently add_recvbuf_big()
              allocates MAX_SKB_FRAGS segments for big <br>
              packets even when GUEST_* offloads are not present on the
              device. <br>
              However, if GSO is not supported, <br>
            </blockquote>
            GUEST GSO (virtio term), or GRO HW (netdev core term) it
            should have <br>
            been be called. <br>
          </blockquote>
          ACK <br>
          <blockquote type=3D"cite"> <br>
            <blockquote type=3D"cite">&nbsp; it would be sufficient to allo=
cate
              <br>
              segments to cover just up the MTU size and no further.
              Allocating the <br>
              maximum amount of segments results in a large waste of
              buffer space in <br>
              the queue, which limits the number of packets that can be
              buffered and <br>
              can result in reduced performance. <br>
              <br>
              Therefore, if GSO is not supported, <br>
            </blockquote>
            Ditto. <br>
          </blockquote>
          ACK <br>
          <blockquote type=3D"cite"> <br>
            <blockquote type=3D"cite">use the MTU to calculate the <br>
              optimal amount of segments required. <br>
              <br>
              Below is the iperf TCP test results over a Mellanox NIC,
              using vDPA for <br>
              1 VQ, queue size 1024, before and after the change, with
              the iperf <br>
              server running over the virtio-net interface. <br>
              <br>
              MTU(Bytes)/Bandwidth (Gbit/s) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Before&nbsp;&nbsp; After <br>
              &nbsp;&nbsp; 1500&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
2.5&nbsp;&nbsp;&nbsp;&nbsp; 22.4 <br>
              &nbsp;&nbsp; 9000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
2.8&nbsp;&nbsp;&nbsp;&nbsp; 25.9 <br>
              <br>
              Signed-off-by: Gavin Li <a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:gavinl@nvidia.com" moz-do-not-send=3D"true">&lt;gavinl@nvidia.=
com&gt;</a>
              <br>
              Reviewed-by: Gavi Teitz <a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:gavi@nvidia.com" moz-do-not-send=3D"true">&lt;gavi@nvidia.com&=
gt;</a>
              <br>
              Reviewed-by: Parav Pandit <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:parav@nvidia.com" moz-do-not-send=3D"true">&lt;parav@nvidia.=
com&gt;</a>
              <br>
              --- <br>
              &nbsp; drivers/net/virtio_net.c | 20 ++++++++++++++++---- <br=
>
              &nbsp; 1 file changed, 16 insertions(+), 4 deletions(-) <br>
              <br>
              diff --git a/drivers/net/virtio_net.c
              b/drivers/net/virtio_net.c <br>
              index ec8e1b3108c3..d36918c1809d 100644 <br>
              --- a/drivers/net/virtio_net.c <br>
              +++ b/drivers/net/virtio_net.c <br>
              @@ -222,6 +222,9 @@ struct virtnet_info { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* I like... big packets and I=
 cannot lie! */ <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool big_packets; <br>
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; /* Indicates GSO support */ <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; bool gso_is_supported; <br>
              + <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Host will merge rx buffers =
for big packets (shake
              it! shake <br>
              it!) */ <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mergeable_rx_bufs; <br>
              <br>
              @@ -1312,14 +1315,21 @@ static int
              add_recvbuf_small(struct <br>
              virtnet_info *vi, struct receive_queue *rq, <br>
              &nbsp; static int add_recvbuf_big(struct virtnet_info *vi,
              struct <br>
              receive_queue *rq, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; gfp_t gfp) <br>
              &nbsp; { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; unsigned int sg_num =3D MAX_SKB_FRA=
GS; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *first, *list =3D =
NULL; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *p; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, err, offset; <br>
              <br>
              -&nbsp;&nbsp;&nbsp;&nbsp; sg_init_table(rq-&gt;sg, MAX_SKB_FR=
AGS + 2); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; if (!vi-&gt;gso_is_supported) { <br=
>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; unsigned int mtu =3D vi-&gt;dev-&gt;mtu; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; sg_num =3D (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE
              + 1 : mtu <br>
              / PAGE_SIZE; <br>
            </blockquote>
            DIV_ROUND_UP() can be used? <br>
          </blockquote>
          ACK <br>
          <blockquote type=3D"cite"> <br>
            Since this branch slightly adds up cost to the datapath, I
            wonder if <br>
            this sg_num can be saved and set only once (generally in
            virtnet_probe <br>
            time) in struct virtnet_info? <br>
          </blockquote>
          Not sure how to do it and align it with align with new mtu
          during <br>
          .ndo_change_mtu()---as you mentioned in the following mail.
          Any idea? <br>
          ndo_change_mtu might be in vendor specific code and
          unmanageable. In <br>
          my case, the mtu can only be changed in the xml of the guest
          vm. <br>
        </blockquote>
        Nope, for e.g. &quot;ip link dev eth0 set mtu 1500&quot; can be don=
e from
        guest on a virtio-net device with 9000 MTU (as defined in guest
        xml). Basically <br>
        guest user can set MTU to any valid value lower than the
        original <br>
        HOST_MTU. In the vendor defined .ndo_change_mtu() op,
        dev_validate_mtu() <br>
        should have validated the MTU value before coming down to it.
        And I <br>
        suspect you might want to do virtnet_close() and virtnet_open()
        <br>
        before/after changing the buffer size on the fly (the
        netif_running() <br>
        case), implementing .ndo_change_mtu() will be needed anyway. <br>
      </blockquote>
      <span style=3D"color: rgb(255, 255, 255); font-family:
        -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;,
        system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
        Emoji&quot;, &quot;Segoe UI Web&quot;, sans-serif; font-size:
        14px; font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(41, 41, 41); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">a guest VM driver changing mtu to
        smaller one is valid use case. However, current optimization
        suggested in the patch doesn't degrade any performance.
        Performing close() and open() sequence is good idea, that I
        would like to take up next after this patch as its going to be
        more than one patch to achieve it.</span></blockquote>
    Sure, it's fine to separate it out into another patch and optimize
    on top later on. Though the previous comment of avoiding repeatedly
    computing sg_num in datapath still holds: set sg_num only once in
    probe() time then, in which case the sg_num needed can be simply
    inferred from dev-&gt;max_mtu rather than dev-&gt;mtu.<br>
    <br>
    -Siwei<br>
    <br>
    <blockquote type=3D"cite" cite=3D"mid:465efc4c-f41f-494e-8f2d-a87deae90=
c5d@nvidia.com">
      <blockquote type=3D"cite" cite=3D"mid:c173ba21-ad86-6360-5db7-df81de0=
b0350@oracle.com"> <br>
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">+&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; sg_init_table(rq-&gt;sg, sg_num + 2=
); <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* page in rq-&gt;sg[MAX_SKB_F=
RAGS + 1] is list tail
              */ <br>
            </blockquote>
            Comment doesn't match code. <br>
          </blockquote>
          ACK <br>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">-&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D =
MAX_SKB_FRAGS + 1; i
              &gt; 1; --i) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D sg_num + 1; i &gt; 1; --=
i) { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; first =3D get_a_page(rq, gfp); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!first) { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list)=
 <br>
              @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct
              virtnet_info <br>
              *vi, struct receive_queue *rq, <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* chain first in list head */=
 <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first-&gt;private =3D (unsigne=
d long)list; <br>
              -&nbsp;&nbsp;&nbsp;&nbsp; err =3D virtqueue_add_inbuf(rq-&gt;=
vq, rq-&gt;sg,
              MAX_SKB_FRAGS + 2, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; err =3D virtqueue_add_inbuf(rq-&gt;=
vq, rq-&gt;sg,
              sg_num + 2, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first, gfp); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; give_pages(rq, first); <br>
              @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct
              virtio_device <br>
              *vdev) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (virtio_has_feature(vdev,
              VIRTIO_NET_F_GUEST_TSO4) || <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio=
_has_feature(vdev,
              VIRTIO_NET_F_GUEST_TSO6) || <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio=
_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN)
              || <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_has_=
feature(vdev,
              VIRTIO_NET_F_GUEST_UFO)) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_has_=
feature(vdev,
              VIRTIO_NET_F_GUEST_UFO)) { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; vi-&gt;big_packets =3D true; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; vi-&gt;gso_is_supported =3D true; <br>
            </blockquote>
            Please do the same for virtnet_clear_guest_offloads(), and <br>
            correspondingly virtnet_restore_guest_offloads() as well.
            Not sure why <br>
            virtnet_clear_guest_offloads() or the caller doesn't unset
            big_packet on <br>
            successful return, seems like a bug to me. <br>
          </blockquote>
          ACK. The two calls virtnet_set_guest_offloads and <br>
          virtnet_set_guest_offloads is also called by
          virtnet_set_features. Do <br>
          you think if I can do this in virtnet_set_guest_offloads? <br>
        </blockquote>
        I think that it should be fine, though you may want to deal with
        the XDP <br>
        path not to regress it. <br>
        <br>
        -Siwei <br>
        <br>
        <blockquote type=3D"cite">
          <blockquote type=3D"cite"> <br>
            <br>
            Thanks, <br>
            -Siwei <br>
            <blockquote type=3D"cite">+&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (virtio_has_feature(vdev,
              VIRTIO_NET_F_MRG_RXBUF)) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; vi-&gt;mergeable_rx_bufs =3D true; <br>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------qzVStYBRiJOLs31OZvug4027--

