Return-Path: <virtio-dev-return-12459-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B913C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:32:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B3A4E41EE7
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:32:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C58398668B
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:32:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 85CC2983E91; Fri, 28 Apr 2023 03:32:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7240698667E
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 03:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682652764; x=1685244764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUqtslRtlthrUDVH6dal27ACMMAeOv5weIFPQG23I34=;
        b=ZXl06x32fGqFBdKtokz6TQYE8TljCn9WRiSXdGwr8J2+YX0P4Ky9WZwsGk61/KRlqn
         8Gg0LCyByu3dQUhbQMA/UOMICQnkeJnWJVMggXkwFiqPisLCEZuJxvSlztqtmnxC2jFy
         J1cz8nCJUmJRtsSAHRXu/Y3vgingEG1d0+IK4FkiYM1cXdQfXHK6rcR/hqkTyyomb3V6
         SjcMs5FiJnImeve/dULOyNXYpgtsXJ9zirqWrjMhw7xgpSUroEXuC6NhnrhUPvPvvHSe
         izoxzqgmwpbfQC4TocMSCd0XJqnaD19VLdGPsoUA30Owbp8yae1x2jQgLkYrkTOY1xYw
         79LA==
X-Gm-Message-State: AC+VfDwkKFrRA3khV+pq088tuq98POhKpGLqeyAeD27feOQriT99S6u0
	Tnh1upypLICee+a6fxXSsh8VULXOIimsaLz7tYc=
X-Google-Smtp-Source: ACHHUZ5pdkG9BYJ9l3FR8ZPqN6713m8FqVswSY5B2/ngIlf0TazThwr1fKrChlkv6nWMb9nWtQgYkQ==
X-Received: by 2002:a05:6a00:15c5:b0:636:f899:46a0 with SMTP id o5-20020a056a0015c500b00636f89946a0mr5417018pfu.15.1682652764348;
        Thu, 27 Apr 2023 20:32:44 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a86:b0:325:c9c3:1196 with SMTP id
 k6-20020a056e021a8600b00325c9c31196mr82277ilv.19.1682652270669; Thu, 27 Apr
 2023 20:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <630ba79d-aed7-60fb-b7b3-cb1d08b1073c@opensynergy.com> <CAPBb6MVWaBHR-d6aqaMXTxuX5ns3RNY4cNJhak5ijoicfTvoAw@mail.gmail.com>
 <4fe9b619-c2b3-fe22-d7ac-b92ffc90a80e@opensynergy.com>
In-Reply-To: <4fe9b619-c2b3-fe22-d7ac-b92ffc90a80e@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 28 Apr 2023 12:24:18 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUSKBE+SUEShm4tksaUh6tPE81b5T8_uKAPS_h_Og23dA@mail.gmail.com>
Message-ID: <CAPBb6MUSKBE+SUEShm4tksaUh6tPE81b5T8_uKAPS_h_Og23dA@mail.gmail.com>
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

On Fri, Apr 28, 2023 at 12:12=E2=80=AFAM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 27.04.23 15:23, Alexandre Courbot wrote:
> > On Thu, Apr 27, 2023 at 12:52=E2=80=AFAM Alexander Gordeev
> > <alexander.gordeev@opensynergy.com> wrote:
> >>
> >> On 21.04.23 06:02, Alexandre Courbot wrote:
> >>> On Wed, Apr 19, 2023 at 4:39=E2=80=AFPM Alexander Gordeev
> >>> <alexander.gordeev@opensynergy.com> wrote:
> >>>>
> >>>> On 17.04.23 16:43, Cornelia Huck wrote:
> >>>>> On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensyner=
gy.com> wrote:
> >>>>>
> >>>>>> OpenSynergy, the company that I work for, develops a proprietary
> >>>>>> hypervisor called COQOS mainly for automotive and aerospace domain=
s. We
> >>>>>> have our proprietary device implementations, but overall our goal =
is to
> >>>>>> bring open standards into these quite closed domains and we're bet=
ting
> >>>>>> big on virtio. The idea is to run safety-critical functions like c=
ockpit
> >>>>>> controller alongside with multimedia stuff in different VMs on the=
 same
> >>>>>> physical board. Right now they have it on separate physical device=
s. So
> >>>>>> they already have maximum isolation. And we're trying to make this
> >>>>>> equally safe on a single board. The benefit is the reduced costs a=
nd
> >>>>>> some additional features. Of course, we also need features here, b=
ut at
> >>>>>> the same time security and ease of certification are among the top=
 of
> >>>>>> our priorities. Nobody wants cars or planes to have security probl=
ems,
> >>>>>> right? Also nobody really needs DVB and even more exotic devices i=
n cars
> >>>>>> and planes AFAIK.
> >>>>>>
> >>>>>> For the above mentioned reasons our COQOS hypervisor is running on=
 bare
> >>>>>> metal. Also memory management for the guests is mostly static. It =
is
> >>>>>> possible to make a shared memory region between a device and a dri=
ver
> >>>>>> managed by device in advance. But definitely no mapping of random =
host
> >>>>>> pages on the fly is supported.
> >>>>>>
> >>>>>> AFAIU crosvm is about making Chrome OS more secure by putting ever=
y app
> >>>>>> in its own virtualized environment, right? Both the host and guest=
 are
> >>>>>> linux. In this case I totally understand why V4L2 UAPI pass-throug=
h
> >>>>>> feels like a right move. I guess, you'd like to make the switch to
> >>>>>> virtualized apps as seemless as possible for your users. If they c=
an't
> >>>>>> use their DVBs anymore, they complain. And adding the virtualizati=
on
> >>>>>> makes the whole thing more secure anyway. So I understand the desi=
re to
> >>>>>> have the range of supported devices as broad as possible. It is al=
so
> >>>>>> understandable that priorities are different with desktop
> >>>>>> virtualization. Also I'm not trying to diminish the great work, th=
at you
> >>>>>> have done. It is just that from my perspective this looks like a s=
tep in
> >>>>>> the wrong direction because of the mentioned concerns. So I'm goin=
g to
> >>>>>> continue being a skeptic here, sorry.
> >>>>>>
> >>>>>> Of course, I don't expect that you continue working on the old app=
roach
> >>>>>> now as you have put that many efforts into the V4L2 UAPI pass-thro=
ugh.
> >>>>>> So I think it is best to do the evolutionary changes in scope of v=
irtio
> >>>>>> video device specification, and create a new device specification
> >>>>>> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
> >>>>>> continue the virtio-video development. In fact I already started m=
aking
> >>>>>> draft v7 of the spec according to the comments. I hope it will be =
ready
> >>>>>> for review soon.
> >>>>>>
> >>>>>> I hope this approach will also help fix issues with virtio-video s=
pec
> >>>>>> and driver development misalignment as well as V4L2 compliance iss=
ues
> >>>>>> with the driver. I believe the problems were caused partly by poor
> >>>>>> communication between us and by misalignment of our development cy=
cles,
> >>>>>> not by the driver complexity.
> >>>>>>
> >>>>>> So in my opinion it is OK to have different specs with overlapping
> >>>>>> functionality for some time. My only concern is if this would be
> >>>>>> accepted by the community and the committee. How the things usuall=
y go
> >>>>>> here: preferring features and tolerating possible security issues =
or the
> >>>>>> other way around? Also how acceptable is having linux-specific pro=
tocols
> >>>>>> at all?
> >>>>> My main question is: What would be something that we can merge as a
> >>>>> spec, that would either cover the different use cases already, or t=
hat
> >>>>> could be easily extended to cover the use cases it does not handle
> >>>>> initially?
> >>>>>
> >>>>> For example, can some of the features that would be useful in crosv=
m be
> >>>>> tucked behind some feature bit(s), so that the more restricted COQO=
S
> >>>>> hypervisor would simply not offer them? (Two feature bits covering =
two
> >>>>> different mechanisms, like the current approach and the v4l2 approa=
ch,
> >>>>> would also be good, as long as there's enough common ground between=
 the
> >>>>> two.)
> >>>>>
> >>>>> If a staged approach (adding features controled by feature bits) wo=
uld
> >>>>> be possible, that would be my preferred way to do it.
> >>>>
> >>>> Hmm, I see several ways how we can use the feature flags:
> >>>> 1. Basically making two feature flags: one for the current video spe=
c
> >>>> and one for the V4L2 UAPI pass through. Kind of the same as having t=
wo
> >>>> different specs, but within one device. Not sure which way is better=
.
> >>>> Probably having two separate devices would be easier to review and m=
erge.
> >>>
> >>> Having two different devices with their own IDs would indeed be less
> >>> confusing than using feature bits.
> >>>
> >>> That being said, the whole point of proposing virtio-v4l2 is to end u=
p
> >>> with *less* specification, not more. Having two concurrent and largel=
y
> >>> overlapping approaches will result in fragmentation and duplicated
> >>> work, so my suggestion would be to decide on one or the other and
> >>> stick to it.
> >>
> >> Hmm, Enrico pointed out, that having virtio-v4l2 would also be good
> >> because of much better compatibility with Android right now. I don't
> >> think the specification length should be our ultimate goal. Cornelia
> >> said, that her ultimate goal is to have a spec everyone is happy with,
> >> regardless on how we arrive there. Well, I can only say, that I also
> >> think this should be our goal.
> >
> > Try to put yourself into the shoes of someone who needs to write a new
> > video device using virtio. Oh, there are two ways to do it. This guest
> > OS only supports virtio-video. But this guest OS only supports
> > virtio-v4l2. Great, now you need to support two interfaces with your
> > device, or write two different devices.
>
> I think this is a hypothetical issue.

Issues have a strange tendency to become hypothetical when it's
convenient for you.

> IMO it makes sense to use V4L2
> UAPI only on Linux host with V4L2 devices + Linux/Android guest.
> virtio-video driver is already available for Linux. We already know our
> priorities and limitations, so building a decision tree for a potential
> device developer would be very easy.
>
> >>> * Having two overlapping specifications for video is overkill and wil=
l
> >>> just fragment virtio (as tempting as it is, I won't link to XKCD). I
> >>> strongly advise against that.
> >>
> >> I think they're not going to create more problems, than virtio-blk,
> >> virtio-scsi and virtio-fs, for example.
> >
> > At least these devices work at different layers, that makes them more
> > justifiable. virtio-video and virtio-v4l2 are just going to provide
> > the same API for video devices, only with different structures and
> > commands.
>
> Hmm, I think virtio-blk and virtio-scsi work on the same level, aren't
> they? They could also say this is basically the same thing.
>
> >> The decision can be made like this:
> >> 1. You have a V4L2 device, you don't need any more processing, just wa=
nt
> >> it inside a Linux/Android VM =3D> use virtio-v4l2.
> >> 2. You don't have a V4L2 device, or your host is not Linux, or your
> >> maybe your guest is not Linux/Android, or you want some extra processi=
ng
> >> on the host (say you have a third-party proprietary library or whateve=
r)
> >> =3D> use virtio-video.
> >
> > That would make sense if 2. could not be done just as easily by also
> > using virtio-v4l2, which I believe it can be.
>
> I'm sorry, I think a potential developer would just look into V4L2 docs,
> see struct v4l2_buffer (AFAIU with patches in the spec for the
> host/guest/object memory types on top) and run back to the cleanliness
> and simplicity of virtio-video. That's basically my story. :)
> Iterating on formats in VIDIOC_ENUM_FMT looks quite weird to me too.

I think you will probably end up doing similarly in virtio-video due
to the dependency between input and output formats that is not easy to
represent in a single structure.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

