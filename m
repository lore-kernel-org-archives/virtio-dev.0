Return-Path: <virtio-dev-return-12930-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3AAC7EE2E
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:09:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DD4622A8FA
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:09:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1E3998652E
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:09:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C1185986422; Sun, 11 Jun 2023 20:09:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98F2B986420
	for <virtio-dev@lists.oasis-open.org>; Sun, 11 Jun 2023 20:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: uPPE7IQKNECVr1UAjHuquA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686514150; x=1689106150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z96n8A6w7xyHqxg1cWC5t3Bkr+bu6HR890b9jNDK1lA=;
        b=EhsiSgimfcgSqnjRa+KbiQFyxsxEncy0DwOXYT0OnU6sweUQoL6+n7xCTtN0KYOlCb
         ejQITYGaQneri5fGvV59dEEic7LcTe5uNX316ZefDd0T6Bcp6VxovI4MlBRjmYi2mT0E
         HoTxXapsJ805sueGNsWhbgNSj7bRis1qG9hJXWHCF92W1eVO+pejCv5jeq45OZWSMLeD
         tXm6HT200rOXdnkqkYgFTQVODRXc/lIVqK3bfSvYRcgpNscI0ZuGu7F+2rsop5gf3nzp
         alzL4a3bP4IPwYfhk+uus5MIiQ79xsN5Zgjir/Bf2F+g2G//5GoZG5UWTy9ayUcxa46M
         ux5A==
X-Gm-Message-State: AC+VfDxANFBJ55IKzYMgj8bZ1Wrew8QtKuDGIWQT12EQNQHGg50Y3Jxz
	iDOHBDyZSZ4WTO8A/mRX+cUtQgintlv5b+vFeXrZXCGe/5q+V5kGQUK+36lXszRfW/C/jlzUEjG
	j9VK5ZsTeNnzyTlCqoo7zyyalE6VF
X-Received: by 2002:a5d:444d:0:b0:30f:c4fb:645a with SMTP id x13-20020a5d444d000000b0030fc4fb645amr11206wrr.18.1686514150646;
        Sun, 11 Jun 2023 13:09:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tIWmAKyURspBYraMQ0SsOv4S9xEf55S05iHOv1io5ZFbDB7LsJXhCucOd39SQIn7Uq53vog==
X-Received: by 2002:a5d:444d:0:b0:30f:c4fb:645a with SMTP id x13-20020a5d444d000000b0030fc4fb645amr11199wrr.18.1686514150379;
        Sun, 11 Jun 2023 13:09:10 -0700 (PDT)
Date: Sun, 11 Jun 2023 16:09:06 -0400
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
Message-ID: <20230611160828-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230610202143-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54807B410DCF097D0DC969A1DC57A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230611031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C7D98AEB2C3328CCF635DC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C7D98AEB2C3328CCF635DC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Sun, Jun 11, 2023 at 12:54:53PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 11, 2023 3:15 AM
> 
> 
> > It's not conformant to that statement then :( It's a SHOULD which means if you
> > know exactly what you are doing, there could be exceptions.
> > In this case it's a SHOULD because it was added after 1.0 and we did not find a
> > way to negotiate this requirement since it's the feature negotiation itself.
> 
> True. May be in future such device can update the revision id.

You can already change it but that doesn't imply anything at all,
in 1.0 revisions are vendor specific.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

