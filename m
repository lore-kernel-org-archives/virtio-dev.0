Return-Path: <virtio-dev-return-13279-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2816BEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:56:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5FC0D2CAD7
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:56:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F801986809
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:56:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2810298672D; Thu,  6 Jul 2023 18:56:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12DDF98672E
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 18:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Pqr_YpMDNqSj9Ac-ORNHNw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688669799; x=1691261799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcO3U2h5rLYnxkUt7tittJnrclDlKtj/UvJ51m6XIVc=;
        b=Ui1cJ/qi7MRHrOPnWBskySdxxUiXOUIbBNGE96Vj6CWWtPbxIIygSlH1gVLuZulnP4
         Z5JaJW+pbyKwEPxdJkZDz1b48cOYWMWoiH63+2CLHx2/jfpA0w6FOB5n+QDJ6fByZoRE
         nudtCslKWUEcCqkuAgZmfQsXsjlDeO5epmQdOF8vetgLtdCPwi+l4FtdWGDTBhcV8N8L
         nQn5z7qv0++OzwFyPyV/SM9vCsd1zeG8nAu7c8Czjk0uvK5SNAllz9gPyDBY9zDnP9kt
         q9DC/h1YVrmMIWoby9kDBBYit2T7CbsFu4Yq47k4akFfgcXydR1hTjkKVbpRmAmKSGo2
         q5Gw==
X-Gm-Message-State: ABy/qLbZ7P4svZCnvr4ciURuS5wJiDMtvJ6tdS2eELGUlv9Jf6ZN00wf
	CN3n05qWhyUOl0cNGOyoXCEZiSbAKvZsXBUR8kfkFvQ2ByGTdhQ7C0JoMjIbxP0pSrSGqocsUx1
	vEaC1lcrs3guAKrdxdyPIb5AhlAbe
X-Received: by 2002:a05:6000:100d:b0:313:ef24:6ff2 with SMTP id a13-20020a056000100d00b00313ef246ff2mr3362582wrx.2.1688669799100;
        Thu, 06 Jul 2023 11:56:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFlqFbsn0GaXHY8VLTSWoaaGeVm/0iyYS8r4bP81T9SjOPYnPyeJODhGzmS4f+XVUhOo1d+4Q==
X-Received: by 2002:a05:6000:100d:b0:313:ef24:6ff2 with SMTP id a13-20020a056000100d00b00313ef246ff2mr3362564wrx.2.1688669798742;
        Thu, 06 Jul 2023 11:56:38 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:56:34 -0400
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
Message-ID: <20230706145538-mutt-send-email-mst@kernel.org>
References: <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06, 2023 at 06:53:55PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, July 6, 2023 2:48 PM
> 
> 
> > > The driver of the owner device can send a driver notification to the
> > > member device by executing
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > > with the \field{offset} matching \field{Queue Notify} and the
> > > \field{data} containing the virtqueue index to be notified or by
> > > performing memory or I/O write in
> > 
> > split to two sentences please. E.g.
> > Alternatively, the driver ...
> >
> Ack.
> Moving to it dedicated para, as in this first para the notification region and command is not yet introduced.
>  
> > > the any of the notification region at offset 0 supplied by the device
> > > in
> > 
> > the any is agrammatical
> > 
> > > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO result.
> > >
> > > > Please also call out the unusual configuration where the type is
> > > > "member" and then you have the owner driver access the memory of the
> > member device.
> > > > People might be confused.
> > > >
> > > > I also think we should explain that order of entries is a hint to
> > > > driver: use the 1st entry that you can.
> > >
> > > Driver really can choose any valid entry out of the 4 that driver likes.
> > > I really don't see a need for overwriting this area as I fail to see why one will
> > expose multiple entries from the device side in reality.
> > 
> > I do: one for owner one for member.
> Yes, I am aware of choice or multi-entry. :)
> 
> > which is best for device is device specific.
> > 
> > I don't know what do you mean by "overwriting". Explaining in detail?
> :) being too verbose than needed.
> 
> > You feel like this because you spent a lot of time thinking about the area and
> > there is a specific solution is very clear in your head.
> > First readers are not like this and second they might have a different solution.
> 
> I am just saying to keep things simple. Let driver choose any entry it wants to use instead of device deciding on priority and hints etc.

Let's say driver can support both types which to choose? 
As the order is there anyway, why not just prescribe entries are
used in order?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

