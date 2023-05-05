Return-Path: <virtio-dev-return-12593-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FFC77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:11:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2AC1D370E8
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:11:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 105E99866CB
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:11:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE6589866C4; Fri,  5 May 2023 16:11:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC79F9866C5
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 16:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683303110; x=1685895110;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTfhzAVWKaXokrhvCpcbRfNUPp73K3VFBBQt45y7FTE=;
        b=R+vfxVqmBzTm9WGC+ubkCTm0nU31Lm1VzjF/Yf7x1vfmuxVFwEn6/u2qLzoJB0QxxJ
         BDAlSPNtcRRPV+EOYsmHjdxaNpavsmlS8Aav7QdXGGayp6cMGxHDf/T0UTY9Y24lowWe
         9JC6Mf9E/tW2KrnCzJAlaWqS/hUTaM6u25+Y7bpnYuEqbTGk37Ae1hU0I2p9QBCX3gGP
         TFAnH4BN/MuH8HWwEBtJlDe/4LiUzVWcKC1x9zs0XB3c+h3zY/95R6w9u6tlUeCoNGHT
         HmzZ3Kvn+1yvDQHhaDdKSTbl5o0/L5QBcyyhmyw3FWu7DqTtYBEs1+0WOXNwlu3sQCbY
         kbIw==
X-Gm-Message-State: AC+VfDyTHh69R6cWb/W7JjjyVX5c42KlFSZNuhU93rpBq3JgeArcZ+WO
	UGSRB4z5CjeuyMYTjbpnbjnq/g==
X-Google-Smtp-Source: ACHHUZ4DkCvYUkMeUYMZ0MuuRAlHx668wJdtAKqubMQ8aX/Q6e1JGDPPfb9DyiRDwtbU4U7AhjF2HQ==
X-Received: by 2002:a5d:5191:0:b0:306:2a21:b5ff with SMTP id k17-20020a5d5191000000b003062a21b5ffmr1420781wrv.17.1683303109675;
        Fri, 05 May 2023 09:11:49 -0700 (PDT)
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
 <87a5ylzf34.fsf@redhat.com> <87354dtp30.fsf@linaro.org>
 <87bkj1h0nf.fsf@redhat.com>
 <a3607ef3-ffd9-345b-0191-5bc946f4be19@opensynergy.com>
 <168329085253.1880445.14002473591422425775@Monstersaurus>
User-agent: mu4e 1.11.4; emacs 29.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Cornelia Huck
 <cohuck@redhat.com>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>,
 Marcin Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?=
 <Matti.Moell@opensynergy.com>, Andrew Gazizov
 <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin
 <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?= Grzesik
 <bag@semihalf.com>, Tomasz
 Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, Albert Esteve
 <aesteve@redhat.com>, libcamera-devel@lists.libcamera.org
Date: Fri, 05 May 2023 16:55:33 +0100
In-reply-to: <168329085253.1880445.14002473591422425775@Monstersaurus>
Message-ID: <87v8h6dagr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification


Kieran Bingham <kieran.bingham@ideasonboard.com> writes:

> Hi All,
>
> Coming in late, thanks to lei/lore spotting the libcamera keyword.
>
> + Cc: libcamera-devel to raise awareness of the discussion there.
>
> Quoting Alexander Gordeev (2023-05-05 10:57:29)
>> On 03.05.23 17:53, Cornelia Huck wrote:
>> > On Wed, May 03 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> >
>> >> Cornelia Huck <cohuck@redhat.com> writes:
>> >>
>> >>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynerg=
y.com> wrote:
>> >>>
>> >>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>> >>>>> But in any case, that's irrelevant to the guest-host interface, an=
d I
>> >>>>> think a big part of the disagreement stems from the misconception =
that
>> >>>>> V4L2 absolutely needs to be used on either the guest or the host,
>> >>>>> which is absolutely not the case.
>> >>>>
>> >>>> I understand this, of course. I'm arguing, that it is harder to
>> >>>> implement it, get it straight and then maintain it over years. Also=
 it
>> >>>> brings limitations, that sometimes can be workarounded in the virtio
>> >>>> spec, but this always comes at a cost of decreased readability and
>> >>>> increased complexity. Overall it looks clearly as a downgrade compa=
red
>> >>>> to virtio-video for our use-case. And I believe it would be the sam=
e for
>> >>>> every developer, that has to actually implement the spec, not just =
do
>> >>>> the pass through. So if we think of V4L2 UAPI pass through as a
>> >>>> compatibility device (which I believe it is), then it is fine to ha=
ve
>> >>>> both and keep improving the virtio-video, including taking the best
>> >>>> ideas from the V4L2 and overall using it as a reference to make wri=
ting
>> >>>> the driver simpler.
>> >>>
>> >>> Let me jump in here and ask another question:
>> >>>
>> >>> Imagine that, some years in the future, somebody wants to add a virt=
io
>> >>> device for handling video encoding/decoding to their hypervisor.
>> >>>
>> >>> Option 1: There are different devices to chose from. How is the pers=
on
>> >>> implementing this supposed to pick a device? They might have a narrow
>> >>> use case, where it is clear which of the devices is the one that nee=
ds to
>> >>> be supported; but they also might have multiple, diverse use cases, =
and
>> >>> end up needing to implement all of the devices.
>> >>>
>> >>> Option 2: There is one device with various optional features. The pe=
rson
>> >>> implementing this can start off with a certain subset of features
>> >>> depending on their expected use cases, and add to it later, if neede=
d;
>> >>> but the upfront complexity might be too high for specialized use cas=
es.
>> >>>
>> >>> Leaving concrete references to V4L2 out of the picture, we're curren=
tly
>> >>> trying to decide whether our future will be more like Option 1 or Op=
tion
>> >>> 2, with their respective trade-offs.
>> >>>
>> >>> I'm slightly biased towards Option 2; does it look feasible at all, =
or
>> >>> am I missing something essential here? (I had the impression that so=
me
>> >>> previous confusion had been cleared up; apologies in advance if I'm
>> >>> misrepresenting things.)
>> >>>
>> >>> I'd really love to see some kind of consensus for 1.3, if at all
>> >>> possible :)
>> >>
>> >> I think feature discovery and extensibility is a key part of the Virt=
IO
>> >> paradigm which is why I find the virtio-v4l approach limiting. By
>> >> pegging the device to a Linux API we effectively limit the growth of =
the
>> >> device specification to as fast as the Linux API changes. I'm not ful=
ly
>> >> immersed in v4l but I don't think it is seeing any additional features
>> >> developed for it and its limitations for camera are one of the reasons
>> >> stuff is being pushed to userspace in solutions like libcamera:
>> >>
>> >>    How is libcamera different from V4L2?
>> >>
>> >>    We see libcamera as a continuation of V4L2. One that can more easi=
ly
>> >>    handle the recent advances in hardware design. As embedded cameras=
 have
>> >>    developed, all of the complexity has been pushed on to the develop=
ers.
>> >>    With libcamera, all of that complexity is simplified and a single =
model
>> >>    is presented to application developers.
>> >
>> > Ok, that is interesting; thanks for the information.
>> >
>> >>
>> >> That said its not totally our experience to have virtio devices act as
>> >> simple pipes for some higher level protocol. The virtio-gpu spec says
>> >> very little about the details of how 3D devices work and simply offers
>> >> an opaque pipe to push a (potentially propriety) command stream to the
>> >> back end. As far as I'm aware the proposals for Vulkan and Wayland
>> >> device support doesn't even offer a feature bit but simply changes the
>> >> graphics stream type in the command packets.
>> >>
>> >> We could just offer a VIRTIO_VIDEO_F_V4L feature bit, document it as
>> >> incompatible with other feature bits and make that the baseline
>> >> implementation but it's not really in the spirit of what VirtIO is
>> >> trying to achieve.
>> >
>> > I'd not be in favour of an incompatible feature flag,
>> > either... extensions are good, but conflicting features is something
>> > that I'd like to avoid.
>> >
>> > So, given that I'd still prefer to have a single device: How well does
>> > the proposed virtio-video device map to a Linux driver implementation
>> > that hooks into V4L2?
>>=20
>> IMO it hooks into V4L2 pretty well. And I'm going to spend next few
>> months making the existing driver fully V4L2 compliant. If this goal
>> requires changing the spec, than we still have time to do that. I don't
>> expect a lot of problems on this side. There might be problems with
>> Android using V4L2 in weird ways. Well, let's see. Anyway, I think all
>> of this can be accomplished over time.
>>=20
>> > If the general process flow is compatible and it
>> > is mostly a question of wiring the parts together, I think pushing that
>> > part of the complexity into the Linux driver is a reasonable
>> > trade-off. Being able to use an existing protocol is nice, but if that
>> > protocol is not perceived as flexible enough, it is probably not worth
>> > encoding it into a spec. (Similar considerations apply to hooking up t=
he
>> > device in the hypervisor.)
>>=20
>> I very much agree with these statements. I think this is how it should
>> be: we start with a compact but usable device, then add features and
>> enable them using feature flags. Eventually we can cover all the
>> use-cases of V4L2 unless we decide to have separate devices for them
>> (virtio-camera, etc). This would be better in the long term I think.
>
> Camera's definitely have their quirks - mostly because many usecases are
> hard to convey over a single Video device node (with the hardware) but I
> think we might expect that complexity to be managed by the host, and
> probably offer a ready made stream to the guest. Of course how to handle
> multiple streams and configuration of the whole pipeline may get more
> difficult and warrant a specific 'virtio-camera' ... but I would think
> the basics could be covered generically to start with.
>
> It's not clear who's driving this implementation and spec, so I guess
> there's more reading to do.
>
> Anyway, I've added Cc libcamera-devel to raise awareness of this topic
> to camera list.
>
> I bet Laurent has some stronger opinions on how he'd see camera's exist
> in a virtio space.

Personally I would rather see a separate virtio-camera specification
that properly encapsulates all the various use cases we have for
cameras. In many ways just processing a stream of video is a much
simpler use case.

During Linaro's Project Stratos we got a lot of feedback from members
who professed interest in a virtio-camera initiative. However we were
unable to get enough engineering resources from the various companies to
collaborate in developing a specification that would meet everyone's
needs. The problem space is wide from having numerous black and white
sensor cameras on cars to the full on computational photography as
exposed by modern camera systems on phones. If you want to read more
words on the topic I wrote a blog post at the time:

  https://www.linaro.org/blog/the-challenges-of-abstracting-virtio/

Back to the topic of virtio-video as I understand it the principle
features/configurations are:

  - All the various CODECs, resolutions and pixel formats
  - Stateful vs Stateless streams
  - If we want support grabbing single frames from a source

My main concern about the V4L approach is that it pegs updates to the
interface to the continuing evolution of the V4L interface in Linux. Now
maybe video is a solved problem and there won't be (m)any new features
we need to add after the initial revision. However I'm not a domain
expert here so I just don't know.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

