Return-Path: <virtio-dev-return-12491-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A99FC7EE23
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:41:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 58294F9384
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:41:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 528F99864A4
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:41:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 47A74986486; Tue,  2 May 2023 07:41:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 373A998648C
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 May 2023 07:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cGPF87YyNrK0R2Qlf2bd_Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683013300; x=1685605300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNB2iFxhRQ0Bl07os+eJCPhi53YeNXW/csSfvbn4nKQ=;
        b=JrRqNZkNu9JEeauQuptwyLVJmuYheId766LBeADkOI2DIICAxTCp8ZGW5pXNX4DJ5m
         ZedYLgGU4CE8n2UGP7UnvIS+jz7Wf3yRMk35P0o3KGuT5rmW/AwJFlBwXe4Xt5fKGi7a
         6A2kvEncaSlerZ8f1glK7xMpRwaQ+SavWkyUzWsiXpv5V3rXUjO01Uawb9OCh0U2fKW2
         6eXLgg91adoO9dF4mIxKDn8nRAU80mJPvuFiIzhPjz5K/HM5/hPE11H7vFmVlcauhNYx
         /VUUv19jHkEG+MjoP/VsqJl8qUyjJHllOmcMaB94p+HSWkxXei++SJete8Vvv+yh4MLf
         bdlw==
X-Gm-Message-State: AC+VfDzfpBg6nwI4YK5vBOblkRiz6AXmFpXm+kAstm5wLVlwkOQMUBpP
	77TKhqCL+BWv6mKNFM7nIy90BJtD6JmLzk8QjATiiugGGUvQQohDJ374WVzIWIRC8Ng6YGGBQMs
	AK7vtjOgxnumold3WfWVrehpRwnAT
X-Received: by 2002:a1c:4b12:0:b0:3f1:70d5:1be8 with SMTP id y18-20020a1c4b12000000b003f170d51be8mr12161817wma.15.1683013300347;
        Tue, 02 May 2023 00:41:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XQIKMMuFXxbYkFcDBPPeZGPdpKYGkPrtKzDzuwvNY0uxCI6ceSGNbmNj4DMeotyGCipgT2g==
X-Received: by 2002:a1c:4b12:0:b0:3f1:70d5:1be8 with SMTP id y18-20020a1c4b12000000b003f170d51be8mr12161803wma.15.1683013300080;
        Tue, 02 May 2023 00:41:40 -0700 (PDT)
Date: Tue, 2 May 2023 03:41:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230502033954-mutt-send-email-mst@kernel.org>
References: <20230501224430.485139-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230501224430.485139-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 0/2] admin virtqueue fixes

On Tue, May 02, 2023 at 01:44:28AM +0300, Parav Pandit wrote:
> 
> Hi Michael,
> 
> Please review these two small fixes for the admin virtqueue patches.
> They are on top of your work of v12 at [1].
> 
> Patch summary:
> patch-1 removes PCI transport dependency on deprecated migration bit
> patch-2 fixes admin command command data type to be u8 similar to result
> 
> [1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t

I can take 1/2 since that's just removing text. Taking 2/2 will mean
more review time before vote - besides me not really
liking that change, are you sure it's worth it?
Was going to start voting today but if we are still
tweaking command format then I can't ...


> Parav Pandit (2):
>   admin: Remove dependency on the deprecated register
>   admin: Make optional command data type to u8
> 
>  admin.tex | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

