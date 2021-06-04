Return-Path: virtio-dev-return-8181-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52B0B986575
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Jun 2021 10:51:00 +0000 (UTC)
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
 <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net>
 <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
 <40119ebe-04c5-ce46-e015-6e69086f2186@metux.net>
 <CABATKF-t-xfj0cTa6zsnKJwLbXUCLaSZOqUWXDEOfKpR3KCPgw@mail.gmail.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <ea3a5d06-d18b-ba44-f6e9-224eaebfdf95@metux.net>
Date: Fri, 4 Jun 2021 12:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <CABATKF-t-xfj0cTa6zsnKJwLbXUCLaSZOqUWXDEOfKpR3KCPgw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: Hao Chen <chenhaosjtuacm@google.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.06.21 22:09, Hao Chen wrote:

> We can use any protocol to implement this, and publish it somewhere, but =
it
> does not carry the same weight as putting it in the virtio spec. It is
> easier to say
> "we use virtio, and for this device we use virtio-xxx device", but it
> would be weird to
> say "we use virtio, but for this device, we use vsock+some other non-stan=
dard
> protocol, please support this or you will break the compatibility".

Why not directly putting 9P links into virtio devices ?

In both cases we still have the problem knowing the actual meaning of
the individual parameters. Not so different from some raw IO space
(just a bit easier to parse).

I believe we need some layer above for describing the actual meanings.


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

