Return-Path: virtio-dev-return-7521-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89770986005
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Jul 2020 10:03:55 +0000 (UTC)
MIME-Version: 1.0
References: <20200623111325.237158-1-keiichiw@chromium.org>
 <2850781.lI95146Gml@os-lin-dmo> <CAD90VcbmrismAXW0t7K6M-=a2-P+OCOw8PvBr6r8S_3LNYu=pw@mail.gmail.com>
 <3163123.i8GTTo9gJ5@os-lin-dmo> <CAPBb6MWqYHidfaaTKq43yDtjOmKEi=AMC3O9vLdWpPBd_vFrUA@mail.gmail.com>
 <20200703051756-mutt-send-email-mst@kernel.org> <CAPBb6MXju_cc3FdWF60Ndx6aYfHmaGbQxu2a3QMxTfnLrXJxYQ@mail.gmail.com>
In-Reply-To: <CAPBb6MXju_cc3FdWF60Ndx6aYfHmaGbQxu2a3QMxTfnLrXJxYQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 3 Jul 2020 11:55:29 +0200
Message-ID: <CAAFQd5CQuDgvZrYC53yKEYBY1LOX2QO8+7eRAscN5wQFmHmkZQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: text/plain; charset="UTF-8"
To: Alexandre Courbot <acourbot@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Saket Sinha <saket.sinha89@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne <nicolas@ndufresne.ca>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 3, 2020 at 11:27 AM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> On Fri, Jul 3, 2020 at 6:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 03, 2020 at 02:45:15PM +0900, Alexandre Courbot wrote:
> > > Hi Dmitry,
> > >
> > > On Thu, Jul 2, 2020 at 10:47 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
> > > >
> > > > Hi Keiichi,
> > > >
> > > > Thanks for the clarification. I believe we should explicitly describe this in
> > > > the VIRTIO_VIDEO_CMD_RESOURCE_ATTACH section. And I also still see a problem
> > > > there. If it is a guest allocated resource, we cannot consider it to be free
> > > > until the device really releases it. And it won't happen until we issue the
> > > > next ATTACH call. Also, as we discussed before, it might be not possible to
> > > > free individual buffers, but the whole queue only.
> > >
> > > In the case of the encoder, a V4L2 driver is not supposed to let
> > > user-space dequeue an input frame while it is used as reference for
> > > the encoding process. So if we add a similar rule in the virtio-video
> > > specification, I suppose this would solve the problem?
> > >
> > > For the decoder case, we have a bigger problem though. Since DMABUFs
> > > can be arbitrarily attached to any V4L2 buffer ID, we may end up
> > > re-queueing the DMABUF of a decoded frame that is still used as
> > > reference under a different V4L2 buffer ID. In this case I don't think
> > > the driver has a way to know that the memory resource should not be
> > > overwritten, and it will thus happily use it as a decode target. The
> > > easiest fix is probably to update the V4L2 stateful specification to
> > > require that reused DMABUFs must always be assigned to the same V4L2
> > > buffer ID, and must be kept alive as long as decoding is in progress,
> > > or until a resolution change event is received. We can then apply a
> > > similar rule to the virtio device.
> >
> >
> > Sounds like a generic kind of problem - how do other devices solve it?
>
> Most users of V4L2 drivers use MMAP buffers, which don't suffer from
> this problem: since MMAP buffers are managed by V4L2 and the same V4L2
> buffer ID always corresponds to the same backing memory, the driver
> just needs to refrain from decoding into a given V4L2 buffer as long
> as it is used as a reference frames. This is something that all
> drivers currently do AFAICT.
>
> The problem only occurs if you let userspace map anything to V4L2
> buffers (USERPTR or DMABUF buffers). In order to guarantee the same
> reliable behavior as with MMAP buffers, you must enforce the same
> rule: always the same backing memory for a given V4L2 buffer.
>
> ... or you can rotate between a large enough number of buffers to
> leave enough space for the reference tag to expire on your frames, but
> that's clearly not a good way to address the problem.

FWIW, it's typically solved with regular devices by completely
disallowing the DMABUF/USERPTR modes and only allowing the
V4L2-managed MMAP mode for affected buffer queues.

However, that's quite a severe limitation and with a careful API
extension, DMABUF could be still handled. Namely:
 - pre-registration of buffers at initialization time: that would
likely mean mandating VIDIOC_QBUF for all indexes before any
decoding/encoding can start,
 - enforcement of index-buffer mapping: VIDIOC_QBUF would have to fail
if one attempts to queue another buffer at the same index,
 - ability to explicitly release existing buffers: there is
VIDIOC_RELEASE_BUF in the works which could be used to release a
specific index,
 - ability to explicitly add new buffers: a combination of
VIDIOC_CREATEBUFS + VIDIOC_QBUF could be already used to achieve this.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

