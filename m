Return-Path: <virtio-dev-return-12933-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDE9C7EE23
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 23:15:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D21882A83A
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 23:15:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C50E0986526
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 23:15:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BA18E98608C; Sun, 11 Jun 2023 23:15:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9E81986418
	for <virtio-dev@lists.oasis-open.org>; Sun, 11 Jun 2023 23:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: D3P37rg4PQ6ygqUj3DCF5Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686525319; x=1689117319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL9l8k5UanxFx+liCfq2up/EqCBasjJGeB0QpLpk/ZQ=;
        b=JCg4pEn6s/ia1r8nNDv5JMXALfiDkSlJ+8IeFenpi2srX7W4v/MVjAnW/kMmNDMARe
         epeixnwO8AzUAvqaBn2ezv91BLBpLDPjuU7L710B6dgy2kQ/0twS64UO38BocQ+IOkJs
         W4+63uLW0t/66e5ru7SVGjyI/jTWwq+HrRLCoBOb4K4xbAKmdYQFi0iFxoex/R5N0hbY
         w5foPQMCxMIzVQgsx8uUA5+I+J0YA3jbOyAER9fkU2vymwoFcUvS3iSZ+M05FSIwh2YF
         u+HqTwY/tKXKAMWmF9Tp3uMvaa3OFSHizpoptXvnckpSX8LrU1pl9N8izENY2slqgqzV
         vGeQ==
X-Gm-Message-State: AC+VfDz9GjGdN8vShs7jv8wlp+Af2+8MvCiyLMOP9q8UcNp7U9bYe//6
	jEDD0ljygWIox466DI54Whr4B1fXq6wb90WOE8+zxejMcxzN4j9DNqCE8TlqKp5wnhsrwljFo3C
	0jXurTp5kgw0NXtJtf1cdlcTNeSQF
X-Received: by 2002:a05:6000:4a:b0:30a:efe0:8c6f with SMTP id k10-20020a056000004a00b0030aefe08c6fmr3693275wrx.47.1686525319639;
        Sun, 11 Jun 2023 16:15:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69kaXnrzuKf65ns3hRUokQe0CteppVJQ3x5DBaL2TPBIL/kB/nqxWCZwbkRzdfHHewl8WxLw==
X-Received: by 2002:a05:6000:4a:b0:30a:efe0:8c6f with SMTP id k10-20020a056000004a00b0030aefe08c6fmr3693270wrx.47.1686525319316;
        Sun, 11 Jun 2023 16:15:19 -0700 (PDT)
Date: Sun, 11 Jun 2023 19:15:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230611191138-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230610202143-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54807B410DCF097D0DC969A1DC57A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230611031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C7D98AEB2C3328CCF635DC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230611160828-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817172C727937B70E2FA3EDC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817172C727937B70E2FA3EDC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Sun, Jun 11, 2023 at 08:17:56PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 11, 2023 4:09 PM
> 
> > > > It's not conformant to that statement then :( It's a SHOULD which
> > > > means if you know exactly what you are doing, there could be exceptions.
> > > > In this case it's a SHOULD because it was added after 1.0 and we did
> > > > not find a way to negotiate this requirement since it's the feature negotiation
> > itself.
> > >
> > > True. May be in future such device can update the revision id.
> > 
> > You can already change it but that doesn't imply anything at all, in 1.0 revisions
> > are vendor specific.
> 
> I was suggesting that when such a fundamental change is done which cannot be communicated via features bit or before the reset,
> a new revision and attaching more advance/different behavior.
> This way driver knows what difference to expect for new revision.

But you don't know which revision do existing devices use:
	Drivers MUST match any PCI Revision ID value.

we can come up with a mechanism, several ideas come to mind.
Before we bother, the actual need has to be understood.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

