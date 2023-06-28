Return-Path: <virtio-dev-return-13112-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B50EB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 02:38:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 93C2F6846B
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 02:38:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B6C19865A8
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 02:38:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B1E298654E; Wed, 28 Jun 2023 02:38:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63B0E98654C;
	Wed, 28 Jun 2023 02:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vm7qztT_1687919921;
Message-ID: <1687918864.3728812-2-xuanzhuo@linux.alibaba.com>
Date: Wed, 28 Jun 2023 10:21:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org,
 parav@nvidia.com,
 virtio-comment@lists.oasis-open.org,
 Jason Wang <jasowang@redhat.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
 <20230627115247-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230627115247-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member to the device

On Tue, 27 Jun 2023 12:02:41 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Jun 27, 2023 at 04:23:05PM +0800, Xuan Zhuo wrote:
> > So, this is how I understand the process of creating vf:
> >
> > 1. Create a PCI VF, at this time there may be no backend virtio device, or there
> >     is only a default backend. It does not fully meet our expectations.
> > 2. Create device or migrate device
> > 3. Bind the backend virtio device to the vf
>
> I can see this making sense as a feature bit that says VFs are not
> initialized by default and must first be setup through an admin command.
> This will likely need to be a feature bit because it's changing
> behaviour outside of admin commands.
>
> Then, we can have:
>
> 	ADMIN_SETUP VF#
> 	ADMIN_CLEANUP VF#
>
> I like this because this generalizes CREATE/DESTROY that SIOV guys proposed.

Great!!

>
>
> Why do we need an id as a level of indirection though? What is wrong
> with just using VF# directly?

I think VF# is ok. I also need to use it. But we need an ID for virtio device
not the transport(PF, VF).

What I want to emphasize is that PCI(pf or vf) is a transport, it is only used
to connect the virtio driver and the virtio device. Right?

The virtio device does not necessarily exist depending on PCI. For example, a
virtio device is migrated from another DPU, and it is not associated with any
PCI. What I have always wanted to say is that this device(not PCI) must have its
own ID, which has nothing to do with the transport.

Now we want to use this migrated device and connect it to the corresponding
vm (migrated from the same host). We can passthrough vf to this vm. But how do I
tell our DPU to bind this migrated device with this vf?
We can specify the VF by the VF#, but how can we specify the virtio device?
Maybe there are two migrated virtio device.

Maybe we should compare it to the case of using PF directly before. The biggest
difference here is that PF is directly hot-plugged by the DPU, so when a
user(custom) buys a virtio-net device, the DPU directly inserts a new PCI device
on the host. Now the vf is created by the user, and only the user knows how to
use each one. We cannot directly bind the device purchased or migrated by the
user to a certain vf. We need the user in the host to bind the vf(transport) to
a certain virtio device.

Thanks.






>
>
>
> --
> MST
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

