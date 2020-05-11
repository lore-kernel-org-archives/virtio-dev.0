Return-Path: virtio-dev-return-7312-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74D24985CE6
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 May 2020 12:33:15 +0000 (UTC)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo> <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
In-Reply-To: <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
From: Saket Sinha <saket.sinha89@gmail.com>
Date: Mon, 11 May 2020 14:32:36 +0200
Message-ID: <CAK25hWNR0WdpddU1kDChUB+PWiLG2A76KJW5u5F-LNkGBREj_g@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Content-Type: text/plain; charset="UTF-8"
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, Kiran Pawar <Kiran.Pawar@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Alexandre Courbot <acourbot@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Pawel Osciak <posciak@chromium.org>, libcamera-devel@lists.libcamera.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

> > > I do not support the approach of  QEMU implementation forwarding
> > > requests to the host's vicodec module since  this can limit the scope
> > > of the virtio-video device only for testing,
> >
> > That was my understanding as well.
>
> Not really because the API which the vicodec provides is V4L2 stateful
> decoder interface [1], which are also used by other video drivers on
> Linux.
> The difference between vicodec and actual device drivers is that
> vicodec performs decoding in the kernel space without using special
> video devices. In other words, vicodec is a software decoder in kernel
> space which provides the same interface with actual video drivers.
> Thus, if the QEMU implementation can forward virtio-video requests to
> vicodec, it can forward them to the actual V4L2 video decoder devices
> as well and VM gets access to a paravirtualized video device.
>
> The reason why we discussed vicodec in the previous thread was it'll
> allow us to test the virtio-video driver without hardware requirement.
>
> [1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html
>

Thanks for clarification.

Could  you provide your views if it would be possible to support also
paravirtualized v4l-subdev devices which is enabled by media
controller to expose ISP processing blocks to linux userspace.
Ofcourse, we might need to change implementation and spec to support that
Please refer (1) for details.

> >
> > > which instead can be used with multiple use cases such as -
> > >
> > > 1. VM gets access to paravirtualized  camera devices which shares the
> > > video frames input through actual HW camera attached to Host.
> >
> > This use-case is out of the scope of virtio-video. Initially I had a plan to
> > support capture-only streams like camera as well, but later the decision was
> > made upstream that camera should be implemented as separate device type. We
> > still plan to implement a simple frame capture capability as a downstream
> > patch though.
> >
> > >
> > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > with selective video streams from actual HW video devices.
> >
> > We do support this in our device implementation. But spec in general has no
> > requirements or instructions regarding this. And it is in fact flexible enough
> > to provide abstraction on top of several HW devices.
> >
> > >
> > > Also instead of using libraries like Gstreamer in Host userspace, they
> > > can also be used inside the VM userspace after getting access to
> > > paravirtualized HW camera devices .
>
> Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> can translate virtio-video requests to this API, we can easily support
> multiple platforms.
> I'm not sure how feasible it is though, as I have no experience of
> using this API by myself...
>
> [2] https://gstreamer.freedesktop.org/documentation/tutorials/playback/hardware-accelerated-video-decoding.html
>

Like pointed out above, Gstreamer is not the only framework present there.
We have the newer libcamera framework [2] and then Openmax (used in
Android Hal )
Refer [3] for comparison.

My intentions are to make the implementation more generic so that it
can be used by different frameworks on different platforms.

[1]: https://static.sched.com/hosted_files/osseu19/21/libcamera.pdf
[2]: http://libcamera.org
[3]: https://processors.wiki.ti.com/images/7/7e/OMX_Android_GST_Comparison.pdf

Regards,
Saket Sinha

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

