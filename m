Return-Path: <virtio-dev-return-13557-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6E7C0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:11:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D205141A0E
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:11:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB3A09863FA
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:11:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ADD7198633B; Wed, 16 Aug 2023 02:11:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A009F9863D7
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Aug 2023 02:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JCT6wUsVPGmPy8p-WFziLw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692151901; x=1692756701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxfrlbWCv9/npSXy9dxJedGXGKMlfXVipL4Or96C3kA=;
        b=ZFcZUPoR5QrN3a5x7fTi0Lpe8Oa2wwV/tZ63Bky6GuxDys/oYdZ5Je0AEqEUh055VQ
         3XV15a45jyaMRb81zWBtybw504i6325JWHjaJPC9LOdsipr92Erb2AGpOg83+9Fem9cz
         F4eSZaEZy8UOAx2jk2B0FxfcPEwyEiEI8rJe5sbcCLIWmPTS1yyp7bdnXknETdW7QPEe
         1CWbH5CKpbgvKf2vOxelaDXM80qQrI9Z7N+gPPgJZyCA8k8VGxkY2Rx6yLfXBBY8rG3r
         DtcVsz6P0ebb91AULJwKxqvb5pYdQIXAuR6pjVmwBMEZL3kuH89ijmiCTRz5HW6+OmKr
         56+A==
X-Gm-Message-State: AOJu0YwoaMtV1sWt0e7XqkxLF0Rrho7v4/AAgMRjA45Z3FmCSDM1tssp
	CkC7sNfChPLJ+Iv9lusH4syj6P9loiCzvDhDcSvh/IDxilMZsgp0tLrR6faToUjEbOZSV3hPrRG
	7GxuhPhRDc0U43pG49t/KEz0YncGA35ZV0WPR5iRKv8te
X-Received: by 2002:a2e:998f:0:b0:2b4:6eb0:2a27 with SMTP id w15-20020a2e998f000000b002b46eb02a27mr392348lji.17.1692151901082;
        Tue, 15 Aug 2023 19:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0nW5qnuGEqL2JNezft0S5q083vLOTl9SooPL4WVUYflK1JFLh/93VgqVW0gq+d0OvaZXfMwFHTs90PQYeTwI=
X-Received: by 2002:a2e:998f:0:b0:2b4:6eb0:2a27 with SMTP id
 w15-20020a2e998f000000b002b46eb02a27mr392342lji.17.1692151900778; Tue, 15 Aug
 2023 19:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com> <CACGkMEtkdXrTZ_=NkuPsmhUooCgKPiCiVo-nJMaDnJ5fufzGwQ@mail.gmail.com>
 <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
In-Reply-To: <8ce92e00-39f9-3e99-96e2-5599588869e3@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 10:11:29 +0800
Message-ID: <CACGkMEtAF9Rc7PQqEToFmjixHB8sb4yxWM7r80g92q8kCCor0A@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH 4/5] virtqueue: constraints for virtqueue state

On Tue, Aug 15, 2023 at 7:30=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
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

replied in another thread.

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

This needs to be clarified.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

