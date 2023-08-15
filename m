Return-Path: <virtio-dev-return-13532-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8E7C001DB
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 03:37:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ADC3EC6117
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 03:37:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A40C69863EE
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 03:37:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9803A98634B; Tue, 15 Aug 2023 03:37:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8642098633F;
	Tue, 15 Aug 2023 03:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vpq6OlA_1692070641;
Message-ID: <1692069010.1946628-2-xuanzhuo@linux.alibaba.com>
Date: Tue, 15 Aug 2023 11:10:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Satananda Burla <sburla@marvell.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1691481880.8297818-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481425BD4582648FDD1B127DC17A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481425BD4582648FDD1B127DC17A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: virtio-net ip restriction.

On Mon, 14 Aug 2023 13:03:53 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, August 8, 2023 1:35 PM
> >
> > ## Background
> >
> > For cloud, the ip restriction is important. Because the user of the vm is
> > untrustworthy. One user may use the ip of another to config the netdevice to
> > receive and send packets. So we need to restrict the ip traffic of the device(or
> > port).
> >
> A VM can do the same with the mac address too.
> Why is mac ignored?

On the cloud, the mac is not important, the DPU forwards the packets by the ip.
But you are right, we can introduce the support for mac.

>
> > ## Implement
> > Now we have these choice:
> >
> > 1. introduce the switch(as the part of pf or as a separate device under all PF
> >    and VFs ), the switch support rx/tx filter 2. the virtio-net device support the ip
> > restriction
> >
> #1 is the right approach, it is not either or.
> Virtio switch object can be part of the virtio-net device or it can be indepdent device in itself.
> So the definition we do should be generic enough so that it can be done as part of indepdent device in future without replicating all.
>
> The concept of switch port etc is needed.

For the switch part, I am ok.

But I would to know can we have two?



>
> >
> > Parav wrote:
> > > I understood that you for some reason do not need restrictions for the PF.
> > > I do not know why you don't need it. :) Most cloud setups that I came
> > > across so far, needs it, but ok...
> >
> > PF is used by the administrator, so the ip restriction for the PF is not important.
> > But we can have this feature.
> >
> In some cloud a PF is also owned by the tenant.
> Hence its administration to be done outside of the PF.
> Therefore the virtio switch object definition to be built for long term and apply to a narrow case for now as PF->VF.

YES.

But I think that the #2 is ok.

Your plan of the switching PF is the universal design to implement the ip
restriction.

But the ip restriction is the common requirement in virtio case.
We can support it in a virtio specific way.

>
>
> > > The design for the switch object needs to cover the PF as well, even though it
> > may not be done initially.
> > > (hint: an abstraction of switch port to be done, instead of doing things directly
> > on the group member id).
> > >
> > > We are seeing use cases reducing of having switch located on the PF for its
> > VFs.
> >
> > So for you, we should introduce a switching PF?
> >
> Yes.

You said that the use cases for switching PF are dwindling. But you prefer to
implement ip restriction with switching PF. Am I right?

We know that the switch under all(PF, VF) is more complex.
So we all not plan to implement it.

Then how about we do not implement the switching PF for now.
We support ip restriction by the #2.

Then we can have an independent switch under all in the future.

>
> > > So please reconsider.
> > > I remember you mentioned in past in other thread, that mac etc is controlled
> > from the infrastructure side.
> >
> > YES.
> >
> Hence the administrative PF doing switching and VF configuration is desired.

I do not got fully.

>
> > > So, I repeatedly ask if you _really_ need to have the switch object as part of
> > the owner PF or not.
> >
> > For me, that are all ok.
> > Could you explain the difference between these?
> > So I would to know which one is better and which one is simper?
> >
> > > Which sort of contradicts with locating the administrative switch on the
> > owner PF.
> >
> > Why?
> >
> > For us, all is on the DPU.
> >
> If all is on the DPU, can the ip restriction be applied on the DPU for the VFs (where there may not be any virtio net device).
> If so, why do we need to introduce things now?

In the past, we provided virtual machines. All virtual machines belong to
different tenants. DPU has ip restriction function by default(without virtio).
But more and more complex forms of services began to appear, they work on the
HOST. But they create virtual machines or Dockers to provide to their tenants.
For performance, each virtual machine or Docker uses a separate NIC provided by
the DPU. So they need to configure IP restrictions for these NICs.

So the form of the cloud is changing, more and more configurations are need by
the users from the host.


Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

