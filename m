Return-Path: <virtio-dev-return-12460-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0E5C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:03:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A2FB41FF8B
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:02:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D32A98668C
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:02:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 60004983E91; Fri, 28 Apr 2023 04:02:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 442DC98667E
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 04:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682654577; x=1685246577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5Od82hoN9iFW6AOdHx5a3WJ9ciOQ2QRPOiUwNT6df4=;
        b=bcIE31wks0vU7A2Oqj7id6q2eFRRyMA8oLXoFBN81SClOcBuks+zZG1qjnvaHcQeKY
         uCr6rZBm+s/gEFb4UjkH7Wf3Bjp2NXOldifsC7o2qvqsScWrnR9ymYaW6arqiG7wZc34
         hE+Otz281TE3ceh1z8spWE6ChHXIQ40nd6udBJCauaW//t5LyMXoYUHhgZWuJeps2NNM
         Gll+fG7gijUC7k+R0dZiyGC1KJqJNLT9yopkSUPQH1YFlQ3/hlox8Y8eOa1UlQSWZ72u
         uB5shutn0duMr9Lez5td6qKqpMPgFvfFFQiBsHJxlrj6MV2JAyMfxXddtAuUNzz4fAD8
         4dPA==
X-Gm-Message-State: AC+VfDx3BL4QXG41+WXZrcMyzZ1nzxX6tNJ2+TKo+ewFhg6I1nPdmTUy
	AtLADvGI1iYNfQRztmene1HeA5BsCULoG0zLPgA=
X-Google-Smtp-Source: ACHHUZ7SiebuXH1cmXsDvSzTuylVG6M/TuC3yXu845o8S9mNV5+Nc64u62SoObMwZs5l9L0l4wInZg==
X-Received: by 2002:a05:6e02:78f:b0:32b:5dec:1476 with SMTP id q15-20020a056e02078f00b0032b5dec1476mr2855709ils.29.1682654577313;
        Thu, 27 Apr 2023 21:02:57 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a45:b0:32e:561d:b42d with SMTP id
 u5-20020a056e021a4500b0032e561db42dmr155770ilv.16.1682654575545; Thu, 27 Apr
 2023 21:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com> <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <87354okkx5.fsf@redhat.com> <c1658889-0a90-5681-6afb-7160cdf1bf77@opensynergy.com>
In-Reply-To: <c1658889-0a90-5681-6afb-7160cdf1bf77@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 28 Apr 2023 13:02:43 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXNUHJuq40-RQO-0aa6UU0R_ZOHvB48B_t_knpK4Uw0eQ@mail.gmail.com>
Message-ID: <CAPBb6MXNUHJuq40-RQO-0aa6UU0R_ZOHvB48B_t_knpK4Uw0eQ@mail.gmail.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, 
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

This is going to be my last answer to this thread ; I don't think I
have more technical arguments to give than I already have and the
discussion is drifting into territory I am not interested in engaging.
At the end of the day it's up to the virtio folks to make a decision
about what the best course of action is. If we end up with
fragmentation, so be it, it will still be better than the current
situation anyway.

On Thu, Apr 27, 2023 at 11:11=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 25.04.23 18:04, Cornelia Huck wrote:
> >
> > [I'm replying here, as that seems to be the last message in the thread,
> > and my reply hopefully catches everyone interested here.]
> >
> > To do a very high level summary, we have (at least) two use cases for
> > virtio-video, that unfortunately have quite different requirements. Bot=
h
> > want to encode/decode video, but in different environments.
> >
> > - The "restricted" case: Priority is on security, and the attack surfac=
e
> >    should be kept as small as possible, for example, by avoiding unnede=
d
> >    complexity in the interface. Fancy allocations and management should
> >    be avoided. The required functionality is also quite clearly defined=
.
> > - The "feature-rich" case: Priority is on enabling features, and being
> >    able to re-use existing V4L2 support is considered a big plus. Both
> >    device and driver implementations will be implemented in a full OS
> >    environment, so all kind of helpers are already available.
> >
> > (This is not to say that one case does not care about functionality or
> > security; it's mostly a case of different priorities and environments.)
>
> I'm thinking about the latter as more like a "compatibility" case, but
> the "feature-rich" is also a good name.
>
> > I had been hoping that it would be possible to find kind of a common
> > ground between the two cases, but reading the thread, I'm not quite as
> > hopeful anymore... if we really don't manage to find an approach to mak=
e
> > the different requirements co-exist, a separate virtio-v4l2 device migh=
t
> > be the way to go -- but I've not totally given up hope yet.
>
>  From our side I can say, that moving from the current state even to a
> well-defined subset of V4L2 would require a lot of work, bring literally
> zero advantages for our use-case, while bringing some disadvantages. I
> think we had a good progress so far, we don't want to give up the
> achievements and now this is a great opportunity to do even better
> because our priorities will not collide anymore.

In other words, virtio-v4l2 does not bring you any direct benefit and
switching would have a cost, acknowledged. But I don't think it's
reasonable to split the standard just for one project.

>
> On the other side I don't think Alexandre and his team are really
> interested in doing the extra work of clearly defining the subset of
> V4L2, writing larger specifications, going through all the hassle with
> making the guest pages sharing work (again) and supporting this case in
> their driver for us for something that is planned to be a very simple
> device and driver. Please correct me if I'm wrong here.

You are wrong and stop making things up about what our intent is.
Guest pages are a must-have for us, as I've already said. I also
proposed in a former email to do just what you said I wouldn't
(defining a valid subset of V4L2 for each device), and you ignored it.

>
> And even if they say they agree to do the work with us... I'm sorry, but
> you can probably see, that our communication doesn't go smooth. My
> emails are forgotten, our use-case is clearly not a priority for
> Alexandre, my arguments seem to be considered as obstacles. If we have a
> single device, we have to cooperate actively. I have a lot of doubts
> that it is possible at the moment. In this case I'd prefer to just make
> room for everybody. Maybe we'll cooperate in a fruitful way again later.
> The priorities or use-cases might change, for example. For us this is an
> opportunity to finally update the virtio-video driver against the latest
> state and hopefully make it V4L2 compliant.

It's pretty rich to constantly misrepresent my proposals and then
pretend communication does not go smoothly (implied, by my fault).

I won't engage any more in this discussion as I don't think your
position can be moved, and I have better things to do with my time
than constantly repeat what I said earlier. Do your thing, I'll do
mine, and at the end the virtio folks will decide what they want.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

