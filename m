Return-Path: <virtio-dev-return-13464-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC58C001DB
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:27:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 820FA157EEE
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:27:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C5D898683A
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:27:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 608759866E4; Fri,  4 Aug 2023 06:27:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A7519866DE;
	Fri,  4 Aug 2023 06:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vp.HYjT_1691130412;
Message-ID: <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
Date: Fri, 4 Aug 2023 14:18:34 +0800
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
In-Reply-To: <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access and control the member devices

On Thu, 3 Aug 2023 13:15:59 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Thursday, August 3, 2023 5:11 PM
> >
> > On Thu, 3 Aug 2023 11:39:20 +0000, Parav Pandit <parav@nvidia.com> wrote:
> > >
> > > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Sent: Thursday, August 3, 2023 5:00 PM
> > >
> > >
> > > > > Admin command is what is suitable for device management, including
> > > > features and configspace fields setup.
> > > >
> > > > I agree.
> > > >
> > > > But some configuration such as mac, ip(eswitch rule) for vfs that
> > > > are suitable for the admin queue?
> > > Mac, why not.
> >
> > Mac is the concept of the virtio-net.
> > How do abstract it? Or a admin queue command
> > VIRTIO_ADMIN_CMD_NET_MAC_SET?
> >
> I don't think we should abstract it.
> A one command that can set one or multiple fields of the config space is fine.


So, you mean we will have many commands like:

VIRTIO_ADMIN_CMD_NET_MAC_SET
VIRTIO_ADMIN_CMD_NET_MTU_SET
VIRTIO_ADMIN_CMD_NET_SPEED_SET
VIRTIO_ADMIN_CMD_BLK_XXX1
VIRTIO_ADMIN_CMD_BLK_XXX2
.....

Or a generic command with the offset and size of the field of the config space?


>
> > >
> > > Eswith rules should be programmed through the flow vq, that we are working
> > with Heng, Satananda and David.
> >
> > I know you are doing for the n-tuple receive flow filters.
> >
> > Here I mean we want to limit the ip of the VF. In the cloud case, the vm is
> > untrust, we should force the vm that it just can use the specified ip.
> >
> That is fine,
>  It is just that the flow filter commands may be different for ingress and egress direction of the VF.
> The command that we are adding does not have concept of switch ports, because there is no switch.
>
> For eswitch case, you would define more commands that will have switch ports...

Yes, for this requirement, I will introduce the concept of simple switch into virtio-net.
Then we can configure the ip of each port of the switch.

>
> > Then can we configure the ip of the vfs via the admin queue?
>
> It should be through the flow filter queue so that it can be performant like nic tx/rxq which has dedicated role.

Why flow filter queue? I think the cvq is ok.

In our case, the ip of the port is configured by the admin on the setup of the
device.

And that is configured to the switch. I think the flow filter is working inside
the deivce.

Thanks.


> For switch use case command formats or fields needs extension.
>


















---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

