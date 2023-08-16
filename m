Return-Path: <virtio-dev-return-13556-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B90C001DE
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:10:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 36C0D2A8E7
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:10:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CA8998641A
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:10:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F326498633B; Wed, 16 Aug 2023 02:10:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E27059863D7
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Aug 2023 02:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: TBjjZ_M0OQOQ1Z7a8HDuTQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692151834; x=1692756634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNsN2QCPSzdxHQZ442EABMqql9mudKRipmeWhyzx/0o=;
        b=aa61q4wTLaEe8DEyZOj17P67BPLC3/vKbI6dCxcRLEQyio7MGzleyTB/+Kdrt8KzVP
         efs9bxgu+WrYWzBopS89xM2YTl4/xmQFNLqC/ptAhj9tt8/w6CftOnpU+2uCABE2PKsg
         YYerACXzDqLqEpnJQDcIAR5C2qbF1+16v/3/SrYXmnqwzjcniKPmioVOlDgM4/MZcny7
         tzlOTV/dkis+Pu847+QM2LdwSqQNF/OLwy/BU6vETvqH8PONb8Dxbaa6HRLjMjsE8zFP
         WYD9pGHDJdp9JRC0BluYdeDEX10Mww1tYp7M8x/K+dezgu5faIhYjGNlk/plsdXRwhsJ
         Hb8Q==
X-Gm-Message-State: AOJu0Yz7WHgl/QcrrCHDVa7s6npP9WhMfhQMylPOf1dY6zqsaNN4ceI6
	gRVOfqQv8oG9QZwqzZUVkd0s1ipO/N0OBBcynuSMgFdzLWHvxdw9Rykk5PO/co5rSt/Wescrqx7
	N0teTRMN6hOcsO6WsAb0TtSPMWPIcev0Br2mlLaUSRF6Mno85qiTP
X-Received: by 2002:a2e:9d8b:0:b0:2b9:ea5f:36b with SMTP id c11-20020a2e9d8b000000b002b9ea5f036bmr369571ljj.52.1692151834088;
        Tue, 15 Aug 2023 19:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcsydXZi/f/kQTsw/lnUnEt8lUZSI7GmI9/eCTakswJ62fZlKkxkwmsAHNukTT5OWPqrrsaA4uAcQvc1PUMok=
X-Received: by 2002:a2e:9d8b:0:b0:2b9:ea5f:36b with SMTP id
 c11-20020a2e9d8b000000b002b9ea5f036bmr369556ljj.52.1692151833754; Tue, 15 Aug
 2023 19:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-4-lingshan.zhu@intel.com> <CACGkMEuS8xnKi8Nh10T4KCXCYSa-yYmN5X+=ZkCHUrb0jbH-XA@mail.gmail.com>
 <2ddf1100-9230-70e3-d641-d2dcda380694@intel.com>
In-Reply-To: <2ddf1100-9230-70e3-d641-d2dcda380694@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 10:10:22 +0800
Message-ID: <CACGkMEtDqHPDwXKy09fgmhZ2yywF2061W0g-RDZwx7Lv5AtBLg@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH 3/5] virtio: The actions by the
 device upon SUSPEND

On Tue, Aug 15, 2023 at 7:17=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
>
>
>
> On 8/15/2023 8:29 AM, Jason Wang wrote:
> > On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@inte=
l.com> wrote:
> >> This commit specifies the actions to be taken by the device upon
> >> SUSPEND.
> >>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> Signed-off-by: Eugenio P=C3=83rez <eperezma@redhat.com>
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   content.tex | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/content.tex b/content.tex
> >> index 074f43e..43bd5de 100644
> >> --- a/content.tex
> >> +++ b/content.tex
> >> @@ -96,6 +96,15 @@ \section{\field{Device Status} Field}\label{sec:Bas=
ic Facilities of a Virtio Dev
> >>   If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUS=
T clear SUSPEND
> >>   and resumes operation upon DRIVER_OK.
> >>
> >> +If VIRTIO_F_SUSPEND is negotiated, when SUSPEND is set, the device MU=
ST perform the following operations:
> >> +\begin{itemize}
> >> +\item Stop comsuming any descriptors
> > Typo.
> yes will fix
> >
> >> +\item Mark all finished descriptors as used and send used buffer noti=
fication to the driver
> > What happens to the unfinished descriptors?
> still in the descriptors table or considered as in-flight, we will post
> a patch tracking in-flight descriptors.

So I think we should either

1) add in-flight descriptors in this series

or

2) force a flush

To make sure the new proposed function is complete.

> >
> >> +\item Record Virtqueue State of each enabled virtqueue, see section \=
ref{sec:Virtqueues / Virtqueue State}
> > This basically means those states are only available after suspending
> > or not? It would be still useful for debugging if we allow it without
> > suspending.
> Yes, for now only allow to read/write the virtqueue state after setting
> SUSPEND, this is to avoid race conditions with the device.

For debugging, we don't need to care about those races. A lot of
hardware allow to expose those via e.g ethtool.

>
> Still can suspend then collect the idx for debugging?

I mean for runtime debugging.

> >
> >> +\item Pause its operation and preserve all configurations in its Devi=
ce Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / =
Device Configuration Space}
> > We probably need to define the "pause" here (e.g what happens to the
> > inflight descriptors).
> Shall we say: freeze both its data-plane and control-plane?

I mean if we've defined "suspend" we can simply use "suspend" instead
of "pause"?

Thanks

> >
> > Thanks
> >
> >> +\item Present SUSPEND in \field{device status}
> >> +\end{itemize}
> >> +
> >>   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device=
 / Feature Bits}
> >>
> >>   Each virtio device offers all the features it understands.  During
> >> --
> >> 2.35.3
> >>
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

