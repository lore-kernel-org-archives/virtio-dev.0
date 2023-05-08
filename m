Return-Path: <virtio-dev-return-12610-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25C8C77B73
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 05:01:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C7D612B341
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 05:01:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD2D2986315
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 05:01:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 98A91983E8E; Mon,  8 May 2023 05:01:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 812BF986298
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 May 2023 05:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683522087; x=1686114087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXhaQO6hI4EbcURkNaGfGteer3sxmEWfEuO3IG3mWco=;
        b=YsH6pEoSsIqzNWU6/xa5JASzxWhUBC44ztwrrVX3BiWt6yft/w1RVsn1YsM4HGQqMA
         4f177XPVQawFZkBN8e2LXgcs0uUwLU45/+zjqNUeCGa07nNlSofJIecCZqVzQmTx8fdN
         a3OVpPVA5IgsNEVJC1OnIwJAbwH5sCElITp8aElQcr8tgCMqD4Zxg8Vvg+TRAJiCvDVc
         oJxddZJNVRdLq6GhZlBF5PpgvPinMRBxzHtN2eWRIGY/K6AyE31M+Uio00y7qfw9RLwQ
         irPZAjoyrYCYieGf0+O9nff9WA5xvDGzrBKRg1RalgTR/0vdDqCOTAe3mIlIiqmi7X0z
         p0Rw==
X-Gm-Message-State: AC+VfDyrNoo/At6DvWlJ0xrhwfciipIWQ3VyJAz29tmvDOeUcMs/bisH
	syIdJXJIjY1ClbeFazPZXVhxLdYnAfuaP4ZFH28=
X-Google-Smtp-Source: ACHHUZ6rJBz6UNcX/dp0zr0+xz7dhAFeRtbC6saLPnKrLHBWrZ9yovugVwAMyaOA0irIQiFgQ/5OKw==
X-Received: by 2002:a17:903:1208:b0:1a6:4606:6e06 with SMTP id l8-20020a170903120800b001a646066e06mr11085909plh.17.1683522087315;
        Sun, 07 May 2023 22:01:27 -0700 (PDT)
X-Received: by 2002:a92:cda6:0:b0:322:848b:6c53 with SMTP id
 g6-20020a92cda6000000b00322848b6c53mr429280ild.14.1683521716018; Sun, 07 May
 2023 21:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com> <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com> <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
In-Reply-To: <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Mon, 8 May 2023 13:55:04 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
Message-ID: <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
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

On Fri, May 5, 2023 at 8:55=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 03.05.23 16:04, Cornelia Huck wrote:
> > On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy.c=
om> wrote:
> >
> >> On 27.04.23 15:16, Alexandre Courbot wrote:
> >>> But in any case, that's irrelevant to the guest-host interface, and I
> >>> think a big part of the disagreement stems from the misconception tha=
t
> >>> V4L2 absolutely needs to be used on either the guest or the host,
> >>> which is absolutely not the case.
> >>
> >> I understand this, of course. I'm arguing, that it is harder to
> >> implement it, get it straight and then maintain it over years. Also it
> >> brings limitations, that sometimes can be workarounded in the virtio
> >> spec, but this always comes at a cost of decreased readability and
> >> increased complexity. Overall it looks clearly as a downgrade compared
> >> to virtio-video for our use-case. And I believe it would be the same f=
or
> >> every developer, that has to actually implement the spec, not just do
> >> the pass through. So if we think of V4L2 UAPI pass through as a
> >> compatibility device (which I believe it is), then it is fine to have
> >> both and keep improving the virtio-video, including taking the best
> >> ideas from the V4L2 and overall using it as a reference to make writin=
g
> >> the driver simpler.
> >
> > Let me jump in here and ask another question:
> >
> > Imagine that, some years in the future, somebody wants to add a virtio
> > device for handling video encoding/decoding to their hypervisor.
> >
> > Option 1: There are different devices to chose from. How is the person
> > implementing this supposed to pick a device? They might have a narrow
> > use case, where it is clear which of the devices is the one that needs =
to
> > be supported; but they also might have multiple, diverse use cases, and
> > end up needing to implement all of the devices.
>
> I think in this case virtio-v4l2 should be used as a compatibility
> device exclusively. This means discouraging increasing its complexity
> even more with more patches in the spec. virtio-video should eventually
> cover all the use-cases of V4L2, so I think it is reasonable to use it
> in both complex use-cases and in simple use-cases, where there is no
> decoder/encoder V4L2 device on the host.
>
> > Option 2: There is one device with various optional features. The perso=
n
> > implementing this can start off with a certain subset of features
> > depending on their expected use cases, and add to it later, if needed;
> > but the upfront complexity might be too high for specialized use cases.

I don't see that many negociable features we can provide for a
decoder/encoder device - at least not many that are not considered
basic (like guest buffers). In terms of provided features for codecs
virtio-video and virtio-v4l2 are essentially equivalent.

The question is more: do we want a decoder/encoder specification and
another one for cameras or do we want something that covers video
devices in general. And is it desirable to reuse an already existing
protocol for communication between a non-privileged entity and a
privileged one (V4L2) or define our own?

About the latter point, Alex Benn=C3=A9e mentioned that it was difficult to
find the engineering time to define virtio-camera. And virtio-video
has also not been particularly fast to come together. virtio-v4l2
basically serves us both on a plate for a lower effort.

>
> In this case I'd prefer to have the simpler device first, that is the
> current virtio-video, then to add features incrementally using feature
> flags and taking into account the virtualization context. V4L2 is a
> complex thing from a different context. They already tried to carve out
> some of the use-cases like stateful decoder/encoder API, but this work
> is not finished (struct v4l2_buffer can serve as an evidence). This is
> like dissecting a monolith. Also it has to be patched to make it more
> appropriate for virtualization (we can see this in Alexandre's PoC alread=
y).
>
> > Leaving concrete references to V4L2 out of the picture, we're currently
> > trying to decide whether our future will be more like Option 1 or Optio=
n
> > 2, with their respective trade-offs.
>
> I'd like to rely on opinions of people, who know more about virtio
> development and goals. I would be happy to present or reiterate my
> arguments to anyone interested if necessary.
>
> > I'm slightly biased towards Option 2; does it look feasible at all, or
> > am I missing something essential here? (I had the impression that some
> > previous confusion had been cleared up; apologies in advance if I'm
> > misrepresenting things.)
>
> Indeed some of the previous confusion has been cleared up. But not the
> key thing. Alexandre still claims, that this patched V4L2 UAPI pass
> through is only marginally more complex, for example. I don't agree with
> this and I have evidence. We haven't finished discussing this evidence.

Are you talking about v4l2_buffer?

https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/buffer.html#struct-v4l2=
-buffer

I think you implied that some of its fields were not relevant for
video decoding or encoding, which if you examine them is again
incorrect. That also answers your question of why the stateful decoder
spec did not mention the valid fields - because it is documented on
this page, which tells exactly which fields the driver/device are
expected to set for each queue.

Also I think I mentioned it before, but it would be really sweet if
you could stop mischaracterizing virtio-v4l2 as a "passthrough" since
it is very much not that, much like virgl and venus aren't either.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

