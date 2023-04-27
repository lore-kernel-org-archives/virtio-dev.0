Return-Path: <virtio-dev-return-12448-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAF4C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 13:16:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A87B3DF38
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 13:16:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0467B986653
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 13:16:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC982986642; Thu, 27 Apr 2023 13:16:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9379986644
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 13:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601404; x=1685193404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PL7wGuzCBLW7PjT7tVkE+P+21UXKPXTlLZsYBTOjD0E=;
        b=FWLc4SGn463vNIymk2gDhAIlMmfkKai8tm3tnnEIp9Y4sUJ9IE4EkTLMLR5P/dFlxo
         gOIgnJYLueiH5VfVKeGObqxCMnmjyK77HGUu71c4I31tPWHbBiDfUZKqh9xWW2/XCMbq
         z/ANlxms+38Ars1XcpTusqW3o9HV2IwE3QvqiU+f2WhUVYWBj9bd+JMl5X2Vipezsnwb
         cn+NaS/o9RpnDPzWBiY0dSuc1qHB8iInYPtJCNLyuD4z/owKa/4xwmvA2mqhK6k7uO5a
         y6KrmmVOp6IARSB05lBFsHbkc9kjcW6/0tffjNrypoAexP06gh5bxGHuL3gVJjxP9aoG
         AzgQ==
X-Gm-Message-State: AC+VfDyyjyRuzff9dWlliGigs/Se4+sXC82+YKSoKm/3JVIaUQFfESDb
	WoHFK1BY7eJrkSC21EnASb047WVP4osSY2brSEI=
X-Google-Smtp-Source: ACHHUZ5ORgMrCELEWaUEjOTTF7zaXX9VUv+5Wy38XmXvcKxGYaOxhJYEsf7z26yCP0co5q4cG1QhNQ==
X-Received: by 2002:a5e:a70b:0:b0:758:d18e:5c71 with SMTP id b11-20020a5ea70b000000b00758d18e5c71mr1192095iod.7.1682601403579;
        Thu, 27 Apr 2023 06:16:43 -0700 (PDT)
X-Received: by 2002:a05:6e02:160b:b0:32a:6ff7:bbbd with SMTP id
 t11-20020a056e02160b00b0032a6ff7bbbdmr192464ilu.13.1682601401518; Thu, 27 Apr
 2023 06:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
In-Reply-To: <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Thu, 27 Apr 2023 22:16:29 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
Message-ID: <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
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

On Thu, Apr 27, 2023 at 12:11=E2=80=AFAM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 21.04.23 06:02, Alexandre Courbot wrote:
> > Hi Alexander,
> >
> > On Mon, Apr 17, 2023 at 9:52=E2=80=AFPM Alexander Gordeev
> > <alexander.gordeev@opensynergy.com> wrote:
> >>
> >> Hi Alexandre,
> >>
> >> Thanks for you letter! Sorry, it took me some time to write an answer.
> >>
> >> First of all I'd like to describe my perspective a little bit because =
it
> >> seems, that in many cases we (and other people writing their feedbacks=
)
> >> simply have very different priorities and background.
> >>
> >> OpenSynergy, the company that I work for, develops a proprietary
> >> hypervisor called COQOS mainly for automotive and aerospace domains. W=
e
> >> have our proprietary device implementations, but overall our goal is t=
o
> >> bring open standards into these quite closed domains and we're betting
> >> big on virtio. The idea is to run safety-critical functions like cockp=
it
> >> controller alongside with multimedia stuff in different VMs on the sam=
e
> >> physical board. Right now they have it on separate physical devices. S=
o
> >> they already have maximum isolation. And we're trying to make this
> >> equally safe on a single board. The benefit is the reduced costs and
> >> some additional features. Of course, we also need features here, but a=
t
> >> the same time security and ease of certification are among the top of
> >> our priorities. Nobody wants cars or planes to have security problems,
> >> right? Also nobody really needs DVB and even more exotic devices in ca=
rs
> >> and planes AFAIK.
> >>
> >> For the above mentioned reasons our COQOS hypervisor is running on bar=
e
> >> metal. Also memory management for the guests is mostly static. It is
> >> possible to make a shared memory region between a device and a driver
> >> managed by device in advance. But definitely no mapping of random host
> >> pages on the fly is supported.
> >>
> >> AFAIU crosvm is about making Chrome OS more secure by putting every ap=
p
> >> in its own virtualized environment, right?
> >
> > Not really, but for the discussion here you can assume that it is a
> > VMM similar to QEmu with KVM enabled.
>
> Thanks for the clarification. If my idea about your use-case is not
> totally correct, then it would be very helpful if you can provide more
> details about it.

It's nothing fancy ; Linux host, Linux (e.g. Android) guests. But
virtio being a standard, we should focus on making something that is
usable by everyone instead of individual use-cases.

>
> >> Both the host and guest are
> >> linux. In this case I totally understand why V4L2 UAPI pass-through
> >> feels like a right move. I guess, you'd like to make the switch to
> >> virtualized apps as seemless as possible for your users. If they can't
> >> use their DVBs anymore, they complain. And adding the virtualization
> >> makes the whole thing more secure anyway. So I understand the desire t=
o
> >> have the range of supported devices as broad as possible. It is also
> >> understandable that priorities are different with desktop
> >> virtualization. Also I'm not trying to diminish the great work, that y=
ou
> >> have done. It is just that from my perspective this looks like a step =
in
> >> the wrong direction because of the mentioned concerns. So I'm going to
> >> continue being a skeptic here, sorry.
> >>
> >> Of course, I don't expect that you continue working on the old approac=
h
> >> now as you have put that many efforts into the V4L2 UAPI pass-through.
> >> So I think it is best to do the evolutionary changes in scope of virti=
o
> >> video device specification, and create a new device specification
> >> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
> >> continue the virtio-video development. In fact I already started makin=
g
> >> draft v7 of the spec according to the comments. I hope it will be read=
y
> >> for review soon.
> >>
> >> I hope this approach will also help fix issues with virtio-video spec
> >> and driver development misalignment as well as V4L2 compliance issues
> >> with the driver. I believe the problems were caused partly by poor
> >> communication between us and by misalignment of our development cycles=
,
> >> not by the driver complexity.
> >>
> >> So in my opinion it is OK to have different specs with overlapping
> >> functionality for some time. My only concern is if this would be
> >> accepted by the community and the committee. How the things usually go
> >> here: preferring features and tolerating possible security issues or t=
he
> >> other way around? Also how acceptable is having linux-specific protoco=
ls
> >> at all?
> >>
> >> Also I still have concerns about memory management with V4L2 UAPI
> >> pass-through. Please see below.
> >>
> >> On 17.03.23 08:24, Alexandre Courbot wrote:
> >>> Hi Alexander,
> >>>
> >>> On Thu, Mar 16, 2023 at 7:13=E2=80=AFPM Alexander Gordeev
> >>> <alexander.gordeev@opensynergy.com> wrote:
> >>>> Hi Alexandre,
> >>>>
> >>>> On 14.03.23 06:06, Alexandre Courbot wrote:
> >>>>> If we find out that there is a benefit in going through the V4L2
> >>>>> subsystem (which I cannot see for now), rebuilding the UAPI structu=
res
> >>>>> to communicate with the device is not different from building
> >>>>> virtio-video specific structures like what we are currently doing.
> >>>> Well, the V4L2 subsystem is there for a reason, right? It does some
> >>>> important things too. I'm going to check all the v4l2_ioctl_ops
> >>>> callbacks in the current virtio-video driver to make the list. Also =
if
> >>>> you have some PoC spec/implementations, that would be nice to review=
. It
> >>>> is always better to see the actual implementation, of course.
> >>>>
> >>>> I have these points so far:
> >>>>
> >>>> 1. Overall the V4L2 stateful decoder API looks significantly more
> >>>> complex to me. Looks like you're a V4L2 expert, so this might not be
> >>>> visible to you that much.
> >>> V4L2 is more generic than virtio-video, so as a result specific uses
> >>> tend to require a bit more operations. I would argue the mental
> >>> overhead of working with it is less than significant, and most of it
> >>> consists in not forgetting to call STREAMON on a queue after some
> >>> operations. Things like format, resolution and buffer management do
> >>> not get more complex (and V4L2 is actually more complete than our
> >>> previous proposal on these).
> >>>
> >>> The counterpart of this marginal extra complexity is that you can
> >>> virtualize more kinds of devices, and even within virtio-video suppor=
t
> >>> more formats than what has been specified so far. If your guest is
> >>> Linux, the same kernel driver can be used to expose any kind of devic=
e
> >>> supported by V4L2, and the driver is also much simpler than
> >>> virtio-video, so you are actually reducing complexity significantly
> >>> here. Even if you are not Linux, you can share the V4L2 structures
> >>> definitions and low-layer code that sends V4L2 commands to the host
> >>> between drivers. So while it is true that some specifics become
> >>> slightly more complex, there is a lot of potential simplification whe=
n
> >>> you look at the whole picture.
> >>>
> >>> It's an opinionated proposal, and it comes with a few compromises if
> >>> you are mostly interested in codecs alone. But looking at the guest
> >>> driver convinces me that this is the better approach when you look at
> >>> the whole picture.
> >>
> >> Sorry, I just see it differently as I tried to describe above. The
> >> problem is that we don't yet see the whole picture with the V4L2 UAPI
> >> pass-through. I reviewed the code briefly. It is great, that you alrea=
dy
> >> implemented the MMAP mode and host allocations already. But I would
> >> argue, that this is the simplest case. Do you agree?
> >
> > I was trying to do a proof-of-concept here, of course it is not
> > feature-complete and of course I started with the simplest case. I
> > don't see your point here.
>
> I understand that. The point is that the real complexity is yet to come.
> Please see below. I think this is logical: if you only have implemented
> the simplest case, then implementing more complex cases requires making
> the implementation more complex.
>
> >> Also this mode of
> >> operation is not supported in our hypervisor for reasons mentioned
> >> above. So in our case this PoC doesn't yet prove anything unfortunatel=
y.
> >
> > I did not have your use-case in mind while writing the PoC, its
> > purpose was to demonstrate the suitability of V4L2 as a protocol for
> > virtualizing video.
> >
> > Now if your hypervisor does static memory management and pre-allocates
> > memory for guest buffers, then the V4L2 MMAP memory type actually
> > looks like the best fit for the job. There are no tokens like virtio
> > objects UUID to manage, and the MMAP request can be as simple as
> > returning the pre-mapped address of the buffer in the guest PAS.
> >
> > If instead it carves some predefined amount of memory out for the
> > whole guest and expects it to allocate buffer memory from there, then
> > the USERPTR memory type (which works like the guest pages of
> > virtio-video) is what you want to use.
>
> It doesn't look like a good idea to us. This means preconfiguring memory
> regions in the hypervisor config. It is hard to predict the amount of
> memory, that is necessary. If we allocate too much, this is a waste of
> memory. If we allocate too little, it won't be enough. Then we don't
> know yet how to make V4L2 allocate from that memory. Then this memory
> has to be managed on the host side. And memory management is exactly the
> thing, that causes most security issues, right? So overall this is very
> tedious, potentially wasteful and not flexible.

My last paragraph mentions that you can also let the guest manage the
buffer memory from its own RAM. Or maybe I am missing how memory is
managed on your hypervisor, but if that's the case elaborate on where
you want the buffer memory to come from.

>
>
> >> I think the real complexity is yet to come.
> >
> > Evidence would be appreciated.
>
> Please check my comment above.
>
> >>>>      a. So V4L2 subsystem and the current virtio-video driver are al=
ready
> >>>> reducing the complexity. And this seems as the right place to do thi=
s,
> >>>> because the complexity is caused by the amount of V4L2 use cases and=
 its
> >>>> legacy. If somebody wants to use virtio-video in a Windows guest, th=
ey
> >>>> would prefer a simpler API, right? I think this use-case is not pure=
ly
> >>>> abstract at all.
> >>> The V4L2 subsystem is there to factorize code that can be shared
> >>> between drivers and manage their internal state. Our target is the
> >>> V4L2 UAPI, so a Windows driver needs not be concerned about these
> >>> details - it does what it would have done with virtio-video, and just
> >>> uses the V4L2 structures to communicate with the host instead of the
> >>> virtio-video ones.
> >>
> >> It can also reuse the virtio-video structures. So I think despite the
> >> ability to reuse V4L2 structures, having to implement a linux-specific
> >> interface would still be a bigger pain.
> >
> > The only Linux-specific thing in this interface is that it
> > misleadingly has "Linux" in its name. Otherwise it's really similar to
> > what we previously had.
> >
> >>
> >>
> >>>>      b. Less complex API is better from a security point of view too=
. When
> >>>> V4L2 was developed, not many people were concerned with malicious US=
B
> >>>> devices probably. At least exploiting a malicious USB device usually
> >>>> requires physical access. With virtual devices and multiple VMs the
> >>>> stakes are higher, I believe.
> >>> That's probably true, but I fail to see how the fact we are using
> >>> struct v4l2_buffer instead of struct virtio_video_buffer can have an
> >>> impact on that?
> >>>
> >>> V4L2 has a larger UAPI surface because it manages more kinds of
> >>> devices, but drivers only need to implement the ioctls they need. For
> >>> the rest, they just return -ENOTTY, and evil actors are hopefully kep=
t
> >>> at bay.
> >>
> >> Still there are definitely more ways to do things wrong. It would be
> >> harder to audit a larger API surface.
> >
> > If you write a video device you don't need to support more API than
> > that requested for your device. All unsupported interfaces can simply
> > return ENOTTY.
>
>
>
> >>>> 2. We have a working virtio-video driver. So we need very good reaso=
ns
> >>>> to start from scratch. You name two reasons AFAIR: simplicity and
> >>>> possible use of cameras. Did I miss something else?
> >>>>
> >>>>      a. The simplicity is there only in case all the interfaces are =
V4L2,
> >>>> both in the backend and in the guest. Otherwise the complexity is ju=
st
> >>>> moved to backends. I haven't seen V4L2 in our setups so far, only so=
me
> >>>> proprietary OMX libraries. So from my point of view, this is not
> >>>> simplicity in general, but an optimization for a specific narrow use=
 case.
> >>> V4L2 is not a narrow use-case when it comes to video devices on Linux
> >>> - basically every user space application involving cameras or codecs
> >>> can use it. Even the virtio-video driver exposes a V4L2 device, so
> >>> unless you are using a different driver and proprietary userspace app=
s
> >>> specifically written to interact with that driver, V4L2 is involved i=
n
> >>> your setup at some point.
> >>
> >> Sorry, I mean narrow use-case if we look into other possibilities:
> >>
> >> 1. Stateless V4L2 on the host.
> >> 2. Any other interface on the host.
> >> 3. Any other guest except Linux.
> >>
> >> Our targets are several popular embedded SoCs. Unfortunately we don't
> >> have the luxury of simply having normal V4L2 devices there. And it
> >> doesn't look like this is going to change.
> >>
> >>
> >>> The guest driver that I wrote is, I think, a good example of the
> >>> complexity you can expect in terms of guest driver size (as it is
> >>> pretty functional already with its 1000 and some LoCs). For the UAPI
> >>> complexity, the host device basically unpacks the information it need=
s
> >>> and rebuilds the V4L2 structures before calling into the host device,
> >>> and I don't see this process as more complex that the unpacking of
> >>> virtio-video structs which we also did in crosvm.
> >>
> >> Unfortunately our hypervisor doesn't support mapping random host pages
> >> in the guest.
> >
> > The ability to map random host pages to the guest is *not* a
> > requirement of virtio-v4l2.
> >
> >> Static allocations of shared memory regions are possible.
> >> But then we have to tell V4L2 to allocate buffers there. Then we'll ne=
ed
> >> a region per virtual device. This is just very tedious and inflexible.
> >> That's why we're mainly interested in having the guest pages sharing i=
n
> >> the virtio video spec.
> >
> > I'll be happy to update the PoC and make it able to use guest pages as
> > buffer backing memory. It just wasn't the priority to demonstrate the
> > global approach.
>
> Great, thank you. If you have a concrete plan already, I think it could
> be beneficial to discuss it now. Otherwise I'd prefer to keep working on
> the current approach until I see something concrete.

Just give me a couple more weeks and I think I can produce the code.
But I'm afraid you have already made up your mind anyway.

>
> >>>>      b. For modern cameras the V4L2 interface is not enough anyway. =
This
> >>>> was already discussed AFAIR. There is a separate virtio-camera
> >>>> specification, that indeed is based on V4L2 UAPI as you said. But
> >>>> combining these two specs is certainly not future proof, right? So I
> >>>> think it is best to let the virtio-camera spec to be developed
> >>>> independently.
> >>> I don't know if virtio-camera has made progress that they have not
> >>> published yet, but from what I have seen virtio-v4l2 can cover
> >>> everything that the currently published driver does (I could not find
> >>> a specification, but please point me to it if it exists), so there
> >>> would be no conflict to resolve.
> >>>
> >>> V4L2 with requests support should be capable of handling complex
> >>> camera configurations, but the effort indeed seems to have switched t=
o
> >>> KCAM when it comes to supporting complex native cameras natively. Tha=
t
> >>> being said:
> >>>
> >>> * KCAM is not merged yet, is probably not going to be for some time
> >>> (https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=
=3Dhttps%3a%2f%2flwn.net%2fArticles%2f904776%2f&umid=3D7506d37b-2a1b-4aff-a=
c10-25fcc75ef955&auth=3D53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-7499883461=
cdeab6be6e5789888e8475e39171da), and we don't know how we can
> >>> handle virtualization with it,
> >>> * The fact that the camera is complex on the host does not mean that
> >>> all that complexity needs to be exposed to the guest. I don't know ho=
w
> >>> the camera folks want to manage this, but one can imagine that the
> >>> host could expose a simpler model for the virtual camera, with only
> >>> the required knobs, while the host takes care of doing all the comple=
x
> >>> configuration.
> >>> * The counter argument can be made that simple camera devices do not
> >>> need a complex virtualization solution, so one can also invoke
> >>> simplicity here to advocate for virtio-v4l2.
> >>>
> >>> My point is not to say that all other camera virtualization efforts
> >>> should be abandoned - if indeed there is a need for something more
> >>> specific, then nothing prevents us from having a virtio-camera
> >>> specification added. However, we are nowhere close to this at the
> >>> moment, and right now there is no official solution for camera
> >>> virtualization, so I see no reason to deny the opportunity to support
> >>> simple camera devices since its cost would just be to add "and camera=
s
> >>> device" in the paragraph of the spec that explains what devices are
> >>> supported.
> >>
> >> Well, for reasons described above it still seems perfectly fine to me =
to
> >> have separate devices. Ok, the argument, that this approach also seems
> >> more future-proof, is not a strong one.
> >
> > Please elaborate on its weaknesses then.
>
> Well, as you said basically. The weakness of the argument is that the
> virtio-camera is not yet published, the KCAM is not merged yet, so yeah,
> the future is not clear actually.
>
> BTW I just thought about one more case, that is already real: sharing
> camera streams with pipewire. I think pipewire doesn't provide a V4L2
> UAPI interface, right?

I believe it does: https://archlinux.org/packages/extra/x86_64/pipewire-v4l=
2/

But in any case, that's irrelevant to the guest-host interface, and I
think a big part of the disagreement stems from the misconception that
V4L2 absolutely needs to be used on either the guest or the host,
which is absolutely not the case.

>
> >>>> 3. More specifically I can see, that around 95% V4L2 drivers use
> >>>> videobuf2. This includes the current virtio-video driver. Bypassing =
the
> >>>> V4L2 subsystem means that vb2 can't be used, right? In various
> >>>> discussions vb2 popped up as a thing, that would be hard to avoid. W=
hat
> >>>> do you think about this? How are you going to deal with various V4L2
> >>>> memory types (V4L2_MEMORY_MMAP, V4L2_MEMORY_DMABUF, etc), for exampl=
e?
> >>>> I'll try to dive deeper myself too...
> >>> VB2 is entirely avoided in the current driver, but my understanding i=
s
> >>> that its helpers could be used if needed.
> >>>
> >>> In virtio-v4l2, MMAP means that the host is responsible for managing
> >>> the buffers, so vb2 is entirely avoided. USERPTR means the guest
> >>> passes a SG list of guest physical addresses as mapping memory. VB2
> >>> may or may not be involved in managing this memory, but most likely
> >>> not if that memory comes from the guest userspace. DMABUF means the
> >>> guest passes a virtio object as the backing memory of the buffer.
> >>> There again there is no particular management to be done on the guest
> >>> side.
> >>>
> >>> I bypassed VB2 for the current driver, and the cost of doing this is
> >>> that I had to write my own mmap() function.
> >>
> >> The cost of it as of now is also that:
> >>
> >> 1. Only guest user-space applications, that use V4L2_MEMORY_MMAP, are
> >> supported AFAIU.
> >
> > This has nothing to do with VB2. I wanted to demonstrate that V4L2
> > could be used as a host-guest protocol and did it on a single memory
> > type to release something quickly. Please stop strawmanning the design
> > because the PoC is still incomplete.
>
> Please stop putting labels like this on my arguments. This is not
> helpful at all.
>
> >> 2. There is no flexibility to choose whatever way of memory management
> >> host and guest would like to use. Now the guest user-space application
> >> selects this.
> >
> > Errr no. The guest user-space chooses a type of memory from what the
> > guest kernel exposes, which depends on what the host itself decides to
> > expose.
>
> I don't agree. If an already written user-space app supports only MMAP,
> then there is no way to force it use USERPTR, right? Please correct me
> if I'm wrong.

The memory types exposed by the guest kernel do not need to match
those exposed by the hypervisor or that the guest kernel chooses to
use.

For instance, imagine that the hypervisor does not support allocating
buffer memory - i.e. it does not support the MMAP memory type. The
guest will then have to use its own memory for buffer allocation, and
send them to the host with the USERPTR memory type.

Now if a guest user-space application only supports MMAP, that's not a
problem at all. Most V4L2 drivers allocate MMAP buffers from regular
memory. So when the application requests MMAP buffers, the guest
kernel can honor this request by allocating some memory itself, and
changes it to USERPTR when passing the request to the hypervisor so it
knows that guest memory is in use.

I am responsible for this misconception since I insisted on using the
same memory types (MMAP, USERPTR, DMABUF) as V4L2 for guest/host
communication, which is misleading. It would probably be less
confusing to define new types (HOST, GUEST and VIRTIO_OBJ) just for
virtio-v4l2 and forbid the use of the kernel/user space memory types.

With these new names, I think it is clear that we have the exact
feature set of virtio-video (guest memory and virtio objects) covered,
plus another one where we allow the host to perform the allocation
itself (which may be useful if the video device has its own dedicated
memory). Again, this is only for host/guest communication. Guest
kernel/userspace is a different thing and can be implemented in
different ways depending on what the host supports.

>
> >> The latter makes the solution much less flexible IMO. For example, thi=
s
> >> won't work well with our hypervisor. There might other special needs i=
n
> >> other use-cases. Like sharing these object UUIDs. Probably this can
> >> handled by mapping, for example, V4L2_MEMORY_USERPTR to guest-pages
> >> sharing, V4L2_MEMORY_DMABUF to the UUIDs (which is not quite correct
> >> IMHO).
> >
> > Please elaborate on why this is not correct.
>
> Because IMHO UUIDs pointing to memory allocated by virtio-gpu are quite
> different dmabufs created in the guest with udmabuf, for example. This
> can be confusing.

True, and that's another reason to define our own memory types to
remove that confusion.

>
> >> So this already means querying the device for supported sharing
> >> methods, rewriting the flow of V4L2 UAPI calls on the fly, ensuring
> >> consistency, etc. This already looks hackish to me. Do you have a bett=
er
> >> plan?
> >
> > How do you support different kinds of memory without querying? Or do
> > you suggest we stick to a single one?
> >
> > I am also not quite sure what you mean by "rewriting the flow of V4L2
> > UAPI calls on the fly". There is no "rewriting" - V4L2 structures are
> > just used to communicate with the host instead of virtio-video
> > structures.
>
> I'd like to know your ideas or better a concrete plan for enabling
> user-space apps, that only support MMAP, to work on top of a device,
> that supports only guest pages sharing.

Hopefully my explanation above clears that.

>
> >> Also this limits us to only 3 methods, right? And what if there
> >> are more than 3 methods in the future?
> >
> > Nothing prevents us from adding new virtio-specific memory types if
> > needed. But what other methods did you have in mind?
>
> You mean we can easily extend V4L2 UAPI with our own memory types, that
> are not used in usual V4L2 drivers? Please provide some evidence.

Err you were the one asking about adding more methods. I don't see the
need for it myself.

>
> >> I think this inflexibility is a major problem with this approach.
> >>
> >>
> >>>>> Actually I don't think this is even something we need to think abou=
t -
> >>>>> in its simplest form the V4L2 guest driver just needs to act as a
> >>>>> proxy for the device. So which decoder API is used by the host is
> >>>>> completely irrelevant to the guest driver - it can support a decode=
r,
> >>>>> an encoder, or a camera - it doesn't even need to be aware of what
> >>>>> kind of device it is exposing and that simplicity is another thing
> >>>>> that I like with this design.
> >>>> As I wrote above the design would be indeed simple only in case the
> >>>> actual hardware is exposed to a backend through V4L2 too. Otherwise =
the
> >>>> complexity is just moved to backends.
> >>> Yes, and while I acknowledge that, this is not really more complex
> >>> that what you would have to do with a virtio-video device which also
> >>> needs to manage its own state and drive the hardware through backends=
.
> >>> I say that based on the experience working on the virtio-video device
> >>> in crosvm which follows that design too.
> >>
> >> As I wrote above we have a different use-case. And I see the current
> >> state of virtio video as a good common ground for different parties an=
d
> >> use-cases. Unfortunately I don't see any upsides for our use-cases fro=
m
> >> the V4L2 UAPI proposal, only downsides.
> >
> > Well AFAICT V4L2 provides the exact same set of capabilities as
> > virtio-video, with only minor differences. If virtio-video was
> > suitable for your use-case, V4L2 should be as well.
> >
> > Maybe it makes things marginally more complex for your particular
> > proprietary bare-metal hypervisor. But it also makes things
> > dramatically easier and provides much more features for the vast
> > majority of the virtio audience who run Linux guests and can now use a
> > much simpler driver. Which one do we want to prioritize?
>
> This sounds like a neglect for our use-case. This is not helpful, if
> we're going to continue working with the same device, because this
> questions our ability to cooperate. That's fine as long as we can
> continue developing the current version separately.

I said "marginally". AFAICT your use-case would be just fine with
virtio-v4l2. On my end, I'd like to make sure the vast majority of
device implementers don't have to make a choice between two equivalent
but incompatible standards.

>
> > I'm sorry but your answer is full of vague assertions about supposed
> > shortcomings of the approach without any concrete evidence of its
> > unsuitability. Please show us why this wouldn't work for you.
>
> I asked you what is your plan about the guest pages sharing. Probably
> you didn't see this question because I don't see the answer in your
> email. So I'm reiterating it here. What is your plan? Without that I can
> only share my own ideas, and indeed the whole conversation can seem
> vague and hypothetical.

The plan is that it's going to be basically the same as virtio-video
guest page sharing. I don't need to detail much more as we both know
how that works.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

