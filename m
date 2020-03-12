Return-Path: virtio-dev-return-6938-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34A20985FDD
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Mar 2020 10:11:14 +0000 (UTC)
MIME-Version: 1.0
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com>
 <c4d7622b-e396-3920-0e14-5a73a0225c0f@xs4all.nl> <CAD90VcZUqU0nVQEn1vNOQkcicR5GA+HzBGd+M7O_b69f2BCUxA@mail.gmail.com>
 <1ac18708-262f-c751-d955-267931270028@xs4all.nl>
In-Reply-To: <1ac18708-262f-c751-d955-267931270028@xs4all.nl>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Thu, 12 Mar 2020 19:11:00 +0900
Message-ID: <CAD90VcbZJ=mMZ_QyLrwkYEM3z_+b43vPSytnw-+x9tvQ+2ZoBQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 0/1] Virtio Video V4L2 driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 12, 2020 at 6:54 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 3/12/20 10:49 AM, Keiichi Watanabe wrote:
> > Hi Hans,
> >
> > On Wed, Mar 11, 2020 at 10:26 PM Hans Verkuil <hverkuil@xs4all.nl> wrot=
e:
> >>
> >> Hi Dmitry,
> >>
> >> On 2/18/20 9:27 PM, Dmitry Sepp wrote:
> >>> Hi all,
> >>>
> >>> This is a v4l2 virtio video driver for the virtio-video device
> >>> specification v3 [1].
> >>>
> >>> The first version of the driver was introduced here [2].
> >>>
> >>> Changes v1 -> v2:
> >>> * support the v3 spec (mostly)
> >>> * add a module parameter to ask for pages from ZONE_DMA
> >>>
> >>> What is not implemented:
> >>> * Plane layout flags should be used to propagate number of planes to
> >>>   user-space
> >>> * There is no real use of stream creation with bitstream format in th=
e
> >>>   parameter list. The driver just uses the first bitstream format fro=
m
> >>>   the list.
> >>> * Setting bitrate is done in a different way compared to the spec. Th=
is
> >>>   is because it has been already agreed on that the way the spec
> >>>   currently describes it requires changes.
> >>>
> >>> Potential improvements:
> >>> * Do not send stream_create from open. Use corresponding state machin=
e
> >>>   condition to do this.
> >>> * Do not send stream_destroy from close. Do it in reqbufs(0).
> >>> * Cache format and control settings. Reduce calls to the device.
> >>
> >> Some general notes:
> >>
> >> Before this can be merged it needs to pass v4l2-compliance.
> >>
> >> I also strongly recommend adding support for V4L2_PIX_FMT_FWHT to
> >> allow testing with the vicodec emulation driver. This will also
> >> allow testing all sorts of corner cases without requiring special
> >> hardware.
> >
> > I agree that it's great if we could test virtio-video with vicodec,
> > but I wonder if supporting FWHT is actually needed for the initial
> > patch.
> > Though it wouldn't be difficult to support FWHT in the driver, we also
> > needs to support it in the host's hypervisor to test it. It's not easy
> > for our hypervisor to support FWHT, as it doesn't talk to v4l2 driver
> > directly.
> > Without the host-side implementation, it makes no sense to support it.
> > Also, if we support FWHT, we should have the format in a list of
> > supported formats in the virtio specification. However, I'm not sure
> > if FWHT is a general codec enough to be added in the spec, which
> > shouldn't be specific to Linux.
>
> Good point, I didn't know that.
>
> Is it possible to add support for FWHT under a linux debug/test option?

It'd be possible to support FWHT as a Linux's local extension of
virtio-video protocol.
However, in order to use the option, someone still needs to implement
a host-side virtual device that talks to vicodec in a hypervisor.
e.g. Implement a virtual video device in QEMU that talks to the host's
vicodec device.

Our virtual video device in ChromeOS's hypervisor (crosvm) talks to a
HAL in Chrome instead of talking to v4l2 stateful device directly.
So, our hypervisor cannot support FWHT as is.

Best regards,
Keiichi


>
> It's really the main reason for having this, since you would never use
> this in production code. But it is so nice to have for regression testing=
.
>
> Regards,
>
>         Hans
>
> >
> > Best regards,
> > Keiichi
> >
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>>
> >>> Best regards,
> >>> Dmitry.
> >>>
> >>> [1] https://markmail.org/message/dmw3pr4fuajvarth
> >>> [2] https://markmail.org/message/wnnv6r6myvgb5at6
> >>>
> >>>
> >>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

