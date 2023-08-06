Return-Path: <virtio-dev-return-13475-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6446C001DE
	for <virtio-dev@archiver.kernel.org>; Sun,  6 Aug 2023 10:32:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3BDAF1EAFF
	for <virtio-dev@archiver.kernel.org>; Sun,  6 Aug 2023 10:32:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36AE398628F
	for <virtio-dev@archiver.kernel.org>; Sun,  6 Aug 2023 10:32:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 28C6D98413E; Sun,  6 Aug 2023 10:32:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12E809840BC
	for <virtio-dev@lists.oasis-open.org>; Sun,  6 Aug 2023 10:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: of6FSAmaMPSsj5WXRpLiVA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691317945; x=1691922745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAps224HeZR9ZSIlHAAm9hcVGnCnU+FEcerQfGTsxOg=;
        b=VoO/3egmushgECVG8H4QyoTJ4b/74Vw07Wem/v2tu+5HbnO2dm/Po0UtRh4eEcobLT
         0uylLmuKTjG7jK7uVP0KOIy7vFDxRduoKMxoIG+5FOi4Y9lghfmEhuhIbELT/XL9L5q+
         S6XFdcOT0Pq1jlfMOodBkRePVAfuDonoBeT1TLT69CfA199OF5LrB1xb79gredDIuJOM
         4jh8qVpUcB1Mk+qS/+WuoQIQ5EuuhCN+ltyGEMn3jn6wn9WycXUC0AMkDBmV8D3WQfoS
         8+tq6j/QAK12HvwgDbS+E/8yOrIL8iAwGH+xLQ4EFgWPGY2824rspRj7+vJeDYAbDKaE
         L8nw==
X-Gm-Message-State: AOJu0YyzrX/N+fSKc2gUxIoNUzax0RWvC/OoUB//F2jtqJoH0xmMmHOG
	eQ6UNLLZNjeIUyLTvkxQUBjGd5Lp2I8SuxgQvEpkel+K6tvpeo79UAhbQfccfQ50/JZ2qZOFmgF
	kX2OwuFOOcPOQPiiiey1RKQwk/frt
X-Received: by 2002:a17:907:a411:b0:993:f664:ce25 with SMTP id sg17-20020a170907a41100b00993f664ce25mr4614484ejc.19.1691317945451;
        Sun, 06 Aug 2023 03:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESzQWHnFfyI5bgHFpjQZloinuZVS9nIgY+CUw7mYR0Dylf4VkkB9S4DfgATvf/u3MzxRBI9w==
X-Received: by 2002:a17:907:a411:b0:993:f664:ce25 with SMTP id sg17-20020a170907a41100b00993f664ce25mr4614474ejc.19.1691317945159;
        Sun, 06 Aug 2023 03:32:25 -0700 (PDT)
Date: Sun, 6 Aug 2023 06:32:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Message-ID: <20230806063152-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230804095255-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481151EFF6442A93BEFA3F1DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481151EFF6442A93BEFA3F1DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices

On Fri, Aug 04, 2023 at 02:12:41PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, August 4, 2023 7:37 PM
> 
> > > True, for us, at this point we do not have plan to expose virtio switch device
> > because users are not blocked on it.
> > 
> > If someone does though I see no reason not to - we have a variety of devices,
> > switch would be just another one. The motivation would be the usual one for
> > virtio - so there's one generic driver.
> >
> Sure.
>  
> > > > Re:queues - it's not by chance that we have multiple admin queues.
> > > > So driver can dedicate one queue to filtering commands if that's
> > > > felt to be important.
> > > >
> > > Admin queue currently do not send non admin command of the device.
> > > Would you propose admin queue for something else also for rtc or console or
> > cryto device and indicate its role so device can understand what is coming to it.
> > 
> > Well, I guess this switch has group members as its "ports" so maybe that makes
> > it like an admin command. Again it's all up in the air too much to be able to
> > judge.
> 
> Flowvq is needed for non switch device too.
> It has advanced to design stage now, its sad that you are no following it.

Frankly I didn't even understand that's what this is talking about.

> Anyways, flow operations is not a admin command.
> I don't find admin queue suitable for self unless we modify its definitions a lot.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

