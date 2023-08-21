Return-Path: <virtio-dev-return-13575-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D0FEE49A0
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 04:03:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5205F2CAD4
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 04:03:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C50B986283
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 04:03:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 116A4986209; Mon, 21 Aug 2023 04:03:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB15A986235
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 Aug 2023 04:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ubswAfgrOAao9Kc3jmEFRw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692590607; x=1693195407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xewN6Q2KscUl2z4X0NzpBrQxnxv2TaUb9Gp9dZEMzw=;
        b=eOH2bOiTN2UVBGFPT20VksnoEOJXBBvTyBCeXT9walENW2ggBxuxXr8gwBSWjxSwff
         CFAvf5RPbTNofSQ1FGElsBWW0GG3RqO8xW1HPCvYx7cTSvQ1LBa3qR2MkQVkqMBZZqui
         VW0WAgFSvU6A9z0IAUfcr1AaHfZvh1gLzS8+8GRH8QznbaealP+WZb1ut99DqF4MXVIz
         Lxg7YmlCwIx4qe9yrwNXSryqqYfOHUGwnCk0omustOn/pVfPh2RyTw23j/mHgz12iVjo
         OQIsrlcSPNLjxJHhXzUKbGNLo2NlGNU8vckLKJE3oOLLcFjBdI2BHaQeCdvnJRMrQOBt
         1tDw==
X-Gm-Message-State: AOJu0YxWAUcRKJzYwpwnUib+lG/Pg7pKN/ZgklF08ZgDL0IJM+b806PO
	2nbARe8uay6F8i7Or5vNLsJDptQxTDy0R259fgFUYlaDwbG66vvLE4GPA4g+ANWAdzFLQdG8sSb
	y8EIkWdyBSTYvPOJbMRtIFxpWC0UIxVnu3Kz/BbEpc0Rs
X-Received: by 2002:a2e:9699:0:b0:2bc:bb02:fdba with SMTP id q25-20020a2e9699000000b002bcbb02fdbamr1392440lji.40.1692590607030;
        Sun, 20 Aug 2023 21:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiNwa+gDF2ayVGUPQRaXn2Dh2Gy9RlRS3TfnRYBfALYhdGCNEUOeiwAP1XTW3PxgUs4Z6neo+xrXJXAGQbQVQ=
X-Received: by 2002:a2e:9699:0:b0:2bc:bb02:fdba with SMTP id
 q25-20020a2e9699000000b002bcbb02fdbamr1392427lji.40.1692590606687; Sun, 20
 Aug 2023 21:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com> <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com> <SN6PR11MB3517EF23D99CE4FDA8DDB22DFF1AA@SN6PR11MB3517.namprd11.prod.outlook.com>
 <a4acfe61-0eff-d487-a62e-5bb523bf3d54@intel.com>
In-Reply-To: <a4acfe61-0eff-d487-a62e-5bb523bf3d54@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Aug 2023 12:03:15 +0800
Message-ID: <CACGkMEsBxKoeVKSx-Zcc1_a77=UgFxxX6A3AWAYScS19o65C7w@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: "Uminski, Piotr" <Piotr.Uminski@intel.com>, "mst@redhat.com" <mst@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state

On Thu, Aug 17, 2023 at 4:43=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
>
>
>
> On 8/17/2023 4:31 PM, Uminski, Piotr wrote:
> >
> >> -----Original Message-----
> >> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> >> open.org> On Behalf Of Zhu, Lingshan
> >> Sent: Tuesday, August 15, 2023 1:30 PM
> >> To: Jason Wang <jasowang@redhat.com>
> >> Cc: mst@redhat.com; eperezma@redhat.com; cohuck@redhat.com; virtio-
> >> comment@lists.oasis-open.org; virtio-dev@lists.oasis-open.org
> >> Subject: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints f=
or
> >> virtqueue state
> >>
> >>
> >>
> >> On 8/15/2023 8:34 AM, Jason Wang wrote:
> >>> On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@in=
tel.com>
> >> wrote:
> >>>> This commit specifies the constraints of the virtqueue state,
> >>>> and the actions should be taken by the device when SUSPEND
> >>>> and DRIVER_OK is set
> >>>>
> >>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>> ---
> >>>>    content.tex | 31 +++++++++++++++++++++++++++++++
> >>>>    1 file changed, 31 insertions(+)
> >>>>
> >>>> diff --git a/content.tex b/content.tex
> >>>> index 43bd5de..f6ac581 100644
> >>>> --- a/content.tex
> >>>> +++ b/content.tex
> >>>> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
> >>>>
> >>>>    See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap
> >> Counters}.
> >>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of =
a Virtio
> >> Device / Virtqueue State}
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set
> >> SUSPEND in \field{device status}
> >>>> +first before getting or setting Virtqueue State of any virtqueues.
> >>> I don't get why this is a must. It could be useful for debugging.
> >> To avoid race conditions with the device and make the device
> >> implementation easier
> > It should be possible to set Virtqueue State in two states:
> >   - Before DRIVER_OK - as a part of the queue creation at target system
> > -  After SUSPEND - when the device was activated and then suspended
> > Setting state on active device can produce random results and should be=
 forbidden.
> > We may allow to get Virtqueue State on active device, without SUSPEND. =
However, we should not mandate the device
> > to report correct value - on some implementations it may be impossible =
without suspend.

Exactly.

> I agree

Great.

Thanks

> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but
> >> VIRTIO_RING_F_PACKED not been negotiated,
> >>> typo
> >> yes
> >>>> +the driver MUST NOT access \field{Used State} of any virtqueues, it=
 should
> >> use the
> >>>> +used index in the used ring.
> >>>> +
> >>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of =
a Virtio
> >> Device / Virtqueue State}
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set =
in
> >> \field{device status},
> >>>> +the device MUST ignore any accesses against Virtqueue State of any
> >> virtqueues.
> >>> Btw, do we need to clarify the behavior of ring reset after suspendin=
g?
> >> I think once suspended, the device should ignore resetting a queue
> >>>> +
> >>>> +When VIRTIO_F_QUEUE_STATE has been negotiated but
> >> VIRTIO_RING_F_PACKED is not,
> >>>> +the device MUST ignore any accesses against \field{Used State}.
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST reset
> >>>> +the Virtqueue State of every virtqueue upon a reset.
> >>> Need to define the meaning of "reset" this is important for packed vi=
rtqueue.
> >> I will remove this as Stefan suggested.
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been
> >> negotiaged, when SUSPEND is set,
> >>>> +the device MUST record the Virtqueue State of every enabled virtque=
ue
> >>>> +in \field{Available State} and \field{Used State} respectively,
> >>>> +and correspondingly restore the Virtqueue State of every enabled vi=
rtqueue
> >>>> +from \field{Avaiable State} and \field{Used State} when DRIVER_OK i=
s set.
> >>> We can just let the device report those states in any case then we
> >>> don't need to care about those details, or did you see any blockers?
> >> Agree, I will add the definition of used_state of splitted vq in the
> >> next version
> >>
> >> Thanks
> >>> Thanks
> >>>
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but
> >> VIRTIO_RING_F_PACKED has been not, when SUSPEND is set,
> >>>> +the device MUST record the available state of every enabled virtque=
ue in
> >> \field{Available State},
> >>>> +and restore the available state of every enabled virtqueue from
> >> \field{Avaiable State}
> >>>> +when DRIVER_OK is set.
> >>>> +
> >>>>    \input{admin.tex}
> >>>>
> >>>>    \chapter{General Initialization And Device Operation}\label{sec:G=
eneral
> >> Initialization And Device Operation}
> >>>> --
> >>>> 2.35.3
> >>>>
> >>
> >> This publicly archived list offers a means to provide input to the
> >> OASIS Virtual I/O Device (VIRTIO) TC.
> >>
> >> In order to verify user consent to the Feedback License terms and
> >> to minimize spam in the list archive, subscription is required
> >> before posting.
> >>
> >> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >> List help: virtio-comment-help@lists.oasis-open.org
> >> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.=
pdf
> >> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailin=
g-lists
> >> Committee: https://www.oasis-open.org/committees/virtio/
> >> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

