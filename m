Return-Path: virtio-dev-return-6626-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DCA4985E06
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 13:52:28 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <3550989.gzE5nMqd4t@os-lin-dmo> <CAAFQd5BgkEUwBFWdv2ZH98egjm=u0dBRgtexqkzjES+J1SEmag@mail.gmail.com>
 <3878267.TzG3DlCiay@os-lin-dmo> <20191219131234.wm24cazvc7zrnhpn@sirius.home.kraxel.org>
In-Reply-To: <20191219131234.wm24cazvc7zrnhpn@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Wed, 8 Jan 2020 22:52:16 +0900
Message-ID: <CAD90Vcb4Vb49uHGRRg0nJaKo=goH6zOxdQR2d7piLH_byxDYyw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video
 device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,

On Thu, Dec 19, 2019 at 10:12 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > However that still doesn't let the driver know which buffers will be
> > > dequeued when. A simple example of this scenario is when the guest is
> > > done displaying a frame and requeues the buffer back to the decoder.
> > > Then the decoder will not choose it for decoding next frames into as
> > > long as the frame in that buffer is still used as a reference frame,
> > > even if one sends the drain request.
> > It might be that I'm getting your point wrong, but do you mean some har=
dware
> > can mark a buffer as ready to be displayed yet still using the underlyi=
ng
> > memory to decode other frames?
>
> Yes, this is how I understand Tomasz Figa.
>
> > This means, if you occasionally/intentionally
> > write to the buffer you mess up the whole decoding pipeline.
>
> And to avoid this the buffer handling aspect must be clarified in the
> specification.  Is the device allowed to continue using the buffer after
> finishing decoding and completing the queue request?  If so, how do we
> hand over buffer ownership back to the driver so it can free the pages?
> drain request?  How do we handle re-using buffers?  Can the driver
> simply re-queue them and expect the device figures by itself whenever it
> can use the buffer or whenever it is still needed as reference frame?

The device shouldn't be able to access buffers after it completes a
queue request.
The device can touch buffer contents from when a queue request is sent
until the device responds it.
In contrast, the driver must not modify buffer contents in that period.

Regarding re-using, the driver can simply re-queue buffers returned by
the device. If the device needs a buffer as reference frame, it must
not return the buffer.
I'll describe this rule in the next version of the patch.

Best regards,
Keiichi

>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

