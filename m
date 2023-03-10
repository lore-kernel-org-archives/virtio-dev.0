Return-Path: <virtio-dev-return-11599-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D996C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 13:20:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C1132AD76
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 13:20:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82361986723
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 13:20:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 676D898671B; Fri, 10 Mar 2023 13:20:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A96B898671C
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Mar 2023 13:19:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKeM6IWl278r3TkwpGSwrVU6xU6HJTVu+20elrYpXVQ=;
        b=gVMse6njf6x0UtL5UyKMfpakWIgU+wz17u9aay+hvIJIZw6g490XzOcadAH+9ShiPX
         lsCgy2eFG/u+g//435w1ErVC8zeKzD3/Dxj/bEEyGnWQs9cJnWLf6O8fgiYaAUNHqmMZ
         mI3IRB/fvaHoOWACoudbyc2+wBt8uViuIAGbXjLg0EojN7VsbG5D5Z2vc0QDcqb8GgQj
         9ZHtWrr92k9EQUKnIuKsaQYnaQtVPn/T89+qPPnoVh2ZfTON6MNk3VhcQBUMyxi+rNHn
         w4EMG7Hzm57JV82Ulw4Mu1QsfBj45eu1mvV7RcTopEl6sIxDoIP1BAG/w2ATOOepFzif
         VTCA==
X-Gm-Message-State: AO0yUKWzn3BF+bpLpQOIhf4P2mf67yqXYaooSJHVSmMogbwhrd2u/HTl
	voiTRQNRm5oAePbOz5nCaBoVPggJ/NTF9amxuj0=
X-Google-Smtp-Source: AK7set/p44l1f+ZgCi9wV1No6MaonEhj80vykEJyP72Bb+LO8uYrAWriJb4pUTa0P3SBraqY8f24lA==
X-Received: by 2002:aa7:c153:0:b0:4ac:b614:dcfc with SMTP id r19-20020aa7c153000000b004acb614dcfcmr24726980edp.9.1678454396036;
        Fri, 10 Mar 2023 05:19:56 -0800 (PST)
X-Received: by 2002:a7b:c2b1:0:b0:3eb:5a1e:d524 with SMTP id
 c17-20020a7bc2b1000000b003eb5a1ed524mr779836wmk.3.1678454394176; Fri, 10 Mar
 2023 05:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
In-Reply-To: <87a60kg9rh.fsf@redhat.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 10 Mar 2023 22:19:41 +0900
X-Gmail-Original-Message-ID: <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
Message-ID: <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Gordeev <alexander.gordeev@opensynergy.com>, virtio-dev@lists.oasis-open.org, 
	Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Enric Balletbo i Serra <eballetb@redhat.com>, Albert Esteve <aesteve@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Hi Cornelia,

On Fri, Mar 10, 2023 at 7:51=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> w=
rote:
>
> On Tue, Feb 07 2023, Cornelia Huck <cohuck@redhat.com> wrote:
>
> > On Tue, Feb 07 2023, Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> >> On Mon, Feb 6, 2023 at 11:13 PM Cornelia Huck <cohuck@redhat.com> wrot=
e:
> >>> I hope we can sort this out soon -- I guess I'm not the only one who =
is
> >>> anxious about this spec moving forward :) Please let me know if I can
> >>> help in any way.
> >>
> >> I'll try to address Alexander's points in more detail, but I am not
> >> seeing any blocking issue with using the V4L2 UAPI as the basis for
> >> virtio-video (we are working on a small proof-of-concept and things
> >> are going smoothly so far).
> >
> > Great to hear, looking forward to it!
>
> Quick question: Is there any git repo or similar where interested
> parties can follow along? It would be great to have virtio-video in 1.3;
> if you have some idea on when it might be ready, we could come up with a
> schedule to accommodate that.

I'm glad you asked, as a matter of fact I have just finished the
virtio-v4l2 proof of concept today! It is capable of exposing a camera
or encoder V4L2 device from the host to the guest, by encapsulating
V4L2 commands into virtio.

The guest driver code (single file for simplicity):
https://github.com/Gnurou/linux/blob/virtio-v4l2/drivers/media/virtio-v4l2/=
virtio_v4l2_driver.c

Bulk of the host-side crosvm device code:
https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4l2/p=
rotocol.rs
https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4l2/w=
orker.rs

Neither are works of art, so please forgive the few inefficiencies
here and there - the goal was to make them easy to understand. Still,
the guest driver is probably closer to what a final driver would look
like. It fits in around 1,000 LoCs (comments excluded), which is
enough to support stateful video encoders as well as USB camera
devices. Decoders cannot be run yet because they require support for
V4L2 events and polling - I will try to enable these features next.
But even in its current state this driver shows one interesting aspect
of virtio-v4l2, at least for Linux guests: a single and relatively
simple driver is able to drive a wide range of devices.

The crosvm device code proxies a V4L2 device on the host, again using
roughly 1,200 lines of non-comment code. This design does not intend
to reflect what an actual host device will look like - in effect they
should be much more specialized since they are unlikely to also call
into V4L2 on the host side. However, if the host is Linux and we just
want to expose a USB camera or other V4L2 device almost as-is, then
this could actually be a good fit.

The protocol should be easy to understand by looking at the code - we
only have 5 virtio commands to open/close a session, map/unmap a
host-allocated buffer into the guest PAS, and the IOCTL command which
sends V4L2 ioctl structures to the host and waits for its reply. All
ioctls are synchronous per-session, meaning that a session only sends
one ioctl at a time and waits for its response before it can send the
next (as this is what user-space does too). Ioctls, however, never
block on the host side and the ones that would do (DQBUF and DQEVENT)
are replaced by host-initiated events. On top of being familiar to
people who have worked with V4L2 (i.e. a large portion of the media
folks), this simple design seems to be efficient as I have observed
identical performance on both host and guest with the vicodec virtual
encoder. Since this device generates frames using the CPU and keeps
one core 100% busy, any overhead introduced by virtualization should
be noticeable - yet I got nearly identical framerates on both host and
guest.

Things that still need to be implemented before this can be considered
more complete:

* Controls. This should not be particularly difficult but I left it
for now as they are not necessary to demonstrate the viability of this
project.
* Guest-allocated memory buffers and virtio objects. Based on our
previous experience with virtio-video these should not be difficult to
implement. Currently all video buffers are allocated by the host, and
mapped into the guest if needed.
* Events and polling, required to use a decoder. Again these were not
strictly necessary for the proof of concept, but since we've gone this
far I will try to get them to work as the next step.
* Requests and multi-part media devices. This will be necessary in
order to support more modern camera pipelines. I haven't made up my
mind yet about whether we should support this, but if we want to it
should not be too hard (describe several devices in the configuration
space and enable the request-related commands). I need to talk to
camera folks to know whether there is an actual interest in this.
* Support for more ioctls, in case we want to support tuners and radios.

If you want to try this code, you need to build the guest kernel with
CONFIG_VIRTIO_V4L2 and enable the `v4l2` feature when building crosvm
(check out the Book of Crosvm if you need instructions on how to build
and use it). Then pass --virtio-v4l2=3D/dev/videoX to crosvm in order to
expose the /dev/videoX host V4L2 device to the guest.

I have successfully captured frames (and verified their validity)
using the following devices:

* A simple USB camera using the `uvcvideo` driver. Both host and guest
could capture a MJPEG stream with the following command:
v4l2-ctl -d0 -v pixelformat=3DMJPG --stream-mmap --stream-to=3Dtest.mjpg

* The vivid virtual camera driver. I could capture a valid YUV stream
using the following command:
v4l2-ctl -d0 -v pixelformat=3DNV12 --stream-mmap --stream-to test.yuv

* The encoder device of the vicodec virtual codec driver. On both host
and guest, the following command produces a valid FWHT stream in
`test.fwht`:
v4l2-ctl -x pixelformat=3DNV12 --stream-mmap --stream-out-mmap
--stream-to-hdr test.fwht

By this work I hope to demonstrate to people interested in video
virtualization that encapsulating V4L2 in virtio is not only a viable
solution, it is a huge shortcut in terms of specification crafting,
driver writing, and overall headaches involved in specifying something
as complex as a video device. Not only could we support video decoders
and encoders, which was the goal of virtio-video, we would also get
image processors, video overlays and simple cameras for free, and
potentially more complex cameras if we decide to.

After writing this prototype (and a couple attempts at the
virtio-video specification) I don't see any reason not to rely on a
battle-tested protocol instead of designing our own that does
basically the same thing. The genericity of V4L2 may mean that
sometimes we will need 2 commands where virtio-video would require
only one, but we are talking about a low frequency of virtio commands
(60 fps for video playback typically) and that genericity comes with
the benefit of a single Linux guest driver.

If there is an agreement to move forward with this, I guess the next
step for me will be to write a proper spec so the protocol can be
understood and discussed in detail. Then why not try and upstream the
kernel driver and make ChromeOS use this too in place of our
heavily-patched virtio-video. :) We might even make it for virtio 1.3.

Looking forward to your feedback. Please don't hesitate to ask
questions, especially if you are not familiar with V4L2. I can also
help folks interested in running this with the setup if needed.

Cheers,
Alex.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

