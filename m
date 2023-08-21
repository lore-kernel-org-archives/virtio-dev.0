Return-Path: <virtio-dev-return-13577-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D9AEE4996
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 09:26:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CC8566846D
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 09:26:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A66B2986265
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 09:26:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8AD9D983FE9; Mon, 21 Aug 2023 09:26:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A201986235
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 Aug 2023 09:26:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: geELlMcfPRa43LzKtcVbXA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692610004; x=1693214804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoNAmjpI7N6d7cHbmOByNhxlcHl3I3FmUzEewdTo08U=;
        b=P+bg/ee6jGaLKWMFdI+DHkvuBxOuBBXQHzv9W5mOZzD1YSCVqifAxNz8D7sysuaNnB
         q81+O/CxyNh/WJk2vlwrr0G+tmvX+HnWbh5HvHr2YshUqZrdgVxMvkUjvDFZcjW3LkwP
         0g5KZZyxB1imXpiD8umP5vvFBVXrfVEEyshqC+eIL6xn/ekKeqCPKGDK5hJBHYXIDoWq
         r2PyI6MdS+lbPQVWjOWIMHwsClU5mIUvsbGPO7RJyAMeCevH2qGvZfj/RdxETyMGzmoE
         cMatjtuhORjQTPRYDh2jytUkaVofzuwMMERl9TFEXAgqP8PHE/iWnbr4fsK6jjJ2g6Bx
         sNuQ==
X-Gm-Message-State: AOJu0Yy4zq9SK+DupLYPle64hYlfW/zvyXjnQau5N9BKLBt2o8YmS11r
	Qkj3+AtuFpVR11ScOPb/WujpbiHlET3eCG84CldIJ7GNTx24ttBgfJImnP/Ov1kogIxCjBu+dGq
	Af6YLnqsZ1VxLiMuWdwW7ZZCXtUGGNr6VLVQGiETHFZqS
X-Received: by 2002:a25:d650:0:b0:d05:96e4:b379 with SMTP id n77-20020a25d650000000b00d0596e4b379mr7252036ybg.56.1692610004663;
        Mon, 21 Aug 2023 02:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLzCseRVG234W0vAQskXOzDXbHG98I7JAJhQmd387H8bxeBI+9wPICdYBkqPs5DBqEdYBZOtt+iFbP8y2avQ8=
X-Received: by 2002:a25:d650:0:b0:d05:96e4:b379 with SMTP id
 n77-20020a25d650000000b00d0596e4b379mr7252023ybg.56.1692610004416; Mon, 21
 Aug 2023 02:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com> <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com> <CAJaqyWd=hCvknO5MQ0Nu4iwxPMfjHGHNJHiwzxAaRLcgZ1HKxg@mail.gmail.com>
 <23b9082d-050a-6f82-754e-d309c48972d5@intel.com>
In-Reply-To: <23b9082d-050a-6f82-754e-d309c48972d5@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 21 Aug 2023 11:26:08 +0200
Message-ID: <CAJaqyWeye4fOTB5pPtwpzusgZRL6d36EzDD61zoD8Uf+0v4FQw@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH 4/5] virtqueue: constraints for virtqueue state

On Fri, Aug 18, 2023 at 11:44=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@intel.=
com> wrote:
>
>
>
> On 8/17/2023 11:19 PM, Eugenio Perez Martin wrote:
> > On Tue, Aug 15, 2023 at 1:30=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@int=
el.com> wrote:
> >>
> >>
> >> On 8/15/2023 8:34 AM, Jason Wang wrote:
> >>> On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@in=
tel.com> wrote:
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
> >>>>    See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap=
 Counters}.
> >>>>
> >>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of =
a Virtio Device / Virtqueue State}
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set SU=
SPEND in \field{device status}
> >>>> +first before getting or setting Virtqueue State of any virtqueues.
> >>> I don't get why this is a must. It could be useful for debugging.
> >> To avoid race conditions with the device and make the device
> >> implementation easier
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but VIRTIO_RING_F_PACKE=
D not been negotiated,
> >>> typo
> >> yes
> >>>> +the driver MUST NOT access \field{Used State} of any virtqueues, it=
 should use the
> >>>> +used index in the used ring.
> >>>> +
> >>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of =
a Virtio Device / Virtqueue State}
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set =
in \field{device status},
> >>>> +the device MUST ignore any accesses against Virtqueue State of any =
virtqueues.
> >>> Btw, do we need to clarify the behavior of ring reset after suspendin=
g?
> >> I think once suspended, the device should ignore resetting a queue
> > Actually shadow virtqueue could benefit from the ability to change vq
> > properties (addresses) while the device is suspended, and then just
> > resume it. I've been told that ring reset is overkill for that.
> If ring reset is overkill, is SUSPEND even more overkill?

It depends on the cost of recreating the vq in the device I think. But
it has more to do with *what* is changed in the vq, as it seems some
parameters (vq size) has more impact than others like vq address. The
way to stop the device does not affect, but ring reset offers the
possibility of change all of the parameters already.

Adding Si-Wei and Dragos here, as they pointed it out in the
virtio-networking upstream meeting.

> >
> > But probably it is better to address it on top, with another feature fl=
ag.
> I think if we want to changing the vq properties, there must be a
> mechanism to
> stop the queue then resume the queue.
>
> How about allow setting queue_enable =3D 0 to stop it and =3D1 to resume =
and
> force it reinitialize?
>

Yes, I think that is better suited. But maybe this is better to be
added on top, so we maintain this series small.

Thanks!

> Thanks
> Zhu Lingshan
> >
> >>>> +
> >>>> +When VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PAC=
KED is not,
> >>>> +the device MUST ignore any accesses against \field{Used State}.
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST reset
> >>>> +the Virtqueue State of every virtqueue upon a reset.
> >>> Need to define the meaning of "reset" this is important for packed vi=
rtqueue.
> >> I will remove this as Stefan suggested.
> >>>> +
> >>>> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been negotiag=
ed, when SUSPEND is set,
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
> >>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKE=
D has been not, when SUSPEND is set,
> >>>> +the device MUST record the available state of every enabled virtque=
ue in \field{Available State},
> >>>> +and restore the available state of every enabled virtqueue from \fi=
eld{Avaiable State}
> >>>> +when DRIVER_OK is set.
> >>>> +
> >>>>    \input{admin.tex}
> >>>>
> >>>>    \chapter{General Initialization And Device Operation}\label{sec:G=
eneral Initialization And Device Operation}
> >>>> --
> >>>> 2.35.3
> >>>>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

