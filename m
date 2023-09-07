Return-Path: <virtio-dev-return-13647-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13502EE14D4
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 08:10:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6101B8504E
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 08:09:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56E49986602
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 08:09:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4ADD6983EBE; Thu,  7 Sep 2023 08:09:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 357C89865EE
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Sep 2023 08:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DNqpD4_HOnK-kugh1jU4zg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694074188; x=1694678988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HrgSsiW3z/Tq9T26xJnqkrUDa7gZMVCMCm1pPWjKeo=;
        b=imkfzVo52vvepFIOTCNlSepB2gG/YXInQLpiTObK0ShLtiwpBdnJ7/7iK0HxOooUcw
         9bMmlZcY1oKPEaJ/Z5BPD1Edo9SJFizjobELdM51ABYZgIpUZPVDni5awL2x4lIr2eKC
         45VU25fLtUuoKSm6XOTxxBHPrguS5PLLuECEKuBMYKmViMfYyJUc5rSrXf+cmdGOJmQQ
         UmVoC+WBih+zrRqO3xlaC00tgU9EaMwNrze5HNQym31rSL3HZuvcjyE8IrqJu9YmtJ9a
         MOJBUJR0+DV4kOXa1FAqf0kvGp0W9HrZdQei2/kEKkwHFgwyjN+4BbXJ3BNXwtBWNAKN
         IB7A==
X-Gm-Message-State: AOJu0YyZPeJ1zOQyM++9eDYXNdK6bOlMBN1+98F3AP6eNKBx+NVeMdXm
	WtkSpugdq++MgQM2qj45Qxj2BN0isCX7246y1oGvz+Q7aKcJkUuQq5YQfNI3yww5egKWW9VDHaq
	WeTeeRjogm9psQF9RJw0BRn1FrdeDz7ec32aj30/pccxa
X-Received: by 2002:a9d:6a05:0:b0:6bd:7b8:8646 with SMTP id g5-20020a9d6a05000000b006bd07b88646mr21186229otn.5.1694074188608;
        Thu, 07 Sep 2023 01:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE79mvLFSOF5/GLu92VEGxK9Pm67zOD48Tk2xD6/FAhtFhOdVW0nCzdtWMXpJJPQvLvMFdbqJM5H9H5iPTW8lk=
X-Received: by 2002:a9d:6a05:0:b0:6bd:7b8:8646 with SMTP id
 g5-20020a9d6a05000000b006bd07b88646mr21186206otn.5.1694074188299; Thu, 07 Sep
 2023 01:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com> <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com> <CAJaqyWd=hCvknO5MQ0Nu4iwxPMfjHGHNJHiwzxAaRLcgZ1HKxg@mail.gmail.com>
 <23b9082d-050a-6f82-754e-d309c48972d5@intel.com> <CAJaqyWeye4fOTB5pPtwpzusgZRL6d36EzDD61zoD8Uf+0v4FQw@mail.gmail.com>
 <4f88bf69-7436-4f26-6be8-76347355d59c@intel.com>
In-Reply-To: <4f88bf69-7436-4f26-6be8-76347355d59c@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Sep 2023 10:09:11 +0200
Message-ID: <CAJaqyWeLeyBJSn2EH9-vfbyVCAcCKDuhp-1G+3QZGpVMf7KTDw@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state

On Tue, Sep 5, 2023 at 11:08=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
>
>
>
> On 8/21/2023 5:26 PM, Eugenio Perez Martin wrote:
> > On Fri, Aug 18, 2023 at 11:44=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@in=
tel.com> wrote:
> >>
> >>
> >> On 8/17/2023 11:19 PM, Eugenio Perez Martin wrote:
> >>> On Tue, Aug 15, 2023 at 1:30=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@i=
ntel.com> wrote:
> >>>>
> >>>> On 8/15/2023 8:34 AM, Jason Wang wrote:
> >>>>> On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@=
intel.com> wrote:
> >>>>>> This commit specifies the constraints of the virtqueue state,
> >>>>>> and the actions should be taken by the device when SUSPEND
> >>>>>> and DRIVER_OK is set
> >>>>>>
> >>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>>>> ---
> >>>>>>     content.tex | 31 +++++++++++++++++++++++++++++++
> >>>>>>     1 file changed, 31 insertions(+)
> >>>>>>
> >>>>>> diff --git a/content.tex b/content.tex
> >>>>>> index 43bd5de..f6ac581 100644
> >>>>>> --- a/content.tex
> >>>>>> +++ b/content.tex
> >>>>>> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
> >>>>>>
> >>>>>>     See also \ref{sec:Packed Virtqueues / Driver and Device Ring W=
rap Counters}.
> >>>>>>
> >>>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities o=
f a Virtio Device / Virtqueue State}
> >>>>>> +
> >>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set =
SUSPEND in \field{device status}
> >>>>>> +first before getting or setting Virtqueue State of any virtqueues=
.
> >>>>> I don't get why this is a must. It could be useful for debugging.
> >>>> To avoid race conditions with the device and make the device
> >>>> implementation easier
> >>>>>> +
> >>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged but VIRTIO_RING_F_PAC=
KED not been negotiated,
> >>>>> typo
> >>>> yes
> >>>>>> +the driver MUST NOT access \field{Used State} of any virtqueues, =
it should use the
> >>>>>> +used index in the used ring.
> >>>>>> +
> >>>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities o=
f a Virtio Device / Virtqueue State}
> >>>>>> +
> >>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not se=
t in \field{device status},
> >>>>>> +the device MUST ignore any accesses against Virtqueue State of an=
y virtqueues.
> >>>>> Btw, do we need to clarify the behavior of ring reset after suspend=
ing?
> >>>> I think once suspended, the device should ignore resetting a queue
> >>> Actually shadow virtqueue could benefit from the ability to change vq
> >>> properties (addresses) while the device is suspended, and then just
> >>> resume it. I've been told that ring reset is overkill for that.
> >> If ring reset is overkill, is SUSPEND even more overkill?
> > It depends on the cost of recreating the vq in the device I think. But
> > it has more to do with *what* is changed in the vq, as it seems some
> > parameters (vq size) has more impact than others like vq address. The
> > way to stop the device does not affect, but ring reset offers the
> > possibility of change all of the parameters already.
> >
> > Adding Si-Wei and Dragos here, as they pointed it out in the
> > virtio-networking upstream meeting.
> >
> >>> But probably it is better to address it on top, with another feature =
flag.
> >> I think if we want to changing the vq properties, there must be a
> >> mechanism to
> >> stop the queue then resume the queue.
> >>
> >> How about allow setting queue_enable =3D 0 to stop it and =3D1 to resu=
me and
> >> force it reinitialize?
> >>
> > Yes, I think that is better suited. But maybe this is better to be
> > added on top, so we maintain this series small.
> Hi Eugenio,
>
> I have a second thought while implementing above queue_enable =3D 0,
> it doesn't provide more advantages over queue_reset:
>
> 1) queue_reset can help to stop a queue and the vq properties can be
> reconfigured during queue_reset --> queue_enable.
>
> 2) once the driver sees SUSPEND presented by the device, it assume the
> device states and vq states are stable, at that point the driver can
> read reliable device configurations. So vq reset should be ignored
> once SUSPEND is present and if we implement queue stop, it should be
> ignored too when SUSPEND.
>

The relation between SUSPEND and ring_reset needs to be described in
this series, yes. This is a good start, but I'm not sure if this one
meets all the requirements for SW assisted live migration.

We can always add new feature flags to define a different interaction
in the future, like for devices that can support the change of vq
attributes in the suspend. To not steal the merit, this idea was
proposed by Si-Wei in a recent virtio-networking meeting.

> 3) the device should only accept resetting a queue when !SUSPEND and
> the driver can flush the queue buffers before resetting it to avoid
> losing buffers,
> and we will have tracker for in-flight descriptors later.
>
> Any thoughts?
>
> Thanks
> >
> > Thanks!
> >
> >> Thanks
> >> Zhu Lingshan
> >>>>>> +
> >>>>>> +When VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_P=
ACKED is not,
> >>>>>> +the device MUST ignore any accesses against \field{Used State}.
> >>>>>> +
> >>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST rese=
t
> >>>>>> +the Virtqueue State of every virtqueue upon a reset.
> >>>>> Need to define the meaning of "reset" this is important for packed =
virtqueue.
> >>>> I will remove this as Stefan suggested.
> >>>>>> +
> >>>>>> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been negoti=
aged, when SUSPEND is set,
> >>>>>> +the device MUST record the Virtqueue State of every enabled virtq=
ueue
> >>>>>> +in \field{Available State} and \field{Used State} respectively,
> >>>>>> +and correspondingly restore the Virtqueue State of every enabled =
virtqueue
> >>>>>> +from \field{Avaiable State} and \field{Used State} when DRIVER_OK=
 is set.
> >>>>> We can just let the device report those states in any case then we
> >>>>> don't need to care about those details, or did you see any blockers=
?
> >>>> Agree, I will add the definition of used_state of splitted vq in the
> >>>> next version
> >>>>
> >>>> Thanks
> >>>>> Thanks
> >>>>>
> >>>>>> +
> >>>>>> +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PAC=
KED has been not, when SUSPEND is set,
> >>>>>> +the device MUST record the available state of every enabled virtq=
ueue in \field{Available State},
> >>>>>> +and restore the available state of every enabled virtqueue from \=
field{Avaiable State}
> >>>>>> +when DRIVER_OK is set.
> >>>>>> +
> >>>>>>     \input{admin.tex}
> >>>>>>
> >>>>>>     \chapter{General Initialization And Device Operation}\label{se=
c:General Initialization And Device Operation}
> >>>>>> --
> >>>>>> 2.35.3
> >>>>>>
> >
> > This publicly archived list offers a means to provide input to the
> >
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> >
> >
> > In order to verify user consent to the Feedback License terms and
> >
> > to minimize spam in the list archive, subscription is required
> >
> > before posting.
> >
> >
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >
> > List help: virtio-comment-help@lists.oasis-open.org
> >
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> >
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> >
> > Committee: https://www.oasis-open.org/committees/virtio/
> >
> > Join OASIS: https://www.oasis-open.org/join/
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

