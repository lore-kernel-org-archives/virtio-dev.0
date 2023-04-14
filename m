Return-Path: <virtio-dev-return-12239-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE60C77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 15:17:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 839A82AEF6
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 15:17:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E54E98660F
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 15:17:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 57E0A986602; Fri, 14 Apr 2023 15:17:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4586698660D
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 15:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485454; x=1684077454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiiGjyqX4o159cvbNlKsXJAHA/ueLUd6Q3sCWwwpz5Y=;
        b=UIWIGnHET1R2XL2kV/twKwTxkbA05sXv/BARbFrSGCHILDoHTqXqJxBhuf2x3ActDx
         92wEiLJvTx3rPQJjZiNeEIPZp7l3zjFQht68O3BZ4LSj9pTeNlPAMy+d1W9hg9z+91nG
         edb942g4JX4miA/wc599C/avjF2CFdIOix155U3Xog3wppuqWF2pnx+pu7TmytNU8SRl
         G9XVZRWT1vxqcdiXQTxkzBk/cHl8n99RdtVj8ji2YtAdRPoAzDjSk03D6EBz/FQbie1Y
         +HJxSzGxT63cFbCChOWqSg+tlkc9mW2sI+O4FVw13tv/iSnRay/K+iNsGd0UPBWDDEvM
         Z8rg==
X-Gm-Message-State: AAQBX9f/MT2ZiwypVkmLkxCs9oq3DrieDdRV009ryIbToVufgerCc73i
	CJxg5DDmTyH2Z5sRM175raP5Vw==
X-Google-Smtp-Source: AKy350bQFzW/yiQUVEbMS8iwEGtjIIv6F3QJDvhfsmxOMugGGxPwOpR0bNIgwlJINtCCORADLPrWlg==
X-Received: by 2002:a05:600c:21cf:b0:3ef:3ce6:7c54 with SMTP id x15-20020a05600c21cf00b003ef3ce67c54mr4860044wmj.35.1681485454655;
        Fri, 14 Apr 2023 08:17:34 -0700 (PDT)
Date: Fri, 14 Apr 2023 16:17:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Auger <eric.auger@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Message-ID: <20230414151735.GA4145625@myrica>
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
 <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
Subject: [virtio-dev] Re: virtio-iommu hotplug issue

On Thu, Apr 13, 2023 at 08:01:54PM +0900, Akihiko Odaki wrote:
> Yes, that's right. The guest can dynamically create and delete VFs. The
> device is emulated by QEMU: igb, an Intel NIC recently added to QEMU and
> projected to be released as part of QEMU 8.0.

Ah great, that's really useful, I'll add it to my tests

> > Yes, I think this is an issue in the virtio-iommu driver, which should be
> > sending a DETACH request when the VF is disabled, likely from
> > viommu_release_device(). I'll work on a fix unless you would like to do it
> 
> It will be nice if you prepare a fix. I will test your patch with my
> workload if you share it with me.

I sent a fix:
https://lore.kernel.org/linux-iommu/20230414150744.562456-1-jean-philippe@linaro.org/

Thank you for reporting this, it must have been annoying to debug

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

