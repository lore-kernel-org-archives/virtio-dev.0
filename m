Return-Path: <virtio-dev-return-13047-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A862EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:11:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 97E216034C
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:11:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A1B79865E3
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:11:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 64C7B9865D0; Thu, 22 Jun 2023 17:11:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5306A9865D1
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 17:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: vOb0Ew67PFSM7INgS9AQ2w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687453867; x=1690045867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZvDnOc0jFBoSOXptY1sxXNXYpqdEJ8Nbv2lE0IowdY=;
        b=bcduYfuwdPnEXsUZRKt/FqTPvqo7xDWl45/2fD39HopWnPOE0JmsKfcIPFLmijz11X
         nCUDs4ijLUBut9r2Ui3Pu+DUYcrTMhHRP2x8sz3oYjZ18jo2ceTsFTdXyjrYe38Ttwg3
         50E4ZtvZ0znfu1I+RGVuPpbm1dw7d3+vpdOXDP6vjQGSykUYsO6hwqSzLLqmL3101NcH
         JLu6WSXS0Bxsadqxx+Lq9Zy6YC9E3Y3/W/b3nTGTgNI1BzRVt74GQsu85D/QCDiingEr
         1XdhskDRICdmxoBHZtjElk4mlkhTXMM0/J6Hsw/ICGZkjve9c3ne+XIqqHMV/23Oanbq
         PIuQ==
X-Gm-Message-State: AC+VfDxNn8U7WSwc/dDy2vQ64dpd/jvfMtnFL9+0nEJ38L04BR07YKm+
	JhXzHEsbpCOB4Au6PjtlHEIElz9QVnNHfRlLP3o9zIHehKaXhxqLxa2aATuYyKeIs5IzmztQso2
	iJ7gDJWAtq0+hgCc7bbRi7RJyzSha
X-Received: by 2002:a17:907:9450:b0:989:2a82:fb02 with SMTP id dl16-20020a170907945000b009892a82fb02mr6023371ejc.51.1687453867204;
        Thu, 22 Jun 2023 10:11:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wQA/CuMhD1MnezZgEDDngpYsS9Qe2Q5xqhXa3kM7R/Ag56HVp6+d+GMVaphYUsUsNes/YRg==
X-Received: by 2002:a17:907:9450:b0:989:2a82:fb02 with SMTP id dl16-20020a170907945000b009892a82fb02mr6023365ejc.51.1687453866938;
        Thu, 22 Jun 2023 10:11:06 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:11:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622130359-mutt-send-email-mst@kernel.org>
References: <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Thu, Jun 22, 2023 at 12:32:33PM +0000, Parav Pandit wrote:
> Provisioning driver usually do not attach to the member device directly.
> This requires device reset, followed by reaching _DRIVER stage, querying features etc and config area.
> And unbinding it and second reset by member driver. Ugh.
> Provisioning driver also needs to get the state or capabilities even when member driver is already attached.
> So config space is not much a gain either.

Actually it's RO so you *can* read it without any issues:
- block guest access to status
- check DRIVER.
If set:
	- read features, config
If not set:
	- read features, config
	- reset

I am not saying it is elegant but then all of vdpa pile of
hacks is not elegant.

And I am all for building something better but we didn't
build it yet.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

