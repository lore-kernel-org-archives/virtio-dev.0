Return-Path: <virtio-dev-return-13120-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC921EB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 10:27:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFF1C68469
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 10:27:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D40F79865A8
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 10:27:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CA6DC98656F; Wed, 28 Jun 2023 10:27:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B73CC986573
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 10:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8F-QhN29NtSzzVauKzT-Uw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687948029; x=1690540029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sED1zyPUIPB6g4gi69v7tuqrCASHOxYrvGjMTlGQkc=;
        b=K3vICU+txxK3UxepGBXDNA47iRqDj1JLCAkzSMPTa2Q/tQ86pe3YzIJs+9hpSNY7QJ
         P6sLn8jUzTDQBWrX6Zjxjghq7YlER/iK/lHTDNwh/2WVp9YW7ZqTZfMkL2x09A8w3KIj
         1ow9Qlf7gaI6hU5XDooPT8N4zsyA+ZYe61VUBLduXPaIfRiqleisqVM3RTitLK50yfN8
         +oaSiVaOo9vcqz0iAM8m1Ur5SsGtjytzjX25mzzoiWYL+OdHwlUJnJF9+57VT6UR/QRO
         aWUupjVWdatuiinaB/AYviqSZ6cNW4+wIcLw6r8Bxqf/uw/UcDi9SgxJx83nwv0AppsR
         jZtQ==
X-Gm-Message-State: AC+VfDxMdvnM+ZlUb0KktY4JDdR+LcutvR6xh7J2QmeI4cf2ecv9noXp
	uW4dAaasLlcN0eYUgyFp/7q2JA4rqewO5iFL4oaOxD0Y0UK19B/vfcB6NstyBkOuBM+w3HlqBX6
	YGBMxF+sVi0cBPllD9/Tu7NXL1Cj/
X-Received: by 2002:adf:e892:0:b0:314:1f0:5846 with SMTP id d18-20020adfe892000000b0031401f05846mr1131157wrm.19.1687948029536;
        Wed, 28 Jun 2023 03:27:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ444KsKA+8gaLmmTLFjCQpeq9B7n56nxRT39qWO+R+djg+anWnnYWUf3NX0z5VcSdsymn6N+A==
X-Received: by 2002:adf:e892:0:b0:314:1f0:5846 with SMTP id d18-20020adfe892000000b0031401f05846mr1131135wrm.19.1687948029167;
        Wed, 28 Jun 2023 03:27:09 -0700 (PDT)
Date: Wed, 28 Jun 2023 06:27:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230628061257-mutt-send-email-mst@kernel.org>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Wed, Jun 28, 2023 at 04:23:09AM +0000, Parav Pandit wrote:
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, June 27, 2023 11:46 PM
> > 
> > Having it in the config space, then a type agnostic provisioning through config
> > space + feature bits just works fine.
> >
> Provisioning is far simpler thing to do in device specific way than asking device to store this value in onchip area which is rarely accessed.

I thought a lot about this over the weekend. I just do not see this
working out, sorry.  Two things is never easier than one. We already
need config space with provisioning.  In fact e.g. on Linux we want
drivers to keep doing virtio_cread() and all the DMA tricks should be
hidden behind the scenes. You don't like it that config space is
on-chip? Build an interface for it not to be on chip. There is simply
no downside to that.

I came back after a small break and I still see this discussion
that keeps playing out as a big distraction.
In particular where are you doing to store the things that are for DMA?
In system RAM? We don't *have* anywhere in system RAM to store this,
we will need an interface to allocate system RAM and pass it to device
for this idea to work. So in 1.3 where we won't have this, there is
much less of an excuse to use a vq.




> There are many fields of many features for 1.4 are discussed including this one. All of these capabilities just cannot be stored in config space.

config space is synchronous interface, vq is asynchronous.  Setup
is just too messy to do asynchronously. So yes, config space.


Please let people just focus on fixing config space instead of
temporary cvq hacks.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

