Return-Path: <virtio-dev-return-12735-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EBEC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:23:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 201F615B665
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:23:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B22F9865B5
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:23:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0F8569862F6; Tue, 16 May 2023 21:23:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED6489862F7
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 21:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: B9Fa8YExNw2ZfgfAdG_DbQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272194; x=1686864194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiwE6I6eZPfqmqsfjNSEzVfhR2MKhiJ8+DKTUlNd5yM=;
        b=K8oLjISIqzN+8Y5PvEnmeKTOmkW1OUAHHaXVQiCNamPiJ8McLlheIzv4Ia3LyLr9gR
         F1VB9eYfZLjrMTQHngNzyAsXHoMC7jLhVbEUjw9EF7jrOKV8zgQ32DZnIa8tm1XzMc5e
         cOsLiasjX1DUuCYOxU2inwRE2KS30qp9984ah/ZMeozi3YdlWtP1QPhOGdksaCrLRXtx
         9L/UVt74LY/iIT76fCqrymwHMRWqfXERhzqLT0s2BvspnLhIaU7LB9hn/c4ZXlZ1drRp
         JdPtn4hlEKP3gA3w4PdLgqReSOZR595UsWfYpjwFxEV4dfol1asmzJnPTJ5G8x8CgEpa
         erlA==
X-Gm-Message-State: AC+VfDw0qOaUJeOX+KBwcyPhr2xB1f8j1oUUKIEP/EEjkme+bRqhXHbm
	VYvA6NfeoTjs73rBqfHWH+pMw0JZ81/sMedXrLTWfHmyy1yMLYacZOS7MAsjLzMvfutp2go8/uO
	Mgb39XKQxKXf0Yd1XUVObe4wgOqeO
X-Received: by 2002:a5d:570c:0:b0:307:cdfb:b7af with SMTP id a12-20020a5d570c000000b00307cdfbb7afmr56711wrv.19.1684272193876;
        Tue, 16 May 2023 14:23:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5K+NHCHa96iKv7Ma42avRHlF3XMTJ+yp54uNQ4vztog43ryXWY9UMXWwhy1rVRztt+/GfDyA==
X-Received: by 2002:a5d:570c:0:b0:307:cdfb:b7af with SMTP id a12-20020a5d570c000000b00307cdfbb7afmr56698wrv.19.1684272193585;
        Tue, 16 May 2023 14:23:13 -0700 (PDT)
Date: Tue, 16 May 2023 17:23:09 -0400
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
Message-ID: <20230516171940-mutt-send-email-mst@kernel.org>
References: <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <PH0PR12MB548136C3582B9DE232AEFDE5DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516021401-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816BF1E277820C594A6344DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516165509-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EE9429669D53FA8E77AADC799@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EE9429669D53FA8E77AADC799@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 16, 2023 at 09:19:02PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 16, 2023 4:58 PM
> 
> > > > Let me give you an example. I feel that device specific config
> > > > should allow arbitrary length accesses so that e.g.
> > > > mac can be read and written atomically.
> > > >
> > > > On the other hand, this is not the case for common config.
> > > >
> > > Why is this not the case with common config?
> > > Spec snippet: "When using the legacy interface the driver MAY access
> > > the device-specific configuration region using any width accesses"
> > 
> > I mean, what you said above exactly?
> > device-specific configuration excludes common config.
> > 
> > 
> So, what prevents the device to fail AQ command with the error code when alignment/width/size is not right?

Nothing but you then need to specify what is and what isn't right.


> > > > I feel we do not need to allow e.g. access to both common config and
> > > > device specific one in a single operation, that is just messy.
> > > It is just an offset and value.
> > > What part bothers you?
> > 
> > E.g. that it can cross the coundary between common and device config.
> > 
> This is the legacy transport.
> 
> > Look we didn't build modern because we wanted to make work, we did because
> > legacy is broken.  So either let legacy die already or let's build a sane interface
> > to emulate it please.
> Almost everyone building virtio device would prefer for legacy to die.
> I am still trying to understand that why bisecting register definition of legacy makes it sane.

Because legacy common config is very evil, do not copy it.
Legacy device config is only bad in minor tolerable ways.

> Device behaves based on the register offset, is fine for the legacy transport, guest driver will make the register accesses anyway it prefers.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

