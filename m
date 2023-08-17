Return-Path: <virtio-dev-return-13567-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4343C3063E
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 15:20:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 26C157535C
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 15:20:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 940379867B1
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 15:20:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 147A4986400; Thu, 17 Aug 2023 15:20:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45AE59863FE
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Aug 2023 15:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6RbtyMQPPSa9PQ-ro1_7qg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692285592; x=1692890392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0PO7WX++ujGqCtbObzzIwTUsgn7NpPOIGXyiwfBSZ0=;
        b=VChixiC7fGHpC7d4NQhX/ht95OUayOmr7qOWATEQOnMJgxZTpqiyY0JKBNMzZPc/5P
         M1Zvo8RMf1wqn713ZjqlTe122JQYY139pj9kwZQBnaYpGx7Tn5utq4CY9u2BoqAx7HI3
         qn7sKnwBNzC0iUcM+mISMNPW8cb748k1WOyorEcZevSqaJ4zLToYMTq1vTZ33pFqPbgX
         V31XULouTU05RGGGnr9Tv2ShgjdtYTLhuidGXd/6nc1uGnS2Xq6hIHZ805P1p2uwZ2sc
         gL0dlSUZzqz/Je237hybdXKG7n7Z69YeXjcvNHBf5+uI546CqfE90ailgY4Amoadgk0L
         /jnA==
X-Gm-Message-State: AOJu0YwxW+IIOdr3McviSokhjkyJTplYMERNKYKjaH0BlWwKcxIviwIM
	K+s4CpsVcMFLxynxAEimsbidVqK9TZhBvTz37FqOnbocr9sJqpk/Sn+qLU3MgNyiug/FZTwbYqL
	536+yCpDY7B+kFsL6oZhiiXheAfKVPOdyr5vUvo2jCzeU
X-Received: by 2002:a25:e695:0:b0:d4d:f8f4:e409 with SMTP id d143-20020a25e695000000b00d4df8f4e409mr4798340ybh.57.1692285591780;
        Thu, 17 Aug 2023 08:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ07/0IksyjX9znZJW7zJJjx7bv4ase8Dt4YfxkAtl6q4cG5fTK6L0yQc/or1KQege1vOjJpaUIROymmRGXh4=
X-Received: by 2002:a25:e695:0:b0:d4d:f8f4:e409 with SMTP id
 d143-20020a25e695000000b00d4df8f4e409mr4798328ybh.57.1692285591532; Thu, 17
 Aug 2023 08:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com> <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
In-Reply-To: <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 17:19:15 +0200
Message-ID: <CAJaqyWd=hCvknO5MQ0Nu4iwxPMfjHGHNJHiwzxAaRLcgZ1HKxg@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH 4/5] virtqueue: constraints for virtqueue state

On Tue, Aug 15, 2023 at 1:30=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
>
>
>
> On 8/15/2023 8:34 AM, Jason Wang wrote:
> > On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@inte=
l.com> wrote:
> >> This commit specifies the constraints of the virtqueue state,
> >> and the actions should be taken by the device when SUSPEND
> >> and DRIVER_OK is set
> >>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   content.tex | 31 +++++++++++++++++++++++++++++++
> >>   1 file changed, 31 insertions(+)
> >>
> >> diff --git a/content.tex b/content.tex
> >> index 43bd5de..f6ac581 100644
> >> --- a/content.tex
> >> +++ b/content.tex
> >> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
> >>
> >>   See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Co=
unters}.
> >>
> >> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a =
Virtio Device / Virtqueue State}
> >> +
> >> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set SUSP=
END in \field{device status}
> >> +first before getting or setting Virtqueue State of any virtqueues.
> > I don't get why this is a must. It could be useful for debugging.
> To avoid race conditions with the device and make the device
> implementation easier
> >
> >> +
> >> +If VIRTIO_F_QUEUE_STATE has been negotiaged but VIRTIO_RING_F_PACKED =
not been negotiated,
> > typo
> yes
> >
> >> +the driver MUST NOT access \field{Used State} of any virtqueues, it s=
hould use the
> >> +used index in the used ring.
> >> +
> >> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a =
Virtio Device / Virtqueue State}
> >> +
> >> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set in=
 \field{device status},
> >> +the device MUST ignore any accesses against Virtqueue State of any vi=
rtqueues.
> > Btw, do we need to clarify the behavior of ring reset after suspending?
> I think once suspended, the device should ignore resetting a queue

Actually shadow virtqueue could benefit from the ability to change vq
properties (addresses) while the device is suspended, and then just
resume it. I've been told that ring reset is overkill for that.

But probably it is better to address it on top, with another feature flag.

> >
> >> +
> >> +When VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKE=
D is not,
> >> +the device MUST ignore any accesses against \field{Used State}.
> >> +
> >> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST reset
> >> +the Virtqueue State of every virtqueue upon a reset.
> > Need to define the meaning of "reset" this is important for packed virt=
queue.
> I will remove this as Stefan suggested.
> >
> >> +
> >> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been negotiaged=
, when SUSPEND is set,
> >> +the device MUST record the Virtqueue State of every enabled virtqueue
> >> +in \field{Available State} and \field{Used State} respectively,
> >> +and correspondingly restore the Virtqueue State of every enabled virt=
queue
> >> +from \field{Avaiable State} and \field{Used State} when DRIVER_OK is =
set.
> > We can just let the device report those states in any case then we
> > don't need to care about those details, or did you see any blockers?
> Agree, I will add the definition of used_state of splitted vq in the
> next version
>
> Thanks
> >
> > Thanks
> >
> >> +
> >> +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED =
has been not, when SUSPEND is set,
> >> +the device MUST record the available state of every enabled virtqueue=
 in \field{Available State},
> >> +and restore the available state of every enabled virtqueue from \fiel=
d{Avaiable State}
> >> +when DRIVER_OK is set.
> >> +
> >>   \input{admin.tex}
> >>
> >>   \chapter{General Initialization And Device Operation}\label{sec:Gene=
ral Initialization And Device Operation}
> >> --
> >> 2.35.3
> >>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

