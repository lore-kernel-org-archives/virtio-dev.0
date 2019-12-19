Return-Path: virtio-dev-return-6539-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44D7E985F3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Dec 2019 09:48:22 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 19 Dec 2019 10:48:15 +0100
Message-ID: <3550989.gzE5nMqd4t@os-lin-dmo>
In-Reply-To: <20191219074639.kdkrqxwb6fdb67hu@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org> <CAAFQd5AEJ0sUzqrXJAmFnBn0aU8Ef6FwXYo0LgK0NO_CdWXRVg@mail.gmail.com> <20191219074639.kdkrqxwb6fdb67hu@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media
 Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, fziglio@redhat.com, Hans Verkuil <hverkuil@xs4all.nl>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Donnerstag, 19. Dezember 2019 08:46:39 CET Gerd Hoffmann wrote:
> On Wed, Dec 18, 2019 at 11:08:37PM +0900, Tomasz Figa wrote:
> > On Wed, Dec 18, 2019 at 10:40 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >   Hi,
> > >   
> > > > +The device MUST mark the last buffer with the
> > > > +VIRTIO_VIDEO_BUFFER_F_EOS flag to denote completion of the drain
> > > > +sequence.
> > > 
> > > No, that would build a race condition into the protocol.  The device
> > > could complete the last buffer after the driver has sent the drain
> > > command but before the device saw it.  So the flag would not be
> > > reliable.
> > > 
> > > I also can't see why the flag is needed in the first place.  The driver
> > > should know which buffers are queued still and be able to figure
> > > whenever the drain is complete or not without depending on that flag.
> > > So I'd suggest to simply drop it.
> > 
> > Unfortunately video decoders are not that simple. There are always
> > going to be some buffers on the decoder side used as reference frames.
> > Only the decoder knows when to release them, as it continues decoding
> > the stream.
> 
> Not clearly defined in the spec:  When is the decoder supposed to send
> the response for a queue request?  When it finished decoding (i.e. frame
> is ready for playback), or when it doesn't need the buffer any more for
> decoding (i.e. buffer can be re-queued or pages can be released)?
In my eyes the both statements mean almost the same and both are valid. I 
think whatever underlying libraries are used for decoding on the device side, 
they simply won't return us the buffer as long as the HW device needs them to 
continue its normal operation. So your first sentence applies to output buffers, 
the second - to input buffers.

My understanding is as follows: we send the response for a queue request as 
soon as the HW device on the host side passes the buffer ownership back to the 
client (like when VIDIOC_DQBUF has returned a buffer).

Thanks for reviewing!

Regards,
Dmitry.

> 
> > How we defined this in the V4L2 stateful decoder interface is that if
> > the decoder happened to return the last framebuffer before the drain
> > request arrived, it would return one more, empty.
> 
> Ok.  That is not clear from the spec.  I've read the drain request as as
> "please stop decoding and complete all queue requests which are in the
> virtqueue, even when you didn't process them yet".  In which case
> completing the last pending queue request would clearly indicate the
> draining request is complete.  Also completing the drain request should
> only happen when the operation is finished.
> 
> I think the various states a buffer can have and how queuing & deciding
> & draining changes these states should be clarified in the
> specification.
> 
> cheers,
>   Gerd



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

