Return-Path: <virtio-dev-return-14136-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9184BC10F04
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Dec 2023 06:47:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A7EEB2AD5F
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Dec 2023 06:47:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82C09986917
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Dec 2023 06:47:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6366598401F; Fri,  8 Dec 2023 06:47:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4ED0C98690C
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Dec 2023 06:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018021; x=1702622821;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhp7niZixNUyC1WRXnTrthFp9hlVK/ThVcRbBT5lIeU=;
        b=nnZ35MFn9wdjfg7MYo/CGmpj/5/5mkjshmqayJxEGsqRUNT5ZjDiURglYt84Coku89
         AyZPYbWGHXalesqYIhdSc5PCFFqHtLYG7vz8UxJSDaKUCGbQyU0F1z2T+gbtkB/3GSCM
         ZSkQiA0brCCW3KZmr/RbgidzAMFpmXL5G09rVyLtGV9cGlU2syp62+XwXGBmd4cVhvGp
         ZRqW5S7hOfJPbNXj64sj+d/msrycjhJhlT/7m1PLjdYA1/STdVZtmaG7QNnNxfSHOyUJ
         C1F6J7G+y9T8u2YvX6de5HMr3WUFhr47TjT8543aFdY4KH/ORqbx4+gtdJbQigRBUaSW
         H7Tg==
X-Gm-Message-State: AOJu0Yz9r4J0vJgVQ3mByNtjPtu2paRm8PPHuqyyxQdoA0qwPV9WDXLu
	2CROvdAyG72cK3xr6XOXAtwGCD1l/QKNnbFwYac=
X-Google-Smtp-Source: AGHT+IFpnLYnIuv+65hDKk3W2MLvIBRQMBYkjP9gEpRNyCBNsAgiKHBGBJ9K9frLoTTdEwrpLU4pcA==
X-Received: by 2002:a05:6402:3818:b0:54b:2894:d198 with SMTP id es24-20020a056402381800b0054b2894d198mr2837781edb.4.1702018020695;
        Thu, 07 Dec 2023 22:47:00 -0800 (PST)
X-Received: by 2002:a05:600c:3b20:b0:40c:1e46:508e with SMTP id
 m32-20020a05600c3b2000b0040c1e46508emr27895wms.0.1702018019494; Thu, 07 Dec
 2023 22:46:59 -0800 (PST)
MIME-Version: 1.0
From: Alexandre Courbot <acourbot@chromium.org>
Date: Fri, 8 Dec 2023 15:46:47 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUB9GTEOCCkvVK9+ukjuYr9x6X8Kv-XSHT1tNd_=ZCCfA@mail.gmail.com>
Message-ID: <CAPBb6MUB9GTEOCCkvVK9+ukjuYr9x6X8Kv-XSHT1tNd_=ZCCfA@mail.gmail.com>
To: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Albert Esteve <aesteve@redhat.com>, 
	Enric Balletbo i Serra <eballetb@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] [FYI] virtio-media published

Hello everyone,

This is just a heads-up to announce the initial publication of virtio-media:

https://github.com/Gnurou/virtio-media

The name has changed slightly, but this project is essentially the
refinement and continuation of my virtio-v4l2 proposal. The reason for
moving forward with this is, to be candid, the unclear direction and
lack of progress regarding the future of virtio-video, and the
non-consensual way in which its development has been, let's say
"redirected".

The repo above contains the specification in the README file
(presented in a more informal way than the virtio specification), as
well as a guest V4L2 driver able to pass v4l2-compliance when proxying
the vivid/vicodec virtual devices or an actual UVC camera using the
crosvm V4L2 proxy device [1]. As of now it is basically
feature-complete and offers everything that virtio-video is supposed
to eventually do. I am considering adding support for multiple devices
and requests to allow more complex camera setups.

Since the initial proposal has been rejected I have no intent to push
this forward for merging in the virtio specification, so this will
live out of the official spec. However, it is likely that we will soon
switch to this solution for video support in ChromeOS and possibly
other Google projects with a similar need for a stable virtualization
solution for media devices.

Anyone who is interested in using this for their project, or with
specific requests, is welcome to contact me or open issues on the
Github project.

Cheers,
Alex.

[1] https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5065329

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

