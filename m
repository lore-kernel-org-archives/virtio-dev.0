Return-Path: virtio-dev-return-8186-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F140986615
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jun 2021 20:31:02 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain> <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net> <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
 <40119ebe-04c5-ce46-e015-6e69086f2186@metux.net> <CABATKF-t-xfj0cTa6zsnKJwLbXUCLaSZOqUWXDEOfKpR3KCPgw@mail.gmail.com>
 <ea3a5d06-d18b-ba44-f6e9-224eaebfdf95@metux.net>
In-Reply-To: <ea3a5d06-d18b-ba44-f6e9-224eaebfdf95@metux.net>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Wed, 9 Jun 2021 13:30:48 -0700
Message-ID: <CABATKF-G5NOAhh4EQqjOSRCS=PjjNpN+dKa7ezXTJaUyoJwNcg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device specification
Content-Type: multipart/alternative; boundary="00000000000014219d05c45b27bd"
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000014219d05c45b27bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Why not directly putting 9P links into virtio devices ?

We have thought about using files to represent properties, but it turns out
we may need to subscribe to a large amount of
properties, so opening all of those files and polling is not ideal. Also
the cross-property time-order matters in our case, so we abandoned this
idea.

On Fri, Jun 4, 2021 at 3:50 AM Enrico Weigelt, metux IT consult <
lkml@metux.net> wrote:

> On 02.06.21 22:09, Hao Chen wrote:
>
> > We can use any protocol to implement this, and publish it somewhere, bu=
t
> it
> > does not carry the same weight as putting it in the virtio spec. It is
> > easier to say
> > "we use virtio, and for this device we use virtio-xxx device", but it
> > would be weird to
> > say "we use virtio, but for this device, we use vsock+some other
> non-standard
> > protocol, please support this or you will break the compatibility".
>
> Why not directly putting 9P links into virtio devices ?
>
> In both cases we still have the problem knowing the actual meaning of
> the individual parameters. Not so different from some raw IO space
> (just a bit easier to parse).
>
> I believe we need some layer above for describing the actual meanings.
>
>
> --mtx
>
> --
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287 <+49%201512%207565287>
>

--00000000000014219d05c45b27bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; Why not directly putting 9P links into virtio devices=
 ?<div><br></div><div>We have thought about using files to represent proper=
ties, but it turns out we may need to subscribe to a large amount of</div><=
div>properties, so opening all of those files and polling is not ideal. Als=
o the cross-property time-order matters in our case, so we abandoned this i=
dea.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Fri, Jun 4, 2021 at 3:50 AM Enrico Weigelt, metux IT consult &=
lt;<a href=3D"mailto:lkml@metux.net">lkml@metux.net</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On 02.06.21 22:09, Hao C=
hen wrote:<br>
<br>
&gt; We can use any protocol to implement this, and publish it somewhere, b=
ut it<br>
&gt; does not carry the same weight as putting it in the virtio spec. It is=
<br>
&gt; easier to say<br>
&gt; &quot;we use virtio, and for this device we use virtio-xxx device&quot=
;, but it<br>
&gt; would be weird to<br>
&gt; say &quot;we use virtio, but for this device, we use vsock+some other =
non-standard<br>
&gt; protocol, please support this or you will break the compatibility&quot=
;.<br>
<br>
Why not directly putting 9P links into virtio devices ?<br>
<br>
In both cases we still have the problem knowing the actual meaning of<br>
the individual parameters. Not so different from some raw IO space<br>
(just a bit easier to parse).<br>
<br>
I believe we need some layer above for describing the actual meanings.<br>
<br>
<br>
--mtx<br>
<br>
-- <br>
---<br>
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert<br>
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren<br=
>
GPG/PGP-Schl=C3=BCssel zu.<br>
---<br>
Enrico Weigelt, metux IT consult<br>
Free software and Linux embedded engineering<br>
<a href=3D"mailto:info@metux.net" target=3D"_blank">info@metux.net</a> -- <=
a href=3D"tel:+49%201512%207565287" value=3D"+4915127565287" target=3D"_bla=
nk">+49-151-27565287</a><br>
</blockquote></div>

--00000000000014219d05c45b27bd--

