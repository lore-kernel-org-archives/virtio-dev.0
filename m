Return-Path: virtio-dev-return-6538-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25F64985F3C
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Dec 2019 09:26:43 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 19 Dec 2019 10:26:37 +0100
Message-ID: <2570078.xtWa8k4VtA@os-lin-dmo>
In-Reply-To: <20191218134037.3jbouht52bxqwfyy@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org> <20191218130214.170703-2-keiichiw@chromium.org> <20191218134037.3jbouht52bxqwfyy@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,

On Mittwoch, 18. Dezember 2019 14:40:37 CET Gerd Hoffmann wrote:
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
No, then it means the device was not in drain, but, for example, hit a 
resolution change in the stream and tells us that this is the last buffer with 
the old resolution.

> 
> I also can't see why the flag is needed in the first place.  The driver
> should know which buffers are queued still and be able to figure
> whenever the drain is complete or not without depending on that flag.
> So I'd suggest to simply drop it.
This flag is used not for drain only. In marks the completion of whatever 
specific buffer sequence, like a full end-of-stream, resolution change, drain 
etc. We also need this to handle nested sequences. For instance, a resolution 
change event might happen while in drain.

Regards,
Dmitry.

> 
> That is the only issue I've spotted in the protocol on a first quick
> look.  There are a few places where the spec text could be improved.
> I'll try to set aside some time to go over this in detail, but I can't
> promise I'll find the time to do that before xmas and new year.
> 
> cheers,
>   Gerd



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

