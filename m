Return-Path: <virtio-dev-return-13921-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C812E70705
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:09:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 600772B020
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:09:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E961986680
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:09:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2348598667E; Thu, 21 Sep 2023 10:09:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13FF998667F
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 10:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 89xFrhdrPsadRFKzCQuU4w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695290983; x=1695895783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxuAIyrYYbS0AUjeb/+9yyRhFDpoDfp4XsT3p+nNhWM=;
        b=lcAuD+0enNySpw3gt4BZp3xW8Y6vUVY4jF7xtvtmc+2cY/7sjVYByr6p4Kq5M/9/Zb
         jSqokra5C7VUqniXGc1J3N7FmRTPXtbvkXJcvykEP1kPLk5sF4djrRagEW/lscBT7Ha8
         xzTg/kYOUo8WlX+4nn2mKMGBdgaHT18t3a3eZWCtZjra2QWfBDvM9UetEzQp7Pz10yZ1
         uGu8EEPLr8aG3U75/JyD/3jm+LijIXTc11F+wGqsZ39PT2HFvtRdMjA12kzbzhUVegRo
         yj26fVIq3bZjF41wqBktZSDE/MwpVf3Ie+s2EqUTk4/1TWDinBMCTfm0GHJtcBxM4HzM
         xiRA==
X-Gm-Message-State: AOJu0Yx77nN3wSZIa/uDdq9Ci/opgbfGAZszVHmoRL3rhdNPKYIx+0JT
	xb2GXWoVFCw4RFZaFkE1XoaFiCY3oJrxeVg5c9/jLtQ+7QxnKplVPH56VittwwAyhOm4m9ZrMg7
	DzbV2GzYlnqEouBOpx+WI2w1o1Xa5
X-Received: by 2002:a17:906:3009:b0:9a1:f10d:9746 with SMTP id 9-20020a170906300900b009a1f10d9746mr4458903ejz.20.1695290983026;
        Thu, 21 Sep 2023 03:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2+q8oL3fXq51QQSAHZpIfhfd9/L8pUstDJcGdJ9jexXNibAMYjLE4/nKOvKneFYLkO6Wzdg==
X-Received: by 2002:a17:906:3009:b0:9a1:f10d:9746 with SMTP id 9-20020a170906300900b009a1f10d9746mr4458893ejz.20.1695290982723;
        Thu, 21 Sep 2023 03:09:42 -0700 (PDT)
Date: Thu, 21 Sep 2023 06:09:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921060320-mutt-send-email-mst@kernel.org>
References: <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 21, 2023 at 09:17:53AM +0000, Parav Pandit wrote:
> Vdpa stack make total sense when the underlying device is not virtio and hence emulation.

Which linux framework is used is kind of beside the point but since you
bring this up - not necessarily.

E.g. I personally don't care much about "stack" but clearly we need a
virtio driver on the host to be involved, teaching vfio about virtio is
probably a much worse idea than creating a mode in the vdpa driver which
mostly sets up the IOMMU and otherwise gets out of the way of using the
VF and just drives the PF.

But for example, to migrate cross-vendor you need the
pci config space to look the same and for some devices this
might mean that pci config space will have to be mediated.
Or maybe not. vdpa is a good framework in that it gives us
flexibility, it is not opinionated.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

