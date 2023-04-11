Return-Path: <virtio-dev-return-12155-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CFCC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:29:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 22F2C98B6D
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:29:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0419498651C
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 21:29:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E0AAB986193; Tue, 11 Apr 2023 21:29:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CED5B9864B3
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 21:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9aTYNw2KOkKbbdsP5It2EQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kgALOX7/Uzr2HqMJsh5FF7vXiKDYIMu/Dxb1aE4fA4=;
        b=wmQ+bLvCPU4/5FuKvAdfUV28Ru4RF3KyArvxx7ktd20RjAmhkbkB7OoTygnLWE6hjF
         eVP45s59KtLb/Pi1q10kneLReCsWrPJL4IMxoSFSIPp0Zt/ULFDRYsKZBa2ZvP/FZlM3
         1Ijdb8XHHwcwcZRaXqZKkbenhZKLLpRsv4bvKkFOWz3nDLTQIlX5wDBLvkHJ91woYHzT
         LjhhN4Qcht7zkxr020gSJflAbApaKDAb3gxoIErzZw+nu5g5zFj8Yjc6J8QAiaQ3hVxD
         0WqvTwxgylXSuqVtvZOQCx9NWKiG2NDim2ZcAa+wd5atyYuqFPSOra8VrdmxHRTEaw0s
         Hq6A==
X-Gm-Message-State: AAQBX9eoUBaVI67HCiwb7KwNniZNOQqNPt9RoZ4e76SgTuzjRIkCFxLt
	vvQhi1BqWxymoB7gisd6mtXzDJ5a4wREdn2vAztOoIzj+8SEyYJlflaWOK0rnUnX7xHD2R5HCZV
	fGtzfwpkg3Q581M8+gzl5gMPuPvd7
X-Received: by 2002:a5d:6611:0:b0:2d8:36de:bb79 with SMTP id n17-20020a5d6611000000b002d836debb79mr10880973wru.9.1681248306115;
        Tue, 11 Apr 2023 14:25:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350bLf2SpctvpKAJVPn1x5KZDr8KuRnOcFigWnx0IdFVg1vMiU/rrgJUPj5ov1ykYpShpPR/8lg==
X-Received: by 2002:a5d:6611:0:b0:2d8:36de:bb79 with SMTP id n17-20020a5d6611000000b002d836debb79mr10880960wru.9.1681248305811;
        Tue, 11 Apr 2023 14:25:05 -0700 (PDT)
Date: Tue, 11 Apr 2023 17:25:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230411172207-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Tue, Apr 11, 2023 at 07:01:16PM +0000, Parav Pandit wrote:
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Jason Wang
> > Sent: Monday, April 10, 2023 11:29 PM
> 
> > > However, it is not backward compatible, if the device place them in
> > > extended capability, it will not work.
> > >
> > 
> > It is kind of intended since it is only used for new PCI-E features:
> > 
> New fields in new extended pci cap area is fine.
> Migrating old fields to be present in the new extended pci cap, is not your intention. Right?
> 
> > "
> > +The location of the virtio structures that depend on the PCI Express
> > +capability are specified using a vendor-specific extended capabilities
> > +on the extended capabilities list in PCI Express extended configuration
> > +space of the device.
> > "
> > 
> > > To make it backward compatible, a device needs to expose existing
> > > structure in legacy area. And extended structure for same capability
> > > in extended pci capability region.
> > >
> > > In other words, it will have to be a both places.
> > 
> > Then we will run out of config space again? 
> No. 
> Only currently defined caps to be placed in two places.
> New fields don’t need to be placed in PCI cap, because no driver is looking there.
> 
> We probably already discussed this in previous email by now.
> 
> > Otherwise we need to deal with the
> > case when existing structures were only placed at extended capability. Michael
> > suggest to add a new feature, but the driver may not negotiate the feature
> > which requires more thought.
> > 
> Not sure I understand feature bit.

This is because we have a concept of dependency between
features but not a concept of dependency of feature on
capability.

> PCI transport fields existence is usually not dependent on upper layer protocol.
> 
> > > We may need it even sooner than this because the AQ patch is expanding
> > > the structure located in legacy area.
> > 
> > Just to make sure I understand this, assuming we have adminq, any reason a
> > dedicated pcie ext cap is required?
> > 
> No. it was my short sight. I responded right after above text that AQ doesn’t need cap extension.



You know, thinking about this, I begin to feel that we should
require that if at least one extended config exists then
all caps present in the regular config are *also*
mirrored in the extended config. IOW extended >= regular.
The reason is that extended config can be emulated more efficiently
(2x less exits).
WDYT?


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

