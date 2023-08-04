Return-Path: <virtio-dev-return-13467-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728C2C04A94
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:59:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CB70978DB4
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:59:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFFF098684D
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:59:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D68B9843C5; Fri,  4 Aug 2023 06:59:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 892099866DE;
	Fri,  4 Aug 2023 06:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vp.SFEL_1691132384;
Message-ID: <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
Date: Fri, 4 Aug 2023 14:54:09 +0800
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
In-Reply-To: <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access and control the member devices

On Fri, 4 Aug 2023 06:37:37 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Friday, August 4, 2023 11:49 AM
>
> > So, you mean we will have many commands like:
> >
> > VIRTIO_ADMIN_CMD_NET_MAC_SET
> > VIRTIO_ADMIN_CMD_NET_MTU_SET
> > VIRTIO_ADMIN_CMD_NET_SPEED_SET
> > VIRTIO_ADMIN_CMD_BLK_XXX1
> > VIRTIO_ADMIN_CMD_BLK_XXX2
> > .....
> >
> > Or a generic command with the offset and size of the field of the config space?
> >
> Mix of both. One command per field is too much.
> Going forward we may not have single boxed config space as many of the config is coming through the cvq logically separate per functionality.
>
> Hence, command should be one per device type, that can set one or more attributes of the device.
> Attribute may be residing in the config space or otherwise.
>
> VIRTIO_ADMIN_CMD_NET_SET
> Input: bitmap (bit per field of config space or otherwise)
> Input: field matches to bitmap
>
> VIRTIO_ADMIN_CMD_BLK_SET


Great! Sounds good.

>
> > > It should be through the flow filter queue so that it can be performant like nic
> > tx/rxq which has dedicated role.
> >
> > Why flow filter queue? I think the cvq is ok.
> >
> For any sensible use of the switch, beyond few filter commands needs a high perf queue.
>
> > In our case, the ip of the port is configured by the admin on the setup of the
> > device.
> >
> > And that is configured to the switch. I think the flow filter is working inside the
> > deivce.
> >
> I lost you on your last two points in terminology of admin, device etc.
>
> We have
> 1. owner device
> 2. member device
> 3. Switch is typically on a owner device, having switch port for each member device.
>
> a. Owner device programs switch rules for ports.
> b. Owner device also may program flow filter rules of its own for RQ for RSS etc.
> c. Member device programs follow filter rules of rss and more.
>
> Flow filters are generic framework applies to all 3 use cases.

I know the gap. For us, the switch is under all devices(including the owner device).
So we need to control the switch separately.

In your structure, the owner device works as the switch. It has port to connect
to the vf devices.


Thanks.



















---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

