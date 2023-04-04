Return-Path: <virtio-dev-return-11955-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831C0C77B60
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:14:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 943B642BE7
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:14:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D7AD986400
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:14:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 148DB986622; Tue,  4 Apr 2023 07:14:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4CCB9865D5
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 07:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JSuwwt79P46jVYzumkaapg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680592437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYfdpUktbIgUdhvdEPnLE35dGDYkSRqGeOuXsFLfvrM=;
        b=mfMnKsg+S9qkW6aSwdKCnKLMaxvWm+oywBYHCZsNpuM8tkAgjobpntv7rexxJB2gs9
         6aUZbFiTeiFO/G9J7iO7Z4Mv25KZTUh/UIJIVMdDHA0eqBxrpiou0QfncG4Rw/SYxbh1
         xagvuD9eQnDSBOFl/ReBAMtLdcXOcN1Sc7l0ibegO7PXcZnz42XAgya1t+vNmGjxf24I
         y2YfKRM78I3Ab/8ovFQkWhc5ZdNr/fAv9+F0XybA3uFZa+ffH4wEX5lRylQKx8LrmvTb
         X2RwErGzn2Xi7xfTCQswPQYFMY6nA6rliUXtaBpxSBSHc3LCmB4J39wmqsuCNs2Ur13g
         7ziw==
X-Gm-Message-State: AAQBX9ctwXKJ+sG/Nc7GZ+e1OESENVHsnyPKLIhe3FZ7OKuX79CBqebv
	PMeWT9i24DAoAKPyNefCOLCWrIkbEUTshND7OOFdwmt5glp5zeh0APJi/OZoall8av397UslXyn
	IijfMNlqUM26tkEyVEG4EY4UIs6Y2
X-Received: by 2002:a17:907:b9ca:b0:933:4556:d1cd with SMTP id xa10-20020a170907b9ca00b009334556d1cdmr1552130ejc.33.1680592437720;
        Tue, 04 Apr 2023 00:13:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4WBBiI5RXqWOlX740OJdMHzwObGfT0D0ci20CM6bOjq5T45eli4YqOdUTX8Jn6DIEZcPzsQ==
X-Received: by 2002:a17:907:b9ca:b0:933:4556:d1cd with SMTP id xa10-20020a170907b9ca00b009334556d1cdmr1552118ejc.33.1680592437482;
        Tue, 04 Apr 2023 00:13:57 -0700 (PDT)
Date: Tue, 4 Apr 2023 03:13:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230404030859-mutt-send-email-mst@kernel.org>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
 <PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230404033622.4b749f89.pasic@linux.ibm.com>
 <d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Mon, Apr 03, 2023 at 10:57:35PM -0400, Parav Pandit wrote:
> I see few options.
> 
> Option_1:
> 1. I will send v12 of this series to use index all the places instead of
> number.
> 2. driver notification structure vqn to rename to vq_notify_id.
> (after merging this series as follow up cleanup).

We can pretend that vqn means "VQ Notification".  Backronims are fun.
In fact it is not always a vq index, sometimes it's a different value.
So maybe keeping vqn there makes sense.


> 3. Once interrupt moderation series is merged, rename vqn to vq_index.
> (really vqn reads better even though history say vq index).
> Because votes is completed and voting period ended for the important
> feature.

It's ongoing but sure, we can do a fix up on top.

> 4. Michael send v12 with index.

Of AQ? Sure.

> Option_2:
> 1. Continue with the v11 of this series as vq number.
> 2. Continue with interrupt moderation series voted
> 3. Continue with Michael's work of AQ
> 4. Will do #2 of option_1.
> 
> Please decide at earliest.
>

It looks like the sentiment is now going more option 1.
If you like post v12 and we'll see which gets more acks.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

