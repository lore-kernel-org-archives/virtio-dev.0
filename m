Return-Path: virtio-dev-return-6534-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33A3B985EFE
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Dec 2019 14:08:53 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <20191218130214.170703-2-keiichiw@chromium.org> <20191218134037.3jbouht52bxqwfyy@sirius.home.kraxel.org>
In-Reply-To: <20191218134037.3jbouht52bxqwfyy@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 18 Dec 2019 23:08:37 +0900
Message-ID: <CAAFQd5AEJ0sUzqrXJAmFnBn0aU8Ef6FwXYo0LgK0NO_CdWXRVg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video
 device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, fziglio@redhat.com, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 18, 2019 at 10:40 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +The device MUST mark the last buffer with the
> > +VIRTIO_VIDEO_BUFFER_F_EOS flag to denote completion of the drain
> > +sequence.
>
> No, that would build a race condition into the protocol.  The device
> could complete the last buffer after the driver has sent the drain
> command but before the device saw it.  So the flag would not be
> reliable.
>
> I also can't see why the flag is needed in the first place.  The driver
> should know which buffers are queued still and be able to figure
> whenever the drain is complete or not without depending on that flag.
> So I'd suggest to simply drop it.

Unfortunately video decoders are not that simple. There are always
going to be some buffers on the decoder side used as reference frames.
Only the decoder knows when to release them, as it continues decoding
the stream. Moreover, with certain features of certain codecs (e.g.
framebuffer reordering in H.264), there could be decoded frames that
need to be held by decoder, because later bitstream may contain
earlier frames.

How we defined this in the V4L2 stateful decoder interface is that if
the decoder happened to return the last framebuffer before the drain
request arrived, it would return one more, empty. From our experience
that was the easiest thing to deal with from both the driver and the
application, so I believe the same should apply to the host device
implementation and the guest driver.

>
> That is the only issue I've spotted in the protocol on a first quick
> look.  There are a few places where the spec text could be improved.
> I'll try to set aside some time to go over this in detail, but I can't
> promise I'll find the time to do that before xmas and new year.

Thanks a lot for review.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

