Return-Path: <virtio-dev-return-12458-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D08C77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:30:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 34A061FF82
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:30:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15768986686
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 03:30:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F3FD0983E91; Fri, 28 Apr 2023 03:30:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1D9F98667E
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 03:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682652624; x=1685244624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpDsRDtOXSnEAOTnzQKoyWmTUOJdQ7843KMytqRpV8A=;
        b=jxD6w4j3kBkCl9zv4BLh9bLFeGvXFNKM+RhgReBG/aZUFDpoF2uMXEsnmAruJNayus
         6cJrl1s4iHCXevDfG3XDElqDSVi4V3IyIufBJIaRC1Mll551HWw087GXKAJXLC6WHn5o
         obhHD/mxobKHsnheWzwj0qk1dDvmx8eFmvHTSQ44eDM+1OI4uyOXxyxlQYJZfsw8DCRp
         2KD3wRzLwoEOdqayB4tEmBMi4PWfsk5++rxgNcGb3ai5/g/H3ztZX0jE9nxiRLE6Ta8l
         wJafL8CnMOlKzNVu7QsTG3FcTAyGOZnZRjGjVMmvpZuJtT8QnHHs7FZbn9ohonVduYcN
         VAtw==
X-Gm-Message-State: AC+VfDxBDBfiM4OIIabjf9IwXRolGYmA57KoHtVjfFxRpAGiao4syjAD
	1lajcmqWthVZFzZjqTKdjaV1kNtAwljJmxFVzV0=
X-Google-Smtp-Source: ACHHUZ4YSaHtCcN9flzR9AqUl4JLAsNtYzBGDO9GWDA7U8gH6e1hNyP3zSPh35nQRC6KJE6pMFdsQA==
X-Received: by 2002:a5e:890d:0:b0:74c:8cec:548e with SMTP id k13-20020a5e890d000000b0074c8cec548emr2330252ioj.4.1682652624205;
        Thu, 27 Apr 2023 20:30:24 -0700 (PDT)
X-Received: by 2002:a05:6e02:b4a:b0:32b:3dd3:4c9a with SMTP id
 f10-20020a056e020b4a00b0032b3dd34c9amr90695ilu.15.1682652186175; Thu, 27 Apr
 2023 20:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <CALgKJBqKWng508cB_F_uD2fy9EAvQ36rYR3fRb57sFd3ihpUFw@mail.gmail.com>
 <d83a8f62-a2c8-8f8d-46ed-0d747daca4d3@opensynergy.com> <CAKxn3ec7nDy9B0nyHUg3GfXt_oktrC91kB3QWXM-sGh8ectE5A@mail.gmail.com>
 <a4bf7c00-4249-cd67-c183-31cd7c019a40@opensynergy.com>
In-Reply-To: <a4bf7c00-4249-cd67-c183-31cd7c019a40@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 28 Apr 2023 12:22:54 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXjfPAeSaSE=XRKNjkAJeS8s6EGGuSypkUbGvXUmZcoRw@mail.gmail.com>
Message-ID: <CAPBb6MXjfPAeSaSE=XRKNjkAJeS8s6EGGuSypkUbGvXUmZcoRw@mail.gmail.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bgrzesik@google.com>, 
	=?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, 
	Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
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

On Thu, Apr 27, 2023 at 11:35=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 27.04.23 12:13, Bart=C5=82omiej Grzesik wrote:
> > Hi Alexander
> >
> > On Wed, Apr 26, 2023 at 6:00=E2=80=AFPM Alexander Gordeev
> > <alexander.gordeev@opensynergy.com> wrote:
> >>
> >> Hi Bart=C5=82omiej,
> >>
> >> On 21.04.23 13:49, Bart=C5=82omiej Grzesik wrote:
> >>> +CC chromeos-arc-video-eng team that also works on virtio-video
> >>>
> >>> Hi everyone!
> >>>
> >>>   From the experience of working on virtio-video I can definitely agr=
ee
> >>> with Alex Courbot, that moving to virtio-v4l2 will be a great move.
> >>> This move will not only simply things a lot but also allow us things =
like
> >>> vhost-net like implementation for some devices (however this is
> >>> thinking way ahead and linux only).
> >>>
> >>> One added benefit of this move that I'd like to point out now, that
> >>> probably
> >>> haven't been mentioned before, is moving to asynchronous resource que=
ue
> >>> call. Previously `VIRTIO_VIDEO_CMD_RESOURCE_QUEUE` have been
> >>> synchronous and caused one hard to debug bug caused by this flawed
> >>> design. During the command execution the virtio queue descriptors are
> >>> blocked, potentially leading to dead locking the device. The implemen=
tation
> >>> of virtio-v4l2 (even as is - btw nice work Alex!) eliminates this iss=
ue
> >>> by moving to asynchronous response of the resource queue (VIDIOC_QBUF=
).
> >>
> >> Thanks for your valuable feedback! Could you please share some details
> >> about the bug? That would be very helpful. I'm working on the next
> >> version of the virtio-video draft, so I can change it there. I like th=
e
> >> idea to use V4L2 as a reference, so we should probably do it like it i=
s
> >> done there, only simpler. Still it would be interesting to know the
> >> details, because we didn't have issues with the current design.
> >
> > In this bug, an app preallocated and enqueued all output buffers (to
> > CAPTURE queue). This is inline with V4L2 and in case of virtualized vid=
eo
> > stack helps with latency. Those enqueued buffers are holding virtqueue
> > descriptors until filled with a decoded frame. While for one stream it =
is not an
> > issue, but for more simultaneous streams, it quickly becomes a serious
> > problem. In our case all descriptors from the virtqueue were consumed
> > by enqueued output buffers and no other command could be issued
> > to hypervisor. This dead locked the entire driver, by starving the driv=
er with
> > descriptors - even STREAM_DESTROY command could not be issued and
> > only solution was to reboot the guest.
> >
> > While it is easily solvable by adjusting the size of the virtqueue, it
> > is a flaw to
> > this design. The number would always have to a function of maximum numb=
er
> > of supported streams - raising rather quickly.
> >
> > I remember having a few thoughts on how it could be solved and I think =
that
> > removing the need to block those descriptors is the best approach in my=
 opinion.
> > One would argue that preallocating descriptors for this purpose or spli=
tting
> > the command queue to input, output and control might be a viable soluti=
on
> > or per stream. However it would only delay the issue in time or could
> > cause other streams to "starve".
>
> Thank you for the detailed description. This makes total sense to me
> indeed. I thought about this problem some time and discussed it with my
> colleagues. Indeed looks like it would be best to stop blocking these
> descriptors. We can add more queues, but this doesn't look scalable
> indeed. There are several ways to unblock the descriptors, I think.
> First, we can do the same thing as in V4L2: add a separate (blocking?)
> DEQUEUE command. But then we theoretically can have the same problem
> with DRAIN, because it also blocks. So why not just use the event queue
> to receive the completion events for both QUEUE and DRAIN commands
> asynchronously? One could argue, that the errors should maybe come out
> of band. But at the same time we already use event queue to deliver
> dynamic resolution change events, that clearly should be delivered with
> the flow of buffers.

FWIW that's exactly how virtio-v4l2 handles things.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

