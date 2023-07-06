Return-Path: <virtio-dev-return-13283-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6AFEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:43:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B722842569
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:43:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CBB19867EB
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:43:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7479598672E; Thu,  6 Jul 2023 19:43:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F4409867B6
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 19:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lgKIPAKdNGCnE2Z3B-tPeA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688672578; x=1691264578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+2CQXqEVlaO5hax9XcrzEzvVQI5ZaNbs642SYGPfLc=;
        b=LCHkc6M+2NyVnthquCNaQZ+pWnw3Ttqcb62WQpIkEe3MXcNReaWFW/zcwIFFJYBaFN
         d/+0b8LfJ9Tfadrbubex6qocmtn2zQC6vAHpT3FWj6GvW/j9T8IFPbFaX/K7ki3kTbVi
         RfRXzyQ65/uiN7uudPPl9ox+kd61xLbuoWXoCVxzo6q9Xuo1UtKPFMpjLYr/r+Na1+Ow
         DZhdTYi0g1MujOLqVeTiVa5Fl6dCwaI7cUJKky/pamdy5RXsnmAnFromYugRRCwY5tgO
         R74YpL4kszzLFLGmmgWaNYwZgCgy5DlgcI0lMoSGyjqlo8dISBVZGX7huJRoSMRz8PBB
         UGDA==
X-Gm-Message-State: ABy/qLYRmrmEJU1sgTQFFeUe7lvRxnNwUu1ZLaIYlhlVoNtMRIvSOo7u
	U2ul8atKobWUiKoP2fA7U22ktr5aGVPNngWUkFKBIWKeYbsBm0tBPx99Pxvmo/mSkdzBvyzh8+L
	1qk5umePdSRKfcit77HfYohDNStHi
X-Received: by 2002:a7b:cd1a:0:b0:3fb:c075:b308 with SMTP id f26-20020a7bcd1a000000b003fbc075b308mr2915258wmj.12.1688672578090;
        Thu, 06 Jul 2023 12:42:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH79j6OETqx8RY1N/gz9qbl2mLAHb8Je4w208XbKAzoLac5qlqz2GN221sRipecRoXxE/18yQ==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:c075:b308 with SMTP id f26-20020a7bcd1a000000b003fbc075b308mr2915247wmj.12.1688672577808;
        Thu, 06 Jul 2023 12:42:57 -0700 (PDT)
Date: Thu, 6 Jul 2023 15:42:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230706154002-mutt-send-email-mst@kernel.org>
References: <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706145538-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06, 2023 at 07:00:22PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, July 6, 2023 2:57 PM
> 
> > > I am just saying to keep things simple. Let driver choose any entry it wants to
> > use instead of device deciding on priority and hints etc.
> > 
> > Let's say driver can support both types which to choose?
> Any entry that driver likes.
> 
> > As the order is there anyway, why not just prescribe entries are used in order?
> 
> I don't see any value in defining any order. It is an array of entries not a priority list.

I think we are losing out. For example I can see how
access through member would be preferable for ordering reasons.
However device might still allow access through PF for cases
where driver can't access VF.

But I don't see any configs where leaving this to the driver's
discretion is preferable. If you see one let me know.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

