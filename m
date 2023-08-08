Return-Path: <virtio-dev-return-13501-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EF9C04A94
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 06:48:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 49B8F74108
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 06:48:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B513986533
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 06:48:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F9D198403A; Tue,  8 Aug 2023 06:48:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CC01986460;
	Tue,  8 Aug 2023 06:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VpK8DQs_1691477274;
Message-ID: <1691477071.6894073-9-xuanzhuo@linux.alibaba.com>
Date: Tue, 8 Aug 2023 14:44:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
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
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
 <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
 <PH0PR12MB5481D3BDFB943D7856D846A9DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvzU4SE8wBoTE6A56S9bGM_rtv=nU113WhEUL2EBEBaug@mail.gmail.com>
 <PH0PR12MB5481C7090E20AF17A9B2C437DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481C7090E20AF17A9B2C437DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access and control the member devices

On Tue, 8 Aug 2023 04:16:59 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, August 8, 2023 9:21 AM
>
> > > The idea is to introduce filters on the new virtio switch object for tx and rx
> > both.
> >
> > It can be done in this way for sure but the question is why it must be done in
> > this way.
> This option because it is in use by very big and mature eco system of multiple sw stacks, kernel subsystem, drivers, and nics for several years now.
>
> > A drawback of using switch is that it introduces dependencies.
> >
> Feature is not a dependency. :)
>
> > > A virtio switch object can be part of a existing virtio device or a new virtio
> > device type in itself.
> >
> > That's fine.
> >
> > >
> > > Xuan,
> > > As we discussed, since the owner device packets also needs to be
> > > filtered, potentially outside of the owner device itself,
> >
> > This seems the admin request out of the scope of virtio.
> >
> Not really, it could be virto switch device that manage PF also.
> At that point, there may be two functions, PF and switching PF, switching PF filters the traffic of the PF.
>
> Anyways, I am just not finding it useful enough at current point in time for us as far mature alternatives exist that users are comfortable with.
> I would like to listen to Xuan if they really have use case for having switching PF as virtio object or not.

So the switching PF is that there is a switch under all devices?

If we use the switch rx/tx filter for the ip restriction, the PF with switch is
enough,  we do not need the ip restirction for the PF.

Thanks.


>
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

