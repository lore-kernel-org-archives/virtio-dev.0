Return-Path: <virtio-dev-return-12487-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048F7C77B7C
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 01:16:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F2CA82B00F
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 01:16:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF17598648A
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 01:16:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B7B8E9862EE; Tue,  2 May 2023 01:16:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F227986461
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 May 2023 01:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682990165; x=1685582165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxoQSfAQYxuBjmq4lWK7oZcUB3RqGsBc2keG68De6Fo=;
        b=Sy27gBwJlW2v9Ns54xYbXIvEiglqGALdtpKTpusfhtQfv2M8YQk1hZaPXXMw0gYw6e
         2jYJHww0zmEFJFAr7s/cR+lLdmkfPZmdxgmFmFmKzInh3frV+59yGXCYKK7KiFOgar6Q
         CcRV6HQ2+kTPaBoXwQORSzZZu8hOxyQ+LcoR6DZ4/cfVJOxD+1oaXk5r+yF7ZGlmhTCE
         072ZtgiIzbmsX9KQ0vOpgc7dNmBPJiVrvjevfWa8+H/8rOKmpVTt+YRoVbRqothLmy3h
         FgvQQPKkEhjG808FV4VBvu3T3mx9hPJKRw333RJmdsEm9XuNn+RjAdAv0tT4/an20qzU
         wtug==
X-Gm-Message-State: AC+VfDzFGG4ZDnyfKRZlASLaCLfVXoIM96ztSRgM+8PPX+wxYBP73QLz
	3GOROpPmV0foB8qo0tI8eMl76BB0bY5HRwMS/PA=
X-Google-Smtp-Source: ACHHUZ4WzIfsuedOi+5krMr5hsYmtL/qilZ3bwJrHcpMh1uB4UfrQY7uRH0DjpbmiJzbwnfzsmJ6lg==
X-Received: by 2002:a17:90b:8c6:b0:247:6ec8:7e93 with SMTP id ds6-20020a17090b08c600b002476ec87e93mr16321798pjb.33.1682990165491;
        Mon, 01 May 2023 18:16:05 -0700 (PDT)
X-Received: by 2002:a05:622a:198a:b0:3c0:4e06:764d with SMTP id
 u10-20020a05622a198a00b003c04e06764dmr191215qtc.16.1682989671290; Mon, 01 May
 2023 18:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <87cz6mnaqk.fsf@redhat.com> <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com> <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <87354okkx5.fsf@redhat.com> <c1658889-0a90-5681-6afb-7160cdf1bf77@opensynergy.com>
 <CAPBb6MXNUHJuq40-RQO-0aa6UU0R_ZOHvB48B_t_knpK4Uw0eQ@mail.gmail.com> <0f67a3ac-4995-154f-142f-d49d1684aa3c@opensynergy.com>
In-Reply-To: <0f67a3ac-4995-154f-142f-d49d1684aa3c@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Tue, 2 May 2023 10:07:39 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUEtC1oyEVq4iwdBG0vMj3FwJ2+Xr+-d99ygCZjp6f39g@mail.gmail.com>
Message-ID: <CAPBb6MUEtC1oyEVq4iwdBG0vMj3FwJ2+Xr+-d99ygCZjp6f39g@mail.gmail.com>
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

On Fri, Apr 28, 2023 at 5:55=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 28.04.23 06:02, Alexandre Courbot wrote:
> > This is going to be my last answer to this thread ; I don't think I
> > have more technical arguments to give than I already have and the
> > discussion is drifting into territory I am not interested in engaging.
> > At the end of the day it's up to the virtio folks to make a decision
> > about what the best course of action is. If we end up with
> > fragmentation, so be it, it will still be better than the current
> > situation anyway.
>
> I agree with the summary. I think we have discussed all the things in
> depth and even reached some understanding.
> Could you please at least share your feedback on my proposal for the
> QUEUE/DRAIN completion handling?

Well I've re-read your email once more and again I confirm, this is
exactly what virtio-v4l2 does. Here is the code that sends the dequeue
buffer event on the event queue after a buffer is dequeued on the
host: https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virtio/=
v4l2/worker.rs#L1114.

IOW, there are no VIDIOC_DQBUF or VIDIOC_DQEVENT (or any command that
can block) taking place between the guest and host, these are sent to
the guest as events.

And yes, this design simplifies things quite a bit vs. retaining
command descriptors until some operation completes. Beyond the
increased potential for deadlock, there is also added complexity as
the descriptors must eventually be returned to the guest, even if the
requested operation is interrupted. This increases the amount of state
on the host which must keep track of pending operations and cancel
some on occasion (which is pretty error-prone), whereas having all
commands complete without delay could theoretically let us function
even with a single command descriptor. Retaining the descriptors was
supposed to reduce host/guest traffic a bit, but at that level of
interaction (60 ops/second for a high framerate video) I don't think
it's worth the cost.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

