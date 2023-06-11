Return-Path: <virtio-dev-return-12928-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D93C7EE23
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 07:15:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1139F2B04D
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 07:15:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1D19986418
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 07:15:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF3A89863DE; Sun, 11 Jun 2023 07:15:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A44689863E4
	for <virtio-dev@lists.oasis-open.org>; Sun, 11 Jun 2023 07:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ok8r0fm1MOKwZQ5HZY7msQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686467698; x=1689059698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YssArbGEB5+rCQgRAMg1b3Zvrj46AmNDB2i8uPNZnM=;
        b=N5ujGG/C/cVB8FxWVaJTu+hR+7p3BrUxl9L8DbWWgpo38UWwqx89AYlo00eyk49o5q
         j5aNlWjlJDZHZi5p+yzRJJS6+VMZvdsFB5+u6BGKdyiz8GIJCy+LbEYLB76hX+xkxQrQ
         T0zx27zNz5K6c1uIQf3vlYOD3OLOCOiWHjGw+UOmMPAKkQPIvv82mNAirhsVBMY8mVeZ
         /lOOGgnlow7OieH/zqNgItQ77Glp0mpm+9eoYnWy/LP7Qnj6RABCRnKRDHYenAvbrIvL
         7mgsmHE1ezBkvbPh8pq94SU3nONqWCvEr0+1dsMbtiItw58CG6D+vby89E6LCHBk0y+B
         CrIg==
X-Gm-Message-State: AC+VfDzp6SDav9TJcJ0G6r07xwLa+Tq27gbp9cckovDcj/LhxIrGHyGD
	LUWKcuR5UR0Ma47KHGHntr4J1HWIYTtqqIqkb+EarKrC+dAIVmLljA60TWaRAca/WZxmLoMVtpP
	/jDhA4nEBhQFmpTkyyOSzsHaTEWoP
X-Received: by 2002:a5d:5254:0:b0:309:3bb5:7968 with SMTP id k20-20020a5d5254000000b003093bb57968mr2659621wrc.16.1686467697981;
        Sun, 11 Jun 2023 00:14:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5giKGzpNOYoR2K7pMCtfOvI/Ugp2+AH137+eO00Twd3MQNCgdzhMhQR49LoCjJXtfQsUNoLg==
X-Received: by 2002:a5d:5254:0:b0:309:3bb5:7968 with SMTP id k20-20020a5d5254000000b003093bb57968mr2659603wrc.16.1686467697712;
        Sun, 11 Jun 2023 00:14:57 -0700 (PDT)
Date: Sun, 11 Jun 2023 03:14:52 -0400
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
Message-ID: <20230611031129-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230610202143-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54807B410DCF097D0DC969A1DC57A@DM8PR12MB5480.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54807B410DCF097D0DC969A1DC57A@DM8PR12MB5480.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Sun, Jun 11, 2023 at 02:08:07AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Saturday, June 10, 2023 8:27 PM
> > 
> > Interesting this actually violates a spec recommendation:
> > 
> > 	If a device has successfully negotiated a set of features
> > 	at least once (by accepting the FEATURES_OK \field{device
> > 	status} bit during device initialization), then it SHOULD
> > 	NOT fail re-negotiation of the same set of features after
> > 	a device or system reset.  Failure to do so would interfere
> > 	with resuming from suspend and error recovery.
> >
> This is how we have seen mlx5 device and it has evolved now to break free such limitation.

It's not conformant to that statement then :( It's a SHOULD which means
if you know exactly what you are doing, there could be exceptions.
In this case it's a SHOULD because it was added after 1.0 and
we did not find a way to negotiate this requirement since it's the feature
negotiation itself.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

