Return-Path: <virtio-dev-return-13554-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547F7C0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 01:59:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EF0885050
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 01:59:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 626D6986423
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 01:59:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B63398633B; Wed, 16 Aug 2023 01:59:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 266479863D7
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Aug 2023 01:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: s2V4gIrcNlquWMjPs1l9qw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692151151; x=1692755951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhnM3d7+kGQVCR9geB3DVYn7WC3MrpU3nOGM0Pu6axk=;
        b=IqdxGnlHNdve5U+KSsHLjmBxHz7UiMBGd+1xSJQXtIci7HYMd0UOrohRVj7hwwiHQU
         fbNbWesgY+g2cpq8q3QI/bglKQFZ3IprD2i+B1OfwMq+fdhw4H70Q1ogUmpctwlOvdpt
         CyNst4Le17CVTaMCS005Be3zT/v/CI2+KdJmU7M1H6IawI4JezpEqOuWJYJTTCuzlTIL
         SQVIL63vPvl3BsdnRHGWQ/EgTERZVUUSW01wuCxplX6d2sADZx1C1/IMFM5ikjN1cMyp
         ZBqpMnKxAGKWiEQebi6aDNTh91m22ZsV8MElXJTdvrxjvSxAcmIr4ZS++m9hdpX54kHb
         IlQA==
X-Gm-Message-State: AOJu0YxLXbvNu6bPSVS+FwlRU4PRT6uqkaYeeAupNmBhYt4uBey4LixN
	IeETYnh5qufHDSKWECHoKfbye/iJYRwIEhuNFAu1HrgrmtTSi02a6yN8sB1FH4/8bHP50lUcXyw
	7sUwXTZeoynq//D7agn1jV0lL70KVKD1zwOlDEfQhgz2c
X-Received: by 2002:a2e:9942:0:b0:2b9:344c:181e with SMTP id r2-20020a2e9942000000b002b9344c181emr223306ljj.19.1692151151188;
        Tue, 15 Aug 2023 18:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkgHVjKv1f/puvO13lqiQd4Q8/dZ2ySCbW0zcs/kaZtUdbkW84N6hNSDSWQjn4G01P61/+TsuKOsWVdEcPuNk=
X-Received: by 2002:a2e:9942:0:b0:2b9:344c:181e with SMTP id
 r2-20020a2e9942000000b002b9344c181emr223274ljj.19.1692151147986; Tue, 15 Aug
 2023 18:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com> <CACGkMEvmYqKTk1Hveo96oKYw4hbEDJD2x5Ye3_nkeBTH0rcMMw@mail.gmail.com>
 <CACGkMEt4mYmf+6+WC=WEZqiJgO2tNo96Ekr5bbyN6akxpjwFqw@mail.gmail.com> <6d41cf4f-8cc2-6bad-7b22-2369fd6a620c@intel.com>
In-Reply-To: <6d41cf4f-8cc2-6bad-7b22-2369fd6a620c@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 09:58:56 +0800
Message-ID: <CACGkMEte7KEi6XS17HFTa=xLSuA2NA5XDUUevJuieNZ00k5+gg@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH 1/5] virtio: introduce SUSPEND bit in device status

On Tue, Aug 15, 2023 at 6:48=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
>
>
>
> On 8/15/2023 8:37 AM, Jason Wang wrote:
> > On Tue, Aug 15, 2023 at 8:26=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> >> On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@int=
el.com> wrote:
> >>> This patch introudces a new status bit in the device status: SUSPEND.
> >>>
> >>> This SUSPEND bit can be used by the driver to suspend a device,
> >>> in order to stablize the device states and virtqueue states.
> >>>
> >>> Its main use case is live migration.
> >> I think patch 3 needs to be squashed into this one.
> Patch 3 mentions Virtqueue State that is introduced in patch 2,

Ok, so let's reorder the let patch 2 come first.

Thanks

> so I think patch 3 should placed after patch 2.
>
> Thanks
> >>
> >>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>> Signed-off-by: Eugenio P=C3=83rez <eperezma@redhat.com>
> >>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>> ---
> >>>   content.tex | 18 ++++++++++++++++++
> >>>   1 file changed, 18 insertions(+)
> >>>
> >>> diff --git a/content.tex b/content.tex
> >>> index 0a62dce..1bb4401 100644
> >>> --- a/content.tex
> >>> +++ b/content.tex
> >>> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Bas=
ic Facilities of a Virtio Dev
> >>>   \item[DRIVER_OK (4)] Indicates that the driver is set up and ready =
to
> >>>     drive the device.
> >>>
> >>> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates t=
hat the
> >>> +  device has been suspended by the driver.
> >>> +
> >>>   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experi=
enced
> >>>     an error from which it can't recover.
> >>>   \end{description}
> >>> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> >>>   recover by issuing a reset.
> >>>   \end{note}
> >>>
> >>> +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
> >>> +
> >>> +When set SUSPEND, the driver MUST re-read \field{device status} to e=
nsure the SUSPEND bit is set.
> >>> +
> >>>   \devicenormative{\subsection}{Device Status Field}{Basic Facilities=
 of a Virtio Device / Device Status Field}
> >>>
> >>>   The device MUST NOT consume buffers or send any used buffer
> >>> @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> >>>   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_=
NEEDS_RESET, the device
> >>>   MUST send a device configuration change notification to the driver.
> >>>
> >>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> >> Is there any value to allow SUSPEND to be set without DRIVER_OK?
> If live migration happens when the guest initializing the device,
> maybe the guest driver has already configured some virtqueues or
> modified the config space. At that point, We should allow to suspend
> the device, because the hypervisor should not reset the device at
> that moment.
>
> SUSPEND requires FEATURES_OK because VIRTIO_F_SUSPEND has to be negotiate=
d.
> >>
> >>> +
> >>> +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated=
.
> >> typo.
> Yes
> >>
> >> Thanks
> > Btw, it's not clear to me if driver is allowed to clear this bit.
> Patch 1 mentions that DRIVER_OK clears SUSPEND, so that the driver
> can resume the device if LM fails.
>
> Thanks
> >
> > Thanks
> >
> >>> +
> >>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUS=
T clear SUSPEND
> >>> +and resumes operation upon DRIVER_OK.
> >>> +
> >>>   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Devic=
e / Feature Bits}
> >>>
> >>>   Each virtio device offers all the features it understands.  During
> >>> @@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserv=
ed Feature Bits}
> >>>          \ref{devicenormative:Basic Facilities of a Virtio Device / F=
eature Bits} for
> >>>          handling features reserved for future use.
> >>>
> >>> +  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver=
 can
> >>> +   SUSPEND the device.
> >>> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status =
Field}.
> >>> +
> >>>   \end{description}
> >>>
> >>>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature =
Bits}
> >>> --
> >>> 2.35.3
> >>>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

