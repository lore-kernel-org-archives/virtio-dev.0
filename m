Return-Path: virtio-dev-return-8170-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D7C398614E
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 May 2021 21:56:59 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain> <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net>
In-Reply-To: <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Tue, 18 May 2021 14:56:46 -0700
Message-ID: <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device specification
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

In our use case, we treat vehicle as a virtual device. For example, we
send values to it to control the HVAC, and we receive values like car
speed from the vehicle. We are not using virtio-can because 1. the
vehicle bus does not have to be CAN and 2. we are doing something
which more than just a pipe to the car bus (e.g., power management).

Hao

On Mon, May 17, 2021 at 11:02 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 17.05.21 21:28, Hao Chen wrote:
> > The reason for defining a virtio-parameter-server device is we are inte=
racting
> > with some devices in a "key-value store" pattern. For example, we inter=
act with
> > "vehicle device" in Android using this pattern.
>
> What kind of devices are these ?
>
>
> --mtx
> --
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

