Return-Path: <virtio-dev-return-12696-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ADDC77B7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:56:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0F33E42A6B
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:56:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E331D98651C
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:56:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CFE4F9864EE; Mon, 15 May 2023 17:56:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDD2198650E
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 17:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: nLni8f5vOW6QJPeii7iQ0w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684173383; x=1686765383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWWnmNtYgCYWDwaAKkwkcEp4iDKHl93bpjdnlnoMZ5o=;
        b=CZJ7ck89Mb1nj5Wa3tziVuKq/iMAZ6DNO2Oygs5P80pnovfS85iLbVH/LtdKS/9gyH
         wYeHoDZ5yzPukNVZYOOmOKZ0k8hu65oBdNOlieWMD7uHeXWLX4eCN0i5GZHFmFxSrWlr
         NgnaxXNKkazw/RMP5zzcl79kHluwUXXLtfTRMulJcpiytLECBbH/ZzveRsZYvAz/YW34
         6c8Vzet9DO1NgEGAhM9lxdtYxCvg5mO2oqDbydTiGnTSBY6ha0PDKwyAko27E1xA0Wrc
         cUHGEuc4KyewKJvltT9h9s5vUAmWPsLLm7WMqlPdgRboami4jo86dv/pxFZ+0n/xUc/4
         c6LA==
X-Gm-Message-State: AC+VfDy8C4rhagA3KsOW3Xl2gfVg40nO/4wFTgw9sTylralc5Er8YaQS
	hxiGm99sHz1N6RIwKfliPyi+cUuIhrCVk9sMXQUyyCX5llEGSjeIt42NeLLMt2AyfO+gDRFSq1P
	eO1C34hi/PGoehGMSYxlG9lO7i66/
X-Received: by 2002:a05:600c:1989:b0:3f5:7e0:714a with SMTP id t9-20020a05600c198900b003f507e0714amr4095945wmq.13.1684173383366;
        Mon, 15 May 2023 10:56:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Vf+OC9cKYVafl7xxC8eHcWfIG2UI4lwRShGPuBLT1LzDN4DrN6iElFJNOoa67fI1nU9IqjQ==
X-Received: by 2002:a05:600c:1989:b0:3f5:7e0:714a with SMTP id t9-20020a05600c198900b003f507e0714amr4095929wmq.13.1684173383024;
        Mon, 15 May 2023 10:56:23 -0700 (PDT)
Date: Mon, 15 May 2023 13:56:18 -0400
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
Message-ID: <20230515135513-mutt-send-email-mst@kernel.org>
References: <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515133719-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Mon, May 15, 2023 at 05:51:05PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, May 15, 2023 1:45 PM
> > 
> > On Mon, May 15, 2023 at 03:49:44PM +0000, Parav Pandit wrote:
> > > All legacy interface via AQ.
> > > All modern interface access via PCI or its own transport between driver and
> > device.
> > 
> > I am wondering however about the hypervisor notifications.  Generally these
> > are the most problematic aspect here I feel.  For example, how does it interact
> > with VIRTIO_F_NOTIF_CONFIG_DATA?  And generally, having both guest and
> > host be allowed to access device's BAR seems problematic.
> > Can we reserve a PF BAR region for these things or is that too expensive?
> 
> VIRTIO_F_NOTIF_CONFIG_DATA is not present for the legacy.

it is not but it just might be required, or it won't be there.

> For modern device, guest driver will access the device own BAR directly with its own config_data anyway.
> Should we reserve a region in the PF BAR for SF/SIOV device?, should device report which BAR/area to use for the given SF/SIOV device?
> May be yes, those are different discussions with tradeoff to consider during SIOV discussions. It is not related to VFs.

For SIOV it's a given. But we can do this for SRIOV: reserve a PF region
per VF.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

