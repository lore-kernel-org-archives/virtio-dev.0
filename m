Return-Path: <virtio-dev-return-11778-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE74FC76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 13:00:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DAF9042A69
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 13:00:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C31A59862BC
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 13:00:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AD3F9983BC4; Mon, 27 Mar 2023 13:00:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A297986260
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Mar 2023 13:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: vHBvxG8ROjCNtoKAJ3d1nw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJvgMimXFXbcZqdL32grHodogjpZaICpv5PhO8zSwZU=;
        b=tFvwFYcnd79FEunUfr3QuYuUe68H5fvDJECe0kWl2R3H0C8vGNrkIy4MurWa4vWNSO
         3zljQKM4ZlhxT1B2q9kNfspRmYQxjJzzLodETPG7V5YD5rCtwD67HgUsqwySYbDTvMnu
         0QbXYAf6prIMewsS8redbsfyA2O0XKrDEtJtC3ToLtk0DimyfcwidodVDEKKyj1TKRaY
         eiQcNbPBWquVMdXNMR/PYrXEGxmjzOOZt/Setk4hy6ozwv5satPxIm5xqWehi/A2c/on
         jRrjMf49KnNQ/XOJNDCc3V/Xbf9CYVB8nBExSqRJGeaeRvHSWqYaij7/2toluaOjO4Z2
         3liw==
X-Gm-Message-State: AAQBX9dX1PLWWUtLFJfvGEJzgYqQkUI4cr4hyUFRliUkIKwkjd4/PSpz
	MtSmwaoRj9LY3JWFji2x6+2QjGoPFaRW6kFu3jwFQ1yLSE/29CY6bsrPx5zVcTRcU2vpV+nJvmD
	66tt3J2tbtzDg3EhVy8AzlnqBrTwDyH+X5Jr+JY6T3awW
X-Received: by 2002:a63:1d08:0:b0:512:fd76:9f0a with SMTP id d8-20020a631d08000000b00512fd769f0amr2957966pgd.9.1679922027957;
        Mon, 27 Mar 2023 06:00:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZUKFLOpLl7gdZL0L/Q1flC/eRkc2FuOi276rAGZkDCOYAYdohhwqGbhS8szZa3wSO0TMQ1K1x6drqitO1j6jI=
X-Received: by 2002:a63:1d08:0:b0:512:fd76:9f0a with SMTP id
 d8-20020a631d08000000b00512fd769f0amr2957948pgd.9.1679922027483; Mon, 27 Mar
 2023 06:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
In-Reply-To: <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 27 Mar 2023 15:00:16 +0200
Message-ID: <CADSE00KD9=2hs5b=fZpTe7XDm3Q3PAmQczGciE=zLBOF3UNLBA@mail.gmail.com>
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Cornelia Huck <cohuck@redhat.com>, 
	Alexander Gordeev <alexander.gordeev@opensynergy.com>, virtio-dev@lists.oasis-open.org, 
	Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Enric Balletbo i Serra <eballetb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000b2eb7a05f7e15313"
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

--000000000000b2eb7a05f7e15313
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 6:06=E2=80=AFAM Alexandre Courbot <acourbot@chromiu=
m.org>
wrote:

> Hi Cornelia,
>
> On Fri, Mar 10, 2023 at 11:20=E2=80=AFPM Cornelia Huck <cohuck@redhat.com=
> wrote:
> >
> > On Fri, Mar 10 2023, Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > > Hi Cornelia,
> > >
> > > On Fri, Mar 10, 2023 at 7:51=E2=80=AFPM Cornelia Huck <cohuck@redhat.=
com>
> wrote:
> > >>
> > >> On Tue, Feb 07 2023, Cornelia Huck <cohuck@redhat.com> wrote:
> > >>
> > >> > On Tue, Feb 07 2023, Alexandre Courbot <acourbot@chromium.org>
> wrote:
> > >> >
> > >> >> On Mon, Feb 6, 2023 at 11:13 PM Cornelia Huck <cohuck@redhat.com>
> wrote:
> > >> >>> I hope we can sort this out soon -- I guess I'm not the only one
> who is
> > >> >>> anxious about this spec moving forward :) Please let me know if =
I
> can
> > >> >>> help in any way.
> > >> >>
> > >> >> I'll try to address Alexander's points in more detail, but I am n=
ot
> > >> >> seeing any blocking issue with using the V4L2 UAPI as the basis f=
or
> > >> >> virtio-video (we are working on a small proof-of-concept and thin=
gs
> > >> >> are going smoothly so far).
> > >> >
> > >> > Great to hear, looking forward to it!
> > >>
> > >> Quick question: Is there any git repo or similar where interested
> > >> parties can follow along? It would be great to have virtio-video in
> 1.3;
> > >> if you have some idea on when it might be ready, we could come up
> with a
> > >> schedule to accommodate that.
> > >
> > > I'm glad you asked, as a matter of fact I have just finished the
> > > virtio-v4l2 proof of concept today! It is capable of exposing a camer=
a
> > > or encoder V4L2 device from the host to the guest, by encapsulating
> > > V4L2 commands into virtio.
> >
> > \o/ Excellent news!
>
> I am delighted that you seem to like it!
>
> >
> > >
> > > The guest driver code (single file for simplicity):
> > >
> https://github.com/Gnurou/linux/blob/virtio-v4l2/drivers/media/virtio-v4l=
2/virtio_v4l2_driver.c
> > >
> > > Bulk of the host-side crosvm device code:
> > >
> https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4l2=
/protocol.rs
> > >
> https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4l2=
/worker.rs
> > >
> > > Neither are works of art, so please forgive the few inefficiencies
> > > here and there - the goal was to make them easy to understand. Still,
> > > the guest driver is probably closer to what a final driver would look
> > > like. It fits in around 1,000 LoCs (comments excluded), which is
> > > enough to support stateful video encoders as well as USB camera
> > > devices. Decoders cannot be run yet because they require support for
> > > V4L2 events and polling - I will try to enable these features next.
> > > But even in its current state this driver shows one interesting aspec=
t
> > > of virtio-v4l2, at least for Linux guests: a single and relatively
> > > simple driver is able to drive a wide range of devices.
> >
> > I had a quick look at the driver; it indeed looks like a big win on
> > Linux systems. (The one thing I'm missing is how easy it would be to
> > replicate the used v4l2 parts on non-Linux systems.)
>
> For non-Linux systems (host or guest, we may need to copy/paste or
> reproduce the UAPI structures. Thankfully they are unambiguously
> described in the UAPI documentation, see for example
> https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-enum-fmt.html
> for the formats structure.
>
> >
> > >
> > > The crosvm device code proxies a V4L2 device on the host, again using
> > > roughly 1,200 lines of non-comment code. This design does not intend
> > > to reflect what an actual host device will look like - in effect they
> > > should be much more specialized since they are unlikely to also call
> > > into V4L2 on the host side. However, if the host is Linux and we just
> > > want to expose a USB camera or other V4L2 device almost as-is, then
> > > this could actually be a good fit.
> > >
> > > The protocol should be easy to understand by looking at the code - we
> > > only have 5 virtio commands to open/close a session, map/unmap a
> > > host-allocated buffer into the guest PAS, and the IOCTL command which
> > > sends V4L2 ioctl structures to the host and waits for its reply. All
> > > ioctls are synchronous per-session, meaning that a session only sends
> > > one ioctl at a time and waits for its response before it can send the
> > > next (as this is what user-space does too). Ioctls, however, never
> > > block on the host side and the ones that would do (DQBUF and DQEVENT)
> > > are replaced by host-initiated events. On top of being familiar to
> > > people who have worked with V4L2 (i.e. a large portion of the media
> > > folks), this simple design seems to be efficient as I have observed
> > > identical performance on both host and guest with the vicodec virtual
> > > encoder. Since this device generates frames using the CPU and keeps
> > > one core 100% busy, any overhead introduced by virtualization should
> > > be noticeable - yet I got nearly identical framerates on both host an=
d
> > > guest.
> >
> > I haven't worked with v4l2, but this approach sounds reasonable to me.
> >
> > >
> > > Things that still need to be implemented before this can be considere=
d
> > > more complete:
> > >
> > > * Controls. This should not be particularly difficult but I left it
> > > for now as they are not necessary to demonstrate the viability of thi=
s
> > > project.
> > > * Guest-allocated memory buffers and virtio objects. Based on our
> > > previous experience with virtio-video these should not be difficult t=
o
> > > implement. Currently all video buffers are allocated by the host, and
> > > mapped into the guest if needed.
> > > * Events and polling, required to use a decoder. Again these were not
> > > strictly necessary for the proof of concept, but since we've gone thi=
s
> > > far I will try to get them to work as the next step.
> > > * Requests and multi-part media devices. This will be necessary in
> > > order to support more modern camera pipelines. I haven't made up my
> > > mind yet about whether we should support this, but if we want to it
> > > should not be too hard (describe several devices in the configuration
> > > space and enable the request-related commands). I need to talk to
> > > camera folks to know whether there is an actual interest in this.
> > > * Support for more ioctls, in case we want to support tuners and
> radios.
> > >
> > > If you want to try this code, you need to build the guest kernel with
> > > CONFIG_VIRTIO_V4L2 and enable the `v4l2` feature when building crosvm
> > > (check out the Book of Crosvm if you need instructions on how to buil=
d
> > > and use it). Then pass --virtio-v4l2=3D/dev/videoX to crosvm in order=
 to
> > > expose the /dev/videoX host V4L2 device to the guest.
> > >
> > > I have successfully captured frames (and verified their validity)
> > > using the following devices:
> > >
> > > * A simple USB camera using the `uvcvideo` driver. Both host and gues=
t
> > > could capture a MJPEG stream with the following command:
> > > v4l2-ctl -d0 -v pixelformat=3DMJPG --stream-mmap --stream-to=3Dtest.m=
jpg
> > >
> > > * The vivid virtual camera driver. I could capture a valid YUV stream
> > > using the following command:
> > > v4l2-ctl -d0 -v pixelformat=3DNV12 --stream-mmap --stream-to test.yuv
> > >
> > > * The encoder device of the vicodec virtual codec driver. On both hos=
t
> > > and guest, the following command produces a valid FWHT stream in
> > > `test.fwht`:
> > > v4l2-ctl -x pixelformat=3DNV12 --stream-mmap --stream-out-mmap
> > > --stream-to-hdr test.fwht
> >
> > This looks very good already.
>
> Turns out that ffmpeg can also be used to capture video and encode it
> in a more convenient format, e.g:
>
> ffmpeg -f v4l2 -i /dev/video0 output.mkv
>
> This is a very good sign with respect to compliance with V4L2
> protocols. We had a very hard time getting the original virtio-video
> to be used with common tools and passing the V4L2 compliance test in
> general, but with this approach it seems like it will be much simpler
> to achieve.
>

I was curious, and I have tried the prototype. I was gladly surprised at
how nice
it behaves in this state. Really nice work.

I have managed to expose different devices to the host and run compliance
tests,
capture frames from a camera, and encode by doing:

# v4l2-ctl -d0 -x width=3D640,height=3D480 -v
width=3D640,height=3D480,pixelformat=3DFWHT \
                --stream-mmap --stream-out-mmap \
                --stream-from in-640-480.YU12 --stream-to output.fwht

Some results for the compliance tests using vicodec:
*  Enconder device
    * Host
Total for vicodec device /dev/video4: 46, Succeeded: 45, Failed: 1,
Warnings: 0
    * Guest
Total for virtio_v4l2 device /dev/video0: 45, Succeeded: 34, Failed: 11,
Warnings: 0

*  Decoder device
    * Host
Total for vicodec device /dev/video5: 46, Succeeded: 42, Failed: 4,
Warnings: 0
    * Guest
Total for virtio_v4l2 device /dev/video0: 45, Succeeded: 36, Failed: 9,
Warnings: 0


>
> >
> > >
> > > By this work I hope to demonstrate to people interested in video
> > > virtualization that encapsulating V4L2 in virtio is not only a viable
> > > solution, it is a huge shortcut in terms of specification crafting,
> > > driver writing, and overall headaches involved in specifying somethin=
g
> > > as complex as a video device. Not only could we support video decoder=
s
> > > and encoders, which was the goal of virtio-video, we would also get
> > > image processors, video overlays and simple cameras for free, and
> > > potentially more complex cameras if we decide to.
> > >
> > > After writing this prototype (and a couple attempts at the
> > > virtio-video specification) I don't see any reason not to rely on a
> > > battle-tested protocol instead of designing our own that does
> > > basically the same thing. The genericity of V4L2 may mean that
> > > sometimes we will need 2 commands where virtio-video would require
> > > only one, but we are talking about a low frequency of virtio commands
> > > (60 fps for video playback typically) and that genericity comes with
> > > the benefit of a single Linux guest driver.
> > >
> > > If there is an agreement to move forward with this, I guess the next
> > > step for me will be to write a proper spec so the protocol can be
> > > understood and discussed in detail. Then why not try and upstream the
> > > kernel driver and make ChromeOS use this too in place of our
> > > heavily-patched virtio-video. :) We might even make it for virtio 1.3=
.
> > >
> > > Looking forward to your feedback. Please don't hesitate to ask
> > > questions, especially if you are not familiar with V4L2. I can also
> > > help folks interested in running this with the setup if needed.
> >
> > Thank you for sharing your work! I think this looks very promising, and
> > I'd like to hear feedback from others as well. I assume that would make
> > the spec change more digestible than earlier versions.
>
> The spec should indeed be considerably lighter. I'll wait for more
> feedback, but if the concept appeals to other people as well, I may
> give the spec a try soon.
>
>
From my perspective, I think we gain a simpler backend, simpler
driver, and potential support for more devices for free. It may
not cover all usecases, but that has already been discussed in this
thread. For that purpose, virtio-camera will still be a possibility.

FWIW, I think this is a great step in the right direction, as it will make
both
drivers and devices easier to implement and debug.

BR,
Albert


> Meanwhile I'll also try to add support for stateful decoders and
> guest-allocated buffers to the prototype so it can be considered more
> complete.
>
> Cheers,
> Alex.
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--000000000000b2eb7a05f7e15313
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 14, 2023 at 6:06=E2=80=AFA=
M Alexandre Courbot &lt;<a href=3D"mailto:acourbot@chromium.org">acourbot@c=
hromium.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Cornelia,<br>
<br>
On Fri, Mar 10, 2023 at 11:20=E2=80=AFPM Cornelia Huck &lt;<a href=3D"mailt=
o:cohuck@redhat.com" target=3D"_blank">cohuck@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Mar 10 2023, Alexandre Courbot &lt;<a href=3D"mailto:acourbot@=
chromium.org" target=3D"_blank">acourbot@chromium.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Hi Cornelia,<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Mar 10, 2023 at 7:51=E2=80=AFPM Cornelia Huck &lt;<a href=
=3D"mailto:cohuck@redhat.com" target=3D"_blank">cohuck@redhat.com</a>&gt; w=
rote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Tue, Feb 07 2023, Cornelia Huck &lt;<a href=3D"mailto:cohu=
ck@redhat.com" target=3D"_blank">cohuck@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; On Tue, Feb 07 2023, Alexandre Courbot &lt;<a href=3D"ma=
ilto:acourbot@chromium.org" target=3D"_blank">acourbot@chromium.org</a>&gt;=
 wrote:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; On Mon, Feb 6, 2023 at 11:13 PM Cornelia Huck &lt;<a=
 href=3D"mailto:cohuck@redhat.com" target=3D"_blank">cohuck@redhat.com</a>&=
gt; wrote:<br>
&gt; &gt;&gt; &gt;&gt;&gt; I hope we can sort this out soon -- I guess I&#3=
9;m not the only one who is<br>
&gt; &gt;&gt; &gt;&gt;&gt; anxious about this spec moving forward :) Please=
 let me know if I can<br>
&gt; &gt;&gt; &gt;&gt;&gt; help in any way.<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; I&#39;ll try to address Alexander&#39;s points in mo=
re detail, but I am not<br>
&gt; &gt;&gt; &gt;&gt; seeing any blocking issue with using the V4L2 UAPI a=
s the basis for<br>
&gt; &gt;&gt; &gt;&gt; virtio-video (we are working on a small proof-of-con=
cept and things<br>
&gt; &gt;&gt; &gt;&gt; are going smoothly so far).<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Great to hear, looking forward to it!<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Quick question: Is there any git repo or similar where intere=
sted<br>
&gt; &gt;&gt; parties can follow along? It would be great to have virtio-vi=
deo in 1.3;<br>
&gt; &gt;&gt; if you have some idea on when it might be ready, we could com=
e up with a<br>
&gt; &gt;&gt; schedule to accommodate that.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m glad you asked, as a matter of fact I have just finished =
the<br>
&gt; &gt; virtio-v4l2 proof of concept today! It is capable of exposing a c=
amera<br>
&gt; &gt; or encoder V4L2 device from the host to the guest, by encapsulati=
ng<br>
&gt; &gt; V4L2 commands into virtio.<br>
&gt;<br>
&gt; \o/ Excellent news!<br>
<br>
I am delighted that you seem to like it!<br>
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; The guest driver code (single file for simplicity):<br>
&gt; &gt; <a href=3D"https://github.com/Gnurou/linux/blob/virtio-v4l2/drive=
rs/media/virtio-v4l2/virtio_v4l2_driver.c" rel=3D"noreferrer" target=3D"_bl=
ank">https://github.com/Gnurou/linux/blob/virtio-v4l2/drivers/media/virtio-=
v4l2/virtio_v4l2_driver.c</a><br>
&gt; &gt;<br>
&gt; &gt; Bulk of the host-side crosvm device code:<br>
&gt; &gt; <a href=3D"https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devi=
ces/src/virtio/v4l2/protocol.rs" rel=3D"noreferrer" target=3D"_blank">https=
://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4l2/protoc=
ol.rs</a><br>
&gt; &gt; <a href=3D"https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devi=
ces/src/virtio/v4l2/worker.rs" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/v4l2/worker.r=
s</a><br>
&gt; &gt;<br>
&gt; &gt; Neither are works of art, so please forgive the few inefficiencie=
s<br>
&gt; &gt; here and there - the goal was to make them easy to understand. St=
ill,<br>
&gt; &gt; the guest driver is probably closer to what a final driver would =
look<br>
&gt; &gt; like. It fits in around 1,000 LoCs (comments excluded), which is<=
br>
&gt; &gt; enough to support stateful video encoders as well as USB camera<b=
r>
&gt; &gt; devices. Decoders cannot be run yet because they require support =
for<br>
&gt; &gt; V4L2 events and polling - I will try to enable these features nex=
t.<br>
&gt; &gt; But even in its current state this driver shows one interesting a=
spect<br>
&gt; &gt; of virtio-v4l2, at least for Linux guests: a single and relativel=
y<br>
&gt; &gt; simple driver is able to drive a wide range of devices.<br>
&gt;<br>
&gt; I had a quick look at the driver; it indeed looks like a big win on<br=
>
&gt; Linux systems. (The one thing I&#39;m missing is how easy it would be =
to<br>
&gt; replicate the used v4l2 parts on non-Linux systems.)<br>
<br>
For non-Linux systems (host or guest, we may need to copy/paste or<br>
reproduce the UAPI structures. Thankfully they are unambiguously<br>
described in the UAPI documentation, see for example<br>
<a href=3D"https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-enum-=
fmt.html" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/h=
tml/v4.9/media/uapi/v4l/vidioc-enum-fmt.html</a><br>
for the formats structure.<br>
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; The crosvm device code proxies a V4L2 device on the host, again u=
sing<br>
&gt; &gt; roughly 1,200 lines of non-comment code. This design does not int=
end<br>
&gt; &gt; to reflect what an actual host device will look like - in effect =
they<br>
&gt; &gt; should be much more specialized since they are unlikely to also c=
all<br>
&gt; &gt; into V4L2 on the host side. However, if the host is Linux and we =
just<br>
&gt; &gt; want to expose a USB camera or other V4L2 device almost as-is, th=
en<br>
&gt; &gt; this could actually be a good fit.<br>
&gt; &gt;<br>
&gt; &gt; The protocol should be easy to understand by looking at the code =
- we<br>
&gt; &gt; only have 5 virtio commands to open/close a session, map/unmap a<=
br>
&gt; &gt; host-allocated buffer into the guest PAS, and the IOCTL command w=
hich<br>
&gt; &gt; sends V4L2 ioctl structures to the host and waits for its reply. =
All<br>
&gt; &gt; ioctls are synchronous per-session, meaning that a session only s=
ends<br>
&gt; &gt; one ioctl at a time and waits for its response before it can send=
 the<br>
&gt; &gt; next (as this is what user-space does too). Ioctls, however, neve=
r<br>
&gt; &gt; block on the host side and the ones that would do (DQBUF and DQEV=
ENT)<br>
&gt; &gt; are replaced by host-initiated events. On top of being familiar t=
o<br>
&gt; &gt; people who have worked with V4L2 (i.e. a large portion of the med=
ia<br>
&gt; &gt; folks), this simple design seems to be efficient as I have observ=
ed<br>
&gt; &gt; identical performance on both host and guest with the vicodec vir=
tual<br>
&gt; &gt; encoder. Since this device generates frames using the CPU and kee=
ps<br>
&gt; &gt; one core 100% busy, any overhead introduced by virtualization sho=
uld<br>
&gt; &gt; be noticeable - yet I got nearly identical framerates on both hos=
t and<br>
&gt; &gt; guest.<br>
&gt;<br>
&gt; I haven&#39;t worked with v4l2, but this approach sounds reasonable to=
 me.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Things that still need to be implemented before this can be consi=
dered<br>
&gt; &gt; more complete:<br>
&gt; &gt;<br>
&gt; &gt; * Controls. This should not be particularly difficult but I left =
it<br>
&gt; &gt; for now as they are not necessary to demonstrate the viability of=
 this<br>
&gt; &gt; project.<br>
&gt; &gt; * Guest-allocated memory buffers and virtio objects. Based on our=
<br>
&gt; &gt; previous experience with virtio-video these should not be difficu=
lt to<br>
&gt; &gt; implement. Currently all video buffers are allocated by the host,=
 and<br>
&gt; &gt; mapped into the guest if needed.<br>
&gt; &gt; * Events and polling, required to use a decoder. Again these were=
 not<br>
&gt; &gt; strictly necessary for the proof of concept, but since we&#39;ve =
gone this<br>
&gt; &gt; far I will try to get them to work as the next step.<br>
&gt; &gt; * Requests and multi-part media devices. This will be necessary i=
n<br>
&gt; &gt; order to support more modern camera pipelines. I haven&#39;t made=
 up my<br>
&gt; &gt; mind yet about whether we should support this, but if we want to =
it<br>
&gt; &gt; should not be too hard (describe several devices in the configura=
tion<br>
&gt; &gt; space and enable the request-related commands). I need to talk to=
<br>
&gt; &gt; camera folks to know whether there is an actual interest in this.=
<br>
&gt; &gt; * Support for more ioctls, in case we want to support tuners and =
radios.<br>
&gt; &gt;<br>
&gt; &gt; If you want to try this code, you need to build the guest kernel =
with<br>
&gt; &gt; CONFIG_VIRTIO_V4L2 and enable the `v4l2` feature when building cr=
osvm<br>
&gt; &gt; (check out the Book of Crosvm if you need instructions on how to =
build<br>
&gt; &gt; and use it). Then pass --virtio-v4l2=3D/dev/videoX to crosvm in o=
rder to<br>
&gt; &gt; expose the /dev/videoX host V4L2 device to the guest.<br>
&gt; &gt;<br>
&gt; &gt; I have successfully captured frames (and verified their validity)=
<br>
&gt; &gt; using the following devices:<br>
&gt; &gt;<br>
&gt; &gt; * A simple USB camera using the `uvcvideo` driver. Both host and =
guest<br>
&gt; &gt; could capture a MJPEG stream with the following command:<br>
&gt; &gt; v4l2-ctl -d0 -v pixelformat=3DMJPG --stream-mmap --stream-to=3Dte=
st.mjpg<br>
&gt; &gt;<br>
&gt; &gt; * The vivid virtual camera driver. I could capture a valid YUV st=
ream<br>
&gt; &gt; using the following command:<br>
&gt; &gt; v4l2-ctl -d0 -v pixelformat=3DNV12 --stream-mmap --stream-to test=
.yuv<br>
&gt; &gt;<br>
&gt; &gt; * The encoder device of the vicodec virtual codec driver. On both=
 host<br>
&gt; &gt; and guest, the following command produces a valid FWHT stream in<=
br>
&gt; &gt; `test.fwht`:<br>
&gt; &gt; v4l2-ctl -x pixelformat=3DNV12 --stream-mmap --stream-out-mmap<br=
>
&gt; &gt; --stream-to-hdr test.fwht<br>
&gt;<br>
&gt; This looks very good already.<br>
<br>
Turns out that ffmpeg can also be used to capture video and encode it<br>
in a more convenient format, e.g:<br>
<br>
ffmpeg -f v4l2 -i /dev/video0 output.mkv<br>
<br>
This is a very good sign with respect to compliance with V4L2<br>
protocols. We had a very hard time getting the original virtio-video<br>
to be used with common tools and passing the V4L2 compliance test in<br>
general, but with this approach it seems like it will be much simpler<br>
to achieve.<br></blockquote><div><br></div><div>I was curious, and I have t=
ried the prototype. I was gladly surprised at how nice</div><div>it behaves=
 in this state. Really nice work.</div><div><br></div><div>I have managed t=
o expose different devices to the host and run compliance tests,</div><div>=
capture frames from a camera, and encode by doing:</div><div><br></div><div=
><div># v4l2-ctl -d0 -x width=3D640,height=3D480 -v width=3D640,height=3D48=
0,pixelformat=3DFWHT \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 --stream-mmap --stream-out-mmap \</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --stream-from in-640-480.YU12 --stre=
am-to output.fwht</div></div><div><br></div><div>Some results for the compl=
iance tests using vicodec:</div><div><div>*=C2=A0 Enconder device</div><div=
>=C2=A0 =C2=A0 * Host</div><div>Total for vicodec device /dev/video4: 46, S=
ucceeded: 45, Failed: 1, Warnings: 0<br></div><div>=C2=A0 =C2=A0 * Guest</d=
iv><div>Total for virtio_v4l2 device /dev/video0: 45, Succeeded: 34, Failed=
: 11, Warnings: 0<br></div><div>=C2=A0</div><div>*=C2=A0 Decoder device</di=
v><div>=C2=A0 =C2=A0 * Host</div><div>Total for vicodec device /dev/video5:=
 46, Succeeded: 42, Failed: 4, Warnings: 0<br></div><div>=C2=A0 =C2=A0 * Gu=
est</div><div>Total for virtio_v4l2 device /dev/video0: 45, Succeeded: 36, =
Failed: 9, Warnings: 0</div></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; By this work I hope to demonstrate to people interested in video<=
br>
&gt; &gt; virtualization that encapsulating V4L2 in virtio is not only a vi=
able<br>
&gt; &gt; solution, it is a huge shortcut in terms of specification craftin=
g,<br>
&gt; &gt; driver writing, and overall headaches involved in specifying some=
thing<br>
&gt; &gt; as complex as a video device. Not only could we support video dec=
oders<br>
&gt; &gt; and encoders, which was the goal of virtio-video, we would also g=
et<br>
&gt; &gt; image processors, video overlays and simple cameras for free, and=
<br>
&gt; &gt; potentially more complex cameras if we decide to.<br>
&gt; &gt;<br>
&gt; &gt; After writing this prototype (and a couple attempts at the<br>
&gt; &gt; virtio-video specification) I don&#39;t see any reason not to rel=
y on a<br>
&gt; &gt; battle-tested protocol instead of designing our own that does<br>
&gt; &gt; basically the same thing. The genericity of V4L2 may mean that<br=
>
&gt; &gt; sometimes we will need 2 commands where virtio-video would requir=
e<br>
&gt; &gt; only one, but we are talking about a low frequency of virtio comm=
ands<br>
&gt; &gt; (60 fps for video playback typically) and that genericity comes w=
ith<br>
&gt; &gt; the benefit of a single Linux guest driver.<br>
&gt; &gt;<br>
&gt; &gt; If there is an agreement to move forward with this, I guess the n=
ext<br>
&gt; &gt; step for me will be to write a proper spec so the protocol can be=
<br>
&gt; &gt; understood and discussed in detail. Then why not try and upstream=
 the<br>
&gt; &gt; kernel driver and make ChromeOS use this too in place of our<br>
&gt; &gt; heavily-patched virtio-video. :) We might even make it for virtio=
 1.3.<br>
&gt; &gt;<br>
&gt; &gt; Looking forward to your feedback. Please don&#39;t hesitate to as=
k<br>
&gt; &gt; questions, especially if you are not familiar with V4L2. I can al=
so<br>
&gt; &gt; help folks interested in running this with the setup if needed.<b=
r>
&gt;<br>
&gt; Thank you for sharing your work! I think this looks very promising, an=
d<br>
&gt; I&#39;d like to hear feedback from others as well. I assume that would=
 make<br>
&gt; the spec change more digestible than earlier versions.<br>
<br>
The spec should indeed be considerably lighter. I&#39;ll wait for more<br>
feedback, but if the concept appeals to other people as well, I may<br>
give the spec a try soon.<br>
<br></blockquote><div><br></div><div>From my perspective, I think we gain a=
 simpler backend, simpler</div><div>driver, and potential support for more =
devices for free. It may</div><div>not cover all usecases, but that has alr=
eady been discussed in this</div><div>thread. For that purpose, virtio-came=
ra will still be a possibility.</div><div><br></div><div>FWIW, I think this=
 is a great step in the right direction, as it will make both</div><div>dri=
vers and devices easier to implement and debug.</div><div><br></div><div>BR=
,</div><div>Albert</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
Meanwhile I&#39;ll also try to add support for stateful decoders and<br>
guest-allocated buffers to the prototype so it can be considered more<br>
complete.<br>
<br>
Cheers,<br>
Alex.<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div></div>

--000000000000b2eb7a05f7e15313--

