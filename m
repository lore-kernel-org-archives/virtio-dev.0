Return-Path: virtio-dev-return-6303-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B0F8985F34
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Nov 2019 07:51:06 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <20191107095657.72dlxzm4uz7ndkek@sirius.home.kraxel.org> <1573181413.STYvEGL1rf@os-lin-dmo>
In-Reply-To: <1573181413.STYvEGL1rf@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 8 Nov 2019 16:50:52 +0900
Message-ID: <CAAFQd5CkTxCYhn70o5oiR4uLA7QyRMUw-XrRWorwZnwXGK0pDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 7, 2019 at 10:09 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
>
> Hello Gerd,
>
> Thank you for your feedback.
>
> There is no relationship between those. As I mentioned earlier. we have also
> been working on a virtio video device at the same time. And there is no
> relationship between the two specs.
>
> I can point you to the differences I see:
>
> virtio-vdec:
> 1. Both the device and the driver submit requests to each other. For each
> request the response is sent as a separate request.

To be more precise, in vdec there are no responses. The guest sends
commands to the host using one virtqueue. The host signals
asynchronous events, which might not have the exact earlier guest
request associated to them. An example of such special case could be
H.264 framebuffer reordering, where one might end up with a few decode
requests not resulting in any frames being output and then one decode
request that would trigger multiple accumulated frames to be returned.

> 2. No support for getting/setting video stream parameters. For example
> (decoder): output format (NV12, I420), so the driver cannot really select the
> output format after headers have been parsed.

Getting video stream parameters is there, but they are currently left
fully in control of the host video decoder. Ability to select between
multiple possible formats could be worth adding, though.

> 3. No support for getting plane requirements from the device (sg vs contig,
> size, stride alignment, plane count).

There is actually a bigger difference that results in that. Vdec
assumes host-allocated buffers coming from a different device, e.g.
virtio-gpu and the host having the right knowledge to allocate the
buffers correctly. This is related to the fact that it's generally
difficult to convey all the allocation constraints in a generic
manner.

> 4. In the vdec device Drain and Flush are not separate for each buffer queue.
> So seek and dynamic resolution change (adaptive playback) cannot be
> implemented because 'flush' can have different meaning for a resolution change
> and a seek.

That's not true. Drain and flush can be defined very precisely for a
stateful video decoder.

For example, V4L2 defines drain as follows:
https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html#drain
and it's modeled after that in vdec.

There is no flush explicitly defined in V4L2, but that corresponds to
the behavior of STREAMOFF, which drops all the buffers on given queue.
There is no practical use for flushing just one queue in case of a
video decoder, so we decided to simplify it down to a single flush
that fully resets the decoder, which is useful for instantaneous seek.

There is also already infrastructure existing for dynamic resolution
change too, using the stream information host request and drain flow,
which is very similar to how this is done in V4L2:
https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html#dynamic-resolution-change

> 5. Decoder only: new devices will be needed to support encoder, processor or
> capture. Currently input is always a bitstream, output is always a video
> frame. No way set input format (needed for encoder, see 2).

The rationale for this was that this is a point of contact with the
host and a possible attack surface, so having a protocol as specific
as possible makes the attack surface smaller and is easier to validate
in the device implementation.

>
> virtio-video:
> 1. Uses the 'driver requests - device responses' model.
> 2. Does not  have the logical split of bitstreams and framebuffers, has only a
> generic buffer object.
> 3. Generic: can support any type of video device right away due to flexibility
> of stream configuration. Both input and output buffer queues can accept
> bitstream and frame buffers and run independently. (more controls need to be
> defined for e.g. camera)

To fully support real cameras, not just simple UVC webcams, some
mechanism to have multiple output and capture streams synchronized
together would be needed, because Android Camera HALv3 heavily relies
on multiple stream support.

For example, a simple camera application with ZSL (zero shutter lag)
could setup following streams:
1) YUV preview
2) RAW capture
3) RAW output
4) JPEG capture

1) and 2) would operate at camera frame rate, while 3) and 4) would be
given on demand whenever the user presses the shutter button. Presence
of 3) and 4) must not affect 1) and 2), i.e. the preview and raw
capture must continue at camera frame rate.

> 4. Supports seek, drain, dynamic resolution change using an API agnostic
> command set (no v4l2/vaapi or so on remoting).
> 5. Complex configuration (most likely cannot be simplified for such a complex
> device type).
>
> Best regards,
> Dmitry.
>
> On Donnerstag, 7. November 2019 10:56:57 CET Gerd Hoffmann wrote:
> > On Tue, Nov 05, 2019 at 08:19:19PM +0100, Dmitry Sepp wrote:
> > > [Resend after fixing an issue with the virtio-dev mailing list]
> > >
> > > This patch proposes a virtio specification for a new virtio video
> > > device.
> >
> > Hmm, quickly looking over this, it looks simliar to the vdec draft
> > posted a few weeks ago, with other device variants added but not
> > fully specified yet.
> >
> > So, can you clarify the relationship between the two?
> >
> > thanks,
> >   Gerd
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

