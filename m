Return-Path: <virtio-dev-return-9743-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66DCA986350
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Aug 2022 01:24:21 +0000 (UTC)
Message-ID: <36a5bcab-4595-1679-2389-758150ea5767@redhat.com>
Date: Wed, 10 Aug 2022 09:24:06 +0800
MIME-Version: 1.0
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <19a564f0-d90c-1264-ba20-dcdfec887051@oracle.com>
 <20220809183516-mutt-send-email-mst@kernel.org>
 <0c6c876b-1d52-bfc8-87d4-edbe6b8581bc@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <0c6c876b-1d52-bfc8-87d4-edbe6b8581bc@oracle.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/8/10 06:54, Si-Wei Liu =E5=86=99=E9=81=93:
>
>
> On 8/9/2022 3:37 PM, Michael S. Tsirkin wrote:
>> On Tue, Aug 09, 2022 at 03:32:26PM -0700, Si-Wei Liu wrote:
>>>
>>> On 8/9/2022 2:37 PM, Michael S. Tsirkin wrote:
>>>> On Tue, Aug 09, 2022 at 07:18:30PM +0000, Parav Pandit wrote:
>>>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>> Sent: Tuesday, August 9, 2022 3:09 PM
>>>>>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>>> Sent: Tuesday, August 9, 2022 2:39 PM Currently it is not. Not a
>>>>>>>> single patch nor this patch, but the context for the eventual=20
>>>>>>>> goal is
>>>>>>>> to allow XDP on a MTU=3D9000 link when guest users intentionally=
=20
>>>>>>>> lower
>>>>>>>> down MTU to 1500.
>>>>>>> Which application benefit by having asymmetry by lowering mtu to=20
>>>>>>> 1500
>>>>>> to send packets but want to receive 9K packets?
>>>>> Below details doesn=E2=80=99t answer the question of asymmetry. :)
>>>>>
>>>>>> I think virtio-net driver doesn't differentiate MTU and MRU, in=20
>>>>>> which case
>>>>>> the receive buffer will be reduced to fit the 1500B payload size=20
>>>>>> when mtu is
>>>>>> lowered down to 1500 from 9000.
>>>>> How? Driver reduced the mXu to 1500, say it is improved to post=20
>>>>> buffers of 1500 bytes.
>>>>>
>>>>> Device doesn't know about it because mtu in config space is RO field.
>>>>> Device keep dropping 9K packets because buffers posted are 1500=20
>>>>> bytes.
>>>>> This is because device follows the spec " The device MUST NOT pass=20
>>>>> received packets that exceed mtu".
>>>> The "mtu" here is the device config field, which is
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Default maxi=
mum transmit unit advice */
>>>>
>>>> there is no guarantee device will not get a bigger packet.
>>>> And there is no guarantee such a packet will be dropped
>>>> as opposed to wedging the device if userspace insists on
>>>> adding smaller buffers.
>>> It'd be nice to document this requirement or statement to the spec for
>>> clarity purpose.
>> It's not a requirement, more of a bug. But it's been like this for
>> years.
> Well, I'm not sure how it may wedge the device if not capable of=20
> posting to smaller buffers, is there other option than drop? Truncate=20
> to what the buffer size may fit and deliver up? Seems even worse than=20
> drop...
>
>>
>>> Otherwise various device implementations are hard to
>>> follow. The capture is that vhost-net drops bigger packets while the=20
>>> driver
>>> only supplied smaller buffers. This is the status quo, and users=20
>>> seemingly
>>> have relied on this behavior for some while.
>>>
>>> -Siwei
>> Weird where do you see this in code? I see
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sock_len =3D vhost_net_rx_peek_head_len(net, sock-=
>sk,
>> &busyloop_intr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (!sock_len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sock_len +=3D sock_hlen;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 vhost_len =3D sock_len + vhost_hlen;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 headcount =3D get_rx_bufs(vq, vq->heads + nvq->don=
e_idx,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 vhost_len, &in, vq_log, &log,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 likely(mergeable) ?=20
>> UIO_MAXIOV : 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* On error, stop handling until the next kick. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(headcount < 0))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>>
>>
>> so it does not drop a packet, it just stops processing the queue.
> Here
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* On overrun, truncate and discard */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (unlikely(headcount > UIO_MAXIOV)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iov_iter=
_init(&msg.msg_iter, READ, vq->iov, 1,=20
> 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D =
sock->ops->recvmsg(sock, &msg,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1, MSG_D=
ONTWAIT |=20
> MSG_TRUNC);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug=
("Discarded rx packet: len %zd\n",=20
> sock_len);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>
> recvmsg(, , 1, ) is essentially to drop the oversized packet.


It's not necessarily the oversized packet but the packet that has too=20
many sgs.

This issues has been discussed in the past, (for example we disable=20
large rx queue size for vhost-net in Qemu). Where it could be solved by=20
doing piece-wise copy

Thanks


>
>
> In get_rx_bufs(), overrun detection will return something larger than=20
> UIO_MAXIOV as indicator:
>
> static int get_rx_bufs()
> {
> :
> ;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Detect overrun */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(datalen > 0)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 r =3D UIO_MAXIOV + 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> :
> :
>
>
> -Siwei
>
>>
>>
>>>>
>>>>> So, I am lost what virtio net device user application is trying to=20
>>>>> achieve by sending smaller packets and dropping all receive packets.
>>>>> (it doesn=E2=80=99t have any relation to mergeable or otherwise).
>>>> ---------------------------------------------------------------------
>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

