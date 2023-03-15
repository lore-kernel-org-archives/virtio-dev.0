Return-Path: <virtio-dev-return-11628-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B26C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:00:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9441E44367
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:00:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F202986422
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:00:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 83BFA986406; Wed, 15 Mar 2023 15:00:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73B12986407
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 15:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ECeBQgzJMMuor2mKiy7NIA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678892416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDiID9kHLrgIeFo3E9PItCmx67iPY1YIaRDfBLWsE6U=;
        b=hXUwrd4wFTcAW29PSrscNYF1b2jVAKk5ctocqQs1CEVufcwnCfKefwowRc1UfG7Rpq
         QcCuBF/kvtKTJLhXMNe/Zrby2R3+4oogIJ2GQqpqWxomW5BTJtF5oECOZ16U2AV0Hbck
         KF3p9FpwxOaGPnXYWrZ0b9ta2vpqQMSII4OKKRBUA+Y5jbcrIvkcfWQdCXke/WDXIJYF
         NynNgBYncQP5rBhbppiUKLXUBa+N8lAFzq8ZX6y+pDx1B4n8z4w7/EBd1EoWwRi8oou7
         CduTMTRw440yfcy/mknkBWd4boBa5aELEqDlqfl8LJBxkk7C5wS5VHtq+DxUDqTo/0Mx
         fqQw==
X-Gm-Message-State: AO0yUKXBnzlbrdsoDfid4IaKltUIT37h4GrwS8LAz4EZG4BuUGWtdQsN
	8tO0a69LMb2BjVzMWW/UMiZ0Wv6Mn5QAGXrAbQ4Qz+30uf5yPpjJQkc6zg9hEhsSnWfW1sxGYLY
	0NjILNvuYnO/Bdhu7eqapR5YkGZaI
X-Received: by 2002:a05:600c:5107:b0:3df:e1e9:201d with SMTP id o7-20020a05600c510700b003dfe1e9201dmr17487108wms.40.1678892416223;
        Wed, 15 Mar 2023 08:00:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set/BRsyW6jlht/ZXJuoPmormJk8z4r2sd3ops5fVMIGZD1tLqSPWkMA+8PpsMrjl49i7C7A0tQ==
X-Received: by 2002:a05:600c:5107:b0:3df:e1e9:201d with SMTP id o7-20020a05600c510700b003dfe1e9201dmr17487086wms.40.1678892415965;
        Wed, 15 Mar 2023 08:00:15 -0700 (PDT)
Date: Wed, 15 Mar 2023 11:00:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230315110003-mutt-send-email-mst@kernel.org>
References: <20230223135205.175949-1-parav@nvidia.com>
 <Y/fQl7ImbYGHEtVY@fedora>
 <PH0PR12MB54812629987A9530712C0649DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54811AF45A8A935B17806632DCBF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811AF45A8A935B17806632DCBF9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout
 before its fields

On Wed, Mar 15, 2023 at 02:24:27PM +0000, Parav Pandit wrote:
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Parav Pandit
> > 
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > Sent: Thursday, February 23, 2023 3:46 PM
> > >
> > > On Thu, Feb 23, 2023 at 03:52:05PM +0200, Parav Pandit wrote:
> > > > Define device configuration layout structure before describing its
> > > > individual fields.
> > > >
> > > > This is an editorial change.
> > > >
> > > > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > ---
> > > >  device-types/blk/description.tex | 95
> > 
> > [..]
> > 
> > > Yes, please!
> > >
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Hi Cornelia,
> > 
> > Can you please merge this?
> 
> Any updates?

Pushed, thanks!



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

