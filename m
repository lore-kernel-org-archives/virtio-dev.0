Return-Path: <virtio-dev-return-10330-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 491FB9863FB
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Dec 2022 09:51:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
Date: Tue, 20 Dec 2022 10:51:41 +0100
Message-ID: <87k02mz9le.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification
Content-Type: text/plain
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Marcin Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?= Grzesik <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 19 2022, Alexander Gordeev <alexander.gordeev@opensynergy.com> wrote:

> Hello Alexandre,
>
> Thanks for the update. Please check my comments below.
> I'm new to the virtio video spec development, so I may lack some
> historic perspective. I would gladly appreciate pointing me to some
> older emails explaining decisions, that I might not understand. I hope
> to read through all of them later. Overall I have a lot of experience in
> the video domain and in virtio video device development in Opsy, so I
> hope, that my comments are relevant and useful.

Thank you for commenting! I know the virtio spec, but I'm not familiar
with the video part, so your feedback is highly appreciated :)

Prior discussions should be in the virtio-dev archives; at least v3
(https://lists.oasis-open.org/archives/virtio-dev/202002/msg00002.html)
and v4
(https://lists.oasis-open.org/archives/virtio-dev/202006/msg00072.html)
seem to have gotten some feedback.

[A note to Alexandre: You'll want to send your patches to virtio-comment
as well as virtio-dev; virtio-comment is for commenting on the spec
including proposing updates, while virtio-dev is for discussing virtio
development. Yes, I know that we haven't always been strict about that
in the past.]

>
> On 08.12.22 08:23, Alexandre Courbot wrote:

(...)

>> +\subsubsection{Image formats}\label{sec:Device Types / Video Device / Supported formats / Image formats}
>> +
>> +The fourcc code of each supported image format is given, as well as its
>> +number of planes, physical buffers, and eventual subsampling.
>> +
>> +\begin{description}
>> +\item[\field{RGB3}]
>> +one RGB plane where each component takes one byte, i.e.~3 bytes per
>> +pixel.
>> +\item[\field{NV12}]
>> +one Y plane followed by interleaved U and V data, in a single buffer.
>> +4:2:0 subsampling.
>> +\item[\field{NV12}]
>> +same as \field{NV12} but using two separate buffers for the Y and UV
>> +planes.
>
> s/NV12/NM12/ ?
>
>
>> +\item[\field{YU12}]
>> +one Y plane followed by one Cb plane, followed by one Cr plane, in a
>> +single buffer. 4:2:0 subsampling.
>> +\item[\field{YM12}]
>> +same as \field{YU12} but using three separate buffers for the Y, U and V
>> +planes.
>> +\end{description}
>
> This looks like V4L2 formats. Maybe add a V4L2 reference? At least the
> V4L2 documentation has a nice description of exact plane layouts.
> Otherwise it would be nice to have these layouts in the spec IMO.

Ah, so this is all V4L2? It looks like we really want to refer to the
existing V4L2 headers (like we already do for FUSE in the virtiofs
case). Are those headers sufficient to specify the formats, or do we
need anything else?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

