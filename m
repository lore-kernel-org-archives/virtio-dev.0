Return-Path: virtio-dev-return-6660-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2AAC6985F6B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jan 2020 11:12:55 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <CAAFQd5DcYWymWyzdiyfy18HkUBsEhALYG+DLwjXGCpRGDaJqyQ@mail.gmail.com>
 <CAD90VcbG6kR1Nw6DTr2RjwFrDja2B=Ohje_2MMeKBwpXGZ_MyA@mail.gmail.com> <2337316.Sgy9Pd6rRy@os-lin-dmo>
In-Reply-To: <2337316.Sgy9Pd6rRy@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 15 Jan 2020 20:12:35 +0900
Message-ID: <CAAFQd5CDQXfwRrdxH4afnz8WdUxczE9vDTXU+2gLjsjPFS7v3A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video
 device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 14, 2020 at 7:35 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> w=
rote:
>
> Hi Keiichi,
>
> thank you for the update.
>
> On Dienstag, 14. Januar 2020 08:18:50 CET Keiichi Watanabe wrote:
> > Hi,
> >
> > On Thu, Jan 9, 2020 at 11:21 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > On Wed, Jan 8, 2020 at 10:52 PM Keiichi Watanabe <keiichiw@chromium.o=
rg>
> wrote:
> > > > Hi Gerd,
> > > >
> > > > On Thu, Dec 19, 2019 at 10:12 PM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
> > > > >   Hi,
> > > > >
> > > > > > > However that still doesn't let the driver know which buffers =
will
> > > > > > > be
> > > > > > > dequeued when. A simple example of this scenario is when the =
guest
> > > > > > > is
> > > > > > > done displaying a frame and requeues the buffer back to the
> > > > > > > decoder.
> > > > > > > Then the decoder will not choose it for decoding next frames =
into
> > > > > > > as
> > > > > > > long as the frame in that buffer is still used as a reference
> > > > > > > frame,
> > > > > > > even if one sends the drain request.
> > > > > >
> > > > > > It might be that I'm getting your point wrong, but do you mean =
some
> > > > > > hardware can mark a buffer as ready to be displayed yet still u=
sing
> > > > > > the underlying memory to decode other frames?
> > > > >
> > > > > Yes, this is how I understand Tomasz Figa.
> > > > >
> > > > > > This means, if you occasionally/intentionally
> > > > > > write to the buffer you mess up the whole decoding pipeline.
> > > > >
> > > > > And to avoid this the buffer handling aspect must be clarified in=
 the
> > > > > specification.  Is the device allowed to continue using the buffe=
r
> > > > > after
> > > > > finishing decoding and completing the queue request?  If so, how =
do we
> > > > > hand over buffer ownership back to the driver so it can free the
> > > > > pages?
> > > > > drain request?  How do we handle re-using buffers?  Can the drive=
r
> > > > > simply re-queue them and expect the device figures by itself when=
ever
> > > > > it
> > > > > can use the buffer or whenever it is still needed as reference fr=
ame?
> > > >
> > > > The device shouldn't be able to access buffers after it completes a
> > > > queue request.
> > > > The device can touch buffer contents from when a queue request is s=
ent
> > > > until the device responds it.
> > > > In contrast, the driver must not modify buffer contents in that per=
iod.
> > > >
> > > > Regarding re-using, the driver can simply re-queue buffers returned=
 by
> > > > the device. If the device needs a buffer as reference frame, it mus=
t
> > > > not return the buffer.
> > >
> > > I think that might not be what we expect. We want the decoder to
> > > return a decoded frame as soon as possible, but that decoded frame ma=
y
> > > be also needed for decoding next frames. In V4L2 stateful decoder, th=
e
> > > API is defined that the client must not modify the decoded
> > > framebuffer, otherwise decoding next frames may not be correct.
> >
> > Thanks Tomasz! I didn't know the V4L2's convention.
> > So, the host should be able to read a frame buffer after it is
> > returned by responding RESOURCE_QUEUE command.
> >
> > > We may
> > > need something similar, with an explicit operation that makes the
> > > buffers not accessible to the host anymore. I think the queue flush
> > > operation could work as such.
> >
> > After offline discussion with Tomasz, I suspect the queue flush
> > operation (=3D VIRTIO_VIDEO_CMD_QUEUE_CLEAR) shouldn't work so, as it
> > just forces pending QUEUE requests to be backed for video seek.
> > So, a buffer can be readable from the device once it's queued until
> > STREAM_DESTROY or RESOURCE_DESTROY is called.
>
> Speaking of v4l2, drivers usually get all buffers back on stop_streaming =
 (this
> means seek(decoder), reset (encoder)). As per my understanding, this mean=
s
> that the device should not read the buffers anymore after
> stop_streaming(STREAMOFF) has been called. We can mention that after
> VIRTIO_VIDEO_CMD_QUEUE_CLEAR no device access is allowed.
>
> So:
> stop_streaming() =3D VIRTIO_VIDEO_CMD_QUEUE_CLEAR
> REQBUFS(0) =3D RESOURCE_DESTROY
>

I'm afraid this may not be enough. "drivers usually get all buffers
back on stop_streaming" is more like executing DQBUF implicitly on all
queued buffers. Unfortunately it doesn't necessarily mean releasing
the buffers. AFAICT currently the only way to guarantee that the
stateful V4L2 decoder on the host wouldn't use the buffers anymore is
to call REQBUFS(CAPTURE, 0).

Best regards,
Tomasz

> >
> > In my understanding, the life cycle of video buffers is defined as
> > this state machine.
> > https://drive.google.com/file/d/1c6oY5S_9bhpJlrOt4UfoQex0CanpG-kZ/view?=
usp=3Ds
> > haring
> >
> > ```
> > # The definition of the state machine in DOT language
> > digraph G {
> >   graph [ rankdir =3D LR, layout =3D dot ];
> >
> >   init [shape=3Dpoint]
> >   created [label=3D"created", shape=3Dcircle]
> >   dequeued [label=3D"dequeued", shape=3Dcircle]
> >   queued [label=3D"queued", shape=3Dcircle]
> >
> >   init -> created [label=3D"RESOURCE_CREATE"]
> >
> >   created -> queued [label=3D"RESOURCE_QUEUE \n is sent"]
> >   dequeued -> queued [label=3D"RESOURCE_QUEUE \n is sent"]
> >   queued -> dequeued [label=3D"RESOURCE_QUEUE \n is returned"]
> >
> >   created -> init [label=3D"DESTROY"]
> >   dequeued -> init [label=3D"DESTROY"]
> > }
> > ```
> >
> > In each state of this figure, the accessibility of each buffer should
> > be like the following:
> >
> > # Input buffers
> >  state   |   Guest    |    Host
> > -----------------------------------
> > created  | Read/Write | -
> > queued   | -          | Read
> > dequeued | Read/Write | -
> >
> > # Output buffers
> >  state   |   Guest    |    Host
> > ----------------------------------
> > created  | Read       | -
> > queued   | -          | Read/Write
> > dequeued | Read       | Read
> >
> > Does it make sense?
> > If ok, I'll have this state machine and tables in the next version of
> > spec to describe device/driver requirements by adding a subsection
> > about buffer life cycle.
> >
>
> Yes, I think this is ok.
>
> >
> > By the way, regarding destruction of buffers, I suspect it doesn't
> > make much sense to have RESOURCE_DESTROY command. Though it was
> > suggested as a per-buffer command, it doesn't match the existing V4L2
> > API, as REQBUFS(0) destroys all buffers at once. I guess per-buffer
> > destruction would require hardware or firmware supports.
> > Even if we want to destroy buffers at once, we can destroy the stream
> > and recreate one. So, I wonder if we can remove RESOURCE_DESTROY
> > command from the first version of spec at least.
> > What do you think?
>
> Stream might have a context behind it (and it in fact does), and the cont=
ents
> of that might depend on the device side implementation. For instance, the
> context can be used to keep the currently set parameters, controls and so=
 on.
> So we'd avoid destroyng streams all the time for seek, resolution change,
> reset and so on.
>
> It still makes sense to use RESOURCE_DESTROY to destroy all resources at =
once
> for one particular queue though. We can rename it to something more
> meaningful.
>
> Best regards,
> Dmitry.
>
> >
> > Best regards,
> > Keiichi
> >
> > > > I'll describe this rule in the next version of the patch.
> > > >
> > > > Best regards,
> > > > Keiichi
> > > >
> > > > > cheers,
> > > > >
> > > > >   Gerd
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

