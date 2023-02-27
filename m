Return-Path: <virtio-dev-return-11324-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD16C64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 20:42:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 690872A88A
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 20:42:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FC8D986610
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 20:42:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5445C984216; Mon, 27 Feb 2023 20:42:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 41EEC9865F8
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 20:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3XEM/jefAzLLTlRILKk70+tJ4zO7noH8hZrnhX0FKY=;
        b=2Y/TR3CktM+sAOlIo5gLa3tfkmJ4QxS5T0yd3Rg0vrMSL/4LqsDfR8cqFpBQE7Unmo
         X3gmL2UPE5ea2IqMzqQ9Z4IwIrxVIZK75Q8gbqC6E177fGMD6dJNZR0lMlwlUJ7vnNF3
         W9uIHHJAm/SVwS3j4jR1upkz82zmv3bImBGckOMBoZ6htzcb6skOmnSiHZlvmj/K+MpU
         DMsc11MP1wqvd/Ziv9xwTtM8kjzj70zGYO9iWXk85/1O5QgAxKM8G5dubSJgbUE9xA18
         P71+tNQOgfCwrZhDv1gelk+EgkIAPLeqbPyfzkW/sHdeH8UeSmoNmdP8s97GlEF3jQaB
         8jpg==
X-Gm-Message-State: AO0yUKXBJE8Fh+drFMgMhE5dRB2iAvBQrpZPnKpTn6hAaoYBNbfHBogw
	CCGyq6nH9mzMgBut4Rw0qnhRMnXyY+6f/YIwr1gSWA==
X-Google-Smtp-Source: AK7set9VJrY8ltp2d9xbJBCOauMT4t3EtPS6bCks/GgOEgB6r+cqXFEJJmod+6AZTtOhzSIEGCMNfLUrQ5lLAuGvDvE=
X-Received: by 2002:a17:90a:6685:b0:236:855f:f9a8 with SMTP id
 m5-20020a17090a668500b00236855ff9a8mr215469pjj.9.1677530536845; Mon, 27 Feb
 2023 12:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
 <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com> <CAJs=3_DND7WdoXc19XzOKDDKYNXFKdKRMr6j93p9z7=5EyGHGQ@mail.gmail.com>
 <20230227151420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230227151420-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 27 Feb 2023 22:41:38 +0200
Message-ID: <CAJs=3_B-MHzLDdbHQEgRt+XoVAbS8G3tR8=0u2hwTQrXWaduTw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, 
	David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support the virtqueue
 coalescing moderation
Message-ID: <20230227204138.CRQs84UD3gWtGzmQzymzVDT1ivoeA6co5gJ9TQTtu6w@z>

> > I see your point, but a reader will see the "global notifications
> > coalescing parameter" concept, and won't know what it is until next
> > paragraph.
> > Maybe we can have a new list with the notification coalescing concepts
> > (like the notification coalescing parameters)? Just throwing an idea
> > here.
>
> Actually, "global notification coalescing parameters" is confusing:
> are these global notifications? global coalescings? global parameters?
>
> The problem is the global qualifier. And it's not even global -
> there are two sets for rx and for tx and does not apply to cvq at all.
> How about "RX/TX coalescing parameters"?

Seems fine to me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

