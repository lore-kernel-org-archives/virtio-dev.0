Return-Path: <virtio-dev-return-13397-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640CEB64DC
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 07:44:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0E4CF3357B
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 07:44:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D53B3986848
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 07:44:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B9E0298683F; Fri, 21 Jul 2023 07:44:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2245986840
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jul 2023 07:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kMqdUM2XM8GlDUZk-9X2_g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925481; x=1690530281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VciaJ1gGIInEf67D/Jk0z/wlE+DJyDO31/bBt3CHuN0=;
        b=d1MahQFlAXUR8zsDTZC6jwRB/l1rB0IksviN22EbEizTbfkqZAr6rtPCUoHt5jACKx
         JPNALOKKnNbyLls+/vJTbelSlIv6rZfSMVS00QAESHbmmDXg+RAe4p/BIlod52ykg8bd
         tsWWDCK3/bP3ffpx8WORrSifY5QnNt4FMLkjOEnHjEJkMC/DOQiyZeLYH1gr3Fkj4bUC
         8z2psg2bnfHQNErl+KQeRB7BDbiaTzeYTlNC71ef3DkX3V3Q3wKN1cEx2yC/Zkz+VdOr
         eLrj9JJjo6NkPKRuuG/wMZiB3wMKseQ3GVEXqczpVdT9mCJNe6QFim9v9vs8AEM4nNbD
         ubVQ==
X-Gm-Message-State: ABy/qLbGBaNxVS5ZlLsptAvs7IbII/vxxJWEqp0viEs4H8SCfQuGHP9b
	le24vF/f/wBKP4i8GRkE8mHAsIh2BgnkOyoAQ9QimYRDQJPO1MbHIxm+Rt1DRMnFmOZQTINo8IZ
	wjcmx/zYbpDsxiLtysq+qJLss+m13
X-Received: by 2002:a0c:e1c3:0:b0:635:e56e:ccf1 with SMTP id v3-20020a0ce1c3000000b00635e56eccf1mr1322763qvl.46.1689925481113;
        Fri, 21 Jul 2023 00:44:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcLQqEfTKDCHSI/jeoJRFNOMja8kuPmcLF4hAXuDu0x+bHFF0PN3cuAMOUPwr8DJPh2P2Bog==
X-Received: by 2002:a0c:e1c3:0:b0:635:e56e:ccf1 with SMTP id v3-20020a0ce1c3000000b00635e56eccf1mr1322755qvl.46.1689925480876;
        Fri, 21 Jul 2023 00:44:40 -0700 (PDT)
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
X-Google-Original-From: Matias Ezequiel Vara Larsen <MVARALAR@redhat.com>
Date: Fri, 21 Jul 2023 09:44:36 +0200
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.oasis-open.org, JP Cottin <jpcottin@google.com>,
	Jorge Moreira Broche <jemoreira@google.com>
Message-ID: <ZLo3ZDfJvS/hAJVp@fedora>
References: <CAOGAQeoLSGR2RtRHX0kyS5dxK=wa+mDZ8BRyZX5oDKaL16LdSg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOGAQeoLSGR2RtRHX0kyS5dxK=wa+mDZ8BRyZX5oDKaL16LdSg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] virtio-snd and snapshots (e.g. in QEMU) when audio
 is active

Hello Roman,

On Wed, Jul 19, 2023 at 04:21:08PM -0700, Roman Kiryanov wrote:
> Hi,
> 
> I work in Android Studio Emulator and we use virtio-snd (implemented
> ourselves) for audio output/input. According to the spec (1.2), the
> device has one TX virtqueue for all output streams and one RX
> virtqueue for all input streams. Each stream may and usually have more
> than one period (I request 4 periods).
> 
> Because virtqueues are shared between streams (if there are more than
> one stream in the same direction), I cannot fetch vq messages when a
> stream needs one. I fetch vq messages (and put them into my own buffer
> to process them later) when the kernel puts them into a vq. I hope
> this is correct. 

I think this is correct. If I understand correctly, this is the idea of
the pre-buffering after the PREPARE command, i.e., to feed the audio
engine before to START streaming (see section 5.14.6.6.1 PCM Command
Lifecycle).

> I think I tried processing them immediately (at least
> for TX) but the kernel was not happy with this because I was draining
> the buffer too fast causing XRUN.
> If a snapshot request comes when audio streams are active I may have
> several unprocessed messages for several streams for both TX and RX.
> In my case messages are VirtQueueElement* which I don't think can be
> saved directly.
> 
> Could you please advise what a device is expected to do in this case?
> 

Do you mean what a VMM shall do when taking a snapshot regarding the
virtio-snd device?

Matias


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

