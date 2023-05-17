Return-Path: <virtio-dev-return-12744-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399CDC77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 03:58:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4403C60344
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 03:58:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F80E9865B0
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 03:58:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0E0F09862FB; Wed, 17 May 2023 03:58:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC2639862FC
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 May 2023 03:58:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295919; x=1686887919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqdAJYZuttUT3xTCctaIk/8acvaNqPlrtFKGbr7nB5Y=;
        b=CrdJ9Y36UxkONH50Dy53ilptMWO/Lta7Ub4/Mmdl61biDfXxg7NpAyPPxjU+gsCnpM
         +d6l1z8I5qQ3opDFYuPC7Jss4KWD2eultCuxfWQ2ih8osejF9z0zOHOrdzznh88Og/j8
         5H8KfVB6HJDO9ugbpQJW2aQCc8RF+tUoum7dLirudG7v3PC+73AOEm+EpGNLsAsGvFNZ
         JV8VG5J4VFAwj1k0jU4UrGdi6KUW0ljZqoePkRjWvqQjyTQx3UzsQVMsMJugPRpHFXYr
         SVg4CoRd7dXuq0oJsgSAG6HJJpJGTjjxSdBvECOPgZiHk3Wz+DYwHzSi0vokgi0mXKiV
         VpaA==
X-Gm-Message-State: AC+VfDwe3FW1OdXaIdrH/ASKERVOT/zfnRHK29EdwQEdz6xLzlrRIYCG
	Rcj+3PCq8xF5SJ1yymgiPLjd8GyqiJ7iMj8heia7DQ==
X-Google-Smtp-Source: ACHHUZ6MXIYzvFDHA8P6qQAeIz2SBsUqqzNBws21VkSX04v8LRujwKESeppUdcGqXp8QTpXT23An7w==
X-Received: by 2002:a05:6214:509c:b0:5ef:467a:5969 with SMTP id kk28-20020a056214509c00b005ef467a5969mr58879104qvb.12.1684295919154;
        Tue, 16 May 2023 20:58:39 -0700 (PDT)
X-Received: by 2002:ad4:5f0c:0:b0:5ea:9fc5:fca2 with SMTP id
 fo12-20020ad45f0c000000b005ea9fc5fca2mr65962517qvb.45.1684295918076; Tue, 16
 May 2023 20:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com> <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com> <87a5ylzf34.fsf@redhat.com>
 <87354dtp30.fsf@linaro.org> <87bkj1h0nf.fsf@redhat.com> <a3607ef3-ffd9-345b-0191-5bc946f4be19@opensynergy.com>
 <168329085253.1880445.14002473591422425775@Monstersaurus> <87v8h6dagr.fsf@linaro.org>
 <20230506081229.GA8114@pendragon.ideasonboard.com>
In-Reply-To: <20230506081229.GA8114@pendragon.ideasonboard.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 17 May 2023 12:58:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BrhDZtFX3vdhBVSLXthe8CykYsZzVQ9ddZxVNvNS3ArA@mail.gmail.com>
Message-ID: <CAAFQd5BrhDZtFX3vdhBVSLXthe8CykYsZzVQ9ddZxVNvNS3ArA@mail.gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	virtio-dev@lists.oasis-open.org, Albert Esteve <aesteve@redhat.com>, 
	=?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, 
	Alexandre Courbot <acourbot@chromium.org>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Cornelia Huck <cohuck@redhat.com>, 
	Marcin Wojtas <mwojtas@google.com>, Keiichi Watanabe <keiichiw@chromium.org>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, 
	Alexander Gordeev <alexander.gordeev@opensynergy.com>, libcamera-devel@lists.libcamera.org, 
	=?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Enrico Granata <egranata@google.com>, Enric Balletbo i Serra <eballetb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [libcamera-devel] [virtio-dev] Re: [RFC PATCH v6] virtio-video:
 Add virtio video device specification

On Sat, May 6, 2023 at 5:12=E2=80=AFPM Laurent Pinchart via libcamera-devel
<libcamera-devel@lists.libcamera.org> wrote:
>
> Hello,
>
> On Fri, May 05, 2023 at 04:55:33PM +0100, Alex Benn=C3=A9e via libcamera-=
devel wrote:
> > Kieran Bingham writes:
> >
> > > Hi All,
> > >
> > > Coming in late, thanks to lei/lore spotting the libcamera keyword.
> > >
> > > + Cc: libcamera-devel to raise awareness of the discussion there.
> > >
> > > Quoting Alexander Gordeev (2023-05-05 10:57:29)
> > >> On 03.05.23 17:53, Cornelia Huck wrote:
> > >> > On Wed, May 03 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> > >> >> Cornelia Huck <cohuck@redhat.com> writes:
> > >> >>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensy=
nergy.com> wrote:
> > >> >>>> On 27.04.23 15:16, Alexandre Courbot wrote:
> > >> >>>>> But in any case, that's irrelevant to the guest-host interface=
, and I
> > >> >>>>> think a big part of the disagreement stems from the misconcept=
ion that
> > >> >>>>> V4L2 absolutely needs to be used on either the guest or the ho=
st,
> > >> >>>>> which is absolutely not the case.
> > >> >>>>
> > >> >>>> I understand this, of course. I'm arguing, that it is harder to
> > >> >>>> implement it, get it straight and then maintain it over years. =
Also it
> > >> >>>> brings limitations, that sometimes can be workarounded in the v=
irtio
> > >> >>>> spec, but this always comes at a cost of decreased readability =
and
> > >> >>>> increased complexity. Overall it looks clearly as a downgrade c=
ompared
> > >> >>>> to virtio-video for our use-case. And I believe it would be the=
 same for
> > >> >>>> every developer, that has to actually implement the spec, not j=
ust do
> > >> >>>> the pass through. So if we think of V4L2 UAPI pass through as a
> > >> >>>> compatibility device (which I believe it is), then it is fine t=
o have
> > >> >>>> both and keep improving the virtio-video, including taking the =
best
> > >> >>>> ideas from the V4L2 and overall using it as a reference to make=
 writing
> > >> >>>> the driver simpler.
> > >> >>>
> > >> >>> Let me jump in here and ask another question:
> > >> >>>
> > >> >>> Imagine that, some years in the future, somebody wants to add a =
virtio
> > >> >>> device for handling video encoding/decoding to their hypervisor.
> > >> >>>
> > >> >>> Option 1: There are different devices to chose from. How is the =
person
> > >> >>> implementing this supposed to pick a device? They might have a n=
arrow
> > >> >>> use case, where it is clear which of the devices is the one that=
 needs to
> > >> >>> be supported; but they also might have multiple, diverse use cas=
es, and
> > >> >>> end up needing to implement all of the devices.
> > >> >>>
> > >> >>> Option 2: There is one device with various optional features. Th=
e person
> > >> >>> implementing this can start off with a certain subset of feature=
s
> > >> >>> depending on their expected use cases, and add to it later, if n=
eeded;
> > >> >>> but the upfront complexity might be too high for specialized use=
 cases.
> > >> >>>
> > >> >>> Leaving concrete references to V4L2 out of the picture, we're cu=
rrently
> > >> >>> trying to decide whether our future will be more like Option 1 o=
r Option
> > >> >>> 2, with their respective trade-offs.
> > >> >>>
> > >> >>> I'm slightly biased towards Option 2; does it look feasible at a=
ll, or
> > >> >>> am I missing something essential here? (I had the impression tha=
t some
> > >> >>> previous confusion had been cleared up; apologies in advance if =
I'm
> > >> >>> misrepresenting things.)
> > >> >>>
> > >> >>> I'd really love to see some kind of consensus for 1.3, if at all
> > >> >>> possible :)
> > >> >>
> > >> >> I think feature discovery and extensibility is a key part of the =
VirtIO
> > >> >> paradigm which is why I find the virtio-v4l approach limiting. By
> > >> >> pegging the device to a Linux API we effectively limit the growth=
 of the
> > >> >> device specification to as fast as the Linux API changes. I'm not=
 fully
> > >> >> immersed in v4l but I don't think it is seeing any additional fea=
tures
> > >> >> developed for it and its limitations for camera are one of the re=
asons
> > >> >> stuff is being pushed to userspace in solutions like libcamera:
> > >> >>
> > >> >>    How is libcamera different from V4L2?
> > >> >>
> > >> >>    We see libcamera as a continuation of V4L2. One that can more =
easily
> > >> >>    handle the recent advances in hardware design. As embedded cam=
eras have
> > >> >>    developed, all of the complexity has been pushed on to the dev=
elopers.
> > >> >>    With libcamera, all of that complexity is simplified and a sin=
gle model
> > >> >>    is presented to application developers.
> > >> >
> > >> > Ok, that is interesting; thanks for the information.
> > >> >
> > >> >>
> > >> >> That said its not totally our experience to have virtio devices a=
ct as
> > >> >> simple pipes for some higher level protocol. The virtio-gpu spec =
says
> > >> >> very little about the details of how 3D devices work and simply o=
ffers
> > >> >> an opaque pipe to push a (potentially propriety) command stream t=
o the
> > >> >> back end. As far as I'm aware the proposals for Vulkan and Waylan=
d
> > >> >> device support doesn't even offer a feature bit but simply change=
s the
> > >> >> graphics stream type in the command packets.
> > >> >>
> > >> >> We could just offer a VIRTIO_VIDEO_F_V4L feature bit, document it=
 as
> > >> >> incompatible with other feature bits and make that the baseline
> > >> >> implementation but it's not really in the spirit of what VirtIO i=
s
> > >> >> trying to achieve.
> > >> >
> > >> > I'd not be in favour of an incompatible feature flag,
> > >> > either... extensions are good, but conflicting features is somethi=
ng
> > >> > that I'd like to avoid.
> > >> >
> > >> > So, given that I'd still prefer to have a single device: How well =
does
> > >> > the proposed virtio-video device map to a Linux driver implementat=
ion
> > >> > that hooks into V4L2?
> > >>
> > >> IMO it hooks into V4L2 pretty well. And I'm going to spend next few
> > >> months making the existing driver fully V4L2 compliant. If this goal
> > >> requires changing the spec, than we still have time to do that. I do=
n't
> > >> expect a lot of problems on this side. There might be problems with
> > >> Android using V4L2 in weird ways. Well, let's see. Anyway, I think a=
ll
> > >> of this can be accomplished over time.
> > >>
> > >> > If the general process flow is compatible and it
> > >> > is mostly a question of wiring the parts together, I think pushing=
 that
> > >> > part of the complexity into the Linux driver is a reasonable
> > >> > trade-off. Being able to use an existing protocol is nice, but if =
that
> > >> > protocol is not perceived as flexible enough, it is probably not w=
orth
> > >> > encoding it into a spec. (Similar considerations apply to hooking =
up the
> > >> > device in the hypervisor.)
> > >>
> > >> I very much agree with these statements. I think this is how it shou=
ld
> > >> be: we start with a compact but usable device, then add features and
> > >> enable them using feature flags. Eventually we can cover all the
> > >> use-cases of V4L2 unless we decide to have separate devices for them
> > >> (virtio-camera, etc). This would be better in the long term I think.
> > >
> > > Camera's definitely have their quirks - mostly because many usecases =
are
> > > hard to convey over a single Video device node (with the hardware) bu=
t I
> > > think we might expect that complexity to be managed by the host, and
> > > probably offer a ready made stream to the guest. Of course how to han=
dle
> > > multiple streams and configuration of the whole pipeline may get more
> > > difficult and warrant a specific 'virtio-camera' ... but I would thin=
k
> > > the basics could be covered generically to start with.
> > >
> > > It's not clear who's driving this implementation and spec, so I guess
> > > there's more reading to do.
> > >
> > > Anyway, I've added Cc libcamera-devel to raise awareness of this topi=
c
> > > to camera list.
> > >
> > > I bet Laurent has some stronger opinions on how he'd see camera's exi=
st
> > > in a virtio space.
>
> You seem to think I have strong opinions about everything. This may not
> be a complitely unfounded assumption ;-)
>
> Overall I agree with you, I think cameras are too complex for a
> low-level virtualization protocol. I'd rather see a high-level protocol
> that exposes webcam-like devices, with the low-level complexity handled
> on the host side (using libcamera of course ;-)). This would support use
> cases that require sharing hardware blocks between multiple logical
> cameras, including sharing the same camera streams between multiple
> guests.
>
> If a guest needs low-level access to the camera, including the ability
> to control the raw camera sensor or ISP, then I'd recommend passing the
> corresponding hardware blocks to the guest for exclusive access.

I'd argue that to be rather a serious limitation for systems like
ChromeOS, which run multiple rich OS environments in virtual machines,
Android being one. Having to pass through the entire hardware
subsystem to get slightly more control over the camera (RAW capture
and reprocessing afterwards is by no means an advanced capability
these days) would impose a number serious implications:

1) can't share access to the camera subsystem across different
applications in different VMs (given that it's common SoC design to
have a single set of ISP devices, which can handle more than 1 stream
simultaneously),

2) need to have all the low level code to deal with the hardware
duplicated (or often reimplemented) for all the different VM guest
OSes,

3) lack of a way to introduce a security layer between the camera hw
subsystem and guest OS.

I'd argue that for proper camera virtualization for consumer
applications, we would need something on an abstraction level closer
to the Android Camera HAL3 API, or actually, the libcamera native API.

Best regards,
Tomasz

>
> > Personally I would rather see a separate virtio-camera specification
> > that properly encapsulates all the various use cases we have for
> > cameras. In many ways just processing a stream of video is a much
> > simpler use case.
> >
> > During Linaro's Project Stratos we got a lot of feedback from members
> > who professed interest in a virtio-camera initiative. However we were
> > unable to get enough engineering resources from the various companies t=
o
> > collaborate in developing a specification that would meet everyone's
> > needs. The problem space is wide from having numerous black and white
> > sensor cameras on cars to the full on computational photography as
> > exposed by modern camera systems on phones. If you want to read more
> > words on the topic I wrote a blog post at the time:
> >
> >   https://www.linaro.org/blog/the-challenges-of-abstracting-virtio/
> >
> > Back to the topic of virtio-video as I understand it the principle
> > features/configurations are:
> >
> >   - All the various CODECs, resolutions and pixel formats
> >   - Stateful vs Stateless streams
> >   - If we want support grabbing single frames from a source
> >
> > My main concern about the V4L approach is that it pegs updates to the
> > interface to the continuing evolution of the V4L interface in Linux. No=
w
> > maybe video is a solved problem and there won't be (m)any new features
> > we need to add after the initial revision. However I'm not a domain
> > expert here so I just don't know.
>
> I've briefly discussed "virtio-v4l2" with Alex Courbot a few weeks ago
> when we got a chance to meet face to face. I think the V4L2 kernel API
> is a quite good fit in the sense that its level of abstraction, when
> applied to video codecs and "simple" cameras (defined, more or less, as
> something ressembling a USB webcam feature-wise). It doesn't mean that
> the virtio-video or virtio-camera specifications should necessarily
> reference V4L2 or use the exact same vocabulary, they could simply copy
> the concepts, and stay loosely-coupled with V4L2 in the sense that both
> specification should try to evolve in compatible directions.
>
> --
> Regards,
>
> Laurent Pinchart

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

