Return-Path: <virtio-dev-return-14370-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1CC54E49
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Feb 2024 03:20:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4EAE51922E7
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Feb 2024 03:20:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48B649865D0
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Feb 2024 03:20:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B9C3985E3D; Thu, 29 Feb 2024 03:20:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 263BB986530
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Feb 2024 03:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176829; x=1709781629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s40kXLQtNsWWpRYX9jsC+IRaxjKIRIaUNNGqcb4YGig=;
        b=twCCnKiq/TN2XmoZMcehkL73Rm3fnAmTcXAF+PcSmAINb8/rPNO121aqLlNEzJhgsj
         V+5R0hgPuUdviXoVKcAbKXo6T2AAtDPqJwuoAlswv3SgosrMUUE2jsmjH3tU04FHw4hB
         I7CwMYfhjUgN/kKQA71SblipvCjlpgDL4t/lHxMslQCDVeNKpUgAuXNkqso3DTIWe1RM
         ord9GMrEL3EQ7tnGp3M+sLly4CUs1B8Z7ILFU3kpwvyyuBN+1/VsmNIB68RRKW9Ha0Rk
         HTd27BmXpHjN7Lxg0oun94MIxoLS2fTfGP6YeSEfMKNFhKZxjDPCNhOJZ3k5IYfoAD0O
         ZVkA==
X-Forwarded-Encrypted: i=1; AJvYcCU4/vrQk/ynyV7Z1pDrFmPmrKXEMeGLHT9FZ2zCt3L9UThwcWk+oM2ZXWfWOD6epS4YasoZdhQKjm18yQw6/OGk9/pO2S8hav22SLYyAn6n
X-Gm-Message-State: AOJu0YyUWO3nGYhQiRsRxBekZqNDMi3twFd2KuHE/zEMXw0qAFoy2JF5
	Vcfjgs/S4y/Kbz0wePNV0ldaMyE7Ztp5STYQU5Ia3CJLjPhfu3T8Ub0ezOlsfq5ZtRLrGmZEpyJ
	qz1mdofiQ6RgUzZwmZUHUYpIyomKn51HZIVOR
X-Google-Smtp-Source: AGHT+IH5x9bGldc411B6YFD08UlV1BO1dzqK+CYcRn/hGwvVaV5UWA7KQthufRyN4g5o804LnBVTGmfVWnI6xYeY0Hc=
X-Received: by 2002:a05:6512:3987:b0:513:19ca:df5c with SMTP id
 j7-20020a056512398700b0051319cadf5cmr811526lfu.45.1709176829262; Wed, 28 Feb
 2024 19:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20240227015345.3614965-1-stevensd@chromium.org>
 <20240227015345.3614965-2-stevensd@chromium.org> <e03d003e-ca23-4dd2-aeac-6df79ee5c1e6@intel.com>
 <CAD=HUj6gM5HUp=gGt1u=OcQRBe3A=ig5ws=ZLkJEy=Jr-caAvQ@mail.gmail.com>
 <e4caa5e3-2cd3-465e-aa9c-275b4426d31d@intel.com> <CAD=HUj66_gBBbf5EZ2dDrc51hKQ83zJotgS8vRanrxbD0oy_vw@mail.gmail.com>
 <7050294e-1d62-4487-b74b-b173bc586776@intel.com>
In-Reply-To: <7050294e-1d62-4487-b74b-b173bc586776@intel.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 29 Feb 2024 12:20:18 +0900
Message-ID: <CAD=HUj60Tz6hyparh_iELO-coyszw9zNjrUu86Wgum753sNkgA@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v5 1/1] Add SUSPEND bit to device status

On Wed, Feb 28, 2024 at 3:45=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
> On 2/28/2024 9:18 AM, David Stevens wrote:
> > On Tue, Feb 27, 2024 at 5:52=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@int=
el.com> wrote:
> >> On 2/27/2024 3:59 PM, David Stevens wrote:
> >>> On Tue, Feb 27, 2024 at 11:22=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@=
intel.com> wrote:
> >>>> On 2/27/2024 9:53 AM, David Stevens wrote:
> >>>>> Add a SUSPEND bit to the device status field to allow drivers to su=
spend
> >>>>> virtio devices. On systems where drivers don't directly manage inte=
rrupt
> >>>>> routing (e.g. Linux), this allows the drivers to suspend their devi=
ces
> >>>>> and prevent interrupts from being sent when the interrupt routing s=
ystem
> >>>>> does not expect interrupts.
> >>>>> ---
> >>>>>     content.tex | 89 ++++++++++++++++++++++++++++++++++++++++++++++=
++++---
> >>>>>     1 file changed, 84 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/content.tex b/content.tex
> >>>>> index 0a62dce5f65f..2183c63c45ea 100644
> >>>>> --- a/content.tex
> >>>>> +++ b/content.tex
> >>>>> @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:B=
asic Facilities of a Virtio Dev
> >>>>>
> >>>>>     \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has ex=
perienced
> >>>>>       an error from which it can't recover.
> >>>>> +
> >>>>> +\item[SUSPEND (16)] Indicates that the device has been suspended b=
y the
> >>>>> +  driver. Only valid when the VIRTIO_F_SUSPEND feature bit is nego=
tiated.
> >>>>>     \end{description}
> >>>>>
> >>>>>     The \field{device status} field starts out as 0, and is reiniti=
alized to 0 by
> >>>>> @@ -60,9 +63,11 @@ \section{\field{Device Status} Field}\label{sec:=
Basic Facilities of a Virtio Dev
> >>>>>     initialization sequence specified in
> >>>>>     \ref{sec:General Initialization And Device Operation / Device
> >>>>>     Initialization}.
> >>>>> -The driver MUST NOT clear a
> >>>>> -\field{device status} bit.  If the driver sets the FAILED bit,
> >>>>> -the driver MUST later reset the device before attempting to re-ini=
tialize.
> >>>>> +
> >>>>> +The driver MUST NOT clear a \field{device status} bit, except for =
the
> >>>>> +SUSPEND bit as described in \ref{sec:General Initialization And De=
vice
> >>>>> +Operation / Device Suspend}. If the driver sets the FAILED bit, th=
e
> >>>>> +driver MUST later reset the device before attempting to re-initial=
ize.
> >>>> Comparing to add a new exception, why not just re-setting DRIVER_OK =
to
> >>>> let the device
> >>>> clearing SUSPEND? This issue has been addressed when Eugenio working=
 on
> >>>> a similar STOP_BIT
> >>>>
> >>>> https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.htm=
l
> >>> I don't think the device status bit is bit-addressable, so it's not
> >>> possible to re-set DRIVER_OK without also either re-setting or
> >>> clearing SUSPEND.
> >> Please correct me if I misunderstand your point,
> >> I think it can be addressed, for example, in PCI it is an u8,
> >> the device can clear a bit in it.
> >>
> >> It may be easier to let the device to clear the SUSPEND bit.
> > If it's a u8, then the driver will be writing all 8 bits at the same
> > time. So I don't see how it's possible for the driver to set one bit
> > without also setting/clearing all the other bits at the same time.
> > When you say the driver can re-set DRIVER_OK, it can either write 0x1F
> > or 0xF. If we don't allow clearing the suspend bit, then it has to
> > write 0x1F. But that's exactly what the driver wrote to suspend the
> > device in the first place - how is the device supposed to tell the
> > difference? I guess we could add something to the spec saying that's
> > how the device is supposed to interpret it. But at that point, that's
> > really the same as allowing the driver to clear the suspend bit, just
> > with more complexity.
> Thanks for the explanation, I get your point now.
> I agree allowing clear a bit can resume the device running. however this
> makes an exception and require the device to examine every bits that the
> driver set.

It needs to do this anyway to detect the SUSPEND bit being set in the
first place, doesn't it? Why is detecting the SUSPEND bit being
cleared more difficult than detecting the SUSPEND set being set?

> Letting the device clear the SUSPEND bit also require the device to exami=
ne
> every bits. Based on the device status(Init, Running or SUSPENDED), the
> device
> can behave differently:
> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD
> clear SUSPEND
> +and resumes operation upon DRIVER_OK.
>
> But no need to make exceptions in the spec. Maybe this is a little less
> complex?

That is also adding an exception, though? It introduces a single
situation where the behavior of bits is tied together and a single
situation where the device instead of the driver is allowed to clear
bits. It would also complicate adding bit to device status that can be
set when the device is suspended, since it would be ambiguous as to
whether a driver writing 0x3F wants to enable bit 0x20 or wants to
enable 0x20 and also disable SUSPEND. I fail to see how that is
simpler than just letting the driver clear the SUSPEND bit.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

