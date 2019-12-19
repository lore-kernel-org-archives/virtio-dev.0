Return-Path: virtio-dev-return-6544-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11551985F41
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Dec 2019 12:06:50 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <3550989.gzE5nMqd4t@os-lin-dmo> <CAAFQd5BgkEUwBFWdv2ZH98egjm=u0dBRgtexqkzjES+J1SEmag@mail.gmail.com>
 <3878267.TzG3DlCiay@os-lin-dmo>
In-Reply-To: <3878267.TzG3DlCiay@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 19 Dec 2019 21:05:56 +0900
Message-ID: <CAAFQd5Bs5Aerr++gc=D_nyHu4KaWw6RfW-TXHRGEjVaf2dTx2Q@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video
 device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, fziglio@redhat.com, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 19, 2019 at 7:55 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> w=
rote:
>
> Hi Tomasz,
>
> On Donnerstag, 19. Dezember 2019 10:59:02 CET Tomasz Figa wrote:
> > On Thu, Dec 19, 2019 at 6:48 PM Dmitry Sepp <dmitry.sepp@opensynergy.co=
m>
> wrote:
> > > Hi,
> > >
> > > On Donnerstag, 19. Dezember 2019 08:46:39 CET Gerd Hoffmann wrote:
> > > > On Wed, Dec 18, 2019 at 11:08:37PM +0900, Tomasz Figa wrote:
> > > > > On Wed, Dec 18, 2019 at 10:40 PM Gerd Hoffmann <kraxel@redhat.com=
>
> wrote:
> > > > > >   Hi,
> > > > > >
> > > > > > > +The device MUST mark the last buffer with the
> > > > > > > +VIRTIO_VIDEO_BUFFER_F_EOS flag to denote completion of the d=
rain
> > > > > > > +sequence.
> > > > > >
> > > > > > No, that would build a race condition into the protocol.  The d=
evice
> > > > > > could complete the last buffer after the driver has sent the dr=
ain
> > > > > > command but before the device saw it.  So the flag would not be
> > > > > > reliable.
> > > > > >
> > > > > > I also can't see why the flag is needed in the first place.  Th=
e
> > > > > > driver
> > > > > > should know which buffers are queued still and be able to figur=
e
> > > > > > whenever the drain is complete or not without depending on that
> > > > > > flag.
> > > > > > So I'd suggest to simply drop it.
> > > > >
> > > > > Unfortunately video decoders are not that simple. There are alway=
s
> > > > > going to be some buffers on the decoder side used as reference fr=
ames.
> > > > > Only the decoder knows when to release them, as it continues deco=
ding
> > > > > the stream.
> > > >
> > > > Not clearly defined in the spec:  When is the decoder supposed to s=
end
> > > > the response for a queue request?  When it finished decoding (i.e. =
frame
> > > > is ready for playback), or when it doesn't need the buffer any more=
 for
> > > > decoding (i.e. buffer can be re-queued or pages can be released)?
> > >
> > > In my eyes the both statements mean almost the same and both are vali=
d. I
> > > think whatever underlying libraries are used for decoding on the devi=
ce
> > > side, they simply won't return us the buffer as long as the HW device
> > > needs them to continue its normal operation. So your first sentence
> > > applies to output buffers, the second - to input buffers.
> > >
> > > My understanding is as follows: we send the response for a queue requ=
est
> > > as
> > > soon as the HW device on the host side passes the buffer ownership ba=
ck to
> > > the client (like when VIDIOC_DQBUF has returned a buffer).
> >
> > That's how it's defined in V4L2 and what makes the most sense from the
> > video decoding point of view, as one wants to display frames as soon
> > as they are available.
> >
> > However that still doesn't let the driver know which buffers will be
> > dequeued when. A simple example of this scenario is when the guest is
> > done displaying a frame and requeues the buffer back to the decoder.
> > Then the decoder will not choose it for decoding next frames into as
> > long as the frame in that buffer is still used as a reference frame,
> > even if one sends the drain request.
> It might be that I'm getting your point wrong, but do you mean some hardw=
are
> can mark a buffer as ready to be displayed yet still using the underlying
> memory to decode other frames? This means, if you occasionally/intentiona=
lly
> write to the buffer you mess up the whole decoding pipeline. That would b=
e
> strange at least...

That's correct. It depends on the hardware, but in principle we don't
want to copy the frames decoded to temporary buffers for using them as
reference frames, as that would waste bandwidth and increase latency.
The contract between the kernel and the application is that it must
not write to the frame buffers if it wants to get correct decoding
results. But after all, I don't see a reason why the application would
write to those buffers.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

