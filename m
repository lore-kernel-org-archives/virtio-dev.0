Return-Path: <virtio-dev-return-12743-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E597C77B7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:57:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7AACB4290A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:57:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53C039865B0
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:57:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3C8DC9862F6; Tue, 16 May 2023 21:57:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A50C9862F8
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 21:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: i1AdhzUjOzucAcKhi1HOzg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684274218; x=1686866218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwXr+ZCfS3PH08G2JokrsOW0HzxZPh3CaCu0b/Cl1Oo=;
        b=PrEn5RpHwfuWu6iyc4M8qquvGRJHmpWOhSzP9+qPELHdRYbJB9Bm4klYgen8PHwvSG
         InSZ0LtSTuVIuPhHRAPVRe5MKRz4G06kxSI6Bn7/x2gG5eTuxAario/IeTXO2LRcnXw2
         xLK8jcMl0q4oM+Rvb2BsxWrKejRizjaBVxFlewAhXRwAUyIkaVQzX6Ua2zENx0b1wPCg
         yiUymrAFhuZOu+twAJOmCLcOtvWEVEHEFfAL3D8GzkshcgKEqRgs4TbB5jMStCmcyxs6
         qkdZkcjL/9smQbBpnsZx/BqD1rFevN/LyE7nrghqRdjE3JX9zoPo17qKIIVtdCrsFCtV
         56Wg==
X-Gm-Message-State: AC+VfDwJs422gvsDwOtdKC4YHW0sw/sY0mKmPAExTzGb67PsjH/ddQHo
	kTlChNagSmL2l99m41hYBEmE4oY/hEDINX+/lUHoRvEPoMIqatYSYlwm5S26YCxzTYz9SyZoub8
	KzS/LskQSvlc37Vkkejr6xfZkv3+9
X-Received: by 2002:a5d:4c47:0:b0:306:3a16:1c2 with SMTP id n7-20020a5d4c47000000b003063a1601c2mr23538830wrt.12.1684274218233;
        Tue, 16 May 2023 14:56:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Zrncy4MtFHE+WhNWxemoobOBjJRHtpgiM3ww71hHRM4ts11zmyARIkdW5ANaYzVkenHaasQ==
X-Received: by 2002:a5d:4c47:0:b0:306:3a16:1c2 with SMTP id n7-20020a5d4c47000000b003063a1601c2mr23538817wrt.12.1684274217913;
        Tue, 16 May 2023 14:56:57 -0700 (PDT)
Date: Tue, 16 May 2023 17:56:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516175452-mutt-send-email-mst@kernel.org>
References: <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <PH0PR12MB5481BCA4D8F6546B3300DD29DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <83603339-e3fa-fe56-d447-813e73eb1961@redhat.com>
 <PH0PR12MB54815633F6C88A1EFFB24500DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516170940-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C64573259FEE1C191229DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C64573259FEE1C191229DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

On Tue, May 16, 2023 at 09:49:19PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 16, 2023 5:12 PM
> 
> > 
> > Nah, we don't need a "break randomly unless it's a full moon and you cross your
> > heart three times" mode. If you are going to implement support for legacy
> > emulation implement it in a way that either predictably works or predictably
> > refuses to load.
> 
> It works with same level of predictability as current legacy interface definition for x86_64 platform when msix in guest is supported.
> 
> Supporting intx we discussed to deal incrementally after this.

Only thing I am worried is that we do not decide to go back
to msix vector after all because of the shifting offset
of device config. As I said, split device and transport
configs to separate commands rather than just using offset
and then I think it's ok to defer INTx work a bit.

Though I feel it's valuable and will help us move towards
more important goals like LM.
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

