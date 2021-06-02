Return-Path: virtio-dev-return-8177-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C85298652B
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Jun 2021 13:48:30 +0000 (UTC)
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
 <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net>
 <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <40119ebe-04c5-ce46-e015-6e69086f2186@metux.net>
Date: Wed, 2 Jun 2021 15:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 18.05.21 23:56, Hao Chen wrote:
> In our use case, we treat vehicle as a virtual device. For example, we
> send values to it to control the HVAC, and we receive values like car
> speed from the vehicle. We are not using virtio-can because 1. the
> vehicle bus does not have to be CAN and 2. we are doing something
> which more than just a pipe to the car bus (e.g., power management).

If its just reading / setting some kind of "variables" via some path
name, why not using 9P for that ?


--mtx

--=20
---
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schl=C3=BCssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

