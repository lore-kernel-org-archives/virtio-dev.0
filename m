Return-Path: virtio-dev-return-6298-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38D50985EFE
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Nov 2019 13:09:44 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 7 Nov 2019 14:09:34 +0100
Message-ID: <1573181413.STYvEGL1rf@os-lin-dmo>
In-Reply-To: <20191107095657.72dlxzm4uz7ndkek@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com> <20191107095657.72dlxzm4uz7ndkek@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, tfiga@chromium.org, keiichiw@chromium.org, acourbot@chromium.org, alexlau@chromium.org, dgreid@chromium.org, marcheu@chromium.org, posciak@chromium.org, stevensd@chromium.org, hverkuil@xs4all.nl, daniel@ffwll.ch
List-ID: <virtio-dev.lists.oasis-open.org>

Hello Gerd,

Thank you for your feedback.

There is no relationship between those. As I mentioned earlier. we have also 
been working on a virtio video device at the same time. And there is no 
relationship between the two specs.

I can point you to the differences I see:

virtio-vdec:
1. Both the device and the driver submit requests to each other. For each 
request the response is sent as a separate request.
2. No support for getting/setting video stream parameters. For example 
(decoder): output format (NV12, I420), so the driver cannot really select the 
output format after headers have been parsed.
3. No support for getting plane requirements from the device (sg vs contig, 
size, stride alignment, plane count).
4. In the vdec device Drain and Flush are not separate for each buffer queue. 
So seek and dynamic resolution change (adaptive playback) cannot be 
implemented because 'flush' can have different meaning for a resolution change 
and a seek.
5. Decoder only: new devices will be needed to support encoder, processor or 
capture. Currently input is always a bitstream, output is always a video 
frame. No way set input format (needed for encoder, see 2).

virtio-video:
1. Uses the 'driver requests - device responses' model.
2. Does not  have the logical split of bitstreams and framebuffers, has only a 
generic buffer object.
3. Generic: can support any type of video device right away due to flexibility 
of stream configuration. Both input and output buffer queues can accept 
bitstream and frame buffers and run independently. (more controls need to be 
defined for e.g. camera)
4. Supports seek, drain, dynamic resolution change using an API agnostic 
command set (no v4l2/vaapi or so on remoting).
5. Complex configuration (most likely cannot be simplified for such a complex 
device type).

Best regards,
Dmitry.

On Donnerstag, 7. November 2019 10:56:57 CET Gerd Hoffmann wrote:
> On Tue, Nov 05, 2019 at 08:19:19PM +0100, Dmitry Sepp wrote:
> > [Resend after fixing an issue with the virtio-dev mailing list]
> > 
> > This patch proposes a virtio specification for a new virtio video
> > device.
> 
> Hmm, quickly looking over this, it looks simliar to the vdec draft
> posted a few weeks ago, with other device variants added but not
> fully specified yet.
> 
> So, can you clarify the relationship between the two?
> 
> thanks,
>   Gerd



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

