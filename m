Return-Path: <virtio-dev-return-10567-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D16369865B0
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Jan 2023 06:40:39 +0000 (UTC)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <87sfggn7rj.fsf@linaro.org>
In-Reply-To: <87sfggn7rj.fsf@linaro.org>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Thu, 12 Jan 2023 15:40:24 +0900
Message-ID: <CAPBb6MV20iu_J8a2a8m_SCNmJo=ebEGYR2i2Cg4gKDcVsyP7Gg@mail.gmail.com>
Subject: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Alexander Gordeev <alexander.gordeev@opensynergy.com>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alex (are we having too many Alexes in this discussion? ^_^;)

On Thu, Jan 12, 2023 at 5:20 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Alexander Gordeev <alexander.gordeev@opensynergy.com> writes:
>
> > Hi Alexandre,
> >
> > On 27.12.22 08:31, Alexandre Courbot wrote:
> >> Hi Alexander,
> >>
> >>
> >> On Tue, Dec 20, 2022 at 1:59 AM Alexander Gordeev
> >> <alexander.gordeev@opensynergy.com> wrote:
> >>> Hello Alexandre,
> >>>
> >>> Thanks for the update. Please check my comments below.
> >>> I'm new to the virtio video spec development, so I may lack some
> >>> historic perspective. I would gladly appreciate pointing me to some
> >>> older emails explaining decisions, that I might not understand. I hop=
e
> >>> to read through all of them later. Overall I have a lot of experience=
 in
> >>> the video domain and in virtio video device development in Opsy, so I
> >>> hope, that my comments are relevant and useful.
> >> Cornelia provided links to the previous versions (thanks!). Through
> >> these revisions we tried different approaches, and the more we
> >> progress the closer we are getting to the V4L2 stateful
> >> decoder/encoder interface.
> <snip>
> >> This probably means a bit more work on the device side, since this
> >> spec is tailored for the specific video codec use-case and V4L2 is
> >> more generic, but also less spec to maintain and more confidence that
> >> things will work as we want in the real world. On the other hand, the
> >> device would also become simpler by the fact that responses to
> >> commands could not come out-of-order as they currently do. So at the
> >> end of the day I'm not even sure this would result in a more complex
> >> device.
> >
> > Sorry for the delay. I tried to gather data about how the spec has
> > evolved in the old emails.
> >
> > Well, on the one hand mimicking v4l2 looks like an easy solution from
> > virtio-video spec writing perspective. (But the implementers will have
> > to read the V4L2 API instead AFAIU, which is probably longer...)
> >
> > On the other hand v4l2 has a lot of history. It started as a camera API
> > and gained the codec support later, right? So it definitely has just to
> > much stuff irrelevant for codecs. Here we have an option to design from
> > scratch taking the best ideas from v4l2.
>
> We definitely don't want to bake in Linux APIs into the VirtIO spec
> which is meant to be host/guest agnostic if we can help it.

Note that using V4L2 here wouldn't bind us to Linux on either the host
or guest, it would just provide definitions of structures and
processes to perform video tasks. You can think of it as the way FUSE
is used in virtio-fs.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

