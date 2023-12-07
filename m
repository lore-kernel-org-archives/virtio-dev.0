Return-Path: <virtio-dev-return-14131-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E14C4167B
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 04:16:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 091C02AD7B
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 04:16:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E48FB98690B
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 04:16:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B88669868FB; Thu,  7 Dec 2023 04:16:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4BCC9868FE
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Dec 2023 04:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: F3bT76WBNGqJ2_j76F-rQA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701922581; x=1702527381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeQc/ktMnF15e5g/6Dn7zE7VISQ16CQ6tOArmf6ZKms=;
        b=iDSNjXUfosurSzmZySyvlmgxvv1F675EQ/4Yz9D9Fv1G9NV0CsK781wUaWiVP4Iog2
         GEO+afGeXXOBdChpgGY7lvgtcpSM/X86w9l0Hvcnvo+2JKKZlg2n27UDBe95WM0A3TCS
         MIA7Gyn9FcANTSohINLiGeSFpwy4YFdgnOyu78y6GC7qoZtyIgLM455LHUF+EYrCvzmt
         26OwOvgdxWS11m/RE0F+bb5doR3GCsGP5JYO96xigxxKQyUBj0sLWsgQMG5QKNAPjkyE
         rGEsjP/7fpq99Om5JB9TOkxabFrSDcWRvP4o48figkSy5lHgBjJE8mX+08TWBuSO+Dro
         yOsQ==
X-Gm-Message-State: AOJu0YxgPCbqOhOyzAY4zCRcQ6FeMLbkkmJXmy+2/afKCvflLAHM79qD
	DvK8oihfWSjsjWxw3m6IaJG7FTzp82b6vWxOf/8ZrJbKh6mBDP8R4fs4b7NIcu/7EuBjlSdLMp3
	co69C8cAhxO9gLYjzx2x1UWNHUo7FeKepNu1SokHwdqui
X-Received: by 2002:a17:90b:1c85:b0:286:cf0b:3cec with SMTP id oo5-20020a17090b1c8500b00286cf0b3cecmr1882319pjb.4.1701922581286;
        Wed, 06 Dec 2023 20:16:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMd6CDwkN//51J4Lwy42YiEkBby4nCtfO6gQYPfxc2k2AYviAt9d9ndzdSVQxgvHDSO6MGf8yS5EoZOYdZppc=
X-Received: by 2002:a17:90b:1c85:b0:286:cf0b:3cec with SMTP id
 oo5-20020a17090b1c8500b00286cf0b3cecmr1882309pjb.4.1701922580907; Wed, 06 Dec
 2023 20:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20231204094123.856214-1-stevensd@chromium.org>
 <20231204094123.856214-2-stevensd@chromium.org> <CACGkMEuHLs=+8_RHVa9eTXfHLqo_Ra6hSrnT9k8DAG_0yz0pvQ@mail.gmail.com>
 <CAD=HUj6bBOOCWmrbxBHKymfAr3UVUL7S57FtffHi0vEzVmewDA@mail.gmail.com>
 <CACGkMEuGY9y5Zt9UdL+4V3tntnR4EyHHCRqX_P4QtmAOL0-Pew@mail.gmail.com> <20231206051652-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231206051652-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 12:16:09 +0800
Message-ID: <CACGkMEvKo-c0XNRyJSrbkrgqLrWdXc9sju1JHx=y8QOLYCfffw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] Define a low power mode for devices

On Wed, Dec 6, 2023 at 6:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Dec 06, 2023 at 05:16:04PM +0800, Jason Wang wrote:
> > On Tue, Dec 5, 2023 at 6:58=E2=80=AFPM David Stevens <stevensd@chromium=
.org> wrote:
> > >
> > > On Tue, Dec 5, 2023 at 1:18=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Mon, Dec 4, 2023 at 5:41=E2=80=AFPM David Stevens <stevensd@chro=
mium.org> wrote:
> > > > >
> > > > > Define a low power mode for virtio devices where the devices are
> > > > > expected to maintain their state. This gives drivers an option fo=
r power
> > > > > management besides simply resetting their device. In the virtuali=
zation
> > > > > use case, this allows the guest to be suspended even with statefu=
l
> > > > > virtio devices like gpu and fs.
> > > > >
> > > > > Low power mode is primarily defined at the transport layer. The o=
nly
> > > > > part that depends on device-type specific details is whether a gi=
ven
> > > > > virtqueue is device driven or driver driven.
> > > > >
> > > > > This change only defines the transport-specific implementation fo=
r
> > > > > Virtio over PCI.
> > > >
> > > > A dumb question, if this is only for PCI, can the device just
> > > > implement no_soft_reset via PMC?
> > >
> > > This is basically No_Soft_Reset, yes. If a change similar to [1] woul=
d
> > > be acceptable based only on the No_Soft_Reset bit even with no concep=
t
> > > of power management in the virtio spec, then I personally don't have
> > > any problems with that.
> > >
> > > [1] https://lore.kernel.org/lkml/20231113055138.117392-1-stevensd@chr=
omium.org/
> >
> > So if I read the code correctly, the current Qemu advertises PM but
> > without no_soft_reset.
> >
> > So this patch seems to break e.g virtio-net and doesn't fix virtio-GPU.
> >
> > Thanks
> >
> > >
> > > -David
> > >
>
> what is the breakage exactly?

It looks to me we need:

1) Device side, if device can preserve state on d3hot, it may
advertise no_soft_reset
2) Driver side, if driver sees no_soft_reset, it doesn't need to
manually suspend and resume. But in the above patch, it only checks
the existence of PM, it looks to me it needs to check no_soft_reset
instead.

> Maybe we need a new feature bit?

Probably not.

Thanks

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

