Return-Path: <virtio-dev-return-12241-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB377C77B71
	for <virtio-dev@archiver.kernel.org>; Sat, 15 Apr 2023 06:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B9C152AD79
	for <virtio-dev@archiver.kernel.org>; Sat, 15 Apr 2023 06:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97571986617
	for <virtio-dev@archiver.kernel.org>; Sat, 15 Apr 2023 06:05:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74640986414; Sat, 15 Apr 2023 06:05:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A0AC984091
	for <virtio-dev@lists.oasis-open.org>; Sat, 15 Apr 2023 06:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681538696; x=1684130696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwqV9U3jGIkY8WJulEL2d3ph6wKy5XLbYjf5TsMxJcQ=;
        b=d6+FbFAtyOHMlnLNmsL6bzAP+/PVcK00ZnPBlEnA/MkTEDsgK0pGYsx613O8PqUduZ
         LX3iEyKaQYc381wPzLXQSLBHbbkRnSivJvgZYnlaSq0IgYaQVdS6mK1WOXZMWCANy2mr
         Pmo1wh8XzmRMi3Ay2mFKTOSEGl2VP1A4rVWnEpj6XCNRYIDozl5u0ljpeUg7PHQl4YIW
         q1b/jVscU5zp3HUb7xW4iUHfSNUtO6IgyJfSSzstlC1Hwcq6xstTJFqaoNGcbAml6RIU
         w9ptlxifo6LMZi0C3movDjzux/vzgCkxSqdbG3oiO1BEwAmq7TEAm2LGxwFRoE+VXTR4
         C9dQ==
X-Gm-Message-State: AAQBX9dTVsv0Upvl1Qh5qyZoJqJhbeIgI8io8EMG4pnaW20yqYD0nurE
	2G0n+KSFF9HbCxyfYwa1IvraIBrOdNccxEK25uw=
X-Google-Smtp-Source: AKy350agFxIW0l7JAGhow7yUNsrEz9ergEj3ypyH3ufwG/es3y+NwXcJ52Rehi6jVqWxARxuwazDDQ==
X-Received: by 2002:ac8:5a4d:0:b0:3e8:e0ed:8cb9 with SMTP id o13-20020ac85a4d000000b003e8e0ed8cb9mr12662983qta.19.1681538695724;
        Fri, 14 Apr 2023 23:04:55 -0700 (PDT)
X-Received: by 2002:a05:6e02:219a:b0:314:17e2:16d1 with SMTP id
 j26-20020a056e02219a00b0031417e216d1mr96902ila.4.1681538312010; Fri, 14 Apr
 2023 22:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <CADSE00KD9=2hs5b=fZpTe7XDm3Q3PAmQczGciE=zLBOF3UNLBA@mail.gmail.com>
In-Reply-To: <CADSE00KD9=2hs5b=fZpTe7XDm3Q3PAmQczGciE=zLBOF3UNLBA@mail.gmail.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Sat, 15 Apr 2023 14:58:20 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW6RxdaH_kq6ZsWpP78yGBSP4T6p3E4=O=uKje4P+MiFw@mail.gmail.com>
Message-ID: <CAPBb6MW6RxdaH_kq6ZsWpP78yGBSP4T6p3E4=O=uKje4P+MiFw@mail.gmail.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, 
	Alexander Gordeev <alexander.gordeev@opensynergy.com>, virtio-dev@lists.oasis-open.org, 
	Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Enric Balletbo i Serra <eballetb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Thanks for the feedback Albert!

On Mon, Mar 27, 2023 at 10:00=E2=80=AFPM Albert Esteve <aesteve@redhat.com>=
 wrote:
>
>
>
>
> On Tue, Mar 14, 2023 at 6:06=E2=80=AFAM Alexandre Courbot <acourbot@chrom=
ium.org> wrote:
>>
>> Hi Cornelia,
>>
>> On Fri, Mar 10, 2023 at 11:20=E2=80=AFPM Cornelia Huck <cohuck@redhat.co=
m> wrote:
>> >
>> > On Fri, Mar 10 2023, Alexandre Courbot <acourbot@chromium.org> wrote:
>> >
>> > > Hi Cornelia,
>> > >
>> > > On Fri, Mar 10, 2023 at 7:51=E2=80=AFPM Cornelia Huck <cohuck@redhat=
.com> wrote:
>> > >>
>> > >> On Tue, Feb 07 2023, Cornelia Huck <cohuck@redhat.com> wrote:
>> > >>
>> > >> > On Tue, Feb 07 2023, Alexandre Courbot <acourbot@chromium.org> wr=
ote:
>> > >> >
>> > >> >> On Mon, Feb 6, 2023 at 11:13 PM Cornelia Huck <cohuck@redhat.com=
> wrote:
>> > >> >>> I hope we can sort this out soon -- I guess I'm not the only on=
e who is
>> > >> >>> anxious about this spec moving forward :) Please let me know if=
 I can
>> > >> >>> help in any way.
>> > >> >>
>> > >> >> I'll try to address Alexander's points in more detail, but I am =
not
>> > >> >> seeing any blocking issue with using the V4L2 UAPI as the basis =
for
>> > >> >> virtio-video (we are working on a small proof-of-concept and thi=
ngs
>> > >> >> are going smoothly so far).
>> > >> >
>> > >> > Great to hear, looking forward to it!
>> > >>
>> > >> Quick question: Is there any git repo or similar where interested
>> > >> parties can follow along? It would be great to have virtio-video in=
 1.3;
>> > >> if you have some idea on when it might be ready, we could come up w=
ith a
>> > >> schedule to accommodate that.
>> > >
>> > > I'm glad you asked, as a matter of fact I have just finished the
>> > > virtio-v4l2 proof of concept today! It is capable of exposing a came=
ra
>> > > or encoder V4L2 device from the host to the guest, by encapsulating
>> > > V4L2 commands into virtio.
>> >
>> > \o/ Excellent news!
>>
>> I am delighted that you seem to like it!
>>
>> >
>> > >
>> > > The guest driver code (single file for simplicity):
>> > > https://github.com/Gnurou/linux/blob/virtio-v4l2/drivers/media/virti=
o-v4l2/virtio_v4l2_driver.c
>> > >
>> > > Bulk of the host-side crosvm device code:
>> > > https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio=
/v4l2/protocol.rs
>> > > https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio=
/v4l2/worker.rs
>> > >
>> > > Neither are works of art, so please forgive the few inefficiencies
>> > > here and there - the goal was to make them easy to understand. Still=
,
>> > > the guest driver is probably closer to what a final driver would loo=
k
>> > > like. It fits in around 1,000 LoCs (comments excluded), which is
>> > > enough to support stateful video encoders as well as USB camera
>> > > devices. Decoders cannot be run yet because they require support for
>> > > V4L2 events and polling - I will try to enable these features next.
>> > > But even in its current state this driver shows one interesting aspe=
ct
>> > > of virtio-v4l2, at least for Linux guests: a single and relatively
>> > > simple driver is able to drive a wide range of devices.
>> >
>> > I had a quick look at the driver; it indeed looks like a big win on
>> > Linux systems. (The one thing I'm missing is how easy it would be to
>> > replicate the used v4l2 parts on non-Linux systems.)
>>
>> For non-Linux systems (host or guest, we may need to copy/paste or
>> reproduce the UAPI structures. Thankfully they are unambiguously
>> described in the UAPI documentation, see for example
>> https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-enum-fmt.html
>> for the formats structure.
>>
>> >
>> > >
>> > > The crosvm device code proxies a V4L2 device on the host, again usin=
g
>> > > roughly 1,200 lines of non-comment code. This design does not intend
>> > > to reflect what an actual host device will look like - in effect the=
y
>> > > should be much more specialized since they are unlikely to also call
>> > > into V4L2 on the host side. However, if the host is Linux and we jus=
t
>> > > want to expose a USB camera or other V4L2 device almost as-is, then
>> > > this could actually be a good fit.
>> > >
>> > > The protocol should be easy to understand by looking at the code - w=
e
>> > > only have 5 virtio commands to open/close a session, map/unmap a
>> > > host-allocated buffer into the guest PAS, and the IOCTL command whic=
h
>> > > sends V4L2 ioctl structures to the host and waits for its reply. All
>> > > ioctls are synchronous per-session, meaning that a session only send=
s
>> > > one ioctl at a time and waits for its response before it can send th=
e
>> > > next (as this is what user-space does too). Ioctls, however, never
>> > > block on the host side and the ones that would do (DQBUF and DQEVENT=
)
>> > > are replaced by host-initiated events. On top of being familiar to
>> > > people who have worked with V4L2 (i.e. a large portion of the media
>> > > folks), this simple design seems to be efficient as I have observed
>> > > identical performance on both host and guest with the vicodec virtua=
l
>> > > encoder. Since this device generates frames using the CPU and keeps
>> > > one core 100% busy, any overhead introduced by virtualization should
>> > > be noticeable - yet I got nearly identical framerates on both host a=
nd
>> > > guest.
>> >
>> > I haven't worked with v4l2, but this approach sounds reasonable to me.
>> >
>> > >
>> > > Things that still need to be implemented before this can be consider=
ed
>> > > more complete:
>> > >
>> > > * Controls. This should not be particularly difficult but I left it
>> > > for now as they are not necessary to demonstrate the viability of th=
is
>> > > project.
>> > > * Guest-allocated memory buffers and virtio objects. Based on our
>> > > previous experience with virtio-video these should not be difficult =
to
>> > > implement. Currently all video buffers are allocated by the host, an=
d
>> > > mapped into the guest if needed.
>> > > * Events and polling, required to use a decoder. Again these were no=
t
>> > > strictly necessary for the proof of concept, but since we've gone th=
is
>> > > far I will try to get them to work as the next step.
>> > > * Requests and multi-part media devices. This will be necessary in
>> > > order to support more modern camera pipelines. I haven't made up my
>> > > mind yet about whether we should support this, but if we want to it
>> > > should not be too hard (describe several devices in the configuratio=
n
>> > > space and enable the request-related commands). I need to talk to
>> > > camera folks to know whether there is an actual interest in this.
>> > > * Support for more ioctls, in case we want to support tuners and rad=
ios.
>> > >
>> > > If you want to try this code, you need to build the guest kernel wit=
h
>> > > CONFIG_VIRTIO_V4L2 and enable the `v4l2` feature when building crosv=
m
>> > > (check out the Book of Crosvm if you need instructions on how to bui=
ld
>> > > and use it). Then pass --virtio-v4l2=3D/dev/videoX to crosvm in orde=
r to
>> > > expose the /dev/videoX host V4L2 device to the guest.
>> > >
>> > > I have successfully captured frames (and verified their validity)
>> > > using the following devices:
>> > >
>> > > * A simple USB camera using the `uvcvideo` driver. Both host and gue=
st
>> > > could capture a MJPEG stream with the following command:
>> > > v4l2-ctl -d0 -v pixelformat=3DMJPG --stream-mmap --stream-to=3Dtest.=
mjpg
>> > >
>> > > * The vivid virtual camera driver. I could capture a valid YUV strea=
m
>> > > using the following command:
>> > > v4l2-ctl -d0 -v pixelformat=3DNV12 --stream-mmap --stream-to test.yu=
v
>> > >
>> > > * The encoder device of the vicodec virtual codec driver. On both ho=
st
>> > > and guest, the following command produces a valid FWHT stream in
>> > > `test.fwht`:
>> > > v4l2-ctl -x pixelformat=3DNV12 --stream-mmap --stream-out-mmap
>> > > --stream-to-hdr test.fwht
>> >
>> > This looks very good already.
>>
>> Turns out that ffmpeg can also be used to capture video and encode it
>> in a more convenient format, e.g:
>>
>> ffmpeg -f v4l2 -i /dev/video0 output.mkv
>>
>> This is a very good sign with respect to compliance with V4L2
>> protocols. We had a very hard time getting the original virtio-video
>> to be used with common tools and passing the V4L2 compliance test in
>> general, but with this approach it seems like it will be much simpler
>> to achieve.
>
>
> I was curious, and I have tried the prototype. I was gladly surprised at =
how nice
> it behaves in this state. Really nice work.
>
> I have managed to expose different devices to the host and run compliance=
 tests,
> capture frames from a camera, and encode by doing:
>
> # v4l2-ctl -d0 -x width=3D640,height=3D480 -v width=3D640,height=3D480,pi=
xelformat=3DFWHT \
>                 --stream-mmap --stream-out-mmap \
>                 --stream-from in-640-480.YU12 --stream-to output.fwht

Just a small update: I have updated the device and driver to handle
V4L2 events and polling and the vicodec decoder is now also working.

Instructions are mostly unchanged:

* Insert the vicodec module on your host (sudo modprobe vicodec multiplanar=
=3D1)
* Check that it is working properly:
** Encode 30 frames in FWHT format:
v4l2-ctl -d/dev/video0 -x pixelformat=3DNV12 --stream-mmap
--stream-out-mmap --stream-to-hdr out.fwht --stream-count 30
** Decode them back to NV12:
v4l2-ctl -d/dev/video1 -v pixelformat=3DNV12 --stream-mmap
--stream-out-mmap --stream-from-hdr out.fwht --stream-to out.nv12
(You can check the result with YUView, frame size is 1280x720).
* Get the kernel at https://github.com/Gnurou/linux/tree/virtio-v4l2
and build with CONFIG_VIRTIO_V4L2,
* Get crosvm at https://github.com/Gnurou/crosvm/tree/virtio-v4l2 and
run it with the "--virtio-v4l2=3D/dev/video0 --virtio-v4l2=3D/dev/video1"
options to virtualize the encoder and decoder devices,
* Run the same commands as the second step in the guest, you should
get the exact same result as when they were run on the host.

This demonstrates that a decoder device can be virtualized quite
simply by this solution. Next let me enable controls (so
v4l2-compliance passes in the guest) and the remaining types of buffer
memories and we should have something rather complete, at least on the
guest side.

I have also chatted a bit more with a few camera folks at Google, and
they agreed that V4L2 with requests should be enough to support even
modern camera pipelines. That is, the whole complexity of the host
pipeline would not and should not be entirely exposed to the guest,
only a simpler model that makes sense for what the camera is used for,
and for that V4L2 is more than enough. So a stronger confidence that
this will be suitable for the camera use-case as well.

If nobody strongly objects, I think this can be pushed a bit more
officially. Cornelia, would you consider it for inclusion if I
switched the next version of the specification to use V4L2 as the
host/guest protocol? This may take some more time as I want to confirm
the last details with code, but it should definitely be faster to
merge and to test with a real implementation than our previous
virtio-video attempts.

Cheers,
Alex.




>
> Some results for the compliance tests using vicodec:
> *  Enconder device
>     * Host
> Total for vicodec device /dev/video4: 46, Succeeded: 45, Failed: 1, Warni=
ngs: 0
>     * Guest
> Total for virtio_v4l2 device /dev/video0: 45, Succeeded: 34, Failed: 11, =
Warnings: 0
>
> *  Decoder device
>     * Host
> Total for vicodec device /dev/video5: 46, Succeeded: 42, Failed: 4, Warni=
ngs: 0
>     * Guest
> Total for virtio_v4l2 device /dev/video0: 45, Succeeded: 36, Failed: 9, W=
arnings: 0
>
>>
>>
>> >
>> > >
>> > > By this work I hope to demonstrate to people interested in video
>> > > virtualization that encapsulating V4L2 in virtio is not only a viabl=
e
>> > > solution, it is a huge shortcut in terms of specification crafting,
>> > > driver writing, and overall headaches involved in specifying somethi=
ng
>> > > as complex as a video device. Not only could we support video decode=
rs
>> > > and encoders, which was the goal of virtio-video, we would also get
>> > > image processors, video overlays and simple cameras for free, and
>> > > potentially more complex cameras if we decide to.
>> > >
>> > > After writing this prototype (and a couple attempts at the
>> > > virtio-video specification) I don't see any reason not to rely on a
>> > > battle-tested protocol instead of designing our own that does
>> > > basically the same thing. The genericity of V4L2 may mean that
>> > > sometimes we will need 2 commands where virtio-video would require
>> > > only one, but we are talking about a low frequency of virtio command=
s
>> > > (60 fps for video playback typically) and that genericity comes with
>> > > the benefit of a single Linux guest driver.
>> > >
>> > > If there is an agreement to move forward with this, I guess the next
>> > > step for me will be to write a proper spec so the protocol can be
>> > > understood and discussed in detail. Then why not try and upstream th=
e
>> > > kernel driver and make ChromeOS use this too in place of our
>> > > heavily-patched virtio-video. :) We might even make it for virtio 1.=
3.
>> > >
>> > > Looking forward to your feedback. Please don't hesitate to ask
>> > > questions, especially if you are not familiar with V4L2. I can also
>> > > help folks interested in running this with the setup if needed.
>> >
>> > Thank you for sharing your work! I think this looks very promising, an=
d
>> > I'd like to hear feedback from others as well. I assume that would mak=
e
>> > the spec change more digestible than earlier versions.
>>
>> The spec should indeed be considerably lighter. I'll wait for more
>> feedback, but if the concept appeals to other people as well, I may
>> give the spec a try soon.
>>
>
> From my perspective, I think we gain a simpler backend, simpler
> driver, and potential support for more devices for free. It may
> not cover all usecases, but that has already been discussed in this
> thread. For that purpose, virtio-camera will still be a possibility.
>
> FWIW, I think this is a great step in the right direction, as it will mak=
e both
> drivers and devices easier to implement and debug.
>
> BR,
> Albert
>
>>
>> Meanwhile I'll also try to add support for stateful decoders and
>> guest-allocated buffers to the prototype so it can be considered more
>> complete.
>>
>> Cheers,
>> Alex.
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

