Return-Path: <virtio-dev-return-12844-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB58EC7EE29
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:56:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0AEF4C6114
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:56:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0F91986337
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:56:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E42C99862CE; Sun,  4 Jun 2023 13:56:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D36D49862D0
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Jun 2023 13:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VmKHs6ijO36Il7WgNfmyPw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685886962; x=1688478962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0PtU9a5lwTnw+yFYgkBZAELoZ/SrDkywiPhOBgla4w=;
        b=GFC2aMyDHZ6dUsCZpUWisYyn7vBOQ+gWBcfvchhKx0SOAlTM5NEiyfeBNGYxy2lu/W
         tU01PZalkBD6Q8bD95SWwrGCygxcHirGeAYm4HS2LIGaEx9GmK9mYZzGhSL/mAwWEgNm
         IL2dWBc8lKRDxXDkjNA+/EEHjwA08x4/EiR/+Qr+Z6NVC+VwZcq+MGivjoJkzJ7F9ZGP
         ZxdR05COvqrGeMP9DZz+2ye6vnCwZH4e9uIWXduo9lNbzs0dQ5IEzmVXF+x1Ij+HxddO
         czcxPMLtR9NGnbghwmKCRfi3YNH2Yb8JeUg6dN0eIrooyZV+UuKcnAZEAIRQ12A6nAcu
         KnAA==
X-Gm-Message-State: AC+VfDypxjo9zfuFZ6QMrMnDzlTIlH0DcI5dSZJZ2U5dZq1xDZJSlv10
	bDcm+iiDQlHu0N/WZe7G/C0VllMn/FxD+9mQliDYfpuY/s87ZqHsE/7JLLwBIRnuSgvOtQJQ2eW
	m89pqL4pC5/oPF3qVfNCfaKzQl5cb
X-Received: by 2002:a2e:804b:0:b0:2ac:7d7e:a503 with SMTP id p11-20020a2e804b000000b002ac7d7ea503mr2594287ljg.36.1685886962038;
        Sun, 04 Jun 2023 06:56:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PXqZlwtLuuFDBm9TP79xVscMTqt0LhJ6woyt26oe7NrRUh9LwV3KB9BfeqoGUwdQKWfwY7w==
X-Received: by 2002:a2e:804b:0:b0:2ac:7d7e:a503 with SMTP id p11-20020a2e804b000000b002ac7d7ea503mr2594272ljg.36.1685886961650;
        Sun, 04 Jun 2023 06:56:01 -0700 (PDT)
Date: Sun, 4 Jun 2023 09:55:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230604094535-mutt-send-email-mst@kernel.org>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

On Sun, Jun 04, 2023 at 01:41:54PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 4, 2023 9:34 AM
> > 
> > On Fri, Jun 02, 2023 at 11:36:01PM +0300, Parav Pandit wrote:
> > > This short series introduces legacy registers access commands for the
> > > owner group member PCI PF to access the legacy registers of the member VFs.
> > 
> > Note that some work will be needed here to fix up grammar and spelling
> > mistakes.
> >
> I already verified using codespell but I guess it missed few.
> If you have specific already identified, let me know.

I remember seeing something about a drier somewhere :)

> If not I will run a different checker.

Yea, pls check grammar too.

> > > If in future any SIOV devices to support legacy registers, they can be
> > > easily supported using same commands by using the group member
> > > identifiers of the future SIOV devices.
> > 
> > Yes, with the exception of
> > VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY - currently refers to VF BAR,
> > subfunctions do not have it.
> A subfunction will also have its own BAR carved out from the PF BAR.
> A subfunction definition will be as contains as possible.
> 
> > Can we find a way to have it in the PF BAR instead?
> At subfution level also it will be a BAR number, which will map to the PF BAR.

exactly. why not support this for PF too?

> > E.g. the notification can include VF# + VQ#?
> > At least as an option?
> No. we discussed this before to have each device on its own BAR. Hence no VF# in the doorbell.

you said that you want it but without much in the way of
explanation. I'm still not convinced it's a workable interface. Will it help
if I get some feedback from windows driver team on the design?

> > If not can you add some info explaining why not?
> Yes, Good point.
> I will add the commit log explanation that every VF has its own BAR hence it does not use PF BAR.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

