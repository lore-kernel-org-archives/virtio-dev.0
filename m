Return-Path: <virtio-dev-return-12663-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26470C77B7F
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 04:15:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 470802CACF
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 04:15:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C31B9866E5
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 04:15:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1744E983D9A; Fri, 12 May 2023 04:15:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04F2C9866D9
	for <virtio-dev@lists.oasis-open.org>; Fri, 12 May 2023 04:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683864948; x=1686456948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIFp5opqkV8VC36TF5DaKfMSkyXkjOULQqsNDGgztoM=;
        b=MN+OA3oZRi1yE6jb4n/vUkQ7qK9W+iNIgdp7Nq6qlV6m0NDUPlatHlUF3NTM//1Ws4
         i/FFboHJ44RqtqwYKZeZ3+TZmb6kF4YJcqBbl7TJyLI6SENWGyFBgYfgCAOvan/ZbH6C
         IjUgWzmdaYYtWrSu/JHw9UETBT+E/N2djC8UA0p1wY/nI08aRQcGwoORKhKe6qiUzXKL
         aHGMC9xTWDbIgqHA3ij45jCRnVsJEewRVdTHtlSDtmeauNgTpkAe9QILXIvCyblFX7s0
         1bfLvDZ7uwnBZAwG3Js4u5upcdy7Hh0O1WGk+l2fp06rAh6HVgn9HfP7YrQ6/279gA9j
         /9nQ==
X-Gm-Message-State: AC+VfDwZRHAdc3qb8vbkCQ5PpFln4jVkhYGIOUFFjxFQoGyhYlBwXa++
	ph2VtxDPDkHOwMEY/M+gkfikxuEZoy3D2Qyozec=
X-Google-Smtp-Source: ACHHUZ6A4fKxAf/w3Ge/RVP44KKdEhs8stdLKOUlAR+mX4DRa0LHoVMWqRM0g4l/TF8tskggfa69WQ==
X-Received: by 2002:a05:622a:14c9:b0:3f3:99fc:5598 with SMTP id u9-20020a05622a14c900b003f399fc5598mr20242323qtx.14.1683864948487;
        Thu, 11 May 2023 21:15:48 -0700 (PDT)
X-Received: by 2002:a05:622a:11cd:b0:3ef:19fe:230d with SMTP id
 n13-20020a05622a11cd00b003ef19fe230dmr126847qtk.17.1683864946260; Thu, 11 May
 2023 21:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com> <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com> <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com> <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com> <624c1712-9a6e-bb10-97ef-71a545534da9@opensynergy.com>
In-Reply-To: <624c1712-9a6e-bb10-97ef-71a545534da9@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 12 May 2023 13:15:34 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXw5PebCXYBvXOP_b2j+t-1Y_rSJv7kWkLPsa3X+uM9gA@mail.gmail.com>
Message-ID: <CAPBb6MXw5PebCXYBvXOP_b2j+t-1Y_rSJv7kWkLPsa3X+uM9gA@mail.gmail.com>
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

On Thu, May 11, 2023 at 6:00=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 11.05.23 10:50, Alexander Gordeev wrote:
> > On 08.05.23 06:55, Alexandre Courbot wrote:
> >> On Fri, May 5, 2023 at 8:55=E2=80=AFPM Alexander Gordeev
> >> <alexander.gordeev@opensynergy.com> wrote:
> >>>
> >>> On 03.05.23 16:04, Cornelia Huck wrote:
> >>>> On Fri, Apr 28 2023, Alexander Gordeev
> >>>> <alexander.gordeev@opensynergy.com> wrote:
> >>>>
> >>>>> On 27.04.23 15:16, Alexandre Courbot wrote:
> >>>>>> But in any case, that's irrelevant to the guest-host interface, an=
d I
> >>>>>> think a big part of the disagreement stems from the misconception
> >>>>>> that
> >>>>>> V4L2 absolutely needs to be used on either the guest or the host,
> >>>>>> which is absolutely not the case.
> >>>>>
> >>>>> I understand this, of course. I'm arguing, that it is harder to
> >>>>> implement it, get it straight and then maintain it over years. Also=
 it
> >>>>> brings limitations, that sometimes can be workarounded in the virti=
o
> >>>>> spec, but this always comes at a cost of decreased readability and
> >>>>> increased complexity. Overall it looks clearly as a downgrade compa=
red
> >>>>> to virtio-video for our use-case. And I believe it would be the
> >>>>> same for
> >>>>> every developer, that has to actually implement the spec, not just =
do
> >>>>> the pass through. So if we think of V4L2 UAPI pass through as a
> >>>>> compatibility device (which I believe it is), then it is fine to ha=
ve
> >>>>> both and keep improving the virtio-video, including taking the best
> >>>>> ideas from the V4L2 and overall using it as a reference to make
> >>>>> writing
> >>>>> the driver simpler.
> >>>>
> >>>> Let me jump in here and ask another question:
> >>>>
> >>>> Imagine that, some years in the future, somebody wants to add a virt=
io
> >>>> device for handling video encoding/decoding to their hypervisor.
> >>>>
> >>>> Option 1: There are different devices to chose from. How is the pers=
on
> >>>> implementing this supposed to pick a device? They might have a narro=
w
> >>>> use case, where it is clear which of the devices is the one that
> >>>> needs to
> >>>> be supported; but they also might have multiple, diverse use cases, =
and
> >>>> end up needing to implement all of the devices.
> >>>
> >>> I think in this case virtio-v4l2 should be used as a compatibility
> >>> device exclusively. This means discouraging increasing its complexity
> >>> even more with more patches in the spec. virtio-video should eventual=
ly
> >>> cover all the use-cases of V4L2, so I think it is reasonable to use i=
t
> >>> in both complex use-cases and in simple use-cases, where there is no
> >>> decoder/encoder V4L2 device on the host.
> >>>
> >>>> Option 2: There is one device with various optional features. The
> >>>> person
> >>>> implementing this can start off with a certain subset of features
> >>>> depending on their expected use cases, and add to it later, if neede=
d;
> >>>> but the upfront complexity might be too high for specialized use cas=
es.
> >>
> >> I don't see that many negociable features we can provide for a
> >> decoder/encoder device - at least not many that are not considered
> >> basic (like guest buffers). In terms of provided features for codecs
> >> virtio-video and virtio-v4l2 are essentially equivalent.
> >
> > Actually I see a lot of potential in using the virtio feature flag
> > negotiation for virtio-video:
> >
> > 1. We already have some feature flags related to memory management.
> >
> > 2. I think it would be great to take V4L2 controls negotiation and turn
> > it into the feature flags negotiation. I really like this idea and I'd
> > like to implement it. Not all the controls at once, of course. Still it
> > would be very easy to port more given the existing process. They
> > correspond well enough to each other, I think. This way we don't need t=
o
> > introduce something like the VIDIOC_QUERYCTRL/VIDIOC_QUERY_EXT_CTRL, we
> > don't need two mechanisms for feature negotiations (like it would be
> > with virtio-v4l2, right?), also all the features would be in one place.
> > Then we can directly reference some enums from V4L2, like
> > v4l2_mpeg_video_h264_profile or v4l2_mpeg_video_h264_level. That's what
> > I call taking the best from V4L2.
> >
> > 3. We can have things, that V4L2 doesn't support in their stateful UAPI=
.
> > For example, dequeuing output buffers in decoder order.
>
> I'd like to also share my current roadmap for the draft v7 of
> virtio-video (or maybe the draft v8 in some cases). The significant
> changes would be:
>
> 1. Making querying the capabilities fully compatible with V4L2 but in 1
> round-trip over virtio, not 10+. This is what I'm actively working on
> right now.

That sounds good, while not essential since the capability negotiation
occurs before we start streaming so these extra trips should not be
perceptible by the user. But the current capability command was not
suitable and needs to be improved anyway.

> 2. Making all the commands non-blocking by providing completion events
> over the event queue.

+1 on that too, as the experience with virtio-v4l2 suggests this
eliminates some headaches down the line.

> 3. Adding back the controls from v5 and adding the corresponding feature
> flags as I wrote in the quote above.

Beware of not repeating the same mistake as v5 (all controls under one
big structure). If you mean extending the parameters mechanisms with
the things that are missing from v5, then yes that should be done
anyway.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

