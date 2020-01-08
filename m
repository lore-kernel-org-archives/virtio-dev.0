Return-Path: virtio-dev-return-6616-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F483985E03
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 11:04:28 +0000 (UTC)
MIME-Version: 1.0
References: <CAD=HUj6FA3VoTJqNa+gmAgVOv9zS7Qk9pdg46EY9NvtJOdz5_A@mail.gmail.com>
 <20200108104002.jxh6amnrazhnamej@sirius.home.kraxel.org>
In-Reply-To: <20200108104002.jxh6amnrazhnamej@sirius.home.kraxel.org>
From: David Stevens <stevensd@google.com>
Date: Wed, 8 Jan 2020 20:04:15 +0900
Message-ID: <CAOiLmNHMAz6UqxuEsiq6Y_dSNcCvtBrFR-FHG6voJAhpF8SeeA@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what exporting a
 resource is
Content-Type: multipart/alternative; boundary="0000000000001bcba4059b9edb4b"
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, virtio-dev@lists.oasis-open.org, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000001bcba4059b9edb4b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>
> Hmm, I'd suggest to move the whole thing into the virtio-gpu section.
> There is no such thing as a "resource" in general virtio context ...
>

If this is moved into the virtio-gpu section, then any device type that
imports resources will have to refer to something defined by the GPU device
type. This would make the GPU device type a sort of special device type
that isn't just a leaf node of the spec. I think it's better to define
'resource' as a top level concept for virtio devices, even if the specifics
of what a 'resource' is are defined by individual device types.

-David

--0000000000001bcba4059b9edb4b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hmm, I&#39;d suggest to move the whole thing into the vi=
rtio-gpu section.<br>
There is no such thing as a &quot;resource&quot; in general virtio context =
...<br></blockquote><div><br></div><div>If this is moved into the virtio-gp=
u section, then any device type that imports resources will have to refer t=
o something defined by the GPU device type. This would make the GPU device =
type a sort of special device type that isn&#39;t just a leaf node of the s=
pec. I think it&#39;s better to define &#39;resource&#39; as a top level co=
ncept for virtio devices, even if the specifics of what a &#39;resource&#39=
; is are defined by individual device types.</div><div><br></div><div>-Davi=
d=C2=A0</div></div></div>

--0000000000001bcba4059b9edb4b--

