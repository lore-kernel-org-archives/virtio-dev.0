Return-Path: virtio-dev-return-6965-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D91E698432E
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Mar 2020 12:08:07 +0000 (UTC)
MIME-Version: 1.0
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-2-keiichiw@chromium.org> <20200225095956.7rtwugfru4dbjj7q@sirius.home.kraxel.org>
 <CAD90VcaTJh5MTRggpOmCK2LAryMHha2+7nPkFVTT8N8S06tf-A@mail.gmail.com>
 <20200227092856.p4kuh5dhh2tk3nnf@sirius.home.kraxel.org> <CAPBb6MWwBbNULCfMxN_KLt_Zd8kmmNy2JPi6XjLF1YgxxCPydw@mail.gmail.com>
 <20200304064251.zzkhevqgth6uets6@sirius.home.kraxel.org> <CAPBb6MVPjgLkbVjOY6O3srywNm8Zb1pMR2pGM1NinByhgFaZ_A@mail.gmail.com>
In-Reply-To: <CAPBb6MVPjgLkbVjOY6O3srywNm8Zb1pMR2pGM1NinByhgFaZ_A@mail.gmail.com>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 23 Mar 2020 21:07:54 +0900
Message-ID: <CAD90VcaYi2KawNOewRaL1QihUjgja6nLyzU+0R7nsHPN3voXDA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi everyone,

I have implemented a virtio-video device following my v3 spec in
crosvm, which worked well together with Dmitry's driver [1]. I've
started preparing v4 proposal to address problems found while
implementing the driver and the devices.

Regarding v3 protocol, I'm thinking about how we can differentiate
'parameters' and 'controls' in the virtio-video spec?
In the previous discussion, we decided to have a profile, level and
bitrate as controls because we want to query supported values for each
field.
But, I don't think it's a good criteria because it'd be possible to
query other values in params.

So, I'm thinking about what should be the difference between params
and controls. If no difference, we should deprecate
virtio_video_params and have every field there as a control value
instead.
If we add a new command to get and set multiple controls at once, this
change won't cause overhead.

What do you think? Is there anything I missed?
If it sounds fine, I'll remove virtio_video_params from the v4 spec proposa=
l.

Best regards,
Keiichi

[1]: https://patchwork.linuxtv.org/patch/61717/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

