Return-Path: <virtio-dev-return-13316-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA4DC001B0
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 14:17:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 24B802A8E7
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 14:17:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FCA498680B
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 14:17:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 118D6986809; Fri,  7 Jul 2023 14:17:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00E8598680A
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 14:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jXmZbgDnNsmek-uMpjVzoQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739434; x=1691331434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZK1X8KznYDLdvXj5OUdkKI6QK4INi1nKW3S1+m9RxM=;
        b=XVDSZrpwoU6pHihOaGcBOBftrUNuxtNDezXIOqo991TqRyg0It70WZHhF3znisLoW7
         RzlUJZO8HquVTBJv0DnsiU3Ku6fdtNqrdUUGFZfvb4ZBWHdWMK+QhfvdGtgYfBoGZaIc
         r9ne5V88U75s+69wqg2og77q+OvEyS679rcsHhr8IbvpS9dwqcLxqc+MrSNsXAoNW5Wv
         xoYjmhzuMdwOlQ5iFm5XUP4U0KA7gx/scuzJF5b+jOH7mAh74dxwrBITuPA7YjQjpo6G
         RtaVo9SKSmbVGlHVTAIAWoNfKcs65owoNwI7/YKdczArOb0LrPjOAh21IENnfNMZ33O/
         4JyQ==
X-Gm-Message-State: ABy/qLZslOC5eEnV3EU54wL+eUHOSgcHg8ZIzC24gBv3y5J5PrV7YdOC
	S5uMnBPSAh8Z90gu6Kc2D7Srmax2t5//rjt91ShjcFV4izgfFJNY3IHsqzXz9/MyCp2a22aYXU1
	Swn7lhA8LRXs7kZ+mf3erZe7nHXWh
X-Received: by 2002:a7b:cd93:0:b0:3fb:a1d0:a872 with SMTP id y19-20020a7bcd93000000b003fba1d0a872mr4055199wmj.20.1688739434626;
        Fri, 07 Jul 2023 07:17:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBo1iphkLDFMKmmuM4NIPSyL0ZpwtWd6NynAg6XG/eyIryI0gfElOopgsWuwRRpgTrYz4x+Q==
X-Received: by 2002:a7b:cd93:0:b0:3fb:a1d0:a872 with SMTP id y19-20020a7bcd93000000b003fba1d0a872mr4055184wmj.20.1688739434286;
        Fri, 07 Jul 2023 07:17:14 -0700 (PDT)
Date: Fri, 7 Jul 2023 10:17:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230707101650-mutt-send-email-mst@kernel.org>
References: <20230707035401.107855-1-parav@nvidia.com>
 <20230707035401.107855-4-parav@nvidia.com>
 <20230707043229-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B9E319B41225FEAE3BE7DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B9E319B41225FEAE3BE7DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v12 3/3] admin: Add group member legacy register access
 commands

On Fri, Jul 07, 2023 at 01:26:56PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, July 7, 2023 5:31 AM
> 
> [..]
> > > +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the driver
> > SHOULD set
> > > +\field{offset} and the length of the \field{data} to refer to a
> > > +single field within the virtio device-specific configuration.
> > > +
> > > +If VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command is supported, the
> > > +group member driver SHOULD use the notification address to send a
> > > +driver notification to the device.
> > 
> > No group member driver is not involved.
> Ok.
> 
> > Just say the driver. And "driver notifications" - you want this for all of them no?
> > 
> Didn’t understand the question. 
> Do you mean "all devices"?

all driver notifications.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

