Return-Path: <virtio-dev-return-12755-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2332C77B7D
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 19:35:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1289E41EE8
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 19:35:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E55FD986722
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 19:35:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CD524986719; Thu, 18 May 2023 19:35:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B989C98671A
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 May 2023 19:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: B_lpwIXtN-iREzg62ddLNg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684438555; x=1687030555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpakjjvgn6Jf/Vqf7Aa7EOdT2AcTavAi6czGHvjJFKQ=;
        b=SUmq+5vhkqn6tfNzuSuz1hzXQg6R1ZcsBUgxQlRKZ1gN7p7guJlRxex0nrdchcyILF
         u3ujbXGv2FQSQ+H+NXYGWie+CA4zf1MCJfALYDBZfd/KpzEH8UzxLvohNF2CdQHmzKCI
         xohXSUfzDgmisLt98+/JWO4UD93yPQv3wC2+Psuw3uIOnuexQnM/barQjrcZsSGe1JCG
         V3tIww9NCk0Ov+bkT/6PiegDVZPTQiukSQhNxHWWMa05YuzZocmWra/kAKDjIxKpZWmU
         jDMRnNWOh8HYhEzhhJkcvRm3ZVl0nO/A+4B/E7s/0N3Ia6baS1fEvgPB6hBklSIAJVf5
         qIDw==
X-Gm-Message-State: AC+VfDxI9as9uXmyrDfBIFxXjA01LHN3yPtt5uPjsy2BWDD667I7Y4RY
	vTJb1MJEOCfqqie546RV6Auo3rUF38ApLkt/k88vCASjldYsXEMVpAiFFFL8lc7RbJdp2RVYPjh
	qQlva4dBYjHsl5Z9Whg1blv1JVwmu
X-Received: by 2002:ac2:59cc:0:b0:4f3:a827:4b81 with SMTP id x12-20020ac259cc000000b004f3a8274b81mr20938lfn.20.1684438554913;
        Thu, 18 May 2023 12:35:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QXxJg+MMS9wqtPxSc+YdOpUDDfyoMcf8hVXD0cyrktN4MqjqlKkc7DgU7rNjLr7OfeK7P0Q==
X-Received: by 2002:ac2:59cc:0:b0:4f3:a827:4b81 with SMTP id x12-20020ac259cc000000b004f3a8274b81mr20922lfn.20.1684438554554;
        Thu, 18 May 2023 12:35:54 -0700 (PDT)
Date: Thu, 18 May 2023 15:35:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Gordeev <alexander.gordeev@opensynergy.com>,
	Alexandre Courbot <acourbot@chromium.org>,
	virtio-dev@lists.oasis-open.org,
	Keiichi Watanabe <keiichiw@chromium.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Marcin Wojtas <mwojtas@google.com>,
	Matti =?iso-8859-1?Q?M=F6ll?= <Matti.Moell@opensynergy.com>,
	Andrew Gazizov <andrew.gazizov@opensynergy.com>,
	Enrico Granata <egranata@google.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?utf-8?Q?Bart=C5=82omiej?= Grzesik <bag@semihalf.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Enric Balletbo i Serra <eballetb@redhat.com>,
	Albert Esteve <aesteve@redhat.com>
Message-ID: <20230518153349-mutt-send-email-mst@kernel.org>
References: <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
 <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
 <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
 <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
 <7c44f2e4-1138-ff69-7cff-11edaec2ecbb@opensynergy.com>
 <87y1lmx6qa.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87y1lmx6qa.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Wed, May 17, 2023 at 06:28:29PM +0200, Cornelia Huck wrote:
> >>> I also hope to be able to update virtio-video at a faster pace. Please
> >>> let me try.
> >>
> >> Please hold on a bit - there are two things here.
> >>
> >> 1) I'd like to settle the virtio-v4l2/virtio-video argument first to
> >> make sure we don't get two things clashing head-on. As far as codecs
> >> are concerned we certainly don't need both. Cornelia, I think we'll
> >> need you to make a call on this, or at least tell us what you need to
> >> make the call. If it helps I can send a draft of what the virtio-v4l2
> >> spec would look like, it should be relatively short.
> >>
> >> 2) I (and other ChromeOS contributors) have been driving this spec so
> >> far and while I think virtio-v4l2 is a better solution, I have not
> >> said I would give up on virtio-video if virtio-v4l2 was not adopted
> >> and will keep iterating on it in that case.
> >
> > It actually very much looks like you gave up. I mean, you developed it
> > for years, and now you'd like to throw it away. Well, I meant something
> > like "please have some faith in my ability to update virtio-video at a
> > faster pace". I think I already have the permission to continue the
> > development. You know, OpenSynergy also spent some time on the
> > virtio-video. This includes the draft v1 version and the V4L2 driver. I
> > think this was kind of an informal agreement between us, that you do the
> > spec and we do the driver. It didn't work well enough since draft v4, I
> > think. Now as our interests are not aligned anymore, it is fine to
> > continue separately. I'm not going to wait until you change your mind on
> > virtio-v4l2. Obviously you're very busy with it right now. If I stop and
> > wait now, we won't have the video device in the 1.3 release for sure. I
> > think when we are ready to develop virtio-video together again, we'll
> > need a better agreement.
> 
> Please, can we just calm down here? This thread is painful to read
> already, and pointing at each other is not going to help us to come up
> with something that is generally agreeable. In the end, I want _a_ spec,
> and I don't really have a horse in V4L2 vs. video race, but having to
> dig through all of this in the hope of moderating things is just
> impossible if you're arguing in circles, and much of it seemingly being
> a rehashing about who said/did something or not.

Well said Cornelia thanks for writing this.

I really stopped reading this thread, hopefully things will be better
from now on. One thing that will help is if future submissions
include a summary of alternatives and past discussion in
the cover letter.

> > That said, I very much appreciate your efforts with the spec. It
> > definitely received a lot of improvements.
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

