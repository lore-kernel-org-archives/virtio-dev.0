Return-Path: <virtio-dev-return-10129-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C71B98640B
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Nov 2022 19:22:31 +0000 (UTC)
Message-ID: <bcf9fd32-1078-2c7f-0c2a-5848ac6571e8@opensynergy.com>
Date: Tue, 8 Nov 2022 20:22:25 +0100
From: Harald Mommer <hmo@opensynergy.com>
References: <20221104172421.8271-1-Harald.Mommer@opensynergy.com>
 <20221104172421.8271-3-Harald.Mommer@opensynergy.com>
 <CAMZ6RqLUCs0W8ZP2jAUsFMUXgHTjce649Gu+jnz_S1x_0ER6YQ@mail.gmail.com>
 <9008244e-10ea-7983-50da-4716e213d119@opensynergy.com>
In-Reply-To: <9008244e-10ea-7983-50da-4716e213d119@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH v2 2/2] can: virtio: Add virtio_can to MAINTAINERS
 file.
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Vincent Mailhol <vincent.mailhol@gmail.com>, Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello Vincent,

sorry, my mistake, got it. I was absolutely convinced that commit 1 only=20
contained the code changes and commit 2 only contained the maintainers=20
file. But this is not the case, there was a last minute change and then=20
I did it wrong in git.

Regards
Harald

On 08.11.22 20:13, Harald Mommer wrote:
> Hello Vincent,
>
> what I see here are places from v1 which should be now obsolete and of=20
> no further interest. There was a patch v1, this has been reworked and=20
> now comes v2 which supersedes v1. Squashing is something I could do if=20
> I had 2 commits which should be joined together but here is probably=20
> not meant to squash the virtio_can.[ch] code file commit with the=20
> MAINTAINERS file commit.
>
> Could be that I misunderstood the way how is worked with patches on=20
> the mailing lists, don't know. I do absolutely not understand what you=20
> mean here.
>
> Regards
> Harald
>
> On 05.11.22 11:14, Vincent Mailhol wrote:
>> On Sat. 5 Nov. 2022 at 02:29, Harald Mommer
>> <Harald.Mommer@opensynergy.com> wrote:
>>> From: Harald Mommer <harald.mommer@opensynergy.com>
>>>
>>> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
>>> ---
>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++++
>>> =C2=A0 drivers/net/can/virtio_can.c | 6 ++----
>>> =C2=A0 2 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 379945f82a64..01b2738b7c16 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -21692,6 +21692,13 @@ F:=C2=A0=C2=A0=C2=A0=C2=A0 drivers/vhost/scsi.=
c
>>> =C2=A0 F:=C2=A0=C2=A0=C2=A0=C2=A0 include/uapi/linux/virtio_blk.h
>>> =C2=A0 F:=C2=A0=C2=A0=C2=A0=C2=A0 include/uapi/linux/virtio_scsi.h
>>>
>>> +VIRTIO CAN DRIVER
>>> +M:=C2=A0=C2=A0=C2=A0=C2=A0 "Harald Mommer" <harald.mommer@opensynergy.=
com>
>>> +L:=C2=A0=C2=A0=C2=A0=C2=A0 linux-can@vger.kernel.org
>>> +S:=C2=A0=C2=A0=C2=A0=C2=A0 Maintained
>>> +F:=C2=A0=C2=A0=C2=A0=C2=A0 drivers/net/can/virtio_can.c
>>> +F:=C2=A0=C2=A0=C2=A0=C2=A0 include/uapi/linux/virtio_can.h
>>> +
>>> =C2=A0 VIRTIO CONSOLE DRIVER
>>> =C2=A0 M:=C2=A0=C2=A0=C2=A0=C2=A0 Amit Shah <amit@kernel.org>
>>> =C2=A0 L:=C2=A0=C2=A0=C2=A0=C2=A0 virtualization@lists.linux-foundation=
.org
>>> diff --git a/drivers/net/can/virtio_can.c=20
>>> b/drivers/net/can/virtio_can.c
>>> index 43cf1c9e4afd..0e87172bbddf 100644
>>> --- a/drivers/net/can/virtio_can.c
>>> +++ b/drivers/net/can/virtio_can.c
>>> @@ -1,7 +1,7 @@
>>> -// SPDX-License-Identifier: GPL-2.0+
>>> +// SPDX-License-Identifier: GPL-2.0-only
>> Please squash this in the previous patch.
>>
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * CAN bus driver for the Virtio CAN controller
>>> - * Copyright (C) 2021 OpenSynergy GmbH
>>> + * Copyright (C) 2021-2022 OpenSynergy GmbH
>> Same.
>>
>>> =C2=A0=C2=A0 */
>>>
>>> =C2=A0 #include <linux/atomic.h>
>>> @@ -793,8 +793,6 @@ static void virtio_can_populate_vqs(struct=20
>>> virtio_device *vdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int idx;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // TODO: Think again a moment if =
here locks already may be=20
>>> needed!
>> Same.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fill RX queue */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq =3D priv->vqs[VIRTI=
O_CAN_QUEUE_RX];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (idx =3D 0u; idx <=
 ARRAY_SIZE(priv->rpkt); idx++) {
>>> --=20
>>> 2.17.1
>>>
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

