Return-Path: <virtio-dev-return-12920-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4322C7EE25
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 07:21:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 40F902AEDD
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 07:21:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A72598669B
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 07:21:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 14796986641; Fri,  9 Jun 2023 07:21:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00B5F986692
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Jun 2023 07:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9mO_R4UxMK6Nz3nRQ19XGA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295315; x=1688887315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWorrsUwnn17iylplb3Gm7k4S02EZ6hAj/l7jVnuj5E=;
        b=GWObPdOP/YnHZC09qCpkHv1RH4/GI4mvIDsJEBirTCLVR2KPdc2PPtB97WAm7kiYSo
         17lhLV48rDm4p3TsKRdjrV+13/iOl4qpcqwfpYIqVs7ZGhR/jI8VQ3ap0UzuLQStB9pg
         3nohMada43KCcFKpfXW/6pJlLchqeZq5P+p6HYuyMO6T6uuOcDScLGuiub54nonrjyOi
         gGLUs4wi3POM3ZEd9JqD52zksXufzEuqv3X1OiWTNFcUW8PAcNdZ9jVDPTJVTlJDfT9Q
         6Q7LT6Uyr3B3jtDl/hX8fwN2atELRV4WEtTd90WmAtg+JFTuG/+W+1imJuqLm7QlD/Mn
         +POw==
X-Gm-Message-State: AC+VfDybms1P7gxdfwSdu88cFBcwrrPKQcqN26Wa3LZdTDEaHIIVtfFu
	HeEZW8CNxgLKnzUTgfbNmtavTrivuYhADFFsLi6+PE4Q5kp2hF8QzzaSlbDKPJWBZ69YRgkTESc
	S7YjrjPjfp1PQjziczcuK6+uZiOZ2
X-Received: by 2002:a05:6512:60f:b0:4f6:133e:a0ec with SMTP id b15-20020a056512060f00b004f6133ea0ecmr318581lfe.25.1686295315431;
        Fri, 09 Jun 2023 00:21:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52d+GAVlTR/VPjKnGyZ+TBdet4NLxB73uK6BgDs2WLuC7xfFygVM1pwqi9/LMAB6Cc6b35Wg==
X-Received: by 2002:a05:6512:60f:b0:4f6:133e:a0ec with SMTP id b15-20020a056512060f00b004f6133ea0ecmr318565lfe.25.1686295315055;
        Fri, 09 Jun 2023 00:21:55 -0700 (PDT)
Date: Fri, 9 Jun 2023 03:21:50 -0400
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
Message-ID: <20230609031923-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Fri, Jun 09, 2023 at 02:27:01PM +0800, Jason Wang wrote:
> > I would like to keep the stateful interactions of 1.x device outside of 0.9.5.
> 
> I don't think this is a real problem, but let's see the drawbacks of
> this proposal:
> 
> 1) non-trivial changes of full new transport alike ABI
> 2) can't work for nesting
> 3) require vendor to implement legacy behaviour which can't be
> documented precisely
> 4) require admin virtqueue to work
> 
> We won't have the above issues if we use modern + legacy header/mac.
> 
> Thanks


All this is true. But it's by design. It makes the legacy thing
as isolated as possible. Because let's be frank we won't be
able to drop legacy support in like 10 years. But hardware
vendors will do that quickly if they can't sell hardware.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

