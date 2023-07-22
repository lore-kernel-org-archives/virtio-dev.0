Return-Path: <virtio-dev-return-13406-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D491EB64DA
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Jul 2023 05:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4F82B42A74
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Jul 2023 05:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 298D7986857
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Jul 2023 05:20:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 07616983D43; Sat, 22 Jul 2023 05:20:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DCFCE986848
	for <virtio-dev@lists.oasis-open.org>; Sat, 22 Jul 2023 05:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690003197; x=1690607997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRhx3xHmwRoRQOVoZCEElci8ZEZsUUSSw/UIBXlB7i8=;
        b=KZxEJKWblNvXrhYMRULfVRjeKw5rwU7ve+/W7ucxMMx8bSFacHCGjtl64CEsEMFi6X
         C5z98mRg1s3s2L1vjPKVMe1D2N52SUsT/QVaDXgz0acnWLis4fxF5cz2Rs9+i15yhxow
         Pu5M5q50M9O625wHA5G+qnuI7RoAAN9/YGa18ENOt8Ifn7Wf6JgcfL9BgFVxc+5S0V8m
         h35Zap1EqIAFTPZYNdPk1cg7YYn9pTS89TyLqARHcRUlR3FgeQTdsU6zOzM+go+oXqNd
         F0mtGRGyvjH0LaYNIw/TEu+ARpe9NkXHNQpPU5RVeMVfj9Uj+xkxmFplFj/3FgYN73Ll
         EcsQ==
X-Gm-Message-State: ABy/qLYqNMaS60EUdrPnbUgydR1+o3B3sT2yiLWU6tZVKyOKLHeaW2tX
	JQuCojbCBN4ksV9KEu5qdfezc8PZjhzz/pPqgGmlwA==
X-Google-Smtp-Source: APBJJlEJdDGI58ZKiDK9iyCFLpJBXfhNVe/QX+xHtTrSS/WbwB7uFFXcmaKr7ZANDAWjrUhtUWNA/vxEZs3MyMv3zIE=
X-Received: by 2002:a17:902:f2d2:b0:1b8:b564:b528 with SMTP id
 h18-20020a170902f2d200b001b8b564b528mr77485plc.7.1690003197270; Fri, 21 Jul
 2023 22:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeoLSGR2RtRHX0kyS5dxK=wa+mDZ8BRyZX5oDKaL16LdSg@mail.gmail.com>
 <ZLo3ZDfJvS/hAJVp@fedora>
In-Reply-To: <ZLo3ZDfJvS/hAJVp@fedora>
From: Roman Kiryanov <rkir@google.com>
Date: Fri, 21 Jul 2023 22:19:46 -0700
Message-ID: <CAOGAQer57mU5rGOE9fZtYhgu6C5kkx0xcfq2N_gw77kRV+NAFg@mail.gmail.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, JP Cottin <jpcottin@google.com>, 
	Jorge Moreira Broche <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] virtio-snd and snapshots (e.g. in QEMU) when audio
 is active

On Fri, Jul 21, 2023 at 12:44=E2=80=AFAM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
> > Could you please advise what a device is expected to do in this case?
> >
>
> Do you mean what a VMM shall do when taking a snapshot regarding the
> virtio-snd device?

Thank you for looking into this, Matias. Stefan already pointed to use
qemu_put_virtqueue_element to save unprocessed messages in virtio-snd
when taking a snapshot.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

