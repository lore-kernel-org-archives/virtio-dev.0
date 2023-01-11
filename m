Return-Path: <virtio-dev-return-10559-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF40B9863B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jan 2023 18:45:36 +0000 (UTC)
Message-ID: <1696ed17-7ec6-16f5-630e-485169627f68@opensynergy.com>
Date: Wed, 11 Jan 2023 19:45:30 +0100
References: <20221208072325.2259940-1-acourbot@chromium.org>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <20221208072325.2259940-1-acourbot@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video device
 specification
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alexandre,

On 08.12.22 08:23, Alexandre Courbot wrote:
> Add the specification of the video decoder and encoder devices, which
> can be used to provide host-accelerated video operations to the guest.
>
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> --
> Here is the long-overdue new revision of the virtio-video RFC. This
> version reorganizes the specification quite a bit and tries to simplify
> the protocol further. Nonetheless, it still results in a rather long (17
> pages) specification for just these devices, even though the spec is not
> fully complete (I want to rethink the formats descriptions, and some
> parameters need to be added for the encoder device).
>
> I would like to get some high-level feedback on this version and maybe
> propose to do things a bit differently before people invest too much
> time reviewing this in depth. While rewriting this document, it became
> more and more obvious that this is just a different, and maybe a bit
> simpler, reimplementation of the V4L2 stateless decoder protocol [1]. I
> am now wondering whether it would not make more sense to rewrite this
> specification as just a way to transport V4L2 requests over virtio,
> similarly to how virtio-fs does with the FUSE protocol [2].
>
> At the time we started writing this implementation, the V4L2 protocols
> for decoders and encoders were not set in stone yet, but now that they
> are it might make sense to reconsider. Switching to this solution would
> greatly shorten the virtio-video device spec, and also provide a way to
> support other kind of V4L2 devices like cameras or image processors at
> no extra cost.
>
> Note that doing so would not require that either the host or guest uses
> V4L2 - the virtio video device would just emulate a V4L2 device over
> virtio. A few adaptations would need to be done regarding how memory
> types work, but otherwise I believe most of V4L2 could be used as-is.
>
> Please share your thoughts about this, and I will either explore this
> idea further with a prototype, or keep moving the present spec forward,
> hopefully at a faster pace.
>
> Due to the RFC state of this patch I have refrained from referencing the
> normative statements in conformance.tex - I will do that as a final step
> once the spec is mostly agreed on.
>
> [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=
=3Dhttps%3a%2f%2fdocs.kernel.org%2fuserspace%2dapi%2fmedia%2fv4l%2fdev%2dst=
ateless%2ddecoder.html&umid=3D8ec8d8c9-b83c-40de-9337-a377056fe2af&auth=3D5=
3c7c7de28b92dfd96e93d9dd61a23e634d2fbec-e98508782bc1c9aa6b2e4a9df9d4dd170f9=
a5ffa
> [2] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-fs.tex
>
> Full PDF:
> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3Dht=
tps%3a%2f%2fdrive.google.com%2ffile%2fd%2f1HRVDiDdo50%2dS9X5tWgzmT90FJRHoB1=
dN%2fview%3fusp%3dsharing&umid=3D8ec8d8c9-b83c-40de-9337-a377056fe2af&auth=
=3D53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-e315af79a067165e908bf1d803441eb=
181e2f375
>
> PDF of video section only:
> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=3Dht=
tps%3a%2f%2fdrive.google.com%2ffile%2fd%2f1Sm6LSqvKqQiwYmDE9BXZ0po3XTKnKYlD=
%2fview%3fusp%3dsharing&umid=3D8ec8d8c9-b83c-40de-9337-a377056fe2af&auth=3D=
53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-b5c45bb4b6ccc5b73ea2a54e26f151d617=
22d0df

One more thing. I haven't found profiles and levels for the encoder
anywhere in the spec. They were there in v5.

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

