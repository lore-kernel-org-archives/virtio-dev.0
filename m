Return-Path: <virtio-dev-return-12423-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9051C77B60
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 04:12:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C5CCD330A2
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 04:12:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC211986644
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 04:12:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 937D19864A2; Wed, 26 Apr 2023 04:12:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E3919865E2
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 04:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fjryldFlO6K7L7rnpJU-aQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682482346; x=1685074346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+6G41G9ENo4lB1hx4wAIewCaxIm4D+82/OaDTqpLAg=;
        b=PwDdJelbONFoHTaRace84pW5athgiMVKm076JqCa8A/j6KIskbvNkr39DMqNp+E13C
         lnlbqMWYVPzw7LtfL/kFwNEp9cRhIkPMXFNEIZIpCvNgI59Gw8zg5BjfKDUpbnVBG+fv
         4VbqRTD42sgdtLvuvDd7kFbb0HuQYQximRIAyjfXNBFtqxRvKKZUIx+keeHxUO8bIb18
         3TeC9kdGW4kUn207Uvq77jm/L6dwvvoPHsaQirZYiypdoJFBss+BRjyMj4UheEMAeYym
         Tp5DE6ADwVOf1PHYR2CI3UXfBw54qXc1HUenM6/3988A3xgVhI4uRR7oDrHb7c1Q7mXE
         SOnA==
X-Gm-Message-State: AC+VfDxob6afeeuhv/h1wdJGhQXCbvcEFSW+qCZZgCA5e6cJHQP/Am4b
	LbcoKnYq4UtCw5RkFlo8lCHXR8v1BdT96abhWm0mx8w1x2DEiaqDDRjQWi4O1s0dOLjMyTNTUCP
	yRmE27PDfxGo/9mi8ideG0AFreTUl
X-Received: by 2002:a5d:4f8e:0:b0:2ef:afe0:727a with SMTP id d14-20020a5d4f8e000000b002efafe0727amr558500wru.12.1682482346701;
        Tue, 25 Apr 2023 21:12:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CXNDhcY76eK2o8SkANkcUJHJRrSFxx58gbnF7ZEBcHYULN9Ta/o6XX/DYdsHpM/493Ex6bw==
X-Received: by 2002:a5d:4f8e:0:b0:2ef:afe0:727a with SMTP id d14-20020a5d4f8e000000b002efafe0727amr558489wru.12.1682482346362;
        Tue, 25 Apr 2023 21:12:26 -0700 (PDT)
Date: Wed, 26 Apr 2023 00:12:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230426000032-mutt-send-email-mst@kernel.org>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <20230425170341-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548148E35F4F0242A71FC5DFDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548148E35F4F0242A71FC5DFDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v13] virtio-net: support inner
 header hash

On Tue, Apr 25, 2023 at 09:39:28PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 25, 2023 5:06 PM
> > > On 4/23/2023 3:35 AM, Heng Qi wrote:
> > > >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device
> > > > Types / Network Device / Feature bits / Legacy Interface: Feature bits} @@
> > -198,6 +202,7 @@ \subsection{Device configuration layout}\label{sec:Device
> > Types / Network Device
> > > >           u8 rss_max_key_size;
> > > >           le16 rss_max_indirection_table_length;
> > > >           le32 supported_hash_types;
> > > > +        le32 supported_tunnel_hash_types;
> > 
> > this needs a comment explaining it only exists with some feature bits.
> > 
> Yes, it is already there.
> +Field \field{supported_tunnel_hash_types} only exists if the device supports inner header hash, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
> +
> I think it should be changed from "device supports" to "driver negotiated".
> 
> > > >   };
> > > In v12 I was asking this to move to above field from the config area
> > > to the GET command in comment [1] as,
> > >
> > > "With that no need to define two fields at two different places in
> > > config area and also in cvq."
> > 
> > I think I disagree.
> > the proposed design is consistent with regular tunneling.
> > 
> Sure.
> I understand how config space has evolved from 0.9.5 to know without much attention, but really expanding this way is not helpful.
> It requires building more and more RAM based devices even for PCI PFs, which is sub optimal.

No, this is ROM, not RAM.

> CVQ already exists and provides the SET command. There is no reason to do GET in some other way.

Spoken looking at just hardware cost :)
The reason is that this is device specific. Maintainance overhead and
system RAM cost for the code to support this should not be ignored.

> Device has single channel to provide a value and hence it doesn't need any internal synchronization between two paths.
> 
> So, if we add a new feature bit as VIRTIO_F_CFG_SPACE_OVER_AQ it is an improvement.
> But it still comes with a cost which device cannot mitigate.
> The cost is, 
> 1. a driver may not negotiate such feature bit, and device ends up burning memory.
> 1.b Device provisioning becomes a factor of what some guests may use/not use/already using on the live system.
> 
> 2. Every device needs AQ even when the CVQ exists.
> 
> Hence, better to avoid expanding current structure for any new fields, specially which has the SET equivalent.
> 
> But if we want to with the path of VIRTIO_F_CFG_SPACE_OVER_AQ, it is fine.
> More things can evolve for generic things like config space over AQ.

I am not sure what does VIRTIO_F_CFG_SPACE_OVER_AQ mean, and what are
these costs.  What I had in mind is extending proposed vq transport to
support sriov. I don't see why we can not have exactly 0 bytes of memory
per VF.

And if we care about single bytes of PF memory (do we? there's only one
PF per SRIOV device ...), what we should do is a variant of pci
transport that aggressively saves memory.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

