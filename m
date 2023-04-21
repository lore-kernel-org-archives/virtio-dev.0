Return-Path: <virtio-dev-return-12337-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73F9C77B75
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 04:10:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E3C9F2AEE1
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 04:10:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B811D98664F
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 04:10:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8E9B4986636; Fri, 21 Apr 2023 04:10:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B2F1986244
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Apr 2023 04:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682050213; x=1684642213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7Ij68Y/xDhS8liKlhyfQdqDudw5riqUoTzF7pqf5L0=;
        b=KK0rxvxvQVd5jmRb4YPgZBAUU5hMTbCb8dRfWehyXFXRrZ9Z+WLkn3BA9pb09j0E1o
         q9UIBYj+hyXCbwVvya7oHlaxQW2eDIDaTLIeNqApYfmzr1fE4CcdSDeHV+dFHVVCTd2a
         xaxGejp7Q20bgvUYNNrdgmWnZyMJmrWVL84Afl2dAArRPWuKzfu2Das6HjEAj4W/IQQe
         ISc+xA5Xj1Ym4GHc/RBlH7+AyzRF99iiQelk9JDekASiCcVaWJi2MxvMd+BA5eeTbhR5
         apK9bLFqjh1F+EUJkskBfEeVHfUvw8PUQAUmXKfcX1oFQW1DbnnkH3VfmX/oISvbX7tq
         JjJA==
X-Gm-Message-State: AAQBX9d00IRSzmPc0RJpCdQ98tF1EeUNZ5NZGjauq0TCf/Mbda5WF63U
	88Cmb2T8CgfIEQoYrSpLew1+6uV5D4VzInZYUS0=
X-Google-Smtp-Source: AKy350Yx1rfB13I7oDzWk/anuRM0DgagQZMOAd7z3sBZT9nnLBDDydHhElZQaVPYMQUXB06beHEbcA==
X-Received: by 2002:ac2:4c98:0:b0:4e9:bafc:88d0 with SMTP id d24-20020ac24c98000000b004e9bafc88d0mr811441lfl.23.1682050212717;
        Thu, 20 Apr 2023 21:10:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1e01:b0:3f1:6fe9:4a95 with SMTP id
 ay1-20020a05600c1e0100b003f16fe94a95mr106138wmb.4.1682049795343; Thu, 20 Apr
 2023 21:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
In-Reply-To: <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 21 Apr 2023 13:02:51 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
Message-ID: <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
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

On Wed, Apr 19, 2023 at 4:39=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 17.04.23 16:43, Cornelia Huck wrote:
> > On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensynergy.c=
om> wrote:
> >
> >> Hi Alexandre,
> >>
> >> Thanks for you letter! Sorry, it took me some time to write an answer.
> >>
> >> First of all I'd like to describe my perspective a little bit because =
it
> >> seems, that in many cases we (and other people writing their feedbacks=
)
> >> simply have very different priorities and background.
> > Thank you for describing the environment you want to use this in, this
> > helps to understand the different use cases.
>
> Yeah, I hope too. I should have done that earlier. I think Dmitry
> described our use-case, but it was several years ago, so nobody
> remembers of course. We should reiterate all the use-cases once in a whil=
e.
>
>
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
> >> in its own virtualized environment, right? Both the host and guest are
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
> > My main question is: What would be something that we can merge as a
> > spec, that would either cover the different use cases already, or that
> > could be easily extended to cover the use cases it does not handle
> > initially?
> >
> > For example, can some of the features that would be useful in crosvm be
> > tucked behind some feature bit(s), so that the more restricted COQOS
> > hypervisor would simply not offer them? (Two feature bits covering two
> > different mechanisms, like the current approach and the v4l2 approach,
> > would also be good, as long as there's enough common ground between the
> > two.)
> >
> > If a staged approach (adding features controled by feature bits) would
> > be possible, that would be my preferred way to do it.
>
> Hmm, I see several ways how we can use the feature flags:
> 1. Basically making two feature flags: one for the current video spec
> and one for the V4L2 UAPI pass through. Kind of the same as having two
> different specs, but within one device. Not sure which way is better.
> Probably having two separate devices would be easier to review and merge.

Having two different devices with their own IDs would indeed be less
confusing than using feature bits.

That being said, the whole point of proposing virtio-v4l2 is to end up
with *less* specification, not more. Having two concurrent and largely
overlapping approaches will result in fragmentation and duplicated
work, so my suggestion would be to decide on one or the other and
stick to it.

> 2. Finding a subset of V4L2, that closely matches the current draft, and
> restrict everything else. A perfectly reasoned answer for this case will
> require a lot of work going through all the V4L2 structures I think. And

It's pretty trivial, on the contrary. For a decoder device one would
just need to restrict to the structs and operations mentioned here:
https://www.kernel.org/doc/html/v5.18/userspace-api/media/v4l/dev-decoder.h=
tml

> even if we have a concrete plan, it has to be implemented first. I doubt
> it is possible. Based on the things, that I already know, this is going
> to be a compromise on security anyway, so we're not happy about that.
> More on that below.
> 3. Stop trying to simply pass the V4L2 UAPI through and focus on making
> the virtio video spec as close to the V4L2 UAPI as possible, but with
> the appropriate security model. So that the video device can be extended
> with a feature flag to something very close to full V4L2 UAPI. A lot of
> work as well, I think. And this won't allow us to simply link the V4L2
> UAPI in the spec and therefore reduce its size, which is Alexandre's
> current goal. So Alexandre and his team are not happy this way probably.

That would indeed be reinventing the wheel and a completely pointless
exercise IMHO.

>
>  From the security point of view these are our goals from most to less
> important AFAIU:
> 1. Make the device secure. If a device is compromised, the whole
> physical machine is at risk. Complexity is the enemy here. It helps a
> lot to make the device as straightforward and easy to implement as
> possible. Therefore it is good to make the spec device/function-centric
> from this PoV.

This seems to be the main point of contention we have right here. I do
not believe that V4L2 introduces significant complexity to the video
use-case, and certainly not to a degree that would justify writing a
new spec just for that.

> 2. Ensure, that drivers are also secure at least from user-space side.
> Maybe from device side too.

FWIW V4L2 has been in use for a looong time (including in Chromebooks
that do secure playback) and I am not aware of fundamental security
issues with it.

> 3. Implementing secure playback and making sure media doesn't leak. For
> this case it is nice to have these object UUIDs as buffers.
>
> Please correct me if there's something wrong here.
>
> When we start looking from this perspective even things like naming
> video buffer queues "output" for device input and "capture" for device
> output are problematic. In my experience this naming scheme takes some
> time and for sure several coding mistakes to get used to. Unfortunately
> this can't be turned off with some feature flags. In contrast virtio
> video v6 names these queues "input" and "output". This is perfectly fine
> if we look from the device side. It is understandable, that Alexandre's
> list of differences between V4L2 UAPI and the current state of virtio
> video doesn't include these things. But we have to count them, I think.
> That's why it takes me so long to make the list. :) So throwing away
> this simplicity is still going to be a compromise from the security
> perspective, that we're not happy about.
>
> This is mostly because V4L2 UAPI brings a hard dependency on V4L2, its
> security model, legacy, use-cases, developers, etc. It can be changed
> over time, but this is a long process because this means changing the
> Linux UAPI. Also this means, that nothing can be removed from it, only
> added (if the V4L2 community agrees). For example, we can't simply add a
> new way of sharing buffers for potential new use-cases once we switch to
> V4L2 UAPI AFAIU.

You certainly can, it would just need to be in the virtio
specification. And again that's a very hypothetical case.

> The V4L2 community can simply reject changes because
> this is a UAPI after all. We kind of have a weak dependency already,
> because the only driver implementation is based on V4L2 and we'd like to
> keep the spec as close to V4L2 as possible, but it is not the same
> thing. So at the moment it looks like the V4L2 UAPI proposal is not
> super flexible. Alexandre said, that we can simply not implement some of
> the ioctls. Well, this definitely doesn't cover all the complexity like
> the structures and other subtle details.

Mmm? Where did I say that? That sounds like a misunderstanding.

>
> Also adding the feature flags would probably defeat the stated purpose
> of switching to V4L2 UAPI anyway: the simplicity of the spec and of the
> V4L2 driver.
>
> So I have a lot of doubts about the feasibility of adding feature flags.
> If Alexandre and his team want the V4L2 UAPI as is, then looks like it
> is best to simply have two specs:
> 1. virtio-video for those interested in building from ground up with the
> security model appropriate for virtualization in mind. This is going to
> take time and not going to reach feature parity with V4L2 ever I think.
> I mean some old devices might never get support this way.
> 2. virtio-v4l2 as a shortcut for those interested in having feature
> parity with V4L2 fast. Like a compatibility layer. Probably this is
> going to be used in linux host + linux guest use-cases only. Maybe it
> gets obsoleted by the first spec in several years for most modern use-cas=
es.
>
> Or maybe have these two cases within a single device spec as I wrote abov=
e.
>
> This makes a lot of sense to me. If V4L2 UAPI pass through is in fact
> only needed for compatibility, then this way we can avoid a lot of work
> going through all of the V4L2 and trying to find different subsets or
> trying to construct something, that is close to V4L2 UAPI, but doesn't
> compromise on the security. I'm not really interested in doing all this
> work because we're already more or less satisfied with the current
> state. We don't need feature parity with V4L2. On the other hand for
> Alexandre the feature-parity with V4L2 is clearly of higher priority,
> than all these subtle security model differences. In my opinion it also
> doesn't make sense to invest that much time in something, that looks
> like a compatibility layer. So it seems both of us are interested in
> avoiding all this extra work. Then I'd just prefer to have two different
> specs so that everyone can work according to their priorities.
>
>
> > Regarding the protocol: I think Linux-originating protocols (that can b=
e
> > implemented on non-Linux setups) are fine, Linux-only protocols probabl=
y
> > not so much.
>
> Thanks for the information. Well, it looks like the V4L2 UAPI could be
> implemented on any platform unless it needs a completely new way of
> memory management since all the V4L2_MEMORY_* constants are going to be
> used already AFAIU.
>
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
> >> It can also reuse the virtio-video structures. So I think despite the
> >> ability to reuse V4L2 structures, having to implement a linux-specific
> >> interface would still be a bigger pain.
> > Hm. Do the v4l2 structures drag in too many adjacent things that need t=
o
> > be implemented? Can we match the video-video structures from the curren=
t
> > proposal with some v4l2 structures and extract a common wrapper for
> > those that match, with a feature-bit controlled backend? It would be
> > fine if any of those backends supported a slightly different subset of
> > the common parts, as long as the parts implemented by both would be
> > enough to implement a working device. (Mostly thinking out loud here.)
>
> I don't think this is realistic unfortunately. On per ioctl level it is
> possible to disable some functionality probably, but the V4L2 structures
> are set in stone. We can only extend them.
>
>
> >>> The guest driver that I wrote is, I think, a good example of the
> >>> complexity you can expect in terms of guest driver size (as it is
> >>> pretty functional already with its 1000 and some LoCs). For the UAPI
> >>> complexity, the host device basically unpacks the information it need=
s
> >>> and rebuilds the V4L2 structures before calling into the host device,
> >>> and I don't see this process as more complex that the unpacking of
> >>> virtio-video structs which we also did in crosvm.
> >> Unfortunately our hypervisor doesn't support mapping random host pages
> >> in the guest. Static allocations of shared memory regions are possible=
.
> >> But then we have to tell V4L2 to allocate buffers there. Then we'll ne=
ed
> >> a region per virtual device. This is just very tedious and inflexible.
> >> That's why we're mainly interested in having the guest pages sharing i=
n
> >> the virtio video spec.
> > This really sounds like you'll want a different approach -- two
> > mechanisms covered by two feature bits might indeed be the way to go.
>
> Well, basically this is the way we have it now. I'm not sure what is
> Alexandre's plan with the V4L2 UAPI approach. And if this is going to be
> solved, the solution already doesn't look future-proof anyway unfortunate=
ly.
>
>
> >>> I hope I have somehow addressed your points. The main point here is t=
o
> >>> discuss whether the V4L2 UAPI is a suitable transport for guest/host
> >>> accelerated codec work, regardless of what the guest or host
> >>> ultimately uses as UAPI. The goal of the PoC is to demonstrate that
> >>> this is a viable solution. This PoC is largely simplified by the fact
> >>> that V4L2 is used all along the way, but this is irrelevant - yes,
> >>> actual devices will likely talk to other APIs and maintain more state=
,
> >>> like a virtio-video device would do. What I want to demonstrate is
> >>> that we can send encoding work and receive a valid stream, and that i=
t
> >>> is not costly, and only marginally more complex than our virtio-video
> >>> spec attempts.
> >>>
> >>> ... and we can support cameras too, but that's just a convenient
> >>> side-effect, not the ultimate solution to the camera virtualization
> >>> problem (that's for the camera folks to decide).
> >> Thanks for your answer!
> > Thanks everyone -- do you think the "two feature bits to cover differen=
t
> > approaches, but using a common infrastructure" idea could work? If yes,
> > I think that's the direction we should take. If we can implement this
> > with just one feature bit, that might also be a good route to extend it
> > later, but I'm not familiar enough with the whole infrastructure to mak=
e
> > any judgement here.
>
> Thanks for your suggestions. Hopefully we end up with a good solution.

To summarize my position:

* I am still not convinced that V4L2 is lacking from a security
perspective. It would take just one valid example to change my mind
(and no, the way the queues are named is not valid). And btw, if it
really introduces security issues, then this makes it invalid for
inclusion in virtio entirely, just not OpSy's hypervisor.

* Having two overlapping specifications for video is overkill and will
just fragment virtio (as tempting as it is, I won't link to XKCD). I
strongly advise against that.

* If the goal is to provide a standard that is suitable and useful to
the greater number, then we shouldn't downsize the benefit that
virtio-v4l2 brings to Linux guests.

Cheers,
Alex.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

