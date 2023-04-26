Return-Path: <virtio-dev-return-12425-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2F3C7618E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 05:02:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3B6942A8FB
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 05:02:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14D8C986651
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 05:02:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E80C7983FE8; Wed, 26 Apr 2023 05:02:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3A709865E2
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 05:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xeLpuxgON5urgKbKZX3I9Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682485325; x=1685077325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZrr8Ty45o1qPgqmMcFcgcEdTpRlPdd7iZZPFQE5IQ0=;
        b=BVqt72UuU0txXm1lgTpJUrs3TQB2kx0mag71eR8yJjR9NF3z2SGaQEVNBZcU1p/6Mf
         85aOctAF1A3vtXBv/rKE0ziDsxLbznMvy98PQiN6Ata0zG6RPb09CZNvEr8CAgKO/yx4
         6rnZnRrgCoZIWFg5OpuN765fwKTwalffTeVI/Qp5NDo04lPzdjzaBqNYhEuZ8vsDP6BI
         L+g701zBrGpLHgavqf60eeuSjsUai7HpXhlYu7rIWXMqW+k8puQ+vWAG/Kj+tfI1IvjN
         6+EWaufUlSjgcCdpwfTVQ+OHMCJDXY1DzSZZVOOS9pSAf4WuF2ggQ4uxUPSTYNKijpUN
         SQrA==
X-Gm-Message-State: AAQBX9fVu17vcUxwduK+Qahd+30skwDbhhZ9GWzPJ+FlfScxV5Tk8bXo
	ySnBKlUPKCzIYNG+T/bn4BG7Us0vXqm2KBeFd4Q/mvxu86y6NJdTPLRw46OftM9uyrUgbkPDRmj
	NMAB/RKuYq81g08tkT2wmplJnkIuO
X-Received: by 2002:a05:600c:210c:b0:3f1:a71b:d46b with SMTP id u12-20020a05600c210c00b003f1a71bd46bmr6343779wml.41.1682485325513;
        Tue, 25 Apr 2023 22:02:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350YXHyqytFcGOphyQvvfB49oJd+YwX2qtPiI5fsqZNz91UPMgpUpjpwFf7sjg5dOftkLjGs5Jg==
X-Received: by 2002:a05:600c:210c:b0:3f1:a71b:d46b with SMTP id u12-20020a05600c210c00b003f1a71bd46bmr6343760wml.41.1682485325197;
        Tue, 25 Apr 2023 22:02:05 -0700 (PDT)
Date: Wed, 26 Apr 2023 01:02:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230426004838-mutt-send-email-mst@kernel.org>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <20230425170341-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548148E35F4F0242A71FC5DFDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230426000032-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ABA342C384B29E569287DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481ABA342C384B29E569287DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v13] virtio-net: support inner
 header hash

On Wed, Apr 26, 2023 at 04:27:34AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 26, 2023 12:12 AM
> > 
> > 
> > No, this is ROM, not RAM.
> > 
> For VFs it is not ROM because one might configure VF with different feature bits.

Hmm interesting. If you want to block a specific feature from VF you
probably want to do it for things like LM compat, and I feel the way to
do it is in software not in hardware because you want e.g.  cross-vendor
compatibility, which specific vendors rarely care about.  No? For
example, we have all the crazy amount of flexibility with layout of pci
config space (not virtio config) that we have zero control over unless
we want to go and mandate all that in virtio - which would put us on a
treadmill of chasing each new pci capability added.

BTW I generally wonder about why this aggressive fight against memory
mapped registers does not seem to be reflected in the pci spec at all,
which seems to keep happily adding more memory mapped stuff for control
plane things in each revision. If anyone, I would expect these guys to
know a thing or two about pci hardware.


> > > CVQ already exists and provides the SET command. There is no reason to do
> > GET in some other way.
> > 
> > Spoken looking at just hardware cost :)
> Not really. The CVQ is already there, no extra overheads.
> > The reason is that this is device specific. Maintainance overhead and system
> > RAM cost for the code to support this should not be ignored.
> Sure. As above its not a new and such query occurs only once or extremely rare.

It will have to be done each time user runs ethtool -k, no?
Unless you cache this in software then it's extra RAM :)


> > 
> > > Device has single channel to provide a value and hence it doesn't need any
> > internal synchronization between two paths.
> > >
> > > So, if we add a new feature bit as VIRTIO_F_CFG_SPACE_OVER_AQ it is an
> > improvement.
> > > But it still comes with a cost which device cannot mitigate.
> > > The cost is,
> > > 1. a driver may not negotiate such feature bit, and device ends up burning
> > memory.
> > > 1.b Device provisioning becomes a factor of what some guests may use/not
> > use/already using on the live system.
> > >
> > > 2. Every device needs AQ even when the CVQ exists.
> > >
> > > Hence, better to avoid expanding current structure for any new fields,
> > specially which has the SET equivalent.
> > >
> > > But if we want to with the path of VIRTIO_F_CFG_SPACE_OVER_AQ, it is fine.
> > > More things can evolve for generic things like config space over AQ.
> > 
> > I am not sure what does VIRTIO_F_CFG_SPACE_OVER_AQ mean, and what are
> > these costs.  
> What I had in mind is all the rarely used and/or one time used config registers are queries over Q interface.
> A device exposes a feature bit indicating that it offers it via a q interface instead of MMIO.
> A net device already has a CVQ and its almost always there, so utilizing an existing object to query makes perfect sense.
> It can be argued other way that, hey other devices cannot benefit for it because they missed the CVQ.
> So may be a AQ can service for all the device types.

Exactly.

> > What I had in mind is extending proposed vq transport to support
> > sriov. I don't see why we can not have exactly 0 bytes of memory per VF.
> > 
> VFs other than legacy purposes do not undergo mediation via PF.
> Legacy is the only exception; newer things is direct communication for a PCI device PF, SRIOV VFs and SIOV devices.
> 
> > And if we care about single bytes of PF memory (do we? there's only one PF per
> > SRIOV device ...), what we should do is a variant of pci transport that
> > aggressively saves memory.
> Users already deploy 16 to 30 PFs coming from single physical card today in single system.
> Building things uniformly for PF, VF, SIOV devices is coming for free.
> 
> It is not only this byte, but we also see that device needs to offer many capabilities more than boolean flag, so putting non latency sensitive item on the MMIO area hurts overall.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

