Return-Path: virtio-dev-return-6248-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BCAC986005
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 08:06:22 +0000 (UTC)
MIME-Version: 1.0
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <12599990.jpbsygJuY9@os-lin-dmo> <20191015075422.yeknnqlsy3nun44r@sirius.home.kraxel.org>
 <9670471.GKRsIjc3Fr@os-lin-dmo>
In-Reply-To: <9670471.GKRsIjc3Fr@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 17 Oct 2019 17:06:06 +0900
Message-ID: <CAAFQd5D_dq6HyXfAYCG9dhuRg6onrJDoecXqf0As+e91wpVzfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Dmitry Morozov <dmitry.morozov@opensynergy.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 15, 2019 at 11:06 PM Dmitry Morozov
<dmitry.morozov@opensynergy.com> wrote:
>
> Hello Gerd,
>
> On Dienstag, 15. Oktober 2019 09:54:22 CEST Gerd Hoffmann wrote:
> > On Mon, Oct 14, 2019 at 03:05:03PM +0200, Dmitry Morozov wrote:
> > > On Montag, 14. Oktober 2019 14:34:43 CEST Gerd Hoffmann wrote:
> > > >   Hi,
> > > >
> > > > > My take on this (for a decoder) would be to allocate memory for output
> > > > > buffers from a secure ION heap, import in the v4l2 driver, and then to
> > > > > provide those to the device using virtio. The device side then uses
> > > > > the
> > > > > dmabuf framework to make the buffers accessible for the hardware. I'm
> > > > > not
> > > > > sure about that, it's just an idea.
> > > >
> > > > Virtualization aside, how does the complete video decoding workflow
> > > > work?  I assume along the lines of ...
> > > >
> > > >   (1) allocate buffer for decoded video frames (from ion).
> > > >   (2) export those buffers as dma-buf.
> > > >   (3) import dma-buf to video decoder.
> > > >   (4) import dma-buf to gpu.
> > > >
> > > > ... to establish buffers shared between video decoder and gpu?
> > > >
> > > > Then feed the video stream into the decoder, which decodes into the ion
> > > > buffers?  Ask the gpu to scanout the ion buffers to show the video?
> > > >
> > > > cheers,
> > > >
> > > >   Gerd
> > >
> > > Yes, exactly.
> > >
> > > [decoder]
> > > 1) Input buffers are allocated using  VIDIOC_*BUFS.
> >
> > Ok.
> >
> > > 2) Output buffers are allocated in a guest specific manner (ION, gbm).
> >
> > Who decides whenever ION or gbm is used?  The phrase "secure ION heap"
> > used above sounds like using ION is required for decoding drm-protected
> > content.
>
> I mention the secure ION heap to address this Chrome OS related point:
> > 3) protected content decoding: the memory for decoded video frames
> > must not be accessible to the guest at all
>
> There was an RFC to implement a secure memory allocation framework, but
> apparently it was not accepted: https://lwn.net/Articles/661549/.
>
> In case of Android, it allocates GPU buffers for output frames, so it is the
> gralloc implementation who decides how to allocate memory. It can use some
> dedicated ION heap or can use libgbm. It can also be some proprietary
> implementation.
>
> >
> > So, do we have to worry about ION here?  Or can we just use gbm?
>
> If we replace vendor specific code in the Android guest and provide a way to
> communicate meatdata for buffer allocations from the device to the driver, we
> can use gbm. In the PC world it might be easier.
>
> >
> > [ Note: don't know much about ion, other than that it is used by
> >         android, is in staging right now and patches to move it
> >         out of staging are floating around @ dri-devel ]

Chrome OS has cros_gralloc, which is an open source implementation of
gralloc on top of minigbm (which itself is built on top of the Linux
DRM interfaces). It's not limited to Chrome OS and I believe Intel
also uses it for their native Android setups. With that, we could
completely disregard ION, but I feel like it's not a core problem
here. Whoever wants to use ION should be still able to do so if they
back the allocations with guest pages or memory coming from the host
using some other interface and it can be described using an identifier
compatible with what we're discussing here.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

