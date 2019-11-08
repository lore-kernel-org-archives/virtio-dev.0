Return-Path: virtio-dev-return-6307-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A050D985F34
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Nov 2019 09:51:46 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Fri, 8 Nov 2019 10:51:41 +0100
Message-ID: <2495905.H3tntR4Av4@os-lin-dmo>
In-Reply-To: <20191108074955.t7mtqks4dfmrdzod@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com> <1573181413.STYvEGL1rf@os-lin-dmo> <20191108074955.t7mtqks4dfmrdzod@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, tfiga@chromium.org, keiichiw@chromium.org, acourbot@chromium.org, alexlau@chromium.org, dgreid@chromium.org, marcheu@chromium.org, posciak@chromium.org, stevensd@chromium.org, hverkuil@xs4all.nl, daniel@ffwll.ch
List-ID: <virtio-dev.lists.oasis-open.org>

Hello Gerd,

Please see the answer below.

On Freitag, 8. November 2019 08:49:55 CET Gerd Hoffmann wrote:
> On Thu, Nov 07, 2019 at 02:09:34PM +0100, Dmitry Sepp wrote:
> > Hello Gerd,
> > 
> > Thank you for your feedback.
> > 
> > There is no relationship between those. As I mentioned earlier. we have
> > also been working on a virtio video device at the same time. And there is
> > no relationship between the two specs.
> 
> Keiichi, have you looked at the spec?
> 
> I think it is useful to have a single device specification for all video
> functions given that there is a bunch of common stuff.  Both encoder and
> decoder must negotiate video frame and video stream parameters for
> example.  Also the virtio-video spec looks like a superset of
> virtio-vdec.
> 
> Is there any important feature in video-vdec which is missing in
> virtio-video?
> 
> > virtio-video:
> > 1. Uses the 'driver requests - device responses' model.
> > 2. Does not  have the logical split of bitstreams and framebuffers, has
> > only a generic buffer object.
> 
> Can you give a quick summary on buffer object management?
Buffer objects are implemented in a similar way to how it was done for virtio-
gpu. The driver allocates a resource (descriptor) on the device.  Than the 
driver allocates/imports backing pages and attaches those to the resource.

When a buffer is ready for processing from the driver's point of view, the 
driver queues it to the device (please see struct 
virtio_video_resource_queue). Within this structure the driver provides 
required metadata (number of data bytes in the buffer, timestamp/counter and so 
on).

The nice thing about this is that there is no real decode or encode requests. 
The device just fetches the buffer from the input queue, applies some 
transformation according to its function and settings, fetches an output buffer 
from the respective queue, and stores the result in the output buffer (or -s, 
if needed).

The device keeps buffer requests until the respective buffer has been processed 
(i.e. input is consumed or output is written). When the buffer is not needed 
anymore, the virtio_video_resource_queue request completes asynchronously. 
This also makes it possible to easily handle different frame types that are 
decoded out-of-order.

Regards,
Dmitry.

> 
> thanks,
>   Gerd



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

