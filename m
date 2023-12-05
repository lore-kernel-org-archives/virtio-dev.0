Return-Path: <virtio-dev-return-14118-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA87C10F04
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 10:58:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E28A52A8F7
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 10:58:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D535D986667
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 10:58:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C78A998645D; Tue,  5 Dec 2023 10:58:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B276C986496
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2023 10:58:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773918; x=1702378718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlZDXRrdYPu6fBH6jwZH9netykcPABwx+0YuSPXngF4=;
        b=VShevq9b2zQ1RT9PV2W36VUspQvxr+8zsEIFwTW6pMBF4taUQmLQ7qrtGaLge4S5dI
         zn99qHQ5MHSPPrCRjdS/PvCVkq/RGc4JMlkOLXlvqV/dqGeto9bVnhk4ki9b65CNZp2R
         fwrUVxLJKtEOAS22xzFix6U54ktWTF8eUF0pbHNIbfqZVeWNdDxKHoppikL50bhaxi47
         hdI+Lghfu0xL+KcKKG7QPKPp9dtkf3oroWKfhsFYKA+g4v+/v4eomdaUy/n+s6t0jEmx
         /uuyGnRYeqrja8V23QZPdQZbRuD6ctJr81Dj2tAzILmzyKOCvzhAmQytGCrUmz/8EUxj
         Zn4Q==
X-Gm-Message-State: AOJu0YxdAenyqR5fiQNJyeDjBpUMZxonOOIjjOpL5IdWWNel1613I9UU
	EPpvQbIFPMO7siXDe9jo8gYvetEBxWxTfzS3WnD7QA==
X-Google-Smtp-Source: AGHT+IEAEsLBLVTFZ2kYdR+dJLTRRlwCny2KR6Y3NYD5Vrc95eC65MpFY69FhfGKHNBP6B/PGRHYl4EFBn5BCkm2C34=
X-Received: by 2002:a19:7612:0:b0:50b:e750:dd99 with SMTP id
 c18-20020a197612000000b0050be750dd99mr1949414lff.38.1701773918067; Tue, 05
 Dec 2023 02:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204094123.856214-1-stevensd@chromium.org>
 <20231204094123.856214-2-stevensd@chromium.org> <CACGkMEuHLs=+8_RHVa9eTXfHLqo_Ra6hSrnT9k8DAG_0yz0pvQ@mail.gmail.com>
In-Reply-To: <CACGkMEuHLs=+8_RHVa9eTXfHLqo_Ra6hSrnT9k8DAG_0yz0pvQ@mail.gmail.com>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 5 Dec 2023 19:58:27 +0900
Message-ID: <CAD=HUj6bBOOCWmrbxBHKymfAr3UVUL7S57FtffHi0vEzVmewDA@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] Define a low power mode for devices

On Tue, Dec 5, 2023 at 1:18=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Dec 4, 2023 at 5:41=E2=80=AFPM David Stevens <stevensd@chromium.o=
rg> wrote:
> >
> > Define a low power mode for virtio devices where the devices are
> > expected to maintain their state. This gives drivers an option for powe=
r
> > management besides simply resetting their device. In the virtualization
> > use case, this allows the guest to be suspended even with stateful
> > virtio devices like gpu and fs.
> >
> > Low power mode is primarily defined at the transport layer. The only
> > part that depends on device-type specific details is whether a given
> > virtqueue is device driven or driver driven.
> >
> > This change only defines the transport-specific implementation for
> > Virtio over PCI.
>
> A dumb question, if this is only for PCI, can the device just
> implement no_soft_reset via PMC?

This is basically No_Soft_Reset, yes. If a change similar to [1] would
be acceptable based only on the No_Soft_Reset bit even with no concept
of power management in the virtio spec, then I personally don't have
any problems with that.

[1] https://lore.kernel.org/lkml/20231113055138.117392-1-stevensd@chromium.=
org/

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

