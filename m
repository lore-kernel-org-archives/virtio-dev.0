Return-Path: virtio-dev-return-6625-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CF62985E06
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 13:51:12 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <CAAFQd5AEJ0sUzqrXJAmFnBn0aU8Ef6FwXYo0LgK0NO_CdWXRVg@mail.gmail.com>
 <20191219074639.kdkrqxwb6fdb67hu@sirius.home.kraxel.org> <3550989.gzE5nMqd4t@os-lin-dmo>
 <20191219130158.7rzdkyemupreudko@sirius.home.kraxel.org>
In-Reply-To: <20191219130158.7rzdkyemupreudko@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Wed, 8 Jan 2020 22:50:59 +0900
Message-ID: <CAD90VcYcXniT-HV09LJoMkm8JWZ1c9et829wBdHUx9xwx3ya=Q@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video
 device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,
Thank you so much for the review. I'm sorry for not replying earlier.

On Thu, Dec 19, 2019 at 10:02 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Not clearly defined in the spec:  When is the decoder supposed to sen=
d
> > > the response for a queue request?  When it finished decoding (i.e. fr=
ame
> > > is ready for playback), or when it doesn't need the buffer any more f=
or
> > > decoding (i.e. buffer can be re-queued or pages can be released)?

The answer is "when it doesn't need the buffer any more for decoding".
The device can access buffer contents from when a queue request is
sent until the device responds it. So, the device must not responds a
queue request before finishing all process that requires the buffer
content.

Actually, the first one "When it finished decoding (i.e. frame is
ready for playback)" doesn't make much sense, as it's not necessary to
have a one-to-one correspondence between an input bitstream buffer and
a decoded frame.
It's okay to decode one input buffer contains bitstream data for two
frames. Also, a user can pass bitstream for one frame as two input
buffers.

I'll document it in the spec.

Best regards,
Keiichi

> > In my eyes the both statements mean almost the same and both are valid.
>
> Well, no.  When the device decoded a P-Frame it can notify the device,
> saying "here is your decoded frame".  But the device might still need
> the buffer with the decoded frame to properly decode the following B/I
> Frames which reference the P-Frame.
>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

