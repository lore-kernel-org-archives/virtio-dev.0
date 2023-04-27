Return-Path: <virtio-dev-return-12447-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E250C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 10:14:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB0E62B03B
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 10:14:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85E0E98664F
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 10:14:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 62104983FE9; Thu, 27 Apr 2023 10:14:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49238986641
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 10:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590439; x=1685182439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQwWa7grodwauxhdiH5+pZhufm23Pb/VZcJ8rZuikiU=;
        b=VhTNuidx3gFM8wsa53Uk9gBD/3gzhZWPL3wt9tNDbN6jV8kC8HbTeI0wGYSZMdBW9i
         oxAjqMILbIwnOYjJMiVaJhLNpbhgxz8AHXlB/H8TeqPnHaqCwbhNJ5M78FKxBa8CDC1R
         g0Rr0hcgL1cBgH68envktTYd28DJa4QRhnW+OyVr/nWWNaQG2Q1i84YWtKrheTNs2ebn
         mNde8j4xyRD9FePLWDB/gqrJRjr+m5/lf7fpIpFaTgItCaeZMDTcBxRZT5GEOGotEYm2
         wbX1M1bK0DbJsnk6p3K1rOTyIeTWAmAg79J8HrVgxiegPkzl5RgRgvpZ9UpWx+j68a6l
         g77w==
X-Gm-Message-State: AC+VfDygKPUmYJ7+AGQ4tCAqn6FUgGBYlRTO8QWjZ2tdcvbHXVQ9cwKI
	FKc8aPsTHZdrvSB/ksRM4hNlOdY82csgmarT25DS
X-Google-Smtp-Source: ACHHUZ48Rkf0OnigapIQ3cP4schf6XN/5TxVXHAiyDZpanzYlCQqxtykA0oDQhFwrApiyyd/QGLFo+uP/DsOkuF4mXs=
X-Received: by 2002:a17:902:f546:b0:19e:6b08:578c with SMTP id
 h6-20020a170902f54600b0019e6b08578cmr126305plf.1.1682590439372; Thu, 27 Apr
 2023 03:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <CALgKJBqKWng508cB_F_uD2fy9EAvQ36rYR3fRb57sFd3ihpUFw@mail.gmail.com> <d83a8f62-a2c8-8f8d-46ed-0d747daca4d3@opensynergy.com>
In-Reply-To: <d83a8f62-a2c8-8f8d-46ed-0d747daca4d3@opensynergy.com>
From: =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bgrzesik@google.com>
Date: Thu, 27 Apr 2023 12:13:48 +0200
Message-ID: <CAKxn3ec7nDy9B0nyHUg3GfXt_oktrC91kB3QWXM-sGh8ectE5A@mail.gmail.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Alexandre Courbot <acourbot@chromium.org>, Cornelia Huck <cohuck@redhat.com>, 
	virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Enric Balletbo i Serra <eballetb@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	"srosek@google.com" <srosek@google.com>, "zyta@google.com" <zyta@google.com>, hmazur@google.com, 
	mikrawczyk@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Hi Alexander

On Wed, Apr 26, 2023 at 6:00=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> Hi Bart=C5=82omiej,
>
> On 21.04.23 13:49, Bart=C5=82omiej Grzesik wrote:
> > +CC chromeos-arc-video-eng team that also works on virtio-video
> >
> > Hi everyone!
> >
> >  From the experience of working on virtio-video I can definitely agree
> > with Alex Courbot, that moving to virtio-v4l2 will be a great move.
> > This move will not only simply things a lot but also allow us things li=
ke
> > vhost-net like implementation for some devices (however this is
> > thinking way ahead and linux only).
> >
> > One added benefit of this move that I'd like to point out now, that
> > probably
> > haven't been mentioned before, is moving to asynchronous resource queue
> > call. Previously `VIRTIO_VIDEO_CMD_RESOURCE_QUEUE` have been
> > synchronous and caused one hard to debug bug caused by this flawed
> > design. During the command execution the virtio queue descriptors are
> > blocked, potentially leading to dead locking the device. The implementa=
tion
> > of virtio-v4l2 (even as is - btw nice work Alex!) eliminates this issue
> > by moving to asynchronous response of the resource queue (VIDIOC_QBUF).
>
> Thanks for your valuable feedback! Could you please share some details
> about the bug? That would be very helpful. I'm working on the next
> version of the virtio-video draft, so I can change it there. I like the
> idea to use V4L2 as a reference, so we should probably do it like it is
> done there, only simpler. Still it would be interesting to know the
> details, because we didn't have issues with the current design.

In this bug, an app preallocated and enqueued all output buffers (to
CAPTURE queue). This is inline with V4L2 and in case of virtualized video
stack helps with latency. Those enqueued buffers are holding virtqueue
descriptors until filled with a decoded frame. While for one stream it is n=
ot an
issue, but for more simultaneous streams, it quickly becomes a serious
problem. In our case all descriptors from the virtqueue were consumed
by enqueued output buffers and no other command could be issued
to hypervisor. This dead locked the entire driver, by starving the driver w=
ith
descriptors - even STREAM_DESTROY command could not be issued and
only solution was to reboot the guest.

While it is easily solvable by adjusting the size of the virtqueue, it
is a flaw to
this design. The number would always have to a function of maximum number
of supported streams - raising rather quickly.

I remember having a few thoughts on how it could be solved and I think that
removing the need to block those descriptors is the best approach in my opi=
nion.
One would argue that preallocating descriptors for this purpose or splittin=
g
the command queue to input, output and control might be a viable solution
or per stream. However it would only delay the issue in time or could
cause other streams to "starve".

Porting asynchronous dequeueing of resources would bring the virtio-video
extremely close to virtio-v4l2 and therefore I support Alexandre idea to us=
e
v4l2 as a protocol.


> > I also agree that in this case v4l2 would only be a protocol similar to=
 how
> > virtio-video was, that has the benefit of allowing very simple guest
> > drivers.
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



--
Best regards,
Bartek

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

