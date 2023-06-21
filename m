Return-Path: <virtio-dev-return-13028-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DFFEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:37:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C00C92AFFC
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:37:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3FB49865E3
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:37:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A7411983DDB; Wed, 21 Jun 2023 20:37:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 934F39865CE
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 20:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: H-ClxbAGPUyPFCoMeXHc3A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687379869; x=1689971869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5190ZnbF624Vm1OnBx6QTgUOLS/i+r9tFNgxzjsbfmg=;
        b=P5sa2G3uaCy74JwmWX+BjKEGH05r0ZQVcPj+Md4DHR9U4wJJjxFckoH1gNUGDq0mLq
         K2PYKnG9awBRh/yDk6D1FAaS/kK3jTBRG8BA6jWneej1SQDWKZwEKoV4TJUnPnBBvTxq
         oUtwWHV7S2wl8nUTsQnscW+8da6VhdsSxrYRdSx1TYvqQQqxWfXJDnXisvjuBzhYpmb2
         j5BYY80iTSjB34iAn2H+l3DMxExmebjE8fXtB4INl774/pi0NlpisrUFPwVixIEO7rgV
         qr/1b4tulkBnsNgG9oVx17tfZHbkZNwcZPm+4O3h9oJlJXjaxxMPn3yCiyjzdGE0OXmS
         5HoQ==
X-Gm-Message-State: AC+VfDwiQJSnDiFdsBhsxNVOPbmTxucm+suHPdFn0HU3f7dXP+X7EMCJ
	q55gi96mEGH2LFOMtSwhwx+KdZ7wiQzqOrLNLGB7ZPBRFY1x7KDIRYB9UX1Yxr70a9YJiAIwT7n
	01f0woDc9hhhDRuk3+mQ+gkXn0aVT
X-Received: by 2002:a17:907:8688:b0:973:e349:43c8 with SMTP id qa8-20020a170907868800b00973e34943c8mr15485914ejc.69.1687379869468;
        Wed, 21 Jun 2023 13:37:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RF0VondWtNjhj+VqooOtS0uXoJNA5+aPh11dTspLsNLZAMD/dJ+F65YNcSgNshYhgdvqjJg==
X-Received: by 2002:a17:907:8688:b0:973:e349:43c8 with SMTP id qa8-20020a170907868800b00973e34943c8mr15485905ejc.69.1687379869102;
        Wed, 21 Jun 2023 13:37:49 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:37:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230621163116-mutt-send-email-mst@kernel.org>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 21, 2023 at 08:24:57PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 21, 2023 4:17 PM
> 
> > 
> > and actually I missed the fact that instead of making this symmetric it forced
> > separate structures for GET and SET.
> > 
> > If we move supported_tunnel_hash_types back to config space then GET and
> > SET just need the active bitmap. *that* seems symmetric to me.
> > 
> > And the field is RO so no memory cost to exposing it in all VFs.
> Two structures do not bring the asymmetry.
> Accessing current and enabled fields via two different mechanism is bringing the asymmetry.

I guess it's a matter of taste, but it is clearly more consistent with
other hash things, to which it's very similar.


Nah, config space is too convenient when we can live with its
limitations. I don't thin kwe prefer not to keep growing it.
For some things such as this one it's perfect.

For example, for migration driver might want to validate
that two devices have same capability. doing it without
dma is nicer.

Another example, future admin transport will have ability
to provision devices by supplying their config space.
This will include this capability automatically, if
instead we hide it in a command we need to do extra
custom work. 

> So we do not prefer to keep growing the config space anymore,
> hence GET is the right approach to me.

Heh I know you hate config space. Let it go, stop wasting
time arguing about the same thing on every turn and instead
help define admin transport to solve it fully.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

