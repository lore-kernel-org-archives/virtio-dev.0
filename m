Return-Path: <virtio-dev-return-13049-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACD5EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:14:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 82482EEA0E
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:14:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FA4A9865E9
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:14:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 47C979865D0; Thu, 22 Jun 2023 17:14:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 333779865D1
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 17:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: p--bwtq4PTqczLnMNV8KpA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454085; x=1690046085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amUrlsrZDra2s7AbvcLgYeF2f9qbeg/yfKt5HUxvnOY=;
        b=Fi9Fp5i5Hc+y/Kj3kr1uYovsQ0WUIlMfWsZADp/USccJ3NPkfe8B3/geCtxWcZli9r
         3WYEvrhBisBaoY1kQmA6PuyysKQHQRrM+PCNkJm5pIFWPPz1OaTtQYyseNuwh/0XVdfa
         67Y3buwxyGmqgQUhXCNrUSPH/nztnoojbfylIjIKSHmSzT78u8z/klnMrLdpVCp1rtHR
         FuSERtdoJMk/7cZN37wDebYplOxlw9gOxwbqJ3LgDUwxvNdowLNkaorWrGQME5arn1BA
         RG/EBm1RhGTCCNKTB/B/YM4ZptDCUDZb4OdWQUvHOpwx50VXBn1oBnmuBXdN0Miv5OPs
         2z5g==
X-Gm-Message-State: AC+VfDw68/MHKUcYC7/KUNwk8Ez6exYiC8gS5TpzPLyGhwp9D7Z2z30t
	bVe33EFT9/xiMSlvQSKNxqjpkl7eEbxVvEu8Ywu0gpe3xHmNOnDlmiH2/3nAqCEVAoctbeEzB6w
	oJrUqrJ70I8CyldmyyYMKFZvvQ4H8
X-Received: by 2002:ac2:5f92:0:b0:4f8:a858:e611 with SMTP id r18-20020ac25f92000000b004f8a858e611mr6305786lfe.3.1687454084901;
        Thu, 22 Jun 2023 10:14:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jowLZOSBwQtiPpUdUZLr9psniqIpZDwe1iNg+IwzbEkBsl5TjK6vefNIPCQRhMXQ7nKfZxQ==
X-Received: by 2002:ac2:5f92:0:b0:4f8:a858:e611 with SMTP id r18-20020ac25f92000000b004f8a858e611mr6305768lfe.3.1687454084488;
        Thu, 22 Jun 2023 10:14:44 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:14:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622131120-mutt-send-email-mst@kernel.org>
References: <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622120756-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812B8DA2A17EF07CBDC3F1DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622124701-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548183EB6CB52E3A719C27ACDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548183EB6CB52E3A719C27ACDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash

On Thu, Jun 22, 2023 at 05:04:04PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: Thursday, June 22, 2023 12:54 PM
> 
> > > Admin command as I recall are not accessible directly by the member driver to
> > the member device.
> > > So a cmdq or cfgq is needed.
> > 
> > Possible, sure. Or we actually discussed a self group. I took it away until it had a
> > user.
> >
> The problematic part of AQ is that its index is placed in the yet another onchip die register that does not scale as each member device has different queue count.
> When admin queue was discussed, it was only for group owner, (you answered to Jiri).
> Hence the scale is relatively less, so it was acceptable.
> 
> Now having unique numbers for VFs is not good.
> Max proposal was the last index after existing defined VQs of num_queues, that saves the storage space on device.

Surely, you can just have a very large index and be done with it?

> > > The single way for every device to query their capabilities is via a cfgvq for all
> > new fields without extending the existing config space.
> > > (and optionally old fields).
> > 
> > Or adminq with self group. I like this somewhat better because we need exactly
> > same query from owner.
> >
> Yes. this is why I proposed to name is cmdvq that can carry admin commands or other.
> But fine, we had to progress for group owner.
>  
> > > > Why don't we focus on a work on a full solution? Just don't
> > > > implement this thing in your devices meanwhile until we do.
> > > >
> > > Then Heng needs to wait for cfgvq to be defined to be implemented first.
> > > Doesn't look reasonable to me.
> > 
> > And *everything* has to wait. No, not reasonable. We somehow managed to
> > release several spec versions and things did not ground to a halt without cfgvq.
> > Don't see a reason to do it right now, what's special about now? I feel we should
> > add to config space and then solve it all.
> >
> Things didn't ground at cost of device keep increasing their memory footprint.
> The latest addition I remember is the queue_reset register.
> It was bit but a purely control operation that got in there.
>  
> > > Current GET is coherent with the new commands defined such as notification
> > coalescing.
> > >
> > > As community, we should work on defining the cfgvq, till that time have the
> > optimal way to get the config, i.e. using the cvq.
> > 
> > cvq doesn't really work for capabilities though.
> 
> For the device itself, it does which is what is being done here.

Yes but not for migration.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

