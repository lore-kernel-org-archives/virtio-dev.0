Return-Path: <virtio-dev-return-11717-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF0C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:53:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8BFFC8442F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:53:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 880B598646D
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:53:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7E4B8986450; Wed, 22 Mar 2023 16:53:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E1CF986456
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 16:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2kyGWyBOOo2oKcJ3jmC4Aw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnICd+2COAiNCYaGUXzuaNjX8uOlmsLgwvvcqjYHdCc=;
        b=fvA2XT05y1dTStcc0YxglahMoKbpxgCEEP9UnfpfGDImkcPk5mBQwttTFCcHDKb688
         EupjUkEhgqWGNGdNvskxTpPvI7MPHbRBEDZIMMCURI2wQ4lWMvLxxJRSHm9c7ZmIt08V
         9wZmnY7H+v8oOxAg3xFLMZPf8KLlx3znBHm7npMrDv8gLKSTbwyBhcBbQDOiz/heYkft
         bhTNSQIqfgP7OFc0pPBib/YI8tlopcCSyGV9nJN44ky03b7x0IcfBcJSElUjR84scURj
         SYb/ApTK5pYeRVqnEjGtlZlHfIgy7lnCGUrAIVMH/5Koa9iV5jCiO4uz63KPZk5cSvdQ
         U7Yg==
X-Gm-Message-State: AO0yUKXuEncWc8/rVC50W/wB/jbhWKm6HUSx97U9Tt77J0Lm+495dXsE
	85QS5p7Ry9WFkWJsGT63Xabl3y0wzLVW57lBYE3nAD4q5yUPqCTvq6VSVxFernT03//+QEx6JY1
	7h3gktUVgvGQloKhNZfIzgY7IOBfD
X-Received: by 2002:a17:906:a855:b0:931:8e8c:2db5 with SMTP id dx21-20020a170906a85500b009318e8c2db5mr7599611ejb.69.1679504010619;
        Wed, 22 Mar 2023 09:53:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set+aTfvYprcWYRljW5GlaXu8PK7R4q4bDkFvhBB1kkTUKYIgrLnLYLOahX949+ZWv8nxio4YKg==
X-Received: by 2002:a17:906:a855:b0:931:8e8c:2db5 with SMTP id dx21-20020a170906a85500b009318e8c2db5mr7599587ejb.69.1679504010320;
        Wed, 22 Mar 2023 09:53:30 -0700 (PDT)
Date: Wed, 22 Mar 2023 12:53:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230322125058-mutt-send-email-mst@kernel.org>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87jzz8hh1w.fsf@redhat.com>
 <20230322124508-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B3FD31F529EDF420FACEDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B3FD31F529EDF420FACEDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation

On Wed, Mar 22, 2023 at 04:49:58PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, March 22, 2023 12:47 PM
> > 
> > I agree with Cornelia here. Yes if devices do not want to trust drivers then they
> > will validate input but what exactly happens then is currently up to device.
> > If we want to try and specify devices in all cases of out of spec input that's a big
> > project, certainly doable but I would rather not connect it to this, rather
> > boutique, feature.
> Both of your and Cornelia's comment is abstract to me.
> We cannot change past.

But we can make sure things are consistent. Currently we don't describe
device behaviour if driver is out of spec and I see 0 reasons to start
doing it with coalescing commands specifically.

> For the new command of interest here, hen driver supplied incorrect values, the device will return error.

It might be easier for device to just set NEEDS_RESET and stop
responding. For a hypervisor implementation that's often better than returning error
since device state is then preserved making things easier to debug.

> How to implement is upto the device to figure out.


what to do is also up to the device.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

