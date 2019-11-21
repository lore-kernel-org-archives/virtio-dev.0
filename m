Return-Path: virtio-dev-return-6363-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19B1F985E91
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Nov 2019 10:55:04 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 21 Nov 2019 11:54:57 +0100
Message-ID: <7736193.Whgddqjo8n@os-lin-dmo>
In-Reply-To: <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com> <CAD90Vcbr7L2KsyDxPeoKPRt6y_ai8xkJ=J0JCGsW6tGZJGH=0A@mail.gmail.com> <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: virtio-dev@lists.oasis-open.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Linux Media
 Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,

On Mittwoch, 20. November 2019 12:29:29 CET Gerd Hoffmann wrote:
>   Hi,
> 
> > > > > 3. No support for getting plane requirements from the device (sg vs
> > > > > contig,
> > > > > size, stride alignment, plane count).
> > > > 
> > > > There is actually a bigger difference that results in that. Vdec
> > > > assumes host-allocated buffers coming from a different device, e.g.
> > > > virtio-gpu and the host having the right knowledge to allocate the
> > > > buffers correctly. This is related to the fact that it's generally
> > > > difficult to convey all the allocation constraints in a generic
> > > > manner.
> > > 
> > > Yep, buffer handling is tricky, especially when it comes to decoding
> > > directly to gpu buffers and also when supporting playback of
> > > drm-protected streams where the guest might not be allowed to access
> > > the stream data.
> > 
> > Also, if we decide to have a buffer sharing device as Gerd suggested
> > in a different thread,
> > we'll get less overlaps between video codec feature and camera feature.
> > e.g. VIRTIO_VIDEO_T_RESOURCE_* would be simplified. (or removed?)
> 
> Disclaimer: Havn't found the time yet to go over both virtio-video and
> virtio-vdec in detail.
> 
> > As Tomasz said, I think virtio-vdec can be modified to support
> > encoding as well without big changes.  I'm happy to update our
> > protocol and driver implementation to support encoding if needed.
> 
> I think it makes sense to have a rough plan first ;)
> Is there a virtio-video implementation too?
Yes, of course. We will be ready to share the code very soon.

Regards,
Dmitry.

> 
> When it comes to buffer handling:  I don't like that virtio-vdec depends
> on virtio-gpu for buffer handling.  Allowing sharing buffers between
> virtio-vdec and virtio-gpu (and possibly other devices) makes sense as
> an optional extension.  But IMO the encoder/decoder device should be
> able to operate as stand-alone device.
> 
> cheers,
>   Gerd
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

