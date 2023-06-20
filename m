Return-Path: <virtio-dev-return-12991-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FB8EB64DA
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 02:40:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 06B7DF3F4B
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 02:40:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5A039864BD
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 02:40:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D379C98638D; Tue, 20 Jun 2023 02:40:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B94DB9863BD;
	Tue, 20 Jun 2023 02:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VlZmPt4_1687228834;
Message-ID: <1687228777.3941622-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 20 Jun 2023 10:39:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B445FDE3A718260C0A0EDC55A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1686810919.3486235-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B46BC5108D0BB9D68ED0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481B46BC5108D0BB9D68ED0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: RE: About custom device counter

On Mon, 19 Jun 2023 20:40:54 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Thursday, June 15, 2023 2:35 AM
>
> > > Debug counters are useful to have.
> > > I agree that they may be vendor specific.
> > > We often try to abstract and define as much as vendor neutral as possible.
> > >
> > > So we should probably first put our efforts to see if more than one vendor can
> > use it.
> >
> > I agree.
> >
> > >
> > > Assuming there is some vendor specific counters, I imagine to come from a
> > separate vendor specific query command.
> > > This is to keep standard counters to avoid mixing with vend_specific.
> >
> > Yes, I agree that these are two separate channels.
> >
> > But I don't think we need to wait for the first job to finish.
> >
> I am saying if you have a counter in mind, lets discuss if we can generalize it, and if we can it falls in the first general bucket.
> If we cannot it falls in second vendor specific bucket.


That is ok.


>
> > It is conceivable that standard counters will be displayed on ethtool in the
> > future. For counters from different manufacturers, we can display them in
> > /sys/class/net/eth0/vendor_couters.
> >
> I understood that you want to show device specific counters.
> We can avoid bringing up the sw interface for a moment.
> For above specific suggestion, vendor counters in sysfs for sure will not be acceptable as no vendor specific sysfs can exist anymore.
>
> One can implement devlink health reporting counters as needed.


I am ok for any way to show this to the users.


>
> > Here we can tell the user that these are only for the current device, and may
> > change during the migration process.
> >
> Sure.
>
> >
> > >
> > > > Of course I know that doing this might hurt migration. But what I
> > > > want to say is, why does it affect live migration? These counters we
> > > > plan to give to users through ethtool -S, and some changes have
> > > > taken place in the ethtool counters output by users. Does this have
> > > > any practical impact? Or do we directly use some other output in a
> > > > way, we can clearly tell the user that these counters may change
> > > > during the migration process. For example, the driver is migrated to
> > > > some new devices. These devices support some new counters. I think
> > > > users should be able to see these new counters. These new counters may be
> > the purpose of the migration.
> > >
> > > Counters which are well defined non-vendor specific should be able to
> > migrate to destination on best effort basis.
> > > For well defined counters if device A at src support N counters, on migrated
> > destination, it should be N.
> > > This should be able to achieve with feature provisioning infra via group owner
> > command.
> >
> > Yes, for standard counters.
> >
> > >
> > > >
> > > > We don't need to support live migration at this point.
> > > When done on best effort level, infra exists, vendor has ability to
> > incrementally implement it.
> >
> >
> > For the standard counters, the manufacturer will be very willing to use it. I just
> > want to introduce the capabilities of the manufacturer's customized.
> >
> Lets try to generalize first and if we fail consider the vendor specific counters.


OK

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

