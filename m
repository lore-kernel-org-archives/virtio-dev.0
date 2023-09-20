Return-Path: <virtio-dev-return-13889-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E11C04FF7
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 20:06:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A1FF52B012
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 20:06:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78AD098667F
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 20:06:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F5F99862F0; Wed, 20 Sep 2023 20:06:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2BDE986674
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 20:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: I9l_9p0BPT2vpYnei9bxgg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240241; x=1695845041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbu2Twy89WQRnQJvZY55VQbs6VUpXG5IjUkX5vSmncM=;
        b=dHrk15eEycEc6L0Tq4JlEv4hV7by2gU+4KEE6Oz0MLDZNwdaS8aNrC3VfmBzek0/l2
         9IYCC+kCZr6Lip1xkqYXWkRU9gGtdhZ8Wf8qIFXFkosEkdTwfKgQbkZVL2E1ZD+189hZ
         1klPfgV0EuE3a5zVYV0relD9JY347q4dwRfB4x+9mdk/oj0+MKIwi/sa7ZcRXSAE7cEn
         /N3q4lXZvc8LP5KFzu06BYyHUl3AFRTzcPK0TkSJZ2Fn2TRMS8BJW3YQTxDYP2grnSl5
         YMnTZd/Jk/pq9pKAUtOIrbMvqZilnKGLHJm2FM/DS4pTlfJRgps1OEJvx2Uh3ifxq4nF
         U88w==
X-Gm-Message-State: AOJu0YyR70kkWMjxrCxmkFvq6OSQdXCIs0iTpcEpS/actBl031iCpKNw
	Dbc6H94m1QMiEq8ZL++ZcYDaH3IfMI1bsLnoZGAfsBJ/nJc5/5mvcX4Hb9k9gcCgao70eT649XI
	PVjeBsXO2duvkthBx1XkAcWGq3g7y
X-Received: by 2002:aa7:c2cb:0:b0:523:33d7:e324 with SMTP id m11-20020aa7c2cb000000b0052333d7e324mr3174985edp.38.1695240241329;
        Wed, 20 Sep 2023 13:04:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfOFdtub1fwYGZXMCjDEbbim481YS7TjyndbB3gIN/AvhuhIlyOzVaAxKJKmQinCMwU6k6Cw==
X-Received: by 2002:aa7:c2cb:0:b0:523:33d7:e324 with SMTP id m11-20020aa7c2cb000000b0052333d7e324mr3174973edp.38.1695240241008;
        Wed, 20 Sep 2023 13:04:01 -0700 (PDT)
Date: Wed, 20 Sep 2023 16:03:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230920160218-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 20, 2023 at 05:21:52PM +0000, Parav Pandit wrote:
> > OK so with this summary in mind, can you find any advantages to
> > inband+mediation that are real or do you just see disadvantages? And
> > it's a tricky question because I can see some advantages ;)
> 
> inband + mediation may be useful for nested case.

Hint: there's more.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

