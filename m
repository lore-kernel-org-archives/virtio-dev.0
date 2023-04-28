Return-Path: <virtio-dev-return-12457-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162F2C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:23:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 208852B03C
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:23:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06A24986688
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:23:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5E38983E91; Fri, 28 Apr 2023 03:23:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D10CE98667E
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 03:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682652181; x=1685244181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRdwZAG1fNU3WpWFjnubaPGS22hm5pKAjlPY9+MOWBc=;
        b=j8fm2BnqSwKoSuV05k3laaXtdMDOBX6Xty9CryFn3KSPZlrhVd+HMyPqS+liZr5KXK
         yKjaRBCHQj8vQ7tFe4EeD93LXhq9zuftWtwvc2UuG273Ain2ygOgf0RiAgTT8rwhaN0S
         N9bQqLugLPDGUN6A3O47R/48l9WxkKxAwnbAYASR43fI7Yk3W8lUBiAHULzV0wMKC0OZ
         l76joiCaAn9ZMzk3hmqUGlxQ8ecqv7/V4KHUwSVdwj3JL4cGEFjFYPeEftQrLfOhmfoD
         cpjMdCiYcpfW7UEu2yOhEhBya+KvGuHtHt72UfR9jk3OTOWlPJFo5kOcWTOcjMK4X0Zh
         csbw==
X-Gm-Message-State: AC+VfDwhmFY+pNxV2gu7xJq5C+QJ1MZLgQpNTVKOBW/aETBJnlPvFBx7
	nizF9zUNeakM8LyiVY12f442aqfxEguzfbvKrNE=
X-Google-Smtp-Source: ACHHUZ6Vb+q4ehPOFxKqxZgDa2RczIwiFxmduarRgPbkVj3sPczSQShQWIVsz7vSAjC4EtNJseC4cw==
X-Received: by 2002:a92:c087:0:b0:32e:d412:5de9 with SMTP id h7-20020a92c087000000b0032ed4125de9mr2746262ile.25.1682652180398;
        Thu, 27 Apr 2023 20:23:00 -0700 (PDT)
X-Received: by 2002:a05:6e02:178a:b0:329:48b9:3fc7 with SMTP id
 y10-20020a056e02178a00b0032948b93fc7mr107923ilu.17.1682652178473; Thu, 27 Apr
 2023 20:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com> <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <CAPBb6MWMjvTiAdCwfUH62EpqYLHotFoDg7hAfqY2oLkpmYM_HQ@mail.gmail.com> <b2d78c20-8476-ccda-42ca-6863f44b06ed@opensynergy.com>
In-Reply-To: <b2d78c20-8476-ccda-42ca-6863f44b06ed@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 28 Apr 2023 12:22:46 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVg3rcWK2XVXEPAijD7ETPDqDnx=LiKrK6aRq0x5bYVTQ@mail.gmail.com>
Message-ID: <CAPBb6MVg3rcWK2XVXEPAijD7ETPDqDnx=LiKrK6aRq0x5bYVTQ@mail.gmail.com>
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

On Thu, Apr 27, 2023 at 11:20=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 26.04.23 07:52, Alexandre Courbot wrote:
> > On Mon, Apr 24, 2023 at 4:52=E2=80=AFPM Alexander Gordeev
> > <alexander.gordeev@opensynergy.com> wrote:
> >>
> >> On 21.04.23 18:01, Alexander Gordeev wrote:
> >>
> >>> On 21.04.23 06:02, Alexandre Courbot wrote:
> >>>
> >>>> * I am still not convinced that V4L2 is lacking from a security
> >>>> perspective. It would take just one valid example to change my mind
> >>>> (and no, the way the queues are named is not valid). And btw, if it
> >>>> really introduces security issues, then this makes it invalid for
> >>>> inclusion in virtio entirely, just not OpSy's hypervisor.
> >>>
> >>>
> >>> I'd like to start with this and then answer everything else later.
> >>>
> >>> Let's compare VIRTIO_VIDEO_CMD_RESOURCE_QUEUE with
> >>> VIDIOC_QBUF+VIDIOC_DQBUF. Including the parameters, of course. First,
> >>> let's compare the word count to get a very rough estimate of complexi=
ty.
> >>> I counted 585 words for VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, including th=
e
> >>> parameters. VIDIOC_QBUF+VIDIOC_DQBUF are defined together and take 12=
06
> >>> words, they both use struct v4l2_buffer as a parameter. The struct ta=
kes
> >>> 2716 words to be described. So the whole thing takes 3922 words. This=
 is
> >>> 6.7 times more, than VIRTIO_VIDEO_CMD_RESOURCE_QUEUE. If we check the
> >>> definitions of the structs, it is also very obvious, that V4L2 UAPI i=
s
> >>> almost like an order of magnitude more complex.
> >>
> >>
> >> I think, it is best to add all the steps necessary to reproduce my cal=
culations just in case.
> >>
> >> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is doing essentially the same thing as=
 VIDIOC_QBUF+VIDIOC_DQBUF, so we're comparing apples to apples (if we don't=
 forget to compare their parameters too).
> >>
> >> To get the word count for the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE I opened=
 the rendered PDF of video section only from the first email in this thread=
. Here is the link: https://drive.google.com/file/d/1Sm6LSqvKqQiwYmDE9BXZ0p=
o3XTKnKYlD/view?usp=3Dsharing . Then I scrolled to page 11 and copied every=
thing related a text file. This is around two pages in the PDF. Then I remo=
ved page numbers from the copied text and used 'wc -w' to count words.
> >>
> >> To get the word count for VIDIOC_QBUF+VIDIOC_DQBUF I opened this link:=
 https://docs.kernel.org/userspace-api/media/v4l/vidioc-qbuf.html . Then I =
selected all the text except table of contents and did followed the same pr=
ocedure.
> >>
> >> To get the word count for struct v4l2_buffer and other types, that are=
 referenced from it, I opened this link: https://docs.kernel.org/userspace-=
api/media/v4l/buffer.html#struct-v4l2-buffer . Then I selected all the text=
 except the table of contents and the text above struct v4l2_buffer definit=
ion. The rest is the same.
> >>
> >> Also it's quite obvious if you look at them how much bigger struct v4l=
2_buffer (including the referenced types) is compared to struct virtio_vide=
o_resource_queue.
> >
> > You are comparing not the complexity of the structures but the
> > verbosity of their documentation, which are written in a different
> > style, format, and by different people.
>
> I agree to some extent. At least this benchmark is simple and it
> provokes to actually go and look at the definitions, which IMO should be
> enough to already see the difference. What could be a better benchmark?
> Maybe counting the number of various fields and flags and enum cases,
> that one has to read through?

I give you another point of comparison literally 5 lines down my email.

>
> > And the V4L2 page also
> > contains the description of memory types, which is part of another
> > section in the virtio-video spec.
>
> You mean only enum v4l2_memory? Or anything else too?
>
> > There is no way to draw a meaningful
> > conclusion from this.
> >
> > If you want to compare, do it with how the structures are actually
> > used. Here is how you would queue an input buffer with virtio-video:
> >
> >    struct virtio_video_resource_queue queue_buf =3D {
> >        .cmd_type =3D VIRTIO_VIDEO_CMD_RESOURCE_QUEUE,
> >        .stream_id =3D 42,
> >        .queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT,
> >        .resource_id =3D 1,
> >        .timestamp =3D 0x10,
> >        .data_sizes =3D {
> >          [0] =3D 0x1000,
> >        },
> >    };
> >
> > Now the same with virtio-v4l2:
> >
> >    struct virtio_v4l2_queue_buf queue_buf =3D {
> >        .cmd =3D VIRTIO_V4L2_CMD_IOCTL,
> >        .code =3D VIDIOC_QBUF,
> >        .session_id =3D 42,
> >        .buffer.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> >        .buffer.index =3D 1,
> >        .buffer.timestamp.tv_usec =3D 0x10,
> >        .buffer.memory =3D V4L2_MEMORY_MMAP,
> >        .planes =3D {
> >          [0] =3D { .bytesused =3D 0x1000 },
> >        }
> >    };
> >
> > In both cases, you pass a structure with some members set, and the
> > rest to 0. The host receives basically the same thing - it's the same
> > data! The only difference is how it is laid out.
>
> How do I know this from the text? How do I verify, that this is correct?
> Can I be sure this code is going to work or not between any device and
> any driver?
>
> With virtio-video you can just go to the spec/header file, take the
> struct definition and simply set all the fields.
>
> With V4L2 UAPI I don't see any other way except going through the whole
> buffer.html file, filtering potentially irrelevant stuff, then doing
> some trials, and maybe looking into the device or driver code. Maybe
> also asking you for an advice?

The relevant fields for each decoding operation are clearly detailed
in https://www.kernel.org/doc/html/v5.18/userspace-api/media/v4l/dev-decode=
r.html,
which I already linked to multiple times.

> I think it is worth trying to imagine you're a newcomer in the project.
> Or a security auditor.
>
> So I think we can't draw conclusions about the spec quality from these
> code samples.
>
> > Also as mentioned by Bart, the apparent simplicity of
> > VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, which does not require a dequeue
> > operation as the dequeue is sent with its response, is actually a
> > fallacy: that design choice makes the specification simpler, but at
> > the cost of more complexity on the device side and the potential to
> > starve on command descriptors. By contrast, adopting the V4L2 model
> > resulted in simpler code on both sides and no possibility to deadlock.
> > That point could be addressed by revising the virtio-video spec, but
> > then you get even closer to V4L2.
>
> Hmm, I understand, thanks. Well, I can fix this in the spec. I have some
> ideas. I think I'd better describe them in an answer to Bart's email.
>
> >> Do we agree now, that V4L2 UAPI is not only marginally more complex?
> >
> > No, and I rest my case on the code samples above.
> >
> >>>
> >>>
> >>> Also please read:
> >>>
> >>> https://medium.com/starting-up-security/evidence-of-absence-8148958da=
092
> >>>
> >>
> >> This reference probably needs a clarification. You argued, that V4L2 h=
as a good track record so far. Here is the quote:
> >>
> >>> FWIW V4L2 has been in use for a looong time (including in Chromebooks
> >>> that do secure playback) and I am not aware of fundamental security
> >>> issues with it.
> >>
> >> But absence of found major security issues doesn't tell us much about =
the number of not found ones. Absence of evidence is not an evidence of abs=
ence. At the link above a former Director of Security at Facebook shares hi=
s thoughts about what could be a good evidence of absence of major security=
 problems.
> >
> > You are just FUDing now.
>
> These are well established security concepts AFAIK. Are you gaslighting?
>
> > The exact same argument could be made about
> > virtio-video. If you want to borrow from the security world, I can ask
> > you how going with virtio-video when V4L2 exists is different from
> > rolling your own crypto.
>
> It is very different because obviously neither of them is a crypto.
>
> >> So a bug bounty program with high premiums that covers V4L2 would be a=
 better argument in favor of *already written code* in my opinion. Not for =
new code. Also probably it is also an argument in favor of the spec, that i=
s the V4L2 UAPI. Like that it is polished enough. Not so sure about that th=
ough.
> >>
> >> There actually are several bug bounty programs, that cover the kernel.=
 These are Google's kctf, ZDI's pwn2own, and zerodium AFAIK. However the pr=
emiums are not even close to the ones mentioned in my reference. Anyway thi=
s means, that using *the existing V4L2 code in the kernel* is probably OK. =
But this creates some limitations if we want the actual code to still be co=
vered with these bug bounties, right? This means, that the host OS has to b=
e Linux and the actual hardware has to be exposed through a stable V4L2 dri=
ver, that is in mainline for some time, and there has to be no or little pr=
ocessing on top. For us this is not possible unfortunately. In the end both=
 things could be secure:
> >>
> >> 1. V4L2 pass through can be secure because of the bug bounty programs =
and a lot of attention to the kernel in general.
> >> 2. For the new code this doesn't work, so the spec should be as simple=
 and device-centric as possible. Because, all other things being equal, the=
re are fewer errors in simpler programs. So defining a subset of V4L2 UAPI =
including the data types looks like a good idea to me. The stateful decoder=
 interface, that you point to, does not define a subset in the data types.
> >
> > Wouldn't you have exactly the same problem by using a new guest-host
> > protocol?
>
> I think this is far-fetched. Especially if our new protocol is
> intentionally kept close to the reference protocol with a few things
> made better and simpler. That would be my preferred route.
>
> > Are you going to start a bounty program for virtio-video to
> > get an assurance that it is secure?
>
> I'm not sure it is possible because the device is proprietary. At least
> the driver is going to be covered hopefully. So for the device we're
> going to rely on simplicity, tests and audits. But who knows. I'm not
> the one to make this decision.
>
> >> This is basically my reasoning.
> >>
> >> Also these two specs don't need to compete with each other. They have =
different limitations and they are for different audiences. If you check th=
e XKCD's comic, it is about competing standards.
> >
> > They allow exactly the same thing (virtualization of video
> > decoding/encoding) and there isn't any use-case of virtio-video that
> > could not be covered equally well by V4L2. Reinventing a new video
> > specification is pointless and will lead to unneeded fragmentation.
>
> I don't agree with these statements.
>
> > We should also expect reticence from the Linux community to upstream
> > two virtual video drivers that basically do the same thing.
>
> This is hypothetical.
>
> --
> Alexander Gordeev
> Senior Software Engineer
>
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
>
> Phone: +49 30 60 98 54 0 - 88
> Fax: +49 (30) 60 98 54 0 - 99
> EMail: alexander.gordeev@opensynergy.com
>
> www.opensynergy.com
>
> Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 1086=
16B
> Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah
>
> Please mind our privacy notice<https://www.opensynergy.com/datenschutzerk=
laerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-=
general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unse=
re Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www=
.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaef=
tspartner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

