Return-Path: virtio-dev-return-6305-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D36E985F34
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Nov 2019 09:05:14 +0000 (UTC)
Date: Fri, 8 Nov 2019 10:05:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191108090506.jw4t46d3o4ooy7ns@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <20191107095657.72dlxzm4uz7ndkek@sirius.home.kraxel.org>
 <1573181413.STYvEGL1rf@os-lin-dmo>
 <CAAFQd5CkTxCYhn70o5oiR4uLA7QyRMUw-XrRWorwZnwXGK0pDQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CkTxCYhn70o5oiR4uLA7QyRMUw-XrRWorwZnwXGK0pDQ@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
To: Tomasz Figa <tfiga@chromium.org>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

> > 1. Both the device and the driver submit requests to each other. For ea=
ch
> > request the response is sent as a separate request.
>=20
> To be more precise, in vdec there are no responses. The guest sends
> commands to the host using one virtqueue. The host signals
> asynchronous events, which might not have the exact earlier guest
> request associated to them.

How do you report errors?  Is there an error event for that?

> An example of such special case could be
> H.264 framebuffer reordering, where one might end up with a few decode
> requests not resulting in any frames being output and then one decode
> request that would trigger multiple accumulated frames to be returned.

Note: this can be done with a request/response model too, by simply
completing the decode request when there is frame data, so in that case
multiple decode requests simply complete at the same time.  Yes, you can
have multiple outstanding requests in virtio.  Out-of-order completion
is also allowed btw.

> > 2. No support for getting/setting video stream parameters. For example
> > (decoder): output format (NV12, I420), so the driver cannot really sele=
ct the
> > output format after headers have been parsed.
>=20
> Getting video stream parameters is there, but they are currently left
> fully in control of the host video decoder. Ability to select between
> multiple possible formats could be worth adding, though.

Nice to see you agree on that one ;)

> > 3. No support for getting plane requirements from the device (sg vs con=
tig,
> > size, stride alignment, plane count).
>=20
> There is actually a bigger difference that results in that. Vdec
> assumes host-allocated buffers coming from a different device, e.g.
> virtio-gpu and the host having the right knowledge to allocate the
> buffers correctly. This is related to the fact that it's generally
> difficult to convey all the allocation constraints in a generic
> manner.

Yep, buffer handling is tricky, especially when it comes to decoding
directly to gpu buffers and also when supporting playback of
drm-protected streams where the guest might not be allowed to access
the stream data.

> > 5. Decoder only: new devices will be needed to support encoder, process=
or or
> > capture. Currently input is always a bitstream, output is always a vide=
o
> > frame. No way set input format (needed for encoder, see 2).
>=20
> The rationale for this was that this is a point of contact with the
> host and a possible attack surface, so having a protocol as specific
> as possible makes the attack surface smaller and is easier to validate
> in the device implementation.

I think it certainly makes sense to support both video encoding and
video decoding with a single device spec.

For capture (especially camera) and processor things are less clear,
although there is at least some overlap too.  IIRC most of the spec is
"TBD" for those anyway, so I'd suggest to drop them from the spec for
now and focus on the video parts.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

