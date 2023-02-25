Return-Path: <virtio-dev-return-11275-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47728C64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 14:21:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 649F777F7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 14:21:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55D87986791
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 14:21:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 48793986784; Sat, 25 Feb 2023 14:21:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36903983F7F
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 14:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYyJ53YDg7JSmZHAC8DCGBvJtwiN/85LIomMdkVKLnc=;
        b=RiApk7daKI1mYx6YqEty5DKTiNEmo2CsGygr4YiNScXT6LHNPZwo2A1gGqo+2MSPRx
         Mmdf7984vXE+tjDu6uvWzkP7tNumg27c/XSewUl32Rk/MhH7bO9MwbnrFawYAozMM2xU
         XO9pVldvDs+3banJi4/jkWXfndjwlwxtG4xyXT5QuEi5a8mBtY0PuGT4xuh8wTfM/O9v
         oNlbLtcgQXBfCO5I/BtDb4djyQF7p4iN1oupj1XHvt2RXpH1T/c23DfX9R7S1tDr1Ltt
         uW6uf4YBRu+Hkbcwy2xKNjwMjRADj87x1m9/xQmJwWP+vbrtnjtpT4QNdo0ymmV/RrST
         IzeQ==
X-Gm-Message-State: AO0yUKUBwVlD2+8e8kvW2Sppp2IKr4VMozIk4jrqyOcSyNgV44Xq32mv
	992B91R6GuCEaYt4XtE6WcX695biRgMXppBPL3PoUA==
X-Google-Smtp-Source: AK7set+AOwRh5WrDn4x9s+QHmis0/Gwa8G/kLb7SFZ92tzRbP/cjM1QpjlNEySJLRuMSuqbXDjm6USdIRV7eAJ3lJcA=
X-Received: by 2002:a63:7354:0:b0:502:fd15:2ad6 with SMTP id
 d20-20020a637354000000b00502fd152ad6mr2612464pgn.2.1677334890486; Sat, 25 Feb
 2023 06:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20230224142602.657-1-hengqi@linux.alibaba.com> <CAJs=3_C_NATOMyLJs1G7cmewpSasW67UBpoa53ZHayw+Uw5+-g@mail.gmail.com>
In-Reply-To: <CAJs=3_C_NATOMyLJs1G7cmewpSasW67UBpoa53ZHayw+Uw5+-g@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sat, 25 Feb 2023 16:20:52 +0200
Message-ID: <CAJs=3_AgSgbqUnpS6SiAobWR9zZbFsAVJNrra8r2EksYMwgcRw@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, 
	David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v8] virtio-net: support the virtqueue coalescing moderation
Message-ID: <20230225142052.xFV0KDYn8zGAT0iD8XU3jLY-gnCPQgAyOYXhGMfhiaM@z>

> A general note,
>
> Correct my if I'm wrong, but the fact that a driver can't send
> VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET  commands if
> VIRTIO_NET_F_NOTF_COAL is not negotiated isn't explicitly mentioned
> anywhere.
> A reader may think that the commands cant be sent if

I meant "can", not "cant"
Sorry about that.

> VIRTIO_NET_F_VQ_NOTF_COAL is negotiated.
> I'm not talking about the conformance parts, but I think that we
> should write somewhere in the beginning which commands can be used
> with which feature bits.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

