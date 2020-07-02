Return-Path: virtio-dev-return-7515-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D958985A9F
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Jul 2020 07:32:14 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 2 Jul 2020 09:32:05 +0200
Message-ID: <2850781.lI95146Gml@os-lin-dmo>
In-Reply-To: <20200623111325.237158-1-keiichiw@chromium.org>
References: <20200623111325.237158-1-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>
Cc: linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, saket.sinha89@gmail.com, laurent.pinchart@ideasonboard.com, nicolas@ndufresne.ca, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

Thank you very much for the hard work to update the spec and to summarize all 
of the recent proposals!

I want to again raise a topic that was discussed earlier and unfortunately the 
latest proposal cannot resolve the problem. I hope together with upstream 
people we'll be able to find a neat solution.

Please consider the following case:
1. Encoder case
2. User app does reqbufs with DMABUF flag.
3. User app submits frames to encode, each frame has a different fd, might be a 
completely new buffer.
4. Driver receives this buffer via queue() and does this check to verify 
whether it is a known dmabuf:
https://elixir.bootlin.com/linux/v5.7.6/source/drivers/media/common/videobuf2/
videobuf2-core.c#L1163
5. When the check fails, it does cleanup.
6. BUG: As we got rid of the flexible resource detach/destroy calls, host side 
has no way to know the resource has a new memory region. The new sgt is never 
propagated to the host.

The mentioned earlier CMD_RESOURE_REASSIGN_ENTRIES/CMD_RESOURE_REASSIGN_OBJECT 
are not included in the spec.

Thanks in advance.

Best regards,
Dmitry.

On Dienstag, 23. Juni 2020 13:13:24 CEST Keiichi Watanabe wrote:
> 
> This is the v4 RFC of virtio video device specification.
> PDF versions are available at [1, 2].
> 
> Note that this patch depends on a recent patchset "Cross-device resource
> sharing" [3].
> 
> Here is a list of major changes from v3:
> * Redesingned struct definitions for each command and request based on
>   discussions at [4].
> * Renamed commands/structs/enums to more descriptive names.
> * Had different structs and fields for image formats and bitstream formats.
> * Added more detailed specification for supported video codecs.
> * Made stream_id be allocated by the device.
> * Had a single parameter struct per-stream instead of per-queue parameters
> and controls.
> * Allowed the driver to specify the number of buffers to use via
>   "cur_{image,bitstream}_buffers".
> * Renamed RESOURCE_CREATE command to RESOURCE_ATTACH command and allow the
>   driver to use this command when replacing backing memories as well.
> 
> [5] is the diff of the header file from v3. Note that it only contains
> changes in the header. We haven't updated the driver nor device
> implementation to focus on protocol design discussion first.
> 
> While it may appear that many parts have been changed since the previous
> revision, these changes are to address the issues raised in previous
> discussions or/and to make the protocol simpler and easier to prevent
> misuse.
> I'd appreciate any types of feedback.
> 
> Best regards,
> Keiichi
> 
> [1] (full):
> https://drive.google.com/file/d/1DiOJZfUJ5wvFtnNFQicxt0zkp4Ob1o9C/view?usp=
> sharing [2] (only video section):
> https://drive.google.com/file/d/188uAkIWE0BsXETECez98y5fJKw8rslj3/view?usp=
> sharing [3]
> https://lists.oasis-open.org/archives/virtio-comment/202003/msg00035.html
> [4] https://markmail.org/thread/c6h3e3zn647qli3w
> [5]
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/
> 2164411
> 
> Keiichi Watanabe (1):
>   virtio-video: Add virtio video device specification
> 
>  .gitignore                        |    1 +
>  content.tex                       |    1 +
>  images/video-buffer-lifecycle.dot |   18 +
>  make-setup-generated.sh           |    8 +
>  virtio-video.tex                  | 1163 +++++++++++++++++++++++++++++
>  5 files changed, 1191 insertions(+)
>  create mode 100644 .gitignore
>  create mode 100644 images/video-buffer-lifecycle.dot
>  create mode 100644 virtio-video.tex
> 
> --
> 2.27.0.111.gc72c7da667-goog



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

