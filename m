Return-Path: <virtio-dev-return-13476-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA79BC00528
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 06:13:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E08BC1318D6
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 06:13:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF1EF986466
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 06:13:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BB02E984033; Mon,  7 Aug 2023 06:13:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1FB298612D;
	Mon,  7 Aug 2023 06:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VpA8oLb_1691388779;
Message-ID: <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 7 Aug 2023 14:02:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access and control the member devices

On Fri, 4 Aug 2023 12:49:04 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, August 4, 2023 4:03 PM
>
> > > >
> > > > At this point to have port for owner device requires creating a dedicated
> > switching object, to be located sometimes side by side inside the owner,
> > sometimes outside.
> > > > All of these cases to be crafted, please rethink if this is _really_ needed as
> > virtio object or not.
> > >
>
> > >
> > > YES.
> > >
> > > We can hear others.
> > >
> > > @Jason @Michael
> > >
> > >
> > > Thanks
> >
> >
> > This is so abstract, hard to have any position as I'm not sure what we are
> > discussing. If some virtio devices have an integrated switch then ability to
> > control the switch through virtio seems useful.
> >
> True, for us, at this point we do not have plan to expose virtio switch device because users are not blocked on it.


Also for us.

But we need to limit the ip of every member device. That is useful for cloud.
Because the user of each VM is untrustworthy. We must limit the ip traffic of
every member device.

We have two choose:

1. add feature to device by cvq of pf(or admin queue?), that can limit the ip(receive and transmit).
2. add feature to switch, it can limit the ip for every port. If we choose this
   way, I will try introduce the simple switch concept to the virtio-net.
   Because except this we have not more requirement for the switch. So we donot
   plan to introduce a complex switch.

Thanks.


>
> > Re:queues - it's not by chance that we have multiple admin queues.
> > So driver can dedicate one queue to filtering commands if that's felt to be
> > important.
> >
> Admin queue currently do not send non admin command of the device.
> Would you propose admin queue for something else also for rtc or console or cryto device and indicate its role so device can understand what is coming to it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

