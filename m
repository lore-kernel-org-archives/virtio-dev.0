Return-Path: <alexander.gordeev@opensynergy.com>
Message-ID: <de2f7a27-9f2a-0e36-d57c-3ddaa86b0a26@opensynergy.com>
Date: Tue, 20 Dec 2022 11:35:56 +0100
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <87k02mz9le.fsf@redhat.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87k02mz9le.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello Cornelia,

On 20.12.22 10:51, Cornelia Huck wrote:
> On Mon, Dec 19 2022, Alexander Gordeev <alexander.gordeev@opensynergy.com=
> wrote:
>
>> Hello Alexandre,
>>
>> Thanks for the update. Please check my comments below.
>> I'm new to the virtio video spec development, so I may lack some
>> historic perspective. I would gladly appreciate pointing me to some
>> older emails explaining decisions, that I might not understand. I hope
>> to read through all of them later. Overall I have a lot of experience in
>> the video domain and in virtio video device development in Opsy, so I
>> hope, that my comments are relevant and useful.
> Thank you for commenting! I know the virtio spec, but I'm not familiar
> with the video part, so your feedback is highly appreciated :)
>
> Prior discussions should be in the virtio-dev archives; at least v3
> (https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3Dh=
ttps%3a%2f%2flists.oasis%2dopen.org%2farchives%2fvirtio%2ddev%2f202002%2fms=
g00002.html&umid=3Dce4587fa-5f66-4a08-be71-c7fad0355b4c&auth=3D53c7c7de28b9=
2dfd96e93d9dd61a23e634d2fbec-8ac7749933f48b779f5d37c4630ba2d37c15b0eb)
> and v4
> (https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3Dh=
ttps%3a%2f%2flists.oasis%2dopen.org%2farchives%2fvirtio%2ddev%2f202006%2fms=
g00072.html&umid=3Dce4587fa-5f66-4a08-be71-c7fad0355b4c&auth=3D53c7c7de28b9=
2dfd96e93d9dd61a23e634d2fbec-f5d8196d57b85625d3a8262d32ad87a88d5d6bee)
> seem to have gotten some feedback.
>
> [A note to Alexandre: You'll want to send your patches to virtio-comment
> as well as virtio-dev; virtio-comment is for commenting on the spec
> including proposing updates, while virtio-dev is for discussing virtio
> development. Yes, I know that we haven't always been strict about that
> in the past.]

Thank you for the references! I'll take some time to read these
discussions through.


>> On 08.12.22 08:23, Alexandre Courbot wrote:
> (...)
>
>>> +\subsubsection{Image formats}\label{sec:Device Types / Video Device / =
Supported formats / Image formats}
>>> +
>>> +The fourcc code of each supported image format is given, as well as it=
s
>>> +number of planes, physical buffers, and eventual subsampling.
>>> +
>>> +\begin{description}
>>> +\item[\field{RGB3}]
>>> +one RGB plane where each component takes one byte, i.e.~3 bytes per
>>> +pixel.
>>> +\item[\field{NV12}]
>>> +one Y plane followed by interleaved U and V data, in a single buffer.
>>> +4:2:0 subsampling.
>>> +\item[\field{NV12}]
>>> +same as \field{NV12} but using two separate buffers for the Y and UV
>>> +planes.
>> s/NV12/NM12/ ?
>>
>>
>>> +\item[\field{YU12}]
>>> +one Y plane followed by one Cb plane, followed by one Cr plane, in a
>>> +single buffer. 4:2:0 subsampling.
>>> +\item[\field{YM12}]
>>> +same as \field{YU12} but using three separate buffers for the Y, U and=
 V
>>> +planes.
>>> +\end{description}
>> This looks like V4L2 formats. Maybe add a V4L2 reference? At least the
>> V4L2 documentation has a nice description of exact plane layouts.
>> Otherwise it would be nice to have these layouts in the spec IMO.
> Ah, so this is all V4L2? It looks like we really want to refer to the
> existing V4L2 headers (like we already do for FUSE in the virtiofs
> case). Are those headers sufficient to specify the formats, or do we
> need anything else?
Yes, these fourcc code seem to come from V4L2:
https://docs.kernel.org/userspace-api/media/v4l/pixfmt-yuv-planar.html
I also think we want to have a reference to V4L2 in the spec here, because:
1. V4L2 docs have the nice component/plane layouts that help convert or
match these format definitions with other APIs.
2. These fourcc codes are not used anywhere else except in V4L2. I think
this is the only place, that distinguishes coontiguous and non
contiguous buffers with a fourcc code. So without a reference this may
look quite weird. With a reference this looks logical, because I guess
any virtio video driver for a Linux guest would naturally implement V4L2.

--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: alexander.gordeev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

