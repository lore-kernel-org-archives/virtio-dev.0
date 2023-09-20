Return-Path: <virtio-dev-return-13886-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2946ACE79D2
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 14:13:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F0788742C
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 14:13:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D53C986674
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 14:13:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3642398666B; Wed, 20 Sep 2023 14:13:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2471098666C
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 14:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lxwjB42VNcu3ncKZI1JV9w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219226; x=1695824026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWIfaJigRXBNPfQTBV0dvLWw4bjXY2fZaDf230/MnnU=;
        b=coesz5kXwWvjUioOElZx30t13qsTWpm6oEX9Z3k7HrbPdl1/JM3DO0QVxSQgJBuTRe
         AD/lxQtkoTVw728fpUzbxRHCd783USqXW2UgAWFzN+UKZaN5oi1E0KScZQ3zsOMiyT+9
         6qBB0P45wJvFTpW525ah++7jkK820vOXZxHW+dxn6tWH/WNO/Bn4R38Spyfr4I4TBUVI
         p1Kz3zLkb4KQhnxMyUfHilbi2sJmRaLjEnT2GbZrnFBMd7AJNolEzG8RUS44LiQ9kbIB
         PgoKgstmUN4mQodfIefzoDBcXBKaYXJiia0fob7JoExUU3AbhhpTcrQgKt0wahA49QME
         Ce7g==
X-Gm-Message-State: AOJu0YxmLVvUFkBYOQq32vPBbHD+gfd/6O706N30w4ulAXdWbDeUexzk
	bwSSFJiPXihp7E/kguqfy18Or8Rh0bM1bMFYRJQbD198/G0HUynZP0jme33QKJn6QysKgpCZmqJ
	zxb23KGar3uL4hbw6FTx5+QkK356f
X-Received: by 2002:aa7:de91:0:b0:521:8777:b00d with SMTP id j17-20020aa7de91000000b005218777b00dmr1931288edv.15.1695219226664;
        Wed, 20 Sep 2023 07:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ67WWpQgVTehTIubr5x4KEpnR1/1l2FeN9W5Mu9r0BDTXT71mR8YBxors+hMM1q+/xKp8Og==
X-Received: by 2002:aa7:de91:0:b0:521:8777:b00d with SMTP id j17-20020aa7de91000000b005218777b00dmr1931277edv.15.1695219226398;
        Wed, 20 Sep 2023 07:13:46 -0700 (PDT)
Date: Wed, 20 Sep 2023 10:13:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230920101142-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 20, 2023 at 01:41:00PM +0000, Parav Pandit wrote:
> 12. Some how register access on single physical card for the PFs and VFs gives better QoS guarantee than virtqueue as registers can scale infinitely no matter how many VFs or for multiple VQs because it is per VF.
>

This makes some sense as memory accesses to independent devices do not
need to be ordered. AQ's answer is multiple queues and out of order
execution within the queue. Not sure whether this is good enough.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

