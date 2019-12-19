Return-Path: virtio-dev-return-6541-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A1BC985F3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Dec 2019 10:00:15 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <20191218130214.170703-2-keiichiw@chromium.org> <20191218134037.3jbouht52bxqwfyy@sirius.home.kraxel.org>
 <2570078.xtWa8k4VtA@os-lin-dmo>
In-Reply-To: <2570078.xtWa8k4VtA@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 19 Dec 2019 18:59:59 +0900
Message-ID: <CAAFQd5CVkcQmMt=H74E4uHE26jidTfg2neJ6sYGKRa9XRxYxwQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, fziglio@redhat.com, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 19, 2019 at 6:26 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> w=
rote:
>
> Hi Gerd,
>
> On Mittwoch, 18. Dezember 2019 14:40:37 CET Gerd Hoffmann wrote:
> >   Hi,
> >
> > > +The device MUST mark the last buffer with the
> > > +VIRTIO_VIDEO_BUFFER_F_EOS flag to denote completion of the drain
> > > +sequence.
> >
> > No, that would build a race condition into the protocol.  The device
> > could complete the last buffer after the driver has sent the drain
> > command but before the device saw it.  So the flag would not be
> > reliable.
> No, then it means the device was not in drain, but, for example, hit a
> resolution change in the stream and tells us that this is the last buffer=
 with
> the old resolution.
>
> >
> > I also can't see why the flag is needed in the first place.  The driver
> > should know which buffers are queued still and be able to figure
> > whenever the drain is complete or not without depending on that flag.
> > So I'd suggest to simply drop it.
> This flag is used not for drain only. In marks the completion of whatever
> specific buffer sequence, like a full end-of-stream, resolution change, d=
rain
> etc. We also need this to handle nested sequences. For instance, a resolu=
tion
> change event might happen while in drain.

Good point. The resolution change event is in a different virtqueue,
so it's not serialized with the request completions.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

