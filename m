Return-Path: <virtio-dev-return-14054-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5136C4332F
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Nov 2023 08:24:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA6022168F
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Nov 2023 08:24:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0B9E986D02
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Nov 2023 08:24:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A8820986CFA; Fri, 10 Nov 2023 08:24:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 939E3986CFB
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Nov 2023 08:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699604636; x=1700209436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FfMPDMojOW98lWRGbi3Y0gvscQ84thvM99O+jTf37U=;
        b=HnVlEXr6xn6S8Scx5VJ+Gu939WIutVAAlvuns3P7lgad2w1VOYWtMjF2zrHtaJcU5A
         5DhDx4q+p1UDsVQJOysAaAEuq8EmkZzfO0I6g7OwzEc8gWunUV5DsJPyErUmCkoWeamp
         XKKqj0s7aZe8NoAgcOkvCbdvaA9JUIBk1IYMjE3aDNi14VLP/AkXSIkUOzs2sIUppWCB
         OXyzHkmivqDpX0LzL3R0X/4hIiIkDKnKQo/bkQ8rXHEJLMNWieLvrEJxg2260+SQHPTG
         lr8bnuhOXekJ55vV7Z5QmmpN5RT8MVe5eQETeb33JVj+L3fnxO27bcm3Oc44kOO5GT7T
         CNVw==
X-Gm-Message-State: AOJu0Yy9G/ZPAsexmTsuesn985+R3/BAABJwOU7i+cOMeWXuYfwr0Fiw
	3zRq6sFbBLw9Oyjxy/jk54v4P53FivXQrsOJygSijerY24NAl2u0CTY=
X-Google-Smtp-Source: AGHT+IFMethhvVw8bSiASuVhFoXgFHYU4XB4B9nPAB3EKH/twdsHkF3qlt3rVQRop1XnJQH6A6inxJZVVKQNES8ARhc=
X-Received: by 2002:a50:ab5b:0:b0:540:ee1e:c3f with SMTP id
 t27-20020a50ab5b000000b00540ee1e0c3fmr6808086edc.28.1699603074203; Thu, 09
 Nov 2023 23:57:54 -0800 (PST)
MIME-Version: 1.0
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
 <ZTeZ6YjyR0BJOylw@fedora> <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>
 <CAHYGQ0yXPY2NU25N3jh=MH7=PUjkWy5R-SmtaMOVP-VCPPuq3w@mail.gmail.com> <37eaf0dc2bdb4a7b936618b48dd00ac2@blackberry.com>
In-Reply-To: <37eaf0dc2bdb4a7b936618b48dd00ac2@blackberry.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 10 Nov 2023 09:57:38 +0200
Message-ID: <CAAjaMXYaNmKuGjTzO+fiAYveBXaVNonNnaUmoBH46b41U94YKQ@mail.gmail.com>
To: Radu Ocica <rocica@blackberry.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
	"anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] virtio-snd comments/questions

On Thu, 9 Nov 2023 at 18:46, Radu Ocica <rocica@blackberry.com> wrote:
> >> This looks promising. I found it already at https://urldefense.com/v3/=
__https://github.com/torvalds/linux/blob/master/sound/virtio/__;!!JoeW-IhCU=
kS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0tsYyEr9pXjSEu7n5ibc5BL4fKT3U=
tk-cpGw6FiWxDY$  and will give it a try. Is there a repository for this dri=
ver code where both this fix and the audio control support is available?

The patch will most likely be part of the next kernel release, 6.7. As
for the control support, read on:

> > What do you mean with audio control support? Are you talking about the
> > device? The device implementation is at
> https://urldefense.com/v3/__https://github.com/rust-vmm/vhost-device/tree=
/main/staging__;!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0t=
sYyEr9pXjSEu7n5ibc5BL4fKT3Utk-cpGw1sNq6IY$ .
>
> I meant the support for feature VIRTIO_SND_F_CTLS in the virtio_snd guest=
 driver. A patch to add this support is available here: https://lists.oasis=
-open.org/archives/virtio-comment/202104/msg00013.html. However this patch =
is not present in the virtio_snd guest driver version here: https://urldefe=
nse.com/v3/__https://github.com/torvalds/linux/blob/master/sound/virtio/__;=
!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0tsYyEr9pXjSEu7n5i=
bc5BL4fKT3Utk-cpGw6FiWxDY$ . I was wondering whether there is a repository =
where the virtio_snd driver has both the VIRTIO_SND_F_CTLS support and the =
ack callback patch.


The feature is part of the 1.3 version of the VIRTIO spec which is
still in a Committee Specification Draft phase. You can find that the
latest version of the VIRTIO spec is 1.2 here:
https://www.oasis-open.org/committees/tc_home.php

I believe it will take some time for both 1.3 to be approved and
afterwards patches for the kernel must be published and reviewed,
which will take some cycles as well. So I'd suggest you not to count
on control capabilities at the moment, unfortunately.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

