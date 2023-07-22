Return-Path: <virtio-dev-return-13405-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A45EB64DA
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Jul 2023 05:16:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 712D82CAD2
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Jul 2023 05:16:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D0BE98684E
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Jul 2023 05:16:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 45E0E983D43; Sat, 22 Jul 2023 05:16:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DBE1986848
	for <virtio-dev@lists.oasis-open.org>; Sat, 22 Jul 2023 05:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690002966; x=1690607766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Puv0HZJC8Xbt3AYYg02l9cZbum9G3GUkKotcsMVJi0c=;
        b=gs9k6Npy5WJWZ0q2tFd3kDW1/nElwNXqzYjdPjG6S/RUpqKz2pXvCTwbzSFEKp1oMf
         YElisI3hnuiCNyk+Wnh1CbWzDWdDVawCpV3JcLDz4q4yrvFSx9oRfSWNm+8FHKxswRWM
         JOY+reO8qYOsXUiM8SlLQ4i8DqfbdNpm7wqQ4D+qWqiYUL2n2jBOE7V14xgVjoULDAde
         iP07sUqWE9ooFYvTja1233XDh1JEQXPG3ftHH0G/s/XcQI2nxLfE8XriuYYwy1YmJtYz
         XeKc/R9PQdwC/8D+M/NbV09RPJOBpw7WY5wzcOusfbwlRv5j0gzxG80yPu4XJD0r3su1
         AuOQ==
X-Gm-Message-State: ABy/qLYQml90gGmEqvmA59bE+nbmPdt7CnWb1mA9Pd7buDP1/GVTsGsn
	MXGLn+2htsUMmMOKsU6Zn8CK/WryH4ZVir78L0SkGg==
X-Google-Smtp-Source: APBJJlHNMhFWPM6Q8tvROvzlY1Sx+gARuK4Q8Dtpt9mc52cCpLaGlbWdn/xXJJ1Oi+YSfkVBqIXsGM5QjDFYFbt7YU4=
X-Received: by 2002:a17:902:d503:b0:1b8:94e9:e966 with SMTP id
 b3-20020a170902d50300b001b894e9e966mr120503plg.24.1690002965562; Fri, 21 Jul
 2023 22:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeoLSGR2RtRHX0kyS5dxK=wa+mDZ8BRyZX5oDKaL16LdSg@mail.gmail.com>
 <20230720154034.GE184015@fedora>
In-Reply-To: <20230720154034.GE184015@fedora>
From: Roman Kiryanov <rkir@google.com>
Date: Fri, 21 Jul 2023 22:15:54 -0700
Message-ID: <CAOGAQeqnFX9K7HF+RUhLPUTJUo5z5McHUWL6kaFJPY=ZCFE-QQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, JP Cottin <jpcottin@google.com>, 
	Jorge Moreira Broche <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] virtio-snd and snapshots (e.g. in QEMU) when audio
 is active

On Thu, Jul 20, 2023 at 8:41=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:

> > Could you please advise what a device is expected to do in this case?
>
> Do you mean QEMU's VirtQueueElement? There are devices in QEMU that
> save/load in-flight VirtQueueElements. See qemu_put_virtqueue_element().

Thank you, Stefan. I found examples on how to use
qemu_put_virtqueue_element. This is clear now.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

