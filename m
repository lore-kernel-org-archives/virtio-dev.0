Return-Path: <virtio-dev-return-13277-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4A4EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:48:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71DEA2B001
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:48:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C766986812
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:48:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4EA8E9867F9; Thu,  6 Jul 2023 18:48:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3999B9867B6
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 18:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lhBORcQhOlGmbcbuEDx_5A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688669294; x=1691261294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjfjZVWSlngd4gtvSlwlXKF7D4wZoY5p32iW6lqxKmU=;
        b=leQP5g8JFpkzGE2kI/ClnssscR8XKJXGo5AxuIMv02aWNe3H0DfZcoO/rWuBpJGFzC
         b6VVY90tm8nczibBPWZwbXEnNPGTG5tg4rUCygwajA2Kr+CqjwagbHE15+gWO880T2wA
         awTVG4dU6D8mEMBob0rG4DczNm/Mya/3q81wrRi2bmzxZJTr6ygmAb48jptbBlFkIZ+q
         qcm7iKQEYWNuYwDE1y8fkkT3041k5AgsNENZOu3gwfSMrBB38Wt138xeKz0a96xQv+JT
         RcJ80hqiAAgNDaiyxd0H/nj2ScwkObi6TO90UdkbOUU+Skw7EktZfSvYFYSMs9ZtAFU9
         eQ3A==
X-Gm-Message-State: ABy/qLYbsa+TDuxv0kv8IEesbsR6R02XwnIiBPfZKGpXfcMsoYpEOWlz
	2GJTFtaXkw/EFMzIUJUSWpLQTroqzzEPNNdyS80emvkfeVz6AG5J5Nzv6AQx+t+rw4DQ2kIi4Pp
	I6V2t1Tp6nTDrETxqaOvyYzT/SUDK
X-Received: by 2002:a05:600c:2146:b0:3fb:ef6f:9231 with SMTP id v6-20020a05600c214600b003fbef6f9231mr2194923wml.11.1688669294538;
        Thu, 06 Jul 2023 11:48:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNn8TGpim/xVY30phY+7wtLU1t35cMbnWE/KzQ6TScTX1qRo6Xg0SSs4XjRnPOQCvNgJvB3Q==
X-Received: by 2002:a05:600c:2146:b0:3fb:ef6f:9231 with SMTP id v6-20020a05600c214600b003fbef6f9231mr2194903wml.11.1688669294225;
        Thu, 06 Jul 2023 11:48:14 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:48:10 -0400
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
Message-ID: <20230706144427-mutt-send-email-mst@kernel.org>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
 <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06, 2023 at 06:16:10PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, July 6, 2023 2:06 PM
> > 
> > But again even if you add it there, you can not claim it's exactly the same as
> > legacy because the address is different, the address type is different, the driver
> > is different (this is owner driver) and even the device is different.
> > 
> You drafted below, that I included,
> 
> The driver of the owner device can send a driver notification to the member
> device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the
> \field{offset} matching \field{Queue Notify} and the \field{data} containing
> the virtqueue index to be notified.
> 
> We extend this further by saying Queue notify notifications is sent via MMIO as,
> 
> The driver of the owner device can send a driver notification to the member
> device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the
> \field{offset} matching \field{Queue Notify} and the \field{data} containing
> the virtqueue index to be notified or by performing memory or I/O write in

split to two sentences please. E.g.
Alternatively, the driver ...

> the any of the notification region at offset 0 supplied by the device in 

the any is agrammatical

> VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO result.
> 
> > Please also call out the unusual configuration where the type is "member" and
> > then you have the owner driver access the memory of the member device.
> > People might be confused.
> > 
> > I also think we should explain that order of entries is a hint to driver: use the 1st
> > entry that you can.
> 
> Driver really can choose any valid entry out of the 4 that driver likes.
> I really don't see a need for overwriting this area as I fail to see why one will expose multiple entries from the device side in reality.

I do: one for owner one for member.
which is best for device is device specific.

I don't know what do you mean by "overwriting". Explaining in detail?
You feel like this because you spent a lot of time thinking
about the area and there is a specific solution is very clear in your head.
First readers are not like this and second they might have a
different solution.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

