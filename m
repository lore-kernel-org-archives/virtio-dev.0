Return-Path: <virtio-dev-return-13133-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD53EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:23:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1308D4290A
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:23:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8BF99865CF
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:23:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D09FA986587; Wed, 28 Jun 2023 17:23:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC662986588
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 17:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Gh7GEKF1NVKwQOxUzyCuTg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973034; x=1690565034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEhI+y/sFJpwvPUHKOKNN4EUNW3O7wtsVdNzBIXm7Nk=;
        b=gOPvjH30QLchecOhDF9ziK76qqP7PoROPi27Pf4bNMEx5RpNkkJ372HFg1aB9nByEh
         w6cYoEuGjlb9awzjRP5OvX2pjGO9rSbUV13nRMwciE58/bWsNVmyINf059YrZBmIoItk
         vZxv4sUQttlYYndqmeB3fHw5o1j1bx8YB3Wx/f6OPYStn2r2TwPK7fT2opWvQjTP9Ax5
         qhCr7NaNryy5m/76eMDi+/PdFJ+0zo+8PO54w3alPak3kBlpbmvRybGWa2RGIRSFJdq4
         O6HoXIDU4w5Hw5LiPgr/FjOZcu8REcYzumo1+A5O+maQV65TWLOQ1jwx23m3J5Cg0UDu
         pJ6g==
X-Gm-Message-State: AC+VfDw/dLrwc9uAhTxVhpYx8Ft3MSQVaILvz+/s6drE+OGnXviHjQEM
	mCh/R51xTtRwryWlCZwzVGqP0t+9fxRaRWJ0aoxAOiLJ2XkcaUj0da6IpE5tMHnM8o7fybrqMgB
	qKk+0ztk1kOPY/HxYGsQXZnGzDMzI
X-Received: by 2002:a5d:480e:0:b0:313:e8f9:803 with SMTP id l14-20020a5d480e000000b00313e8f90803mr10421134wrq.3.1687973034586;
        Wed, 28 Jun 2023 10:23:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5irfaTSU9d07pC2xOiNetMGjhyeE25d5BHy3QPT9mMXOgkOvN5Qezr3VSFZ7w5nxI5atZbyA==
X-Received: by 2002:a5d:480e:0:b0:313:e8f9:803 with SMTP id l14-20020a5d480e000000b00313e8f90803mr10421126wrq.3.1687973034308;
        Wed, 28 Jun 2023 10:23:54 -0700 (PDT)
Date: Wed, 28 Jun 2023 13:23:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230628132122-mutt-send-email-mst@kernel.org>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Wed, Jun 28, 2023 at 05:06:40PM +0000, Parav Pandit wrote:
> > > >
> > > > Please let people just focus on fixing config space instead of
> > > > temporary cvq hacks.
> > >
> > > The ask is to have predictable sizing for existing defined config space field and
> > not keep infinitely growing by two interfaces.
> > 
> > I don't know what "predictable sizing" is or why does it matter.
> > 
> Because when device has two ways to access config space, it always have to account and build the interface that, hey some driver will not use DMA.
> Hence have it always in the MMIO accessible area.

Maybe I get it. You want to use the new features as a carrot to force
drivers to implement DMA? You suspect they will ignore the spec
requirement just because things seem to work?

There's some logic here, for sure. you just might be right.

However, surely we can discuss this small tweak in 1.4 timeframe?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

