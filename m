Return-Path: <virtio-dev-return-14352-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320FEC54E41
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 06:42:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7B4EC2B12F
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 06:42:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 635B0986364
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 06:42:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56FCB98632B; Mon, 26 Feb 2024 06:42:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43C37986344
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Feb 2024 06:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LRaDFsHTNGmbQBaR8DQfBQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708929738; x=1709534538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxDUPagDvVtXFYNQzhzXprsOfNbHn672p3g9URdq+ZU=;
        b=ZF0NDwXnLAcKQxbc/TA9i7Y1+uD4x+4MO4Hgr60GB5F+0V8c3FuX3wU7xUybzeDZUf
         eK1h8zcbNHy33nk5qrPvsidcFqsCjB3ZTBYYWr91p04H4+Q8Jtd+JTxoVKlP6EkeM00f
         owvOZxeFQHPpawGlxvjm5ItaGIhHDZVqiYOhJhvCNoRrxZ7MbZ2I76g0GgMIRBJmRE4A
         3ZGstCgZFHAc6TWPSHqpxX2x6a56uUuh4oF0vUkW+RfbClxRC3cX8a7InBA6AdTtMBjr
         ghLdJwlsmcZblPqiu393CxaCTqFVvTud41KCuSpQxnqiQHGEU/9mDtkyq9Ms4k2J3zCb
         38Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVBBd8seTRM9ZZFWFUVTbDK4hDZxfOLTWCbPfCgd2ZPiQv8oHVGwU/62LnGDviWS6ab47D9eu3D+YWMIXnm61FEBT6HjFQr/XY/ig+Jk0lC
X-Gm-Message-State: AOJu0YyOOxe/HoilEzA+H4jkCpUk5lO6V90SK4IKu5ocPEkdJV70auTq
	mO/bYuXMlU3r4TKqjdaSosCWwM7Obqf1WQYthChutxUTCgFBC03xqosm17ogGbcD/uCm7u5EjSQ
	S+LfuSEESgb686C6PaJclkSxGlKbYBylRoikz5TvvbX291tHo38IX61atGn+Kcn8er8+Lcm5ho4
	n0FtCLq24Pbr3jKGGsUP+iGwUYkyjMLI5PDE83q8F7
X-Received: by 2002:a17:902:ead2:b0:1dc:177b:1d85 with SMTP id p18-20020a170902ead200b001dc177b1d85mr5212140pld.27.1708929738063;
        Sun, 25 Feb 2024 22:42:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPjqXDqvRSryvZUoHlapsPF8sYJ2LccTIQnf1QlrFDeAAnlVtwK8iyELbez+L0Sh0tF4nraIcdu4TqUhKTGGQ=
X-Received: by 2002:a17:902:ead2:b0:1dc:177b:1d85 with SMTP id
 p18-20020a170902ead200b001dc177b1d85mr5212129pld.27.1708929737544; Sun, 25
 Feb 2024 22:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20240216082432.709956-1-stevensd@chromium.org> <20240216082432.709956-2-stevensd@chromium.org>
In-Reply-To: <20240216082432.709956-2-stevensd@chromium.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Feb 2024 14:42:06 +0800
Message-ID: <CACGkMEuP=ZcbRf4G8O1hBjg0s5uNbrRMO=ESnU0AKWSHmF_fMQ@mail.gmail.com>
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, parav@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v4 1/1] Add suspend support for virtio PCI devices

On Fri, Feb 16, 2024 at 4:25=E2=80=AFPM David Stevens <stevensd@chromium.or=
g> wrote:
>
> Add a virtio power management PCI capability to allow drivers to suspend
> virtio PCI devices. This allows drivers to suspend devices at the virtio
> level before suspending them at the PCI transport layer. This allows
> drivers to do a two phase suspend, which prevents notifications from
> being ignored or lost if interrupts are reconfigured at the PCI
> transport layer immediately before or after the device is put into the
> PCI PM D3 low power state.
> ---
>  transport-pci.tex | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>

I would like to know how the two phase suspend can prevent the loss of
notification or interrupt. Or for example, if it can be workaround at
the driver level.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

