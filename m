Return-Path: <virtio-dev-return-14364-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AA5C54798
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 01:18:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F349378148
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 01:18:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7AAA986542
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 01:18:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BFFC4983C8E; Wed, 28 Feb 2024 01:18:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF3CE98645C
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Feb 2024 01:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083107; x=1709687907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/3grtq/1UKpSoVKy7leamP4+HFizWuMa5Vs8fRQ1dc=;
        b=ijrgcDWzBI2xb3SSv8AIENthDvK5ENLL6nawjdYFJY/cGns9JkhOlel6kHkq0U05tG
         Qr4v0GOwCM7kQH5D1oCmNAoaHjS6xabynwaJ11S9KfwF9+yD+mXI8uf5UagNPEtRGJkQ
         Jq/hie9fAlESi+Buiw/Yg7rUVRPSm8RHkmq2XGzFjdx2+tQn1FAkL3hWJs29l1Zi7Ux5
         uVZvTP8Ehz4L3eqkhjj5P+b0Hn2I03hR+bi8IZ4Jkp77HtzqLLXO0krKDZ80JseAfH19
         LfwOPk+xDRPuAxg7OH9JrLKFoBbKW2mQvmDTJQwc5dbOhLYDrEBzXAm9eWmPm1FzMdIm
         /51Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4t7GJlgcwBlzGiTW2FMEwkVOhjxs6kPXglyyb/PeXt/xO4iuXASUQOjYAvP1z2HNKa+01ZyLbAF/cJ34mvQMqWZ54znpbflJ2yp8V7JdP
X-Gm-Message-State: AOJu0YwvaN798X1iCJGWZyqwUBwkw4eY9TLKZOCKx95y478ZeX63x0qz
	QhHbp+LCaW6kUkNZdWrE0Qe1bHgnN/ogKTKpNV8H8c0OJDMhdSWXw5Xx2mqTmLF6hRLZiZfIOXh
	hgB+fp8PRvTKtPoPEstKkctLohCKz9OaTYWjR
X-Google-Smtp-Source: AGHT+IFgrN2SxX/0tWl8D6iMmgUW+YfrkNYTC9Rx/hNerG71sZNqTUgm48Q9SktcKlL4ttmuff0lOIVLU8A72aMUlzA=
X-Received: by 2002:a19:6449:0:b0:513:16a8:4285 with SMTP id
 b9-20020a196449000000b0051316a84285mr1098136lfj.60.1709083107520; Tue, 27 Feb
 2024 17:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20240227015345.3614965-1-stevensd@chromium.org>
 <20240227015345.3614965-2-stevensd@chromium.org> <e03d003e-ca23-4dd2-aeac-6df79ee5c1e6@intel.com>
 <CAD=HUj6gM5HUp=gGt1u=OcQRBe3A=ig5ws=ZLkJEy=Jr-caAvQ@mail.gmail.com> <e4caa5e3-2cd3-465e-aa9c-275b4426d31d@intel.com>
In-Reply-To: <e4caa5e3-2cd3-465e-aa9c-275b4426d31d@intel.com>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 28 Feb 2024 10:18:16 +0900
Message-ID: <CAD=HUj66_gBBbf5EZ2dDrc51hKQ83zJotgS8vRanrxbD0oy_vw@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v5 1/1] Add SUSPEND bit to device status

On Tue, Feb 27, 2024 at 5:52=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
> On 2/27/2024 3:59 PM, David Stevens wrote:
> > On Tue, Feb 27, 2024 at 11:22=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@in=
tel.com> wrote:
> >> On 2/27/2024 9:53 AM, David Stevens wrote:
> >>> Add a SUSPEND bit to the device status field to allow drivers to susp=
end
> >>> virtio devices. On systems where drivers don't directly manage interr=
upt
> >>> routing (e.g. Linux), this allows the drivers to suspend their device=
s
> >>> and prevent interrupts from being sent when the interrupt routing sys=
tem
> >>> does not expect interrupts.
> >>> ---
> >>>    content.tex | 89 +++++++++++++++++++++++++++++++++++++++++++++++++=
+---
> >>>    1 file changed, 84 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/content.tex b/content.tex
> >>> index 0a62dce5f65f..2183c63c45ea 100644
> >>> --- a/content.tex
> >>> +++ b/content.tex
> >>> @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Bas=
ic Facilities of a Virtio Dev
> >>>
> >>>    \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has exper=
ienced
> >>>      an error from which it can't recover.
> >>> +
> >>> +\item[SUSPEND (16)] Indicates that the device has been suspended by =
the
> >>> +  driver. Only valid when the VIRTIO_F_SUSPEND feature bit is negoti=
ated.
> >>>    \end{description}
> >>>
> >>>    The \field{device status} field starts out as 0, and is reinitiali=
zed to 0 by
> >>> @@ -60,9 +63,11 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> >>>    initialization sequence specified in
> >>>    \ref{sec:General Initialization And Device Operation / Device
> >>>    Initialization}.
> >>> -The driver MUST NOT clear a
> >>> -\field{device status} bit.  If the driver sets the FAILED bit,
> >>> -the driver MUST later reset the device before attempting to re-initi=
alize.
> >>> +
> >>> +The driver MUST NOT clear a \field{device status} bit, except for th=
e
> >>> +SUSPEND bit as described in \ref{sec:General Initialization And Devi=
ce
> >>> +Operation / Device Suspend}. If the driver sets the FAILED bit, the
> >>> +driver MUST later reset the device before attempting to re-initializ=
e.
> >> Comparing to add a new exception, why not just re-setting DRIVER_OK to
> >> let the device
> >> clearing SUSPEND? This issue has been addressed when Eugenio working o=
n
> >> a similar STOP_BIT
> >>
> >> https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.html
> > I don't think the device status bit is bit-addressable, so it's not
> > possible to re-set DRIVER_OK without also either re-setting or
> > clearing SUSPEND.
> Please correct me if I misunderstand your point,
> I think it can be addressed, for example, in PCI it is an u8,
> the device can clear a bit in it.
>
> It may be easier to let the device to clear the SUSPEND bit.

If it's a u8, then the driver will be writing all 8 bits at the same
time. So I don't see how it's possible for the driver to set one bit
without also setting/clearing all the other bits at the same time.
When you say the driver can re-set DRIVER_OK, it can either write 0x1F
or 0xF. If we don't allow clearing the suspend bit, then it has to
write 0x1F. But that's exactly what the driver wrote to suspend the
device in the first place - how is the device supposed to tell the
difference? I guess we could add something to the spec saying that's
how the device is supposed to interpret it. But at that point, that's
really the same as allowing the driver to clear the suspend bit, just
with more complexity.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

