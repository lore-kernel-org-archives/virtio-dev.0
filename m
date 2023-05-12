Return-Path: <virtio-dev-return-12662-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4458DC77B75
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 04:09:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 584732B042
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 04:09:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4694E9866E3
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 04:09:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 32581983D9A; Fri, 12 May 2023 04:09:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B8A69866D9
	for <virtio-dev@lists.oasis-open.org>; Fri, 12 May 2023 04:09:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683864571; x=1686456571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1iUX5ABOLrFSy3+Jbwgs3u+c+5Ndy9PG2jn+Xl2Bck=;
        b=GrROPzLgtvw9I4eeqPeIRSLzlnVAsIrWzPk+5KqQOoEhDJOUnWETFLrXFTe3bwAZcG
         9gRdODlDmoTvzlB72M4TP3jGDFXGUFy+cqN//SZH0Tqjn0b978qDf4NBFZ9EHMx/5DIq
         F7s560+njS6fDA6CxZr430cHxckyWEmvLDYHZGS41s8CsTLrt1I61TKd2m/6WCwB4TtX
         DivwqxcZgwjCXL+s9zuiZtTPon5EJsbFNHRXacKdkBqNHlOALDqaKdu6bq+NUNlF8qZe
         lMEkcKBdfr8FkSyrrsqX6LSNiY1iDeOGwW8gomYIg0AxhW1xfr+yZmUu4sBxudCwnJmg
         +LbQ==
X-Gm-Message-State: AC+VfDwLSiDrn7U3yfXWCYBWLQtLfv0D9g3HJtPRrTqJ8DjOAXFhQmWA
	yDsqlZbeY3cTenrD8D4uQ6lFNRdDNXp1PfdbACA=
X-Google-Smtp-Source: ACHHUZ7MTbvdrK8hxHEx+cF9VkO/YAjxc5m34NTfe/0YCPHvEdnb5WDzHyDUtPuXcbYAfcXJWtHDzw==
X-Received: by 2002:a05:622a:40c:b0:3ef:64d9:f0b3 with SMTP id n12-20020a05622a040c00b003ef64d9f0b3mr35666847qtx.14.1683864570880;
        Thu, 11 May 2023 21:09:30 -0700 (PDT)
X-Received: by 2002:a05:622a:180b:b0:3f4:f0fd:fe7e with SMTP id
 t11-20020a05622a180b00b003f4f0fdfe7emr118356qtc.3.1683864568408; Thu, 11 May
 2023 21:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <87cz6mnaqk.fsf@redhat.com> <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com> <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com> <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com> <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
In-Reply-To: <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 12 May 2023 13:09:16 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
Message-ID: <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
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

On Thu, May 11, 2023 at 5:50=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 08.05.23 06:55, Alexandre Courbot wrote:
> > On Fri, May 5, 2023 at 8:55=E2=80=AFPM Alexander Gordeev
> > <alexander.gordeev@opensynergy.com> wrote:
> >>
> >> On 03.05.23 16:04, Cornelia Huck wrote:
> >>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy=
.com> wrote:
> >>>
> >>>> On 27.04.23 15:16, Alexandre Courbot wrote:
> >>>>> But in any case, that's irrelevant to the guest-host interface, and=
 I
> >>>>> think a big part of the disagreement stems from the misconception t=
hat
> >>>>> V4L2 absolutely needs to be used on either the guest or the host,
> >>>>> which is absolutely not the case.
> >>>>
> >>>> I understand this, of course. I'm arguing, that it is harder to
> >>>> implement it, get it straight and then maintain it over years. Also =
it
> >>>> brings limitations, that sometimes can be workarounded in the virtio
> >>>> spec, but this always comes at a cost of decreased readability and
> >>>> increased complexity. Overall it looks clearly as a downgrade compar=
ed
> >>>> to virtio-video for our use-case. And I believe it would be the same=
 for
> >>>> every developer, that has to actually implement the spec, not just d=
o
> >>>> the pass through. So if we think of V4L2 UAPI pass through as a
> >>>> compatibility device (which I believe it is), then it is fine to hav=
e
> >>>> both and keep improving the virtio-video, including taking the best
> >>>> ideas from the V4L2 and overall using it as a reference to make writ=
ing
> >>>> the driver simpler.
> >>>
> >>> Let me jump in here and ask another question:
> >>>
> >>> Imagine that, some years in the future, somebody wants to add a virti=
o
> >>> device for handling video encoding/decoding to their hypervisor.
> >>>
> >>> Option 1: There are different devices to chose from. How is the perso=
n
> >>> implementing this supposed to pick a device? They might have a narrow
> >>> use case, where it is clear which of the devices is the one that need=
s to
> >>> be supported; but they also might have multiple, diverse use cases, a=
nd
> >>> end up needing to implement all of the devices.
> >>
> >> I think in this case virtio-v4l2 should be used as a compatibility
> >> device exclusively. This means discouraging increasing its complexity
> >> even more with more patches in the spec. virtio-video should eventuall=
y
> >> cover all the use-cases of V4L2, so I think it is reasonable to use it
> >> in both complex use-cases and in simple use-cases, where there is no
> >> decoder/encoder V4L2 device on the host.
> >>
> >>> Option 2: There is one device with various optional features. The per=
son
> >>> implementing this can start off with a certain subset of features
> >>> depending on their expected use cases, and add to it later, if needed=
;
> >>> but the upfront complexity might be too high for specialized use case=
s.
> >
> > I don't see that many negociable features we can provide for a
> > decoder/encoder device - at least not many that are not considered
> > basic (like guest buffers). In terms of provided features for codecs
> > virtio-video and virtio-v4l2 are essentially equivalent.
>
> Actually I see a lot of potential in using the virtio feature flag
> negotiation for virtio-video:
>
> 1. We already have some feature flags related to memory management.
>
> 2. I think it would be great to take V4L2 controls negotiation and turn
> it into the feature flags negotiation. I really like this idea and I'd
> like to implement it. Not all the controls at once, of course. Still it
> would be very easy to port more given the existing process. They
> correspond well enough to each other, I think. This way we don't need to
> introduce something like the VIDIOC_QUERYCTRL/VIDIOC_QUERY_EXT_CTRL, we
> don't need two mechanisms for feature negotiations (like it would be
> with virtio-v4l2, right?), also all the features would be in one place.
> Then we can directly reference some enums from V4L2, like
> v4l2_mpeg_video_h264_profile or v4l2_mpeg_video_h264_level. That's what
> I call taking the best from V4L2.
>
> 3. We can have things, that V4L2 doesn't support in their stateful UAPI.
> For example, dequeuing output buffers in decoder order.

... provided the host can do that (i.e. has a stateless decoder
interface). What is the use-case for this btw?

>
> > The question is more: do we want a decoder/encoder specification and
> > another one for cameras or do we want something that covers video
> > devices in general. And is it desirable to reuse an already existing
> > protocol for communication between a non-privileged entity and a
> > privileged one (V4L2) or define our own?
>
> Please note, that virtio-video could be extended to support everything
> V4L2 does in the future. Including cameras if necessary. So it can cover
> video devices in general too.

That's a very, very bold claim, and if you do you will inevitably need
to add things that are not relevant to the codec case, which is your
complaint about V4L2. Not to mention the many new pages of spec that
this will require.

>
> > About the latter point, Alex Benn=C3=A9e mentioned that it was difficul=
t to
> > find the engineering time to define virtio-camera. And virtio-video
> > has also not been particularly fast to come together. virtio-v4l2
> > basically serves us both on a plate for a lower effort.
>
> If we talk only about codecs, the effort is lower only in case you have
> V4L2 codecs on the host. Otherwise the effort seems higher.

The effort is lower in terms of spec writing, and also lower if your
guest is Linux as you can support all video devices with a single
driver. That's a very large portion of the virtio users here.

> I also hope to be able to update virtio-video at a faster pace. Please
> let me try.

Please hold on a bit - there are two things here.

1) I'd like to settle the virtio-v4l2/virtio-video argument first to
make sure we don't get two things clashing head-on. As far as codecs
are concerned we certainly don't need both. Cornelia, I think we'll
need you to make a call on this, or at least tell us what you need to
make the call. If it helps I can send a draft of what the virtio-v4l2
spec would look like, it should be relatively short.

2) I (and other ChromeOS contributors) have been driving this spec so
far and while I think virtio-v4l2 is a better solution, I have not
said I would give up on virtio-video if virtio-v4l2 was not adopted
and will keep iterating on it in that case.

That said, your contributions are of course welcome if you have stuff
written down that you want to include. The current virtio-video spec
is available here:

https://github.com/Gnurou/virtio-video-spec

I'm writing it in Markdown (virtio-video.md) to avoid dealing with
LaTeX directly and use a pandoc filter to convert it before submission
- there is a Makefile that takes care of that. Feel free to send a
pull request with changes you have worked on, including your
Signed-off-by in the patches so I can carry it on into the v7 patch if
we go that route.

> This is understandable, that working on the specs takes time. That's why
> I'm all for making room for everybody to work. I think eventually
> virtio-video or virtio-video + virtio-camera can replace virtio-v4l2. I
> strongly believe this is a better solution for the long term.
>
> >> In this case I'd prefer to have the simpler device first, that is the
> >> current virtio-video, then to add features incrementally using feature
> >> flags and taking into account the virtualization context. V4L2 is a
> >> complex thing from a different context. They already tried to carve ou=
t
> >> some of the use-cases like stateful decoder/encoder API, but this work
> >> is not finished (struct v4l2_buffer can serve as an evidence). This is
> >> like dissecting a monolith. Also it has to be patched to make it more
> >> appropriate for virtualization (we can see this in Alexandre's PoC alr=
eady).
> >>
> >>> Leaving concrete references to V4L2 out of the picture, we're current=
ly
> >>> trying to decide whether our future will be more like Option 1 or Opt=
ion
> >>> 2, with their respective trade-offs.
> >>
> >> I'd like to rely on opinions of people, who know more about virtio
> >> development and goals. I would be happy to present or reiterate my
> >> arguments to anyone interested if necessary.
> >>
> >>> I'm slightly biased towards Option 2; does it look feasible at all, o=
r
> >>> am I missing something essential here? (I had the impression that som=
e
> >>> previous confusion had been cleared up; apologies in advance if I'm
> >>> misrepresenting things.)
> >>
> >> Indeed some of the previous confusion has been cleared up. But not the
> >> key thing. Alexandre still claims, that this patched V4L2 UAPI pass
> >> through is only marginally more complex, for example. I don't agree wi=
th
> >> this and I have evidence. We haven't finished discussing this evidence=
.
> >
> > Are you talking about v4l2_buffer?
> >
> > https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/buffer.html#struct-=
v4l2-buffer
> >
> > I think you implied that some of its fields were not relevant for
> > video decoding or encoding, which if you examine them is again
> > incorrect. That also answers your question of why the stateful decoder
> > spec did not mention the valid fields - because it is documented on
> > this page, which tells exactly which fields the driver/device are
> > expected to set for each queue.
>
> I'm talking about struct v4l2_buffer, yes, but not only. Also about
> struct v4l2_plane, enum v4l2_buf_type, the buffer flags, enum
> v4l2_memory (but this one is comparable to virtio-video), timecodes.
> For example, the way the fields in the struct v4l2_buffer and struct
> v4l2_plane are filled and interpreted depends a lot on the type. Here is
> the enum v4l2_buf_type:
>
> enum v4l2_buf_type {
>          V4L2_BUF_TYPE_VIDEO_CAPTURE        =3D 1,
>          V4L2_BUF_TYPE_VIDEO_OUTPUT         =3D 2,
>          V4L2_BUF_TYPE_VIDEO_OVERLAY        =3D 3,
>          V4L2_BUF_TYPE_VBI_CAPTURE          =3D 4,
>          V4L2_BUF_TYPE_VBI_OUTPUT           =3D 5,
>          V4L2_BUF_TYPE_SLICED_VBI_CAPTURE   =3D 6,
>          V4L2_BUF_TYPE_SLICED_VBI_OUTPUT    =3D 7,
>          V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY =3D 8,
>          V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE =3D 9,
>          V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE  =3D 10,
>          V4L2_BUF_TYPE_SDR_CAPTURE          =3D 11,
>          V4L2_BUF_TYPE_SDR_OUTPUT           =3D 12,
>          V4L2_BUF_TYPE_META_CAPTURE         =3D 13,
>          V4L2_BUF_TYPE_META_OUTPUT          =3D 14,
>          /* Deprecated, do not use */
>          V4L2_BUF_TYPE_PRIVATE              =3D 0x80,
> };
>
> Of these 14 cases we only need 2 for the codecs. Right?
> Also the flags. There are 22 of them. Are they all needed too? I don't
> think so. We only have like 5 in virtio-video at the moment.

Upon reading the V4L2 spec it is pretty clear which queue types are
valid for each device, and anything other than CAPTURE_MPLANE and
OUTPUT_MPLANE is unlikely to be used anyway.

We are really splitting hairs here and this looks like a wild goose
chase for software purity - even within virtio-video there are already
flags that only make sense for an encoder, and you cannot remove them
without defining new more specific structures and complicating things
overall. If you extend virtio-video to support more use-cases, you
will end up with more of these as well. So seriously, why is this such
a big deal when the instructions on how to use these structures for
each use case are at the other end of a link click?

>
> You posted code for filling v4l2_buffer in one of your previous emails.
> What I'm trying to say is that a person, who doesn't know this in
> advance, will have a hard time writing this same code if they only have
> the virtio-v4l2 spec.

Well yes, the counterpart of virtio-v4l2 being shorter is that you
need to refer to V4L2 as well - that's actually the point, to reduce
the burden on virtio by reusing a spec that already exists and
referring to it.

Earlier in this email you mentioned reusing structs like
v4l2_mpeg_video_h264_profile in virtio-video, that creates the same
dependency to the V4L2 spec. The difference is how much we are taking
from it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

