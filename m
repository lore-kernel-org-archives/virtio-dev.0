Return-Path: <virtio-dev-return-12282-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B645BC77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:30:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E559F77BEA
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:30:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C78B2986406
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:30:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B199F9863E3; Tue, 18 Apr 2023 12:30:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9EE8C9863E8
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 12:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: C_cNfeTnNgC8dmbNP00HUg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681821054; x=1684413054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsqjwvq9uPHLN3lB1D+MMFVglRiAnh8cLkM8J8w+aKc=;
        b=RSl47TmyZlAKC60RuVZdJygW8lS652II/qnM0lwod/vMCIjBnFlM/LLR6I3LeovLh3
         0R90KgLP+jj5dAg2nNS+ZOCZUvNSfTxJdkmCcTy0Zvn0OI4wmkIOIW168y6XudhCPjdM
         /an6RtmpDI3tAOoUsNVrlld6QskjHF4DbW8jGpywQe22KZLzeV+ZvMnWt87Tzdser2PK
         NEC5zeJPX+cetPpnaL9wEBEYbc1oXG0aqK02XJGyBgYxk5PY3QQDwyQUMtkm3D+hdFF0
         7ZbZLHWcKAerSh/TT/moXdDfIrFNGTUyva5CruALJKE1C7YItPsWpOsCLcdZM7XdgtPA
         jYWw==
X-Gm-Message-State: AAQBX9eVhdYMJ+eDbcL82d5AmYu0ky2et37lw+I/Py1AtYuG2eHYHRan
	TbSk25pbpNE2G46/U4wkAEyOJKwBumW3is7N9hqtXZe+W38fBTCascGwGSpURLtzwTLbLbIbthb
	Pm71pGQAT8DNyeryeff0EeYqSWz4P
X-Received: by 2002:a7b:c848:0:b0:3f1:7372:f98f with SMTP id c8-20020a7bc848000000b003f17372f98fmr5106928wml.41.1681821054512;
        Tue, 18 Apr 2023 05:30:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z0ufqTCdYLM8hRWrBzsyjfQ9/NwpbEcraymcIRZ9WfTHjWJv/OTGVxfNqC4h6SSbnHehtzdQ==
X-Received: by 2002:a7b:c848:0:b0:3f1:7372:f98f with SMTP id c8-20020a7bc848000000b003f17372f98fmr5106912wml.41.1681821054243;
        Tue, 18 Apr 2023 05:30:54 -0700 (PDT)
Date: Tue, 18 Apr 2023 08:30:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230418083018-mutt-send-email-mst@kernel.org>
References: <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417162618-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481710854882449008F28BDDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvPv7eH3+cggcCVZvRCqkNCh_CX+6azNJtdJUDxjjAjwg@mail.gmail.com>
 <PH0PR12MB548113626CD6C7B2F8589042DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230418075401-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2E9CCDD9B813F420A81DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D2E9CCDD9B813F420A81DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Tue, Apr 18, 2023 at 12:09:17PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 18, 2023 7:58 AM
> 
> > I think in any case, using device through two transports at the same time
> > shouldn't be legal.
> 
> PCI is the transport.

... and AQ can be a transport too :)

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

