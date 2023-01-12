Return-Path: <virtio-dev-return-10607-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F350D9865D3
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Jan 2023 22:24:26 +0000 (UTC)
Message-ID: <4d6b627a-1691-6d17-c4cc-5fbc505671ce@opensynergy.com>
Date: Thu, 12 Jan 2023 23:24:19 +0100
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <a20adf2d-6a2b-bfdf-d86f-c8c5972ab39e@opensynergy.com>
 <CAPBb6MV=Ghxr_ZVB1HfmXtjuiBi6tYeSzTQgmMsOL7LgAVBR2A@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MV=Ghxr_ZVB1HfmXtjuiBi6tYeSzTQgmMsOL7LgAVBR2A@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video device
 specification
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alexandre,

On 12.01.23 07:32, Alexandre Courbot wrote:
> Hi Alexander,
>
> On Thu, Jan 12, 2023 at 2:04 AM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>> +\subsubsection{Bitstream formats}\label{sec:Device Types / Video Devic=
e / Supported formats / Bitstream formats}
>>> +
>>> +The fourcc code of each supported bitstream format is given, as well a=
s
>>> +the unit of data requested in each input resource for the decoder, or
>>> +produced in each output resource for the encoder.
>>> +
>>> +\begin{description}
>>> +\item[\field{MPG2}]
>>> +MPEG2 encoded stream. One Access Unit per resource.
>>> +\item[\field{H264}]
>>> +H.264 encoded stream. One NAL unit per resource.
>>> +\item[\field{HEVC}]
>>> +HEVC encoded stream. One NAL unit per resource.
>>> +\item[\field{VP80}]
>>> +VP8 encoded stream. One frame per resource.
>>> +\item[\field{VP90}]
>>> +VP9 encoded stream. One frame per resource.
>>> +\end{description}
>>> +
>> Actually I'm not sure where do these fourcc codes for bitstream formats
>> come from.
>>
>> In one of the old comments I found a reference to
>> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3Dh=
ttps%3a%2f%2fwww.rfc%2deditor.org%2frfc%2frfc2361&umid=3D1c7e5b96-6438-489f=
-ae82-dfea03537169&auth=3D53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-9abf34a6=
12eb36d608f592911fde3480af19c68e
>>
>> But it doesn't define MPG2, HEVC, VP80, VP90.
>>
>> Also there is this comment to virtio-video v1 from Tomasz Figa and the
>> related discussion:
>> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3Dh=
ttps%3a%2f%2fmarkmail.org%2fmessage%2fgc6h25acct22niut%23query%3a%2bpage%3a=
1%2bmid%3aet4l3ni7qjqhiygo%2bstate%3aresults&umid=3D1c7e5b96-6438-489f-ae82=
-dfea03537169&auth=3D53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-d0ecfac6371fb=
65d9d93c694ba692ef42fe41d63
>>
>> He wrote that it is not worth it because there are so many conflicting
>> sets of fourcc codes.
>>
>> I can see that fourcc codes were not used in virtio-video spec draft
>> versions 1 to 5. So now it looks quite weird to see them here. Probably
>> this is because you'd like to mimic v4l2 interface more closely?
> These come from here:
> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3Dht=
tps%3a%2f%2fdocs.kernel.org%2fuserspace%2dapi%2fmedia%2fv4l%2fpixfmt%2dcomp=
ressed.html&umid=3D1c7e5b96-6438-489f-ae82-dfea03537169&auth=3D53c7c7de28b9=
2dfd96e93d9dd61a23e634d2fbec-4fbebb6ce3215a0e62782b61d287090a62d088dc
>
> V4L2 has a nice list of supported fourccs for coded formats, so I'd
> just suggest we refer to them and use them instead of defining our
> own.

Oops, somehow I overlooked that. Thanks!


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

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

