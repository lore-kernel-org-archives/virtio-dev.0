Return-Path: <virtio-dev-return-13963-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63623E7D27B
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 10:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 74FF72ACB8
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 10:50:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8C689867BB
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 10:50:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F4489863A9; Tue, 26 Sep 2023 10:50:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 790FB9863A6
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 10:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KjfUMHLBO9S2sxPLD3eOCQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725342; x=1696330142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KuwFR0wjVG6lK3Pke+FARvbN9oWJHChLuw9kA7KE1o=;
        b=K9NsZ1y/MndUEWJobd1JHk1wk4IL6LYuV4QT7/m4b9s05YoJYnXMneNXeqayjEDxwB
         YYQQLpc2KZdG2B1mEn4FBCn2JUVhWMXFoLGgukD6CLXCn07dPCG52jWO/fsPEiuMfVoD
         QCBoVS4nKKDF4IWorHT60icbfoDoKtTlCO/GyIbvbSXD/B5BqRKMEw8NQeXq6dYOku8U
         c1RlMb3SJhCSDA1GxiiXR9k83wtnszF+BDI8/4hZHMfeNkTOuztH4qjndcBveK9ouaF1
         y1xgIETxQnDpm43ovjJUhitHXw14TiHh2DZDmrz7d4SXb3AG4lm+XtsZLno/c+lYsvEv
         850g==
X-Gm-Message-State: AOJu0YwDnWlqBiUTt+xOcFxSVVc6RNP1R5j0UE58hx2z7UIZg6356uos
	dFvk7GUytXYETOapkNOLhT5dalBlkMEMQXCW8mO6sVyt+jl5DF2lPZbuxDEtq3412E2ktV4pOy5
	2L9ELJ8vbk5KYJ0qiQ7iAiKI/SQds
X-Received: by 2002:a17:906:c143:b0:9ae:68a2:3bf0 with SMTP id dp3-20020a170906c14300b009ae68a23bf0mr9776564ejc.28.1695725342385;
        Tue, 26 Sep 2023 03:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH1vB5/vnr6wrsujDsLwK8mlaYlx8Dt50W068JlCr5ju7TG9sa4DckMfv7A0gZwmJlDP/5cA==
X-Received: by 2002:a17:906:c143:b0:9ae:68a2:3bf0 with SMTP id dp3-20020a170906c14300b009ae68a23bf0mr9776555ejc.28.1695725342109;
        Tue, 26 Sep 2023 03:49:02 -0700 (PDT)
Date: Tue, 26 Sep 2023 06:48:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230926064201-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
MIME-Version: 1.0
In-Reply-To: <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Tue, Sep 26, 2023 at 05:25:42PM +0800, Zhu, Lingshan wrote:
> We don't want to repeat the discussions, it looks like endless circle with
> no direction.

OK let me try to direct this discussion.
You guys were speaking past each other, no dialog is happening.
And as long as it goes on no progress will be made and you
will keep going in circles.

Parav here made an effort and attempted to summarize
use-cases addressed by your proposal but not his.
He couldn't resist adding "a yes but" in there oh well.
But now I hope you know he knows about your use-cases?

So please do the same. Do you see any advantages to Parav's
proposal as compared to yours? Try to list them and
if possible try not to accompany the list with "yes but"
(put it in a separate mail if you must ;) ).
If you won't be able to see any, let me know and I'll try to help.

Once each of you and Parav have finally heard the other and
the other also knows he's been heard, that's when we can
try to make progress by looking for something that addresses
all use-cases as opposed to endlessly repeating same arguments.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

