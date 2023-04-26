Return-Path: <virtio-dev-return-12427-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C229C77B60
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 06:29:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 354F82B07A
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 06:29:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14FF5986642
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 06:29:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F25E9983FE8; Wed, 26 Apr 2023 06:29:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E08569865E2
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 06:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682490558; x=1685082558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEyidOYTm0tAGmfLD76JbklJv66kQ4aUW5y+yyY3tHY=;
        b=aXZuh9a2G/Iblh3fZbHGyicuBMIMkbAwVqkZirTqYZh7eUpfErdQBTFvYbBCVzPaNf
         kDgDsyLFfNWzp0p3pRSXB4eyGADLr4jh7mEa1/w6NTP5djVxx5gAe2Zy6vhk5Xgb4ZhN
         oG2WYOY0fcoAJgYtt3OC7058+sT49nO7jgzhXo0wtSodvu9TMxuq+LqWFBLMzIBb1wmS
         sueeA4ZIJRdsHCMmXRHmfZeVPRubiwg4H1k9Z0+ZoFVd0xvfoCHpPo4Y2eRrKrn/YQ5K
         bWJG77DEsjQPUNpYQqTXydz930aMDe1TQDx0GV7ZbgQKoxQi2Voq+8jFGpCAo/gdPUaP
         VM3A==
X-Gm-Message-State: AAQBX9eu8d04fx2lUOUv5hp3IEwnrJMuawH9dAA3HDy+iRGoLeErT6GV
	iE9UEUuiNyefIoxMdZ8oMUJ4Sm2BR4BevlfRFMo=
X-Google-Smtp-Source: AKy350YpyE95lljoig2/iiB0CBnCtrtUBrLHu6pOG+SyKYT2csJf+gUXX2tDx0gR/rf8h9C+5NSH3Q==
X-Received: by 2002:a92:ce84:0:b0:329:646c:1d72 with SMTP id r4-20020a92ce84000000b00329646c1d72mr8354522ilo.25.1682490558344;
        Tue, 25 Apr 2023 23:29:18 -0700 (PDT)
X-Received: by 2002:a05:6e02:20e2:b0:329:333e:4e79 with SMTP id
 q2-20020a056e0220e200b00329333e4e79mr127926ilv.1.1682490555529; Tue, 25 Apr
 2023 23:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com> <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <87354okkx5.fsf@redhat.com>
In-Reply-To: <87354okkx5.fsf@redhat.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Wed, 26 Apr 2023 15:29:03 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXC_xXRVUdAikN+uNvxo3Ms7kQcrEr8ZP29Zm4ZELRGTA@mail.gmail.com>
Message-ID: <CAPBb6MXC_xXRVUdAikN+uNvxo3Ms7kQcrEr8ZP29Zm4ZELRGTA@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Gordeev <alexander.gordeev@opensynergy.com>, virtio-dev@lists.oasis-open.org, 
	Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Enric Balletbo i Serra <eballetb@redhat.com>, Albert Esteve <aesteve@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Wed, Apr 26, 2023 at 1:04=E2=80=AFAM Cornelia Huck <cohuck@redhat.com> w=
rote:
>
>
> [I'm replying here, as that seems to be the last message in the thread,
> and my reply hopefully catches everyone interested here.]
>
> To do a very high level summary, we have (at least) two use cases for
> virtio-video, that unfortunately have quite different requirements. Both
> want to encode/decode video, but in different environments.
>
> - The "restricted" case: Priority is on security, and the attack surface
>   should be kept as small as possible, for example, by avoiding unneded
>   complexity in the interface. Fancy allocations and management should
>   be avoided. The required functionality is also quite clearly defined.
> - The "feature-rich" case: Priority is on enabling features, and being
>   able to re-use existing V4L2 support is considered a big plus. Both
>   device and driver implementations will be implemented in a full OS
>   environment, so all kind of helpers are already available.

I should highlight that virtio-v4l2 does not require any more allocations o=
r
management that virtio-video does. It's just a different way to pass the sa=
me
messages between guest and host.

>
> (This is not to say that one case does not care about functionality or
> security; it's mostly a case of different priorities and environments.)
>
> I had been hoping that it would be possible to find kind of a common
> ground between the two cases, but reading the thread, I'm not quite as
> hopeful anymore... if we really don't manage to find an approach to make
> the different requirements co-exist, a separate virtio-v4l2 device might
> be the way to go -- but I've not totally given up hope yet.
>
> Some remarks from my side:
>
> - I'm not totally convinced that counting words is always a good proxy
>   for complexity -- an interface might be simple on paper, but if the
>   actual implementation would need to be quite involved to get it right,
>   we'd again have a lot of opportunity for mistakes.
> - How much of v4l2 does actually need to be in the device specification
>   for a driver to make potentially good use of it? Sure, being able to
>   directly map to v4l2 really gives a huge benefit, but is there a way
>   to extract a subset that's not too complex, but can be easily wrapped
>   for interfacing with v4l2? (Both interface and functionality wise.)
>   Even if that means that a driver would need to implement some kind of
>   shim, a layer that easily maps to v4l2 concepts would still be much
>   easier to implement than one that needs to map two quite different
>   interfaces. [I'm really relying on the good judgement of people
>   familiar with the interfaces here :)]

The current prototype is eschewing some legacy V4L2 features, so we are alr=
eady
in that spirit. Even with a V4L2 guest there will be some light shimming.

One extra step we could maybe take, if we are worried about having the whol=
e
V4L2 API, is assign a virtio device ID to each kind of device (decoder,
encoder, camera, ...) and explicitly list which calls and features from V4L=
2
are allowed for this kind of device - anything else is invalid and must be
rejected by the host.

This would result in more spec and less flexibility as nobody could e.g. wr=
ite
a camera device before we specify what a camera device can do.

But it would also unambiguously define the allowed functionality and set ha=
rd
boundaries as to what can be done, which may be one of Alexander's concerns=
. As
a bonus it will also spare the guest from having to detect what kind of vid=
eo
device it is dealing with as the device ID will carry that information.

I don't think it is absolutely necessary, as this is already defined in the
V4L2 docs, and the host is under no obligation to support every V4L2 syscal=
l -
it can just reject those it doesn't like, as many drivers do. But it could =
be a
way to mitigate concerns about the attack surface.

> - To which extent does security need to be baked into the device
>   specification? We should avoid footguns, and avoiding needless
>   complication is also a good idea, but while every new functionality
>   means more attack surface, it also enables more use cases. That
>   tension is hard to resolve; how much of it can we alleviate by making
>   things optional?
>
> I hope I have not muddied the waters here, but I'd really like to see an
> agreement on how to continue (with two different devices, if there is
> really no other way.)

That would be an ironic way to end up with more work when we expected to ha=
ve
less, but ultimately it's your call. :)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

