Return-Path: <virtio-dev-return-10565-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FB9E9865B0
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Jan 2023 06:33:08 +0000 (UTC)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org> <a20adf2d-6a2b-bfdf-d86f-c8c5972ab39e@opensynergy.com>
In-Reply-To: <a20adf2d-6a2b-bfdf-d86f-c8c5972ab39e@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Thu, 12 Jan 2023 15:32:54 +0900
Message-ID: <CAPBb6MV=Ghxr_ZVB1HfmXtjuiBi6tYeSzTQgmMsOL7LgAVBR2A@mail.gmail.com>
Subject: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset="UTF-8"
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alexander,

On Thu, Jan 12, 2023 at 2:04 AM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
> > +\subsubsection{Bitstream formats}\label{sec:Device Types / Video Device / Supported formats / Bitstream formats}
> > +
> > +The fourcc code of each supported bitstream format is given, as well as
> > +the unit of data requested in each input resource for the decoder, or
> > +produced in each output resource for the encoder.
> > +
> > +\begin{description}
> > +\item[\field{MPG2}]
> > +MPEG2 encoded stream. One Access Unit per resource.
> > +\item[\field{H264}]
> > +H.264 encoded stream. One NAL unit per resource.
> > +\item[\field{HEVC}]
> > +HEVC encoded stream. One NAL unit per resource.
> > +\item[\field{VP80}]
> > +VP8 encoded stream. One frame per resource.
> > +\item[\field{VP90}]
> > +VP9 encoded stream. One frame per resource.
> > +\end{description}
> > +
>
> Actually I'm not sure where do these fourcc codes for bitstream formats
> come from.
>
> In one of the old comments I found a reference to
> https://www.rfc-editor.org/rfc/rfc2361
>
> But it doesn't define MPG2, HEVC, VP80, VP90.
>
> Also there is this comment to virtio-video v1 from Tomasz Figa and the
> related discussion:
> https://markmail.org/message/gc6h25acct22niut#query:+page:1+mid:et4l3ni7qjqhiygo+state:results
>
> He wrote that it is not worth it because there are so many conflicting
> sets of fourcc codes.
>
> I can see that fourcc codes were not used in virtio-video spec draft
> versions 1 to 5. So now it looks quite weird to see them here. Probably
> this is because you'd like to mimic v4l2 interface more closely?

These come from here:
https://docs.kernel.org/userspace-api/media/v4l/pixfmt-compressed.html

V4L2 has a nice list of supported fourccs for coded formats, so I'd
just suggest we refer to them and use them instead of defining our
own.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

