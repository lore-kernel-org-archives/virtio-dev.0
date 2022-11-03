Return-Path: <virtio-dev-return-10115-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A0B398661C
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Nov 2022 13:02:35 +0000 (UTC)
Message-ID: <6eee6929-577b-2b26-605d-ff650c435d21@opensynergy.com>
Date: Thu, 3 Nov 2022 14:02:25 +0100
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <b19f3d7e-9439-5c2b-c731-e5eaef37442d@hartkopp.net>
From: Harald Mommer <hmo@opensynergy.com>
In-Reply-To: <b19f3d7e-9439-5c2b-c731-e5eaef37442d@hartkopp.net>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN driver.
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Oliver Hartkopp <socketcan@hartkopp.net>, Harald Mommer <harald.mommer@opensynergy.com>, virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

On 27.08.22 11:02, Oliver Hartkopp wrote:
>> +=C2=A0=C2=A0=C2=A0 if ((can_flags & ~CAN_KNOWN_FLAGS) !=3D 0u) {
>
> For your entire patch:
>
> Please remove this pointless " !=3D 0u)" stuff.
>
> =C2=A0=C2=A0=C2=A0=C2=A0if (can_flags & ~CAN_KNOWN_FLAGS) {
>
> is just ok.
Too much MISRA habit in my head which has no place here. Did so.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (can_id > CAN_EFF_MASK) {
>
> The MASK is not a number value.
>
> The check should be
>
> if (can_id & ~CAN_EFF_MASK) {
>
> or you simply mask the can_id value to be really sure without the=20
> netdev_warn() stuff.
CAN_EFF_MASK is now treated as bitmask. And decided to remove this=20
netdev_warn() stuff as proposed, masked the values. So I will miss=20
invalid combinations from the virtio CAN device (may also be buggy) I=20
might still be interested in but this excessive netdev_warn() usage was=20
in the end also for my taste too much.
>
> Are you sure that you could get undefined CAN ID values here?
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stat=
s->rx_dropped++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netd=
ev_warn(dev, "RX: CAN Ext Id 0x%08x too big\n",

The proposed virtio CAN specification says: "The type of a CAN message=20
identifier is determined by flags. The 3 most significant bits of can_id=20
do not bear the information about the type of the CAN message identifier=20
and are 0."

=3D> This trace could have been seen when a buggy device wasn't obeying=20
the 2nd sentence.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len !=3D 0u) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stat=
s->rx_dropped++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netd=
ev_warn(dev, "RX: CAN Id 0x%08x: RTR with len !=3D 0\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can_id);
>
> This is not the right handling.
>
> Classical CAN frames with RTR bit set can have a DLC value from 0 .. F=20
> which is represented in
>
> can_frame.len (for values 0 .. 8)
> can_frame.len8_dlc (values 9 .. F; len must be 8)
>
> With the RTR bit set, the CAN controller does not send CAN data, but=20
> the DLC value is set from 0 .. F.

RTR frames! DLC values <> 0 but then no payload. This needed to be=20
reworked and fixed.

> When you silently sanitize the length value here, you should do the=20
> same with the can_id checks above and simply do a masking like
>
> can_id &=3D CAN_SFF_MASK or can_id &=3D CAN_EFF_MASK
>
Did so. Too much netdev_warn() in the code, really. Too much is too much.
>> +=C2=A0=C2=A0=C2=A0 (void)netif_receive_skb(skb);
>
> Why this "(void)" here and at other places in the patch? Please remove.
> Is there no error handling needed when netif_receive_skb() fails? Or=20
> ar least some statistics rollback?
Old MISRA habit to silence the warning when no error is expected to be=20
possible to occur. This has no place here and was replaced by some=20
better error handling evaluating the returned error not updating the=20
statistics as proposed. For the (void) below just omitted the (void), I=20
see no possible good error handling there and we're not going to run the=20
driver through the MISRA checker.
>> +
>> +putback:
>> +=C2=A0=C2=A0=C2=A0 /* Put processed RX buffer back into avail queue */
>> +=C2=A0=C2=A0=C2=A0 (void)virtio_can_add_inbuf(vq, can_rx, sizeof(struct=
=20
>> virtio_can_rx));
>> +
>> +=C2=A0=C2=A0=C2=A0 return 1; /* Queue was not emtpy so there may be mor=
e data */
>> +}
>
> Best regards,
> Oliver
>
Regards
Harald

(First answering all those review E-Mails, then will have to fight with=20
sending the changed code).

--=20
Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <=3D=3D Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail: harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Regis Adjamah


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

