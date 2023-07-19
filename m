Return-Path: <virtio-dev-return-13385-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE352C0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Jul 2023 23:21:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2F1A31CA246
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Jul 2023 23:21:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1BCC39867B3
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Jul 2023 23:21:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 047F79866B0; Wed, 19 Jul 2023 23:21:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1015986730
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jul 2023 23:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689808880; x=1690413680;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXXBeiez8mwTBQlIsfqMbCg9hcfZ98limD5Zu0pHSms=;
        b=McoaHNaudPgjZBOAHjv0rz2GZsJ2WEaFnv7qxtBOAq2RJ9sRrhA0yndRqCgYpMbGQ8
         evrF6Z+2oLKwZnwHJevGHhREr1KophzA/jRWxA2uq6t+QV7pFRZlpYmBp8gUHFxQcc6G
         ZmxRasYiwqT1Xa5adbGbo+hjA+TmzIE4NNA6WPQfDylqRxcsR1mG8PdN3uzyeEgurg2s
         xVpatsFOEkReiQmAF5zdEVV010mm10URIF1yE+UrsMNrRiw6vTw9KpexcKhD2TKxtpqW
         u94YFyMhXFydj6bRc6VQQiPRQwd+8F2pe3OEhgwY+fDn7SsDqnHkAlBFz/cBuy8w3pd1
         RKGQ==
X-Gm-Message-State: ABy/qLbDjvuIWPUkigI1SmdOPOQFWzs9usM0Ont8utwSk4uPguxznhd6
	rU1qAVMQj5DjOxWaBnvacAClkZ2xzeLwpqKxH5D5eYRpVcwNKmilnwOBJQ==
X-Google-Smtp-Source: APBJJlE5qlDz8f+mXE6Z4hmmyC1dmYoOu3OESEqOBZXmiRDuyuvcDY2wwtZ3f9kvcHhI/vUFgRrL8YYy8Pn7JhjFACM=
X-Received: by 2002:a17:902:d4ca:b0:1ac:3605:97dc with SMTP id
 o10-20020a170902d4ca00b001ac360597dcmr105990plg.6.1689808879890; Wed, 19 Jul
 2023 16:21:19 -0700 (PDT)
MIME-Version: 1.0
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 19 Jul 2023 16:21:08 -0700
Message-ID: <CAOGAQeoLSGR2RtRHX0kyS5dxK=wa+mDZ8BRyZX5oDKaL16LdSg@mail.gmail.com>
To: virtio-dev@lists.oasis-open.org
Cc: JP Cottin <jpcottin@google.com>, Jorge Moreira Broche <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] virtio-snd and snapshots (e.g. in QEMU) when audio is active

Hi,

I work in Android Studio Emulator and we use virtio-snd (implemented
ourselves) for audio output/input. According to the spec (1.2), the
device has one TX virtqueue for all output streams and one RX
virtqueue for all input streams. Each stream may and usually have more
than one period (I request 4 periods).

Because virtqueues are shared between streams (if there are more than
one stream in the same direction), I cannot fetch vq messages when a
stream needs one. I fetch vq messages (and put them into my own buffer
to process them later) when the kernel puts them into a vq. I hope
this is correct. I think I tried processing them immediately (at least
for TX) but the kernel was not happy with this because I was draining
the buffer too fast causing XRUN.

If a snapshot request comes when audio streams are active I may have
several unprocessed messages for several streams for both TX and RX.
In my case messages are VirtQueueElement* which I don't think can be
saved directly.

Could you please advise what a device is expected to do in this case?

Thank you.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

