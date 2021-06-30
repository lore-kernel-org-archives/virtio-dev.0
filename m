Return-Path: <virtio-dev-return-8211-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B59B59861E4
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 Jun 2021 15:55:10 +0000 (UTC)
References: <20210630115837.12182-1-info@metux.net>
 <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
Date: Wed, 30 Jun 2021 17:55:07 +0200
MIME-Version: 1.0
In-Reply-To: <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 30.06.21 17:22, Viresh Kumar wrote:
> + All the people from previous version (Please cc them yourself while sen=
ding a
> new version, these are the people interested in this stuff).

Phuh, it's hard to track them all. I'm assuming everybody interested in
this is already on the list or can easily subscribe :p

> What happened to all the detailed discussions that we went through ? Why =
did we
> spend so much time discussing all that when you didn't had to take sugges=
tions
> from the reviews provided on the list?

Which ones are missing, besides those that we talked about doing as
optional feature (like irq controller, etc). Please let's do that in
separate rounds - the minimal base spec first, and then add optional
features.

> I don't see the improvements suggested for the config structure, nothing =
about
> features, no interrupt support. You just reformatted the stuff and that's=
 all.

Don't worry, I haven't forgotten that. But that's something I'd *really*
like to have as optional features (so not all hardware is mandated to
implement that all) and i'd like to get the mandatory base finished,
before specifying the optional features like interrupt controller.

Let's discuss the optional features separately, feel free to share your
thoughts here.


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

