Return-Path: virtio-dev-return-7519-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65CDE985FFF
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Jul 2020 09:18:31 +0000 (UTC)
Date: Fri, 3 Jul 2020 05:18:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200703051756-mutt-send-email-mst@kernel.org>
References: <20200623111325.237158-1-keiichiw@chromium.org>
 <2850781.lI95146Gml@os-lin-dmo>
 <CAD90VcbmrismAXW0t7K6M-=a2-P+OCOw8PvBr6r8S_3LNYu=pw@mail.gmail.com>
 <3163123.i8GTTo9gJ5@os-lin-dmo>
 <CAPBb6MWqYHidfaaTKq43yDtjOmKEi=AMC3O9vLdWpPBd_vFrUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPBb6MWqYHidfaaTKq43yDtjOmKEi=AMC3O9vLdWpPBd_vFrUA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Saket Sinha <saket.sinha89@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne <nicolas@ndufresne.ca>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 03, 2020 at 02:45:15PM +0900, Alexandre Courbot wrote:
> Hi Dmitry,
> 
> On Thu, Jul 2, 2020 at 10:47 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
> >
> > Hi Keiichi,
> >
> > Thanks for the clarification. I believe we should explicitly describe this in
> > the VIRTIO_VIDEO_CMD_RESOURCE_ATTACH section. And I also still see a problem
> > there. If it is a guest allocated resource, we cannot consider it to be free
> > until the device really releases it. And it won't happen until we issue the
> > next ATTACH call. Also, as we discussed before, it might be not possible to
> > free individual buffers, but the whole queue only.
> 
> In the case of the encoder, a V4L2 driver is not supposed to let
> user-space dequeue an input frame while it is used as reference for
> the encoding process. So if we add a similar rule in the virtio-video
> specification, I suppose this would solve the problem?
> 
> For the decoder case, we have a bigger problem though. Since DMABUFs
> can be arbitrarily attached to any V4L2 buffer ID, we may end up
> re-queueing the DMABUF of a decoded frame that is still used as
> reference under a different V4L2 buffer ID. In this case I don't think
> the driver has a way to know that the memory resource should not be
> overwritten, and it will thus happily use it as a decode target. The
> easiest fix is probably to update the V4L2 stateful specification to
> require that reused DMABUFs must always be assigned to the same V4L2
> buffer ID, and must be kept alive as long as decoding is in progress,
> or until a resolution change event is received. We can then apply a
> similar rule to the virtio device.


Sounds like a generic kind of problem - how do other devices solve it?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

