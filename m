Return-Path: <virtio-dev-return-11648-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D9CC74A5B
	for <virtio-dev@archiver.kernel.org>; Fri, 17 Mar 2023 07:24:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D6C202B04D
	for <virtio-dev@archiver.kernel.org>; Fri, 17 Mar 2023 07:24:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9752986435
	for <virtio-dev@archiver.kernel.org>; Fri, 17 Mar 2023 07:24:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B6856985FE5; Fri, 17 Mar 2023 07:24:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A00D398642F
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Mar 2023 07:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679037888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brXWh2gMq55v/T1dUjw6JvSDO/Y+hVUDX+a4h/Ty7uY=;
        b=ec557kHBQmrnvtfx0X6EmeXTMRlj30BezdSOKPElHVwmv0L0FAaT8tyahKiXq3N534
         7hlR6oN6+APueujUOwTnkbJ0+FN6e6F6qFkuAzU0/0GWPUzVW0GGqkZspUyhNuWKW7au
         QOqkbfO6wva+Pcf9NSmlSGvKTvl6o9ol+oK+g66XsIlJZMJhJLsHnRlZwAxbNz9KMdpE
         HPQOt0mQjCZRh7eDOwW7xwPtsEBCvE1XMkcSJV3b9E7nEx6pj2DjTuFBD1mWjiDHTEl5
         T4rZ9ZR9T/qrS8L4lcwgSwq9nxk4oF/HjTnNHSagErB1aBwXHk/eVr7rjcelxd+doMTO
         J1Fw==
X-Gm-Message-State: AO0yUKUK1cEJrP92grXxrIWxGmepyzKhG+QGw89u777xwSD+I6j20RLn
	p2jWxbHLAdfwUR44gDCY6ZgnVCJUqslLbZfXLsU=
X-Google-Smtp-Source: AK7set/1ldSJwP2RreUncBY1Xr7GQs+rG0Z4D/HXqv5cTZtBlxiClUAOs15ENeD9saGn2BuPtnwTUQ==
X-Received: by 2002:a17:907:1c81:b0:8b1:304b:8e2c with SMTP id nb1-20020a1709071c8100b008b1304b8e2cmr16835315ejc.0.1679037887712;
        Fri, 17 Mar 2023 00:24:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1c8b:b0:3ed:8826:256e with SMTP id
 k11-20020a05600c1c8b00b003ed8826256emr32822wms.1.1679037884820; Fri, 17 Mar
 2023 00:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
In-Reply-To: <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 17 Mar 2023 16:24:32 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
Message-ID: <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, 
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

Hi Alexander,

On Thu, Mar 16, 2023 at 7:13=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> Hi Alexandre,
>
> On 14.03.23 06:06, Alexandre Courbot wrote:
> > The spec should indeed be considerably lighter. I'll wait for more
> > feedback, but if the concept appeals to other people as well, I may
> > give the spec a try soon.
>
> Did you receive an email I sent on February 7? There was some feedback
> there. It has been already established, that V4L2 UAPI pass-through is
> technically possible. But I had a couple of points why it is not
> desirable. Unfortunately I haven't received a reply. I also don't see
> most of these points addressed in any subsequent emails from you.
>
> I have more to say now, but I'd like to make sure that you're interested
> in the discussion first.

Sorry about that, I dived head first into the code to see how viable
the idea would be and forgot to come back to you. Let me try to answer
your points now that I have a better idea of how this would work.

> > If we find out that there is a benefit in going through the V4L2
> > subsystem (which I cannot see for now), rebuilding the UAPI structures
> > to communicate with the device is not different from building
> > virtio-video specific structures like what we are currently doing.
>
> Well, the V4L2 subsystem is there for a reason, right? It does some
> important things too. I'm going to check all the v4l2_ioctl_ops
> callbacks in the current virtio-video driver to make the list. Also if
> you have some PoC spec/implementations, that would be nice to review. It
> is always better to see the actual implementation, of course.
>
> I have these points so far:
>
> 1. Overall the V4L2 stateful decoder API looks significantly more
> complex to me. Looks like you're a V4L2 expert, so this might not be
> visible to you that much.

V4L2 is more generic than virtio-video, so as a result specific uses
tend to require a bit more operations. I would argue the mental
overhead of working with it is less than significant, and most of it
consists in not forgetting to call STREAMON on a queue after some
operations. Things like format, resolution and buffer management do
not get more complex (and V4L2 is actually more complete than our
previous proposal on these).

The counterpart of this marginal extra complexity is that you can
virtualize more kinds of devices, and even within virtio-video support
more formats than what has been specified so far. If your guest is
Linux, the same kernel driver can be used to expose any kind of device
supported by V4L2, and the driver is also much simpler than
virtio-video, so you are actually reducing complexity significantly
here. Even if you are not Linux, you can share the V4L2 structures
definitions and low-layer code that sends V4L2 commands to the host
between drivers. So while it is true that some specifics become
slightly more complex, there is a lot of potential simplification when
you look at the whole picture.

It's an opinionated proposal, and it comes with a few compromises if
you are mostly interested in codecs alone. But looking at the guest
driver convinces me that this is the better approach when you look at
the whole picture.

>    a. So V4L2 subsystem and the current virtio-video driver are already
> reducing the complexity. And this seems as the right place to do this,
> because the complexity is caused by the amount of V4L2 use cases and its
> legacy. If somebody wants to use virtio-video in a Windows guest, they
> would prefer a simpler API, right? I think this use-case is not purely
> abstract at all.

The V4L2 subsystem is there to factorize code that can be shared
between drivers and manage their internal state. Our target is the
V4L2 UAPI, so a Windows driver needs not be concerned about these
details - it does what it would have done with virtio-video, and just
uses the V4L2 structures to communicate with the host instead of the
virtio-video ones.

>    b. Less complex API is better from a security point of view too. When
> V4L2 was developed, not many people were concerned with malicious USB
> devices probably. At least exploiting a malicious USB device usually
> requires physical access. With virtual devices and multiple VMs the
> stakes are higher, I believe.

That's probably true, but I fail to see how the fact we are using
struct v4l2_buffer instead of struct virtio_video_buffer can have an
impact on that?

V4L2 has a larger UAPI surface because it manages more kinds of
devices, but drivers only need to implement the ioctls they need. For
the rest, they just return -ENOTTY, and evil actors are hopefully kept
at bay.

> 2. We have a working virtio-video driver. So we need very good reasons
> to start from scratch. You name two reasons AFAIR: simplicity and
> possible use of cameras. Did I miss something else?
>
>    a. The simplicity is there only in case all the interfaces are V4L2,
> both in the backend and in the guest. Otherwise the complexity is just
> moved to backends. I haven't seen V4L2 in our setups so far, only some
> proprietary OMX libraries. So from my point of view, this is not
> simplicity in general, but an optimization for a specific narrow use case=
.

V4L2 is not a narrow use-case when it comes to video devices on Linux
- basically every user space application involving cameras or codecs
can use it. Even the virtio-video driver exposes a V4L2 device, so
unless you are using a different driver and proprietary userspace apps
specifically written to interact with that driver, V4L2 is involved in
your setup at some point.

The guest driver that I wrote is, I think, a good example of the
complexity you can expect in terms of guest driver size (as it is
pretty functional already with its 1000 and some LoCs). For the UAPI
complexity, the host device basically unpacks the information it needs
and rebuilds the V4L2 structures before calling into the host device,
and I don't see this process as more complex that the unpacking of
virtio-video structs which we also did in crosvm.

>    b. For modern cameras the V4L2 interface is not enough anyway. This
> was already discussed AFAIR. There is a separate virtio-camera
> specification, that indeed is based on V4L2 UAPI as you said. But
> combining these two specs is certainly not future proof, right? So I
> think it is best to let the virtio-camera spec to be developed
> independently.

I don't know if virtio-camera has made progress that they have not
published yet, but from what I have seen virtio-v4l2 can cover
everything that the currently published driver does (I could not find
a specification, but please point me to it if it exists), so there
would be no conflict to resolve.

V4L2 with requests support should be capable of handling complex
camera configurations, but the effort indeed seems to have switched to
KCAM when it comes to supporting complex native cameras natively. That
being said:

* KCAM is not merged yet, is probably not going to be for some time
(https://lwn.net/Articles/904776/), and we don't know how we can
handle virtualization with it,
* The fact that the camera is complex on the host does not mean that
all that complexity needs to be exposed to the guest. I don't know how
the camera folks want to manage this, but one can imagine that the
host could expose a simpler model for the virtual camera, with only
the required knobs, while the host takes care of doing all the complex
configuration.
* The counter argument can be made that simple camera devices do not
need a complex virtualization solution, so one can also invoke
simplicity here to advocate for virtio-v4l2.

My point is not to say that all other camera virtualization efforts
should be abandoned - if indeed there is a need for something more
specific, then nothing prevents us from having a virtio-camera
specification added. However, we are nowhere close to this at the
moment, and right now there is no official solution for camera
virtualization, so I see no reason to deny the opportunity to support
simple camera devices since its cost would just be to add "and cameras
device" in the paragraph of the spec that explains what devices are
supported.

> 3. More specifically I can see, that around 95% V4L2 drivers use
> videobuf2. This includes the current virtio-video driver. Bypassing the
> V4L2 subsystem means that vb2 can't be used, right? In various
> discussions vb2 popped up as a thing, that would be hard to avoid. What
> do you think about this? How are you going to deal with various V4L2
> memory types (V4L2_MEMORY_MMAP, V4L2_MEMORY_DMABUF, etc), for example?
> I'll try to dive deeper myself too...

VB2 is entirely avoided in the current driver, but my understanding is
that its helpers could be used if needed.

In virtio-v4l2, MMAP means that the host is responsible for managing
the buffers, so vb2 is entirely avoided. USERPTR means the guest
passes a SG list of guest physical addresses as mapping memory. VB2
may or may not be involved in managing this memory, but most likely
not if that memory comes from the guest userspace. DMABUF means the
guest passes a virtio object as the backing memory of the buffer.
There again there is no particular management to be done on the guest
side.

I bypassed VB2 for the current driver, and the cost of doing this is
that I had to write my own mmap() function.

> >> 3. user-space <-> v4l2 subsystem API is already the same or very close
> >> to v4l2 subsystem <-> v4l2 driver API. I believe this is not the case
> >> even with stateful decoder/encoder. Even more with stateless decoders
> >> because I can see, that v4l2 subsystem actually stores some state in
> >> this case as well. Which is quite reasonable I think.
> > Actually I don't think this is even something we need to think about -
> > in its simplest form the V4L2 guest driver just needs to act as a
> > proxy for the device. So which decoder API is used by the host is
> > completely irrelevant to the guest driver - it can support a decoder,
> > an encoder, or a camera - it doesn't even need to be aware of what
> > kind of device it is exposing and that simplicity is another thing
> > that I like with this design.
>
> As I wrote above the design would be indeed simple only in case the
> actual hardware is exposed to a backend through V4L2 too. Otherwise the
> complexity is just moved to backends.

Yes, and while I acknowledge that, this is not really more complex
that what you would have to do with a virtio-video device which also
needs to manage its own state and drive the hardware through backends.
I say that based on the experience working on the virtio-video device
in crosvm which follows that design too.

> > This simplicity goes away if the guest device does not use V4L2 as its
> > user-space interface (e.g. Windows?). In this case we would be in the
> > exact same scenario as the current virtio-video spec, where we need to
> > build device-specific structures from the guest driver's internal
> > state.
>
> IMO this is not quite correct. The scenario would not be not the same,
> because the V4L2 stateful decoder API is more complex in comparison to
> any virtio-video spec draft version. Probably it would be great to have
> a list of differences. I hope to find some time for this later...

There is not much difference between the V4L2 stateful decoder spec
and the virtio-video spec. Actually that's the very reason why I am
proposing to just virtualize V4L2, we were redoing the same thing.

I have quickly parsed the V4L2 decoder spec and here are the
differences I have found:

* VIDIOC_STREAMON needs to be called on both queues to start decoding.
* Frame crop is obtained using VIDIOC_G_SELECTION instead of being
available alongside the format parameter.
* End of drain requires to send the V4L2_DEC_CMD_START and call
VIDIOC_STREAMON again.
* Seeking is done by calling VIDIOC_STREAMOFF followed by
VIDIOC_STREAMON on the OUTPUT queue instead of having a dedicated
command.

... and that's basically it! Do we really need a new spec just to
smoothen these differences?

I hope I have somehow addressed your points. The main point here is to
discuss whether the V4L2 UAPI is a suitable transport for guest/host
accelerated codec work, regardless of what the guest or host
ultimately uses as UAPI. The goal of the PoC is to demonstrate that
this is a viable solution. This PoC is largely simplified by the fact
that V4L2 is used all along the way, but this is irrelevant - yes,
actual devices will likely talk to other APIs and maintain more state,
like a virtio-video device would do. What I want to demonstrate is
that we can send encoding work and receive a valid stream, and that it
is not costly, and only marginally more complex than our virtio-video
spec attempts.

... and we can support cameras too, but that's just a convenient
side-effect, not the ultimate solution to the camera virtualization
problem (that's for the camera folks to decide).

 Cheers,
Alex.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

