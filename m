Return-Path: <virtio-dev-return-11612-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFF7C6FD1F
	for <virtio-dev@archiver.kernel.org>; Tue, 14 Mar 2023 05:06:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 138B742A67
	for <virtio-dev@archiver.kernel.org>; Tue, 14 Mar 2023 05:06:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5B9E986370
	for <virtio-dev@archiver.kernel.org>; Tue, 14 Mar 2023 05:06:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CB8CC985FF0; Tue, 14 Mar 2023 05:06:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B735698635A
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Mar 2023 05:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678770391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qpg/kib063B8lcnmtL06vE18pb3SKj5IvJ54Tj+HE4=;
        b=QCUTP33ryEyphYUNeV+r1BQiMf6U2pHrQzvixluzuD2gBYqWj7pt281hIELbw+n6Aa
         haOTjdkUJxjOfYCXXB7OVZhkduIPf1aYVumS3FU/14Yq1Yb+SfUKkxOapp4mVHIMBGac
         2mjDG4t0b968kl7sXuGYL5tF+b/tPd//RVH4si8jkJWbCYliRyEzEGyk6WXak9wkBTJc
         FIOQAr4WS/vFnOqw7a3wwx/XbbsQ9ELs3NIvdjkyau76cDy4KwPb7DB17x3FpyHgikH6
         Dcnm+lEXIE8814NSSBx1Q+ZzGTfaZoXNAg52MmjZBrLH8tqLTnVmEFXGkcSMu5ME64y+
         ZBcA==
X-Gm-Message-State: AO0yUKVb9zawzmWh3sATzakoMtaDGOACMp926higCSFcWBwQRRt2Tlua
	bOYF31shgwagWdV5mz7E1r3ar9DcXcjLT30gf6U=
X-Google-Smtp-Source: AK7set+BzEkkIJS92EkDIKb7+Q/hIMToxdc5rDN5yMcZBYgBjNnKILCxByniGQcl1hcUpV4jjrvmuQ==
X-Received: by 2002:a17:906:5fcc:b0:8b2:2141:6de8 with SMTP id k12-20020a1709065fcc00b008b221416de8mr1256884ejv.73.1678770390764;
        Mon, 13 Mar 2023 22:06:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1c9b:b0:3e2:1a5e:b13c with SMTP id
 k27-20020a05600c1c9b00b003e21a5eb13cmr41852wms.2.1678770388656; Mon, 13 Mar
 2023 22:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
In-Reply-To: <877cvog030.fsf@redhat.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Tue, 14 Mar 2023 14:06:16 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
Message-ID: <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
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

On Fri, Mar 10, 2023 at 11:20=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> =
wrote:
>
> On Fri, Mar 10 2023, Alexandre Courbot <acourbot@chromium.org> wrote:
>
> > Hi Cornelia,
> >
> > On Fri, Mar 10, 2023 at 7:51=E2=80=AFPM Cornelia Huck <cohuck@redhat.co=
m> wrote:
> >>
> >> On Tue, Feb 07 2023, Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> > On Tue, Feb 07 2023, Alexandre Courbot <acourbot@chromium.org> wrote=
:
> >> >
> >> >> On Mon, Feb 6, 2023 at 11:13 PM Cornelia Huck <cohuck@redhat.com> w=
rote:
> >> >>> I hope we can sort this out soon -- I guess I'm not the only one w=
ho is
> >> >>> anxious about this spec moving forward :) Please let me know if I =
can
> >> >>> help in any way.
> >> >>
> >> >> I'll try to address Alexander's points in more detail, but I am not
> >> >> seeing any blocking issue with using the V4L2 UAPI as the basis for
> >> >> virtio-video (we are working on a small proof-of-concept and things
> >> >> are going smoothly so far).
> >> >
> >> > Great to hear, looking forward to it!
> >>
> >> Quick question: Is there any git repo or similar where interested
> >> parties can follow along? It would be great to have virtio-video in 1.=
3;
> >> if you have some idea on when it might be ready, we could come up with=
 a
> >> schedule to accommodate that.
> >
> > I'm glad you asked, as a matter of fact I have just finished the
> > virtio-v4l2 proof of concept today! It is capable of exposing a camera
> > or encoder V4L2 device from the host to the guest, by encapsulating
> > V4L2 commands into virtio.
>
> \o/ Excellent news!

I am delighted that you seem to like it!

>
> >
> > The guest driver code (single file for simplicity):
> > https://github.com/Gnurou/linux/blob/virtio-v4l2/drivers/media/virtio-v=
4l2/virtio_v4l2_driver.c
> >
> > Bulk of the host-side crosvm device code:
> > https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4=
l2/protocol.rs
> > https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4=
l2/worker.rs
> >
> > Neither are works of art, so please forgive the few inefficiencies
> > here and there - the goal was to make them easy to understand. Still,
> > the guest driver is probably closer to what a final driver would look
> > like. It fits in around 1,000 LoCs (comments excluded), which is
> > enough to support stateful video encoders as well as USB camera
> > devices. Decoders cannot be run yet because they require support for
> > V4L2 events and polling - I will try to enable these features next.
> > But even in its current state this driver shows one interesting aspect
> > of virtio-v4l2, at least for Linux guests: a single and relatively
> > simple driver is able to drive a wide range of devices.
>
> I had a quick look at the driver; it indeed looks like a big win on
> Linux systems. (The one thing I'm missing is how easy it would be to
> replicate the used v4l2 parts on non-Linux systems.)

For non-Linux systems (host or guest, we may need to copy/paste or
reproduce the UAPI structures. Thankfully they are unambiguously
described in the UAPI documentation, see for example
https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-enum-fmt.html
for the formats structure.

>
> >
> > The crosvm device code proxies a V4L2 device on the host, again using
> > roughly 1,200 lines of non-comment code. This design does not intend
> > to reflect what an actual host device will look like - in effect they
> > should be much more specialized since they are unlikely to also call
> > into V4L2 on the host side. However, if the host is Linux and we just
> > want to expose a USB camera or other V4L2 device almost as-is, then
> > this could actually be a good fit.
> >
> > The protocol should be easy to understand by looking at the code - we
> > only have 5 virtio commands to open/close a session, map/unmap a
> > host-allocated buffer into the guest PAS, and the IOCTL command which
> > sends V4L2 ioctl structures to the host and waits for its reply. All
> > ioctls are synchronous per-session, meaning that a session only sends
> > one ioctl at a time and waits for its response before it can send the
> > next (as this is what user-space does too). Ioctls, however, never
> > block on the host side and the ones that would do (DQBUF and DQEVENT)
> > are replaced by host-initiated events. On top of being familiar to
> > people who have worked with V4L2 (i.e. a large portion of the media
> > folks), this simple design seems to be efficient as I have observed
> > identical performance on both host and guest with the vicodec virtual
> > encoder. Since this device generates frames using the CPU and keeps
> > one core 100% busy, any overhead introduced by virtualization should
> > be noticeable - yet I got nearly identical framerates on both host and
> > guest.
>
> I haven't worked with v4l2, but this approach sounds reasonable to me.
>
> >
> > Things that still need to be implemented before this can be considered
> > more complete:
> >
> > * Controls. This should not be particularly difficult but I left it
> > for now as they are not necessary to demonstrate the viability of this
> > project.
> > * Guest-allocated memory buffers and virtio objects. Based on our
> > previous experience with virtio-video these should not be difficult to
> > implement. Currently all video buffers are allocated by the host, and
> > mapped into the guest if needed.
> > * Events and polling, required to use a decoder. Again these were not
> > strictly necessary for the proof of concept, but since we've gone this
> > far I will try to get them to work as the next step.
> > * Requests and multi-part media devices. This will be necessary in
> > order to support more modern camera pipelines. I haven't made up my
> > mind yet about whether we should support this, but if we want to it
> > should not be too hard (describe several devices in the configuration
> > space and enable the request-related commands). I need to talk to
> > camera folks to know whether there is an actual interest in this.
> > * Support for more ioctls, in case we want to support tuners and radios=
.
> >
> > If you want to try this code, you need to build the guest kernel with
> > CONFIG_VIRTIO_V4L2 and enable the `v4l2` feature when building crosvm
> > (check out the Book of Crosvm if you need instructions on how to build
> > and use it). Then pass --virtio-v4l2=3D/dev/videoX to crosvm in order t=
o
> > expose the /dev/videoX host V4L2 device to the guest.
> >
> > I have successfully captured frames (and verified their validity)
> > using the following devices:
> >
> > * A simple USB camera using the `uvcvideo` driver. Both host and guest
> > could capture a MJPEG stream with the following command:
> > v4l2-ctl -d0 -v pixelformat=3DMJPG --stream-mmap --stream-to=3Dtest.mjp=
g
> >
> > * The vivid virtual camera driver. I could capture a valid YUV stream
> > using the following command:
> > v4l2-ctl -d0 -v pixelformat=3DNV12 --stream-mmap --stream-to test.yuv
> >
> > * The encoder device of the vicodec virtual codec driver. On both host
> > and guest, the following command produces a valid FWHT stream in
> > `test.fwht`:
> > v4l2-ctl -x pixelformat=3DNV12 --stream-mmap --stream-out-mmap
> > --stream-to-hdr test.fwht
>
> This looks very good already.

Turns out that ffmpeg can also be used to capture video and encode it
in a more convenient format, e.g:

ffmpeg -f v4l2 -i /dev/video0 output.mkv

This is a very good sign with respect to compliance with V4L2
protocols. We had a very hard time getting the original virtio-video
to be used with common tools and passing the V4L2 compliance test in
general, but with this approach it seems like it will be much simpler
to achieve.

>
> >
> > By this work I hope to demonstrate to people interested in video
> > virtualization that encapsulating V4L2 in virtio is not only a viable
> > solution, it is a huge shortcut in terms of specification crafting,
> > driver writing, and overall headaches involved in specifying something
> > as complex as a video device. Not only could we support video decoders
> > and encoders, which was the goal of virtio-video, we would also get
> > image processors, video overlays and simple cameras for free, and
> > potentially more complex cameras if we decide to.
> >
> > After writing this prototype (and a couple attempts at the
> > virtio-video specification) I don't see any reason not to rely on a
> > battle-tested protocol instead of designing our own that does
> > basically the same thing. The genericity of V4L2 may mean that
> > sometimes we will need 2 commands where virtio-video would require
> > only one, but we are talking about a low frequency of virtio commands
> > (60 fps for video playback typically) and that genericity comes with
> > the benefit of a single Linux guest driver.
> >
> > If there is an agreement to move forward with this, I guess the next
> > step for me will be to write a proper spec so the protocol can be
> > understood and discussed in detail. Then why not try and upstream the
> > kernel driver and make ChromeOS use this too in place of our
> > heavily-patched virtio-video. :) We might even make it for virtio 1.3.
> >
> > Looking forward to your feedback. Please don't hesitate to ask
> > questions, especially if you are not familiar with V4L2. I can also
> > help folks interested in running this with the setup if needed.
>
> Thank you for sharing your work! I think this looks very promising, and
> I'd like to hear feedback from others as well. I assume that would make
> the spec change more digestible than earlier versions.

The spec should indeed be considerably lighter. I'll wait for more
feedback, but if the concept appeals to other people as well, I may
give the spec a try soon.

Meanwhile I'll also try to add support for stateful decoders and
guest-allocated buffers to the prototype so it can be considered more
complete.

Cheers,
Alex.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

