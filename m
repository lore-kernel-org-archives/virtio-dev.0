Return-Path: <virtio-dev-return-12829-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00846C77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 31 May 2023 06:08:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3CCE62B028
	for <virtio-dev@archiver.kernel.org>; Wed, 31 May 2023 06:08:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E7C49865FE
	for <virtio-dev@archiver.kernel.org>; Wed, 31 May 2023 06:08:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 01D2398658F; Wed, 31 May 2023 06:08:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E28A7986595
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 May 2023 06:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: V_q-1iAsOqe29bp3VV5JgQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685513282; x=1688105282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaG7LQahZkIDm9HIuYbz4+rDravtHiJEIkbM9c8zQCc=;
        b=A4/YmBWF7FV7Tn8YTkUYMWwXe++oGU+lptO9qOU/tiVbb0GQPXOpD7oLSEHo158ye4
         V9yeo/NAg3VtD7LcofhJYicz01Jj6xIuMiSz5rPr9+PgT3K6MgD2sqT0KDcMMv2eJw5x
         Jdw7ueaFtbyM6s/ZVF98dcUL2QjcUsltK1rWntLScPjVWT3jxRWMJDhoPcz+vxAPQ7uf
         OSoqxVM9NSA+P7IHcscJX7B743R7w5W7X/EexC1RFEVQUBrd7bKhtCmk4UZUhjf2Lm5N
         s18N4gENm4jmTPkkUSop0B7ZOU7Ld3Ygmi1Dxs+Aa3EU8sRJ6l6rEqTAMg95AgTp9cWJ
         6jwA==
X-Gm-Message-State: AC+VfDxBwKuvCUcz62Yh33OgJU6MGoBIch+URQAEA7VLmGOTE0s/gqVj
	LvTklGfiyDBEp1o05ImsgBIfszJ50XYvawV4otsKyM8A/VEhgp3iPKJ+i+GO6dX9lHBFVrwmioj
	xnqey7TEZvFLgXUfST59Nmigbe4NW
X-Received: by 2002:a2e:a28f:0:b0:2ad:9acb:4849 with SMTP id k15-20020a2ea28f000000b002ad9acb4849mr1847513lja.47.1685513282591;
        Tue, 30 May 2023 23:08:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zAaBP1alQm8o1vxt5moZjFQUwyz9uCjA3MwyYzoKv5akxCkm5Xta5jAquutD2YBAeKftu0w==
X-Received: by 2002:a2e:a28f:0:b0:2ad:9acb:4849 with SMTP id k15-20020a2ea28f000000b002ad9acb4849mr1847495lja.47.1685513282309;
        Tue, 30 May 2023 23:08:02 -0700 (PDT)
Date: Wed, 31 May 2023 02:07:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandre Courbot <acourbot@google.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Albert Esteve <aesteve@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Andrew Gazizov <andrew.gazizov@opensynergy.com>,
	Andrii Cherniavskyi <andrii.cherniavskyi@opensynergy.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Enric Balletbo i Serra <eballetb@redhat.com>,
	Enrico Granata <egranata@google.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	Keiichi Watanabe <keiichiw@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Alexander Gordeev <alexander.gordeev@opensynergy.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Matti =?iso-8859-1?Q?M=F6ll?= <Matti.Moell@opensynergy.com>
Message-ID: <20230531020611-mutt-send-email-mst@kernel.org>
References: <CAPBb6MXBaKKFGg8Yt2Me8kjUwCm4utWcsVOiCS1Qunjhza4Ycg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPBb6MXBaKKFGg8Yt2Me8kjUwCm4utWcsVOiCS1Qunjhza4Ycg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: virtio-v4l2 specification draft

On Wed, May 31, 2023 at 03:02:04PM +0900, Alexandre Courbot wrote:
> Hello everyone,
> 
> With the virtio-video call taking place soon, I thought it would help
> everyone understand both proposals if I sent a more formal
> specification of what virtio-v4l2 looks like. Please find it attached
> to this email.
> 
> I apologize for not finishing and sending this earlier, but hopefully
> at 7 and a half pages it should be rather quick to skim through. :)
> 
> Despite its short size, this spec is capable of supporting camera and
> image processor devices (on top of decoder/encoders), and also allows
> for another kind of memory backing for buffers (host-managed) that is
> not supported by virtio-video.
> 
> For convenience I have made use of clickable links to the relevant
> parts of the V4L2 documentation, since it is supposed to be used
> alongside this spec.
> 
> Looking forward to a fruitful discussion tomorrow!
> 
> Cheers,
> Alex.


Can you please post patch with tex source inline as opposed as
pdf as an attachment? Thanks!

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

