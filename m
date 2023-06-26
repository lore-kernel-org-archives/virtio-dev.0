Return-Path: <virtio-dev-return-13084-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3F0EB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 10:50:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CBEA4157EE5
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 10:50:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26872986450
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 10:50:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 73967986385; Mon, 26 Jun 2023 10:50:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AE5E986382
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jun 2023 10:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: l5jKeqhWNpCds8E0-qfC1A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687776588; x=1690368588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtaTeszHywBvX9cUDiRyZ+ktDjAJ/oIrj++AC7cubjw=;
        b=VRDL/rVekKDPwTHr9CWSNtuGXx7MVpWn7B4+lv1QB+1LBmfXzPpQOnhlvMiizhFVF+
         9hD0JgQ4X0zGh+7FX+5qXRcmyKXw/ypJ8yQblDFjyESzDDbrMMfypeOhK3kA3wPancfz
         YykDODwarwhdFem8At/icjYRkrM6vIBGhZNSIgIJwQa2ezLUPyOJQWoKnB0u79VTikKU
         stBD1Jjg4lLGuU847KtKNjHpK5kFAwYBjUoPnetUvy/fOlAyjUcp9Xk8u9o9oIxQpnHl
         8lsT+2iVEwdfliyHrG1FNBIb1+cuKgzihnqEXF1wamWSRmiT7tquY9lTXm8bDyQ/BzuC
         KkDQ==
X-Gm-Message-State: AC+VfDyQrrZtdb7tk+FdJjit0nnXdp37z+n2wLfY21cmf6ivD6WxUoYE
	3xlVeeRpJ+X6s/vm8ELpVHp5djhPrF4gwHksT21ltv0yPf8yxuyjAl5Y329N3X+xPdfMs8UbSwg
	k+Hl+nYjhaDZxDmc+V5EtRTBJ9L+W
X-Received: by 2002:a7b:c3d7:0:b0:3fb:40ce:503e with SMTP id t23-20020a7bc3d7000000b003fb40ce503emr277928wmj.25.1687776587863;
        Mon, 26 Jun 2023 03:49:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oW/VhAWavHBvdIoo6236cBigCUW1ACQ7N2FDum4zVX/ntD30tQbp3YNRKP300zMBUra2ngA==
X-Received: by 2002:a7b:c3d7:0:b0:3fb:40ce:503e with SMTP id t23-20020a7bc3d7000000b003fb40ce503emr277913wmj.25.1687776587605;
        Mon, 26 Jun 2023 03:49:47 -0700 (PDT)
Date: Mon, 26 Jun 2023 06:49:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230626060445-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <CACGkMEtPKh-fEkjPu2iPeV5uXus0W7J1V94q1VHVWv-jJHYWGQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtPKh-fEkjPu2iPeV5uXus0W7J1V94q1VHVWv-jJHYWGQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Mon, Jun 26, 2023 at 11:50:24AM +0800, Jason Wang wrote:
> > But hardware
> > vendors will do that quickly if they can't sell hardware.
> 
> It looks to me that producing a modern only device will be more quick and easy?
> 
> Thanks

Exactly, that's the point.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

