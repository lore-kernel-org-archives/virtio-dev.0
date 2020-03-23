Return-Path: virtio-dev-return-6967-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D81A98432E
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Mar 2020 13:28:15 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Mon, 23 Mar 2020 14:28:08 +0100
Message-ID: <8121654.T7Z3S40VBb@os-lin-dmo>
In-Reply-To: <CAD90VcaYi2KawNOewRaL1QihUjgja6nLyzU+0R7nsHPN3voXDA@mail.gmail.com>
References: <20200206102058.247258-1-keiichiw@chromium.org> <CAPBb6MVPjgLkbVjOY6O3srywNm8Zb1pMR2pGM1NinByhgFaZ_A@mail.gmail.com> <CAD90VcaYi2KawNOewRaL1QihUjgja6nLyzU+0R7nsHPN3voXDA@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

On Montag, 23. M=E4rz 2020 13:07:54 CET Keiichi Watanabe wrote:
> Hi everyone,
>=20
> I have implemented a virtio-video device following my v3 spec in
> crosvm, which worked well together with Dmitry's driver [1]. I've
> started preparing v4 proposal to address problems found while
> implementing the driver and the devices.

Great news!

>=20
> Regarding v3 protocol, I'm thinking about how we can differentiate
> 'parameters' and 'controls' in the virtio-video spec?
> In the previous discussion, we decided to have a profile, level and
> bitrate as controls because we want to query supported values for each
> field.
> But, I don't think it's a good criteria because it'd be possible to
> query other values in params.

Could you elaborate on this? Do you now how the design could look like or i=
t=20
is just an idea? AFAIR during the discussion of OpenSynergy's original v1 s=
pec=20
your point was to separate something that we call 'controls' now to reduce =
the=20
command data size and make command handling less error prone.

On one hand if don't really see any difference in params vs controls it wou=
ld=20
for sure make sense to remove one of the two. On the other hand I'd of cour=
se=20
like to avoid moving back in forth, especially when it comes to such a majo=
r=20
driver rework.

>=20
> So, I'm thinking about what should be the difference between params
> and controls. If no difference, we should deprecate
> virtio_video_params and have every field there as a control value
> instead.

I deem we should then deprecate controls instead. Params seem to be more=20
abstract. Width and height don't sound like a control for me.

> If we add a new command to get and set multiple controls at once, this
> change won't cause overhead.
>=20

How would we do this? Provide a flexible array member where each entry has =
a=20
type field first?

What can also make sense is to potentially join set and get calls (probably=
=20
provide 'get' stuff automatically within a response to 'set'). Anyway set a=
nd=20
get are currently used in conjunction all the time.

Best regards,
Dmitry.

> What do you think? Is there anything I missed?
> If it sounds fine, I'll remove virtio_video_params from the v4 spec
> proposal.
>=20
> Best regards,
> Keiichi
>=20
> [1]: https://patchwork.linuxtv.org/patch/61717/



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

