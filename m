Return-Path: virtio-dev-return-7919-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA9EC9864B7
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Jan 2021 18:18:52 +0000 (UTC)
References: <20200623111325.237158-1-keiichiw@chromium.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 14 Jan 2021 17:55:39 +0000
In-reply-to: <20200623111325.237158-1-keiichiw@chromium.org>
Message-ID: <87czy7l6uu.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, saket.sinha89@gmail.com, laurent.pinchart@ideasonboard.com, nicolas@ndufresne.ca, mst@redhat.com, virtio-dev@lists.oasis-open.org, Ruchika Gupta <ruchika.gupta@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, Mike Holmes <mike.holmes@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Keiichi Watanabe <keiichiw@chromium.org> writes:

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
> * Had different structs and fields for image formats and bitstream format=
s.
> * Added more detailed specification for supported video codecs.
> * Made stream_id be allocated by the device.
> * Had a single parameter struct per-stream instead of per-queue parameter=
s and
>   controls.
> * Allowed the driver to specify the number of buffers to use via
>   "cur_{image,bitstream}_buffers".
> * Renamed RESOURCE_CREATE command to RESOURCE_ATTACH command and allow th=
e
>   driver to use this command when replacing backing memories as well.
>
> [5] is the diff of the header file from v3. Note that it only contains ch=
anges
> in the header. We haven't updated the driver nor device implementation to=
 focus
> on protocol design discussion first.
>
> While it may appear that many parts have been changed since the previous
> revision, these changes are to address the issues raised in previous disc=
ussions
> or/and to make the protocol simpler and easier to prevent misuse.
> I'd appreciate any types of feedback.
>
> Best regards,
> Keiichi
>
> [1] (full): https://drive.google.com/file/d/1DiOJZfUJ5wvFtnNFQicxt0zkp4Ob=
1o9C/view?usp=3Dsharing
> [2] (only video section): https://drive.google.com/file/d/188uAkIWE0BsXET=
ECez98y5fJKw8rslj3/view?usp=3Dsharing
> [3] https://lists.oasis-open.org/archives/virtio-comment/202003/msg00035.=
html
> [4] https://markmail.org/thread/c6h3e3zn647qli3w
> [5]
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/2164411

Hi Keiichi,

I wanted to ask what the current status of this spec was. Are you
planning to submit a new revision of the specification due or are things
fairly stable now?

We are starting to think about next steps for virtualised video as part
of Linaro's Stratos work. Specifically we are thinking about
implementing backends and getting a stack up and running which we can
use to experiment with multiple hypervisors and VM deployment
approaches.

Longer term goals included looking at how to integrate virtio-video with
a secure world on ARM (e.g. feed video data to a secure world device for
playback via virtio). As part of that we will also be looking at how to
minimise the memory profile of the backend to do this.

Looking at the virtio-spec repo it looks like the cross-device resource
sharing is now merged:

  87fa6b5 * virtio-gpu: add support for mapping/unmapping blob resources
  89e7eb5 * virtio-gpu: add resource create blob
  162578b * virtio-gpu: add the ability to export resources
  68f66ff * content: define what an exported object is

are there any other prerequisites?

From a backend implementation point of view it makes sense to wait until
there is a working frontend driver up-streamed into the kernel. I guess
that is blocked on the final call for vote on the virtio spec?

I'm sure there is scope for parallelism here but I wanted to get a sense
of the current direction before embarking on work that would require a
big re-write down the line.

Regards,

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

