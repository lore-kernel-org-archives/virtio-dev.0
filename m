Return-Path: <virtio-dev-return-11414-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD74C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 07:45:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 59ACB2B057
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 07:45:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3641A986784
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 07:45:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 22D25983E93; Fri,  3 Mar 2023 07:45:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11F789866FA
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 07:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0B5RCgqfMDGzVdO08_kRUw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWmeL+b7RSzSESgEwnGUxlyVAOTl/TivqE23VB8rGnU=;
        b=fgeM71xzSjrm+ujmDOhHQ7HcSY0Qgoh5T0p1Z5m1CbcSbf95qrr2clPObDif8rhJMi
         JZ+HnbJKaoP2LAn7TuYNMXp1SM0KNCdHiTnLKUNYi90EtHOzDIxg+CSj7BYJLBTBC6CH
         teqE9GJrjQ7h42Jb8SrTb5OZ/tpuxF0wN3RfmsFnKyttghI8EGEZTOgpyHYPiNpIRggw
         ykJXIVOfTHS84+FgxmBaReu7jWMcrY/jscFPJlC9RuzkPYxfTdjJdHNdpJe24cZNiNs3
         h0pRDh6P/ZrLE+pgXrUUu7ug0KfENW8qXTrNeGRxNUnhIJlfIwUpcAwX653RianTZJ1O
         fppA==
X-Gm-Message-State: AO0yUKUyugyg9qHAmcs8yjVqbebK/rz3P5UuSdNArP8j2QRpKLGRX8aJ
	eJxMTYsR7b9LjvR/TRnWsWkITlAexVOY+bVxt0+DmDFV4sba1Ip2/OkcDUy1ncqxrTXTjAktYLl
	VmtIgQo5+nM09WC6gXUtyrGrU0MnP
X-Received: by 2002:a05:600c:4f50:b0:3eb:2b88:5af2 with SMTP id m16-20020a05600c4f5000b003eb2b885af2mr859315wmq.20.1677829554192;
        Thu, 02 Mar 2023 23:45:54 -0800 (PST)
X-Google-Smtp-Source: AK7set8tW96A77/w7xaI/Y+H+vCKSE9V8Vfuib+6iwo6bXBtRnu4zkYjg57qbiXBPag9KxmqQm2+Lw==
X-Received: by 2002:a05:600c:4f50:b0:3eb:2b88:5af2 with SMTP id m16-20020a05600c4f5000b003eb2b885af2mr859297wmq.20.1677829553863;
        Thu, 02 Mar 2023 23:45:53 -0800 (PST)
Date: Fri, 3 Mar 2023 02:45:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230303024543-mutt-send-email-mst@kernel.org>
References: <20230224222215.339715-1-parav@nvidia.com>
 <PH0PR12MB54810629E248D17C25CF5B1CDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810629E248D17C25CF5B1CDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v5 0/6] Split transport specific files

On Thu, Mar 02, 2023 at 03:10:45PM +0000, Parav Pandit wrote:
> 
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Friday, February 24, 2023 5:22 PM
> > 
> > Problem statement:
> > Currently several tens of pages worth of transport specification is situated in
> > single file. Many parts of the specification are already maintained in separate
> > files.
> > 
> > Such separate files enables better maintenance of the specification overall.
> > 
> > Solution:
> > Follow the approach similar to rest of the spec, and keep transport specific spec
> > in their individual files.
> > 
> > This series is for fixing issue [1].
> > 
> > [1] Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
> > 
> > Please review.
> > 
> > Patch summary:
> > patch 1 moves pci transport to its own file patch 2 moves mmio transport to its
> > own file patch 3 moves channel io transport to its own file patch 4 to 6 fixes
> > spelling errors existed in the spec which are discovered during splitting the files
> > 
> Other patches on top of this needs it.
> 
> Please create a voting ballot for this series.

Done, thanks for doing this.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

