Return-Path: virtio-dev-return-7518-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D182B985FFF
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Jul 2020 05:45:37 +0000 (UTC)
MIME-Version: 1.0
References: <20200623111325.237158-1-keiichiw@chromium.org>
 <2850781.lI95146Gml@os-lin-dmo> <CAD90VcbmrismAXW0t7K6M-=a2-P+OCOw8PvBr6r8S_3LNYu=pw@mail.gmail.com>
 <3163123.i8GTTo9gJ5@os-lin-dmo>
In-Reply-To: <3163123.i8GTTo9gJ5@os-lin-dmo>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 3 Jul 2020 14:45:15 +0900
Message-ID: <CAPBb6MWqYHidfaaTKq43yDtjOmKEi=AMC3O9vLdWpPBd_vFrUA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: text/plain; charset="UTF-8"
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Saket Sinha <saket.sinha89@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne <nicolas@ndufresne.ca>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dmitry,

On Thu, Jul 2, 2020 at 10:47 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
>
> Hi Keiichi,
>
> Thanks for the clarification. I believe we should explicitly describe this in
> the VIRTIO_VIDEO_CMD_RESOURCE_ATTACH section. And I also still see a problem
> there. If it is a guest allocated resource, we cannot consider it to be free
> until the device really releases it. And it won't happen until we issue the
> next ATTACH call. Also, as we discussed before, it might be not possible to
> free individual buffers, but the whole queue only.

In the case of the encoder, a V4L2 driver is not supposed to let
user-space dequeue an input frame while it is used as reference for
the encoding process. So if we add a similar rule in the virtio-video
specification, I suppose this would solve the problem?

For the decoder case, we have a bigger problem though. Since DMABUFs
can be arbitrarily attached to any V4L2 buffer ID, we may end up
re-queueing the DMABUF of a decoded frame that is still used as
reference under a different V4L2 buffer ID. In this case I don't think
the driver has a way to know that the memory resource should not be
overwritten, and it will thus happily use it as a decode target. The
easiest fix is probably to update the V4L2 stateful specification to
require that reused DMABUFs must always be assigned to the same V4L2
buffer ID, and must be kept alive as long as decoding is in progress,
or until a resolution change event is received. We can then apply a
similar rule to the virtio device.

>
> Best regards,
> Dmitry.
>
> On Donnerstag, 2. Juli 2020 14:50:58 CEST Keiichi Watanabe wrote:
> > Hi Dmitry,
> >
> > On Thu, Jul 2, 2020 at 4:32 PM Dmitry Sepp <dmitry.sepp@opensynergy.com>
> wrote:
> > > Hi Keiichi,
> > >
> > > Thank you very much for the hard work to update the spec and to summarize
> > > all of the recent proposals!
> > >
> > > I want to again raise a topic that was discussed earlier and unfortunately
> > > the latest proposal cannot resolve the problem. I hope together with
> > > upstream people we'll be able to find a neat solution.
> > >
> > > Please consider the following case:
> > > 1. Encoder case
> > > 2. User app does reqbufs with DMABUF flag.
> > > 3. User app submits frames to encode, each frame has a different fd, might
> > > be a completely new buffer.
> > > 4. Driver receives this buffer via queue() and does this check to verify
> > > whether it is a known dmabuf:
> > > https://elixir.bootlin.com/linux/v5.7.6/source/drivers/media/common/videob
> > > uf2/ videobuf2-core.c#L1163
> > > 5. When the check fails, it does cleanup.
> > > 6. BUG: As we got rid of the flexible resource detach/destroy calls, host
> > > side has no way to know the resource has a new memory region. The new sgt
> > > is never propagated to the host.
> > >
> > > The mentioned earlier
> > > CMD_RESOURE_REASSIGN_ENTRIES/CMD_RESOURE_REASSIGN_OBJECT are not included
> > > in the spec.
> >
> > This shouldn't be a problem. Though we don't have a per-resource
> > detach command, we can _replace_ attached sg-list or virtio-object by
> > calling the attach command.
> > In your scenario, if the driver notices a new dmabuf is given at 4 and
> > 5, the driver should send RESOURCE_ATTACH command with the new dmabuf.
> > Then, the old dmabuf was regarded as "detached". Please see the
> > "Buffer life cycle" section.
> >
> > I renamed RESOURCE_REASSIGN_* commands to RESOURCE_ATTACH as it's also
> > used at the first time to attach a buffer.
> >
> > Best regards,
> > Keiichi
> >
> > > Thanks in advance.
> > >
> > > Best regards,
> > > Dmitry.
> > >
> > > On Dienstag, 23. Juni 2020 13:13:24 CEST Keiichi Watanabe wrote:
> > > > This is the v4 RFC of virtio video device specification.
> > > > PDF versions are available at [1, 2].
> > > >
> > > > Note that this patch depends on a recent patchset "Cross-device resource
> > > > sharing" [3].
> > > >
> > > > Here is a list of major changes from v3:
> > > > * Redesingned struct definitions for each command and request based on
> > > >
> > > >   discussions at [4].
> > > >
> > > > * Renamed commands/structs/enums to more descriptive names.
> > > > * Had different structs and fields for image formats and bitstream
> > > > formats.
> > > > * Added more detailed specification for supported video codecs.
> > > > * Made stream_id be allocated by the device.
> > > > * Had a single parameter struct per-stream instead of per-queue
> > > > parameters
> > > > and controls.
> > > > * Allowed the driver to specify the number of buffers to use via
> > > >
> > > >   "cur_{image,bitstream}_buffers".
> > > >
> > > > * Renamed RESOURCE_CREATE command to RESOURCE_ATTACH command and allow
> > > > the
> > > >
> > > >   driver to use this command when replacing backing memories as well.
> > > >
> > > > [5] is the diff of the header file from v3. Note that it only contains
> > > > changes in the header. We haven't updated the driver nor device
> > > > implementation to focus on protocol design discussion first.
> > > >
> > > > While it may appear that many parts have been changed since the previous
> > > > revision, these changes are to address the issues raised in previous
> > > > discussions or/and to make the protocol simpler and easier to prevent
> > > > misuse.
> > > > I'd appreciate any types of feedback.
> > > >
> > > > Best regards,
> > > > Keiichi
> > > >
> > > > [1] (full):
> > > > https://drive.google.com/file/d/1DiOJZfUJ5wvFtnNFQicxt0zkp4Ob1o9C/view?u
> > > > sp=
> > > > sharing [2] (only video section):
> > > > https://drive.google.com/file/d/188uAkIWE0BsXETECez98y5fJKw8rslj3/view?u
> > > > sp=
> > > > sharing [3]
> > > > https://lists.oasis-open.org/archives/virtio-comment/202003/msg00035.htm
> > > > l
> > > > [4] https://markmail.org/thread/c6h3e3zn647qli3w
> > > > [5]
> > > > https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel
> > > > /+/
> > > > 2164411
> > > >
> > > > Keiichi Watanabe (1):
> > > >   virtio-video: Add virtio video device specification
> > > >
> > > >  .gitignore                        |    1 +
> > > >  content.tex                       |    1 +
> > > >  images/video-buffer-lifecycle.dot |   18 +
> > > >  make-setup-generated.sh           |    8 +
> > > >  virtio-video.tex                  | 1163 +++++++++++++++++++++++++++++
> > > >  5 files changed, 1191 insertions(+)
> > > >  create mode 100644 .gitignore
> > > >  create mode 100644 images/video-buffer-lifecycle.dot
> > > >  create mode 100644 virtio-video.tex
> > > >
> > > > --
> > > > 2.27.0.111.gc72c7da667-goog
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

