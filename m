Return-Path: <virtio-dev-return-8292-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 091509864BC
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Jul 2021 16:04:26 +0000 (UTC)
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
 <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
 <20210714031300-mutt-send-email-mst@kernel.org>
From: Harald Mommer <hmo@opensynergy.com>
Message-ID: <3da52df1-c639-94b7-a3d1-f7c03d422f41@opensynergy.com>
Date: Thu, 15 Jul 2021 18:04:15 +0200
In-Reply-To: <20210714031300-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] review of virtio-can (was: Re: MSG_CONFIRM RX
 messages with SocketCAN known as unreliable under heavy load?)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Am 14.07.21 um 09:15 schrieb Michael S. Tsirkin:
>
>> As mentioned before don't make this AUTOSAR specific.
> If the specs are more or less identical it might be worth it to link
> to AUTOSAR too just because it can be downloaded for free.
>
> --
> MST

The specs are not identical. But the specifications do not contradict,=20
we are talking about the same CAN. From this point of view inclusion=20
would be ok. But there was already a comment about the AUTOSAR=20
specifications highliting a problem. While the AUTOSAR spec is=20
downloadable for free it is not usable for free for all purposes. This=20
may be a problem or even a trap for people.

AUTOSAR CP R20-11 says on page 9 chapter "Disclaimer":

"This work (specification and/or software implementation) and the=20
material contained in it, as released by AUTOSAR, is for the purpose of=20
information only. ..."

"The material contained in this work is protected by copyright and other=20
types of intellectual property rights. The commercial exploitation of=20
the material contained in this work requires a license to such=20
intellectual property rights.
This work may be utilized or reproduced without any modification, in any=20
form or by any means, for informational purposes only. ..."

Cannot judge the exact impact of those sentences, I'm an engineer not a=20
lawyer. Not my field of expertise. Free downloadable seems not to mean=20
free usable so it may indeed be better to get rid of this reference=20
here. Poisoned? Don't know, looks so.

Regards
Harald

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

