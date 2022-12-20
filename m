Return-Path: <virtio-dev-return-10334-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F63F98640C
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Dec 2022 17:39:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <de2f7a27-9f2a-0e36-d57c-3ddaa86b0a26@opensynergy.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <87k02mz9le.fsf@redhat.com>
 <de2f7a27-9f2a-0e36-d57c-3ddaa86b0a26@opensynergy.com>
Date: Tue, 20 Dec 2022 18:39:13 +0100
Message-ID: <87bknyyny6.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification
Content-Type: text/plain
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Marcin Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?= Grzesik <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Dec 20 2022, Alexander Gordeev <alexander.gordeev@opensynergy.com> wrote:

> Hello Cornelia,
>
> On 20.12.22 10:51, Cornelia Huck wrote:
>> On Mon, Dec 19 2022, Alexander Gordeev <alexander.gordeev@opensynergy.com> wrote:
>>
>>> Hello Alexandre,
>>>
>>> Thanks for the update. Please check my comments below.
>>> I'm new to the virtio video spec development, so I may lack some
>>> historic perspective. I would gladly appreciate pointing me to some
>>> older emails explaining decisions, that I might not understand. I hope
>>> to read through all of them later. Overall I have a lot of experience in
>>> the video domain and in virtio video device development in Opsy, so I
>>> hope, that my comments are relevant and useful.
>> Thank you for commenting! I know the virtio spec, but I'm not familiar
>> with the video part, so your feedback is highly appreciated :)
>>
>> Prior discussions should be in the virtio-dev archives; at least v3
>> (https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flists.oasis%2dopen.org%2farchives%2fvirtio%2ddev%2f202002%2fmsg00002.html&umid=ce4587fa-5f66-4a08-be71-c7fad0355b4c&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-8ac7749933f48b779f5d37c4630ba2d37c15b0eb)
>> and v4
>> (https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flists.oasis%2dopen.org%2farchives%2fvirtio%2ddev%2f202006%2fmsg00072.html&umid=ce4587fa-5f66-4a08-be71-c7fad0355b4c&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-f5d8196d57b85625d3a8262d32ad87a88d5d6bee)
>> seem to have gotten some feedback.
>>
>> [A note to Alexandre: You'll want to send your patches to virtio-comment
>> as well as virtio-dev; virtio-comment is for commenting on the spec
>> including proposing updates, while virtio-dev is for discussing virtio
>> development. Yes, I know that we haven't always been strict about that
>> in the past.]
>
> Thank you for the references! I'll take some time to read these
> discussions through.

You're welcome; I'm not sure how much of this is still relevant.

>
>
>>> On 08.12.22 08:23, Alexandre Courbot wrote:
>> (...)
>>
>>>> +\subsubsection{Image formats}\label{sec:Device Types / Video Device / Supported formats / Image formats}
>>>> +
>>>> +The fourcc code of each supported image format is given, as well as its
>>>> +number of planes, physical buffers, and eventual subsampling.
>>>> +
>>>> +\begin{description}
>>>> +\item[\field{RGB3}]
>>>> +one RGB plane where each component takes one byte, i.e.~3 bytes per
>>>> +pixel.
>>>> +\item[\field{NV12}]
>>>> +one Y plane followed by interleaved U and V data, in a single buffer.
>>>> +4:2:0 subsampling.
>>>> +\item[\field{NV12}]
>>>> +same as \field{NV12} but using two separate buffers for the Y and UV
>>>> +planes.
>>> s/NV12/NM12/ ?
>>>
>>>
>>>> +\item[\field{YU12}]
>>>> +one Y plane followed by one Cb plane, followed by one Cr plane, in a
>>>> +single buffer. 4:2:0 subsampling.
>>>> +\item[\field{YM12}]
>>>> +same as \field{YU12} but using three separate buffers for the Y, U and V
>>>> +planes.
>>>> +\end{description}
>>> This looks like V4L2 formats. Maybe add a V4L2 reference? At least the
>>> V4L2 documentation has a nice description of exact plane layouts.
>>> Otherwise it would be nice to have these layouts in the spec IMO.
>> Ah, so this is all V4L2? It looks like we really want to refer to the
>> existing V4L2 headers (like we already do for FUSE in the virtiofs
>> case). Are those headers sufficient to specify the formats, or do we
>> need anything else?
> Yes, these fourcc code seem to come from V4L2:
> https://docs.kernel.org/userspace-api/media/v4l/pixfmt-yuv-planar.html
> I also think we want to have a reference to V4L2 in the spec here, because:
> 1. V4L2 docs have the nice component/plane layouts that help convert or
> match these format definitions with other APIs.
> 2. These fourcc codes are not used anywhere else except in V4L2. I think
> this is the only place, that distinguishes coontiguous and non
> contiguous buffers with a fourcc code. So without a reference this may
> look quite weird. With a reference this looks logical, because I guess
> any virtio video driver for a Linux guest would naturally implement V4L2.

Maybe the best way to handle this would be to link to both the UAPI
header file (via Linus' tree on kernel.org, as we do for FUSE), and to
the .rst file(s) that describe what this all means (probably also via
kernel.org). The header file would definitely be a normative reference;
not sure whether the .rst files would be normative or non-normative, but
we can figure that out later. That's certainly better than trying to
replicate existing definitions and explanations.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

