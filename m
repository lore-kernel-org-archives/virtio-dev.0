Return-Path: <virtio-dev-return-13448-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A52EC04A94
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:28:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B3B231FF82
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:28:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFE5F9866E2
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:28:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A27B19866C1; Thu,  3 Aug 2023 11:28:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F7949866B1;
	Thu,  3 Aug 2023 11:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VoygpEH_1691062117;
Message-ID: <1691062042.915913-6-xuanzhuo@linux.alibaba.com>
Date: Thu, 3 Aug 2023 19:27:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B976E62998B8B61267C8DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060755.2124963-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54814C7410C51E08348B14A4DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061333.287353-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481940B21B24FF817891D34DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481940B21B24FF817891D34DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: RE: RE: [RFC] virtio-net: support access and control the member devices

On Thu, 3 Aug 2023 11:21:08 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Thursday, August 3, 2023 4:46 PM
> >
> > On Thu, 3 Aug 2023 11:13:28 +0000, Parav Pandit <parav@nvidia.com> wrote:
> > >
> > > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Sent: Thursday, August 3, 2023 4:36 PM
> > >
> > >
> > > >
> > > > OK.
> > > >
> > > >
> > > > >
> > > > > > +        u8 mac[6];
> > > > > > +        le16 status;
> > > > > > +        le16 max_virtqueue_pairs;
> > > > > > +        le16 mtu;
> > > > > > +        le32 speed;
> > > > > > +        u8 duplex;
> > > > >
> > > > > We should above split constant config space fields and below run
> > > > > time fields
> > > > meant for debug purpose.
> > > > > We are working on the member device migration proposal and below
> > > > > fields
> > > > belong to "device context" should be available through such separate
> > command.
> > > > > But if you do it before, please cover the whole device state and
> > > > > we will be
> > > > able to reuse for multiple use-cases.
> > > >
> > > >
> > > > I am not sure I got fully.
> > > >
> > > > I will try.
> > >
> > > Something like below.
> > >
> > > struct virtio_field {
> > > 	le32 type;	/* contains the value of enum virtio_dev_field_type */
> > > 	le32 size;	/* size of the data field in bytes */
> > > 	u8 data[];
> > > };
> > >
> > > enum virtio_dev_field_type {
> > >         VIRTIO_DEV_PCI_COMMON_CFG, 	/*  struct
> > virtio_dev_common_cfg */
> > >         VIRTIO_DEV_CFG_SPACE,	/* config space fields, for net  struct
> > virtio_net_config etc */
> > >         VIRTIO_DEV_QUEUE_CFG,	/* struct virtio_dev_q_cfg */
> > > };
> > >
> > > In your use case, it is VIRTIO_DEV_CFG_SPACE, just blob of data bytes.
> >
> >
> > That is ok for me.
> >
> > My question is what is ctx? How do we decide what to put in ctx? How do we
> > define ctx?
>
> In the live migration use case flow, ctx is collection of all the device information.
> I only listed 3 above for simplicity of our discussion.
> In specific config space query, like your example,
> The owner driver asks for specific piece of the context to query by supplying the bitmap for above enum.


OK. I see.

Let we start from this.

Thanks.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

