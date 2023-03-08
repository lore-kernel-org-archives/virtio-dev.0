Return-Path: <virtio-dev-return-11538-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7FEC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:30:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E64392AEDF
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:30:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1F939866FC
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:30:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A85119866F0; Wed,  8 Mar 2023 16:30:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 956929866F2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 16:30:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: X9p4qpjbPIORNhQaEVTLZQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678293026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDsU3IQnVwpATYkXoKJ8Qw0OvII2PbE5ToGOeKuDk6Y=;
        b=UDgRwqlFSJmQIzTtVHnjzR4pENxecK6j8ETT4icgiWLHIyqjLegEtDrtHPjOom+OnI
         0mWxZb4/JzlDJqiroUjOIqUAuiDthsIaFJzkYlgfbhgkjc9VY9eSS/w+wLsXE95nnbwF
         wZauwphVpLZbxicrlMcEPRAVPbcmEkp8w13BKM/tk3nNLC+zpotDfU+IGHoPdogOg1RG
         PSCbl1GKc4WYmudHlb8EX+XaAXgh/XN150m/YfT3frDnZojoI5rivGyYxIOHszqbHYNn
         lzDpq5y65yCufKIQ16JXxxD/pdcpBFVmgwCpFpx4Sa7iKYrZkeK6qc26nSt9DlB1VO2z
         PKTw==
X-Gm-Message-State: AO0yUKU5G/lZdfNMShsV4SumsNe29Bg0qCzT7kp0tSgX2+wm5eSNOCYN
	6vvPJIfZt3rL3PcmOzkdLrYmaNW5gWTTP6ZR3YTrNbIbC40BBC7rFE0smUwIJIXaCzzwuVF+PVX
	OarJ24TXDQBjj9GPH2cz54LCNOdMq
X-Received: by 2002:a17:907:80e:b0:8b0:f58d:2da9 with SMTP id wv14-20020a170907080e00b008b0f58d2da9mr24360741ejb.64.1678293026626;
        Wed, 08 Mar 2023 08:30:26 -0800 (PST)
X-Google-Smtp-Source: AK7set9gufTkbEaEF/UQXAcBV2+nY0tEhyxHBA2K2oEpaX4DmaHHxyajwK9X1zHpvi4GJvZV7DDysg==
X-Received: by 2002:a17:907:80e:b0:8b0:f58d:2da9 with SMTP id wv14-20020a170907080e00b008b0f58d2da9mr24360710ejb.64.1678293026380;
        Wed, 08 Mar 2023 08:30:26 -0800 (PST)
Date: Wed, 8 Mar 2023 11:30:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308112854-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303032434-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819AE477640508DCFF8333DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819AE477640508DCFF8333DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved

On Tue, Mar 07, 2023 at 06:52:03PM +0000, Parav Pandit wrote:
> > And I wonder whether it's worth it - it definitely makes contributing to Linux
> > harder, and even within Linux it pushes contributors away. 
> The number of virtio spec contributors are in order of magnitude less
> than Linux kernel or just the Linux netdev.  Patch split up reduces
> lot of time author and reviewers.  For example, interrupt moderation
> at v10 can be very easily split up where prep patch can have RB tag
> and v11 doesn't need reviewers and author's time.  Your work here with
> 10 patches is yet another good example of it.  I remember Max and I
> started with 6 patches... and current 10 are more useful way to split
> them.

It's a big project though. All I ask is that we try to be gentler
than netdev to new contributors. If there's a 10 line patch it is
not necessary to be pedantic and ask for it to be split up to
a 3 patch series.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

