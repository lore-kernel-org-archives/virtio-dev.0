Return-Path: virtio-dev-return-8187-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 418D798663D
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Jun 2021 16:06:34 +0000 (UTC)
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
 <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net>
 <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
 <40119ebe-04c5-ce46-e015-6e69086f2186@metux.net>
 <CABATKF-t-xfj0cTa6zsnKJwLbXUCLaSZOqUWXDEOfKpR3KCPgw@mail.gmail.com>
 <ea3a5d06-d18b-ba44-f6e9-224eaebfdf95@metux.net>
 <CABATKF-G5NOAhh4EQqjOSRCS=PjjNpN+dKa7ezXTJaUyoJwNcg@mail.gmail.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <70ada7a8-7a9c-6d5f-a881-e436bd30cb9b@metux.net>
Date: Thu, 10 Jun 2021 18:06:22 +0200
MIME-Version: 1.0
In-Reply-To: <CABATKF-G5NOAhh4EQqjOSRCS=PjjNpN+dKa7ezXTJaUyoJwNcg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 09.06.21 22:30, Hao Chen wrote:
>  > Why not directly putting 9P links into virtio devices ?
>=20
> We have thought about using files to represent properties, but it turns=
=20
> out we may need to subscribe to a large amount of
> properties, so opening all of those files and polling is not ideal. Also=
=20
> the cross-property time-order matters in our case, so we abandoned this=
=20
> idea.

On 9P it would just be issuing one Tread per file you're intersted in
(of course, after Rread comes in, you'll have to send it again, if you
wanna continue to read).

How is that so different from subscriptions ?

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

