Return-Path: <virtio-dev-return-11904-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEE9C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:07:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D338398FAA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:07:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7A06986400
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:07:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB0E89863D6; Mon,  3 Apr 2023 15:07:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BCC89863DD
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2vjN1G3INpKmCQhmM2U0eA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhOlvUnZPjx9ar17FWMMNs1oDfbZiA03vaE0YQb5kLs=;
        b=uPI3Mm7NyxLkfzPX4cBsbevMBfICd+0JjO/VYrautqHmPS3NCmlcVXWvL7UJQziqBx
         n/epiNFPTTSsEXRqFouzD5mm8hWjAqRmKlKq/WtbLKs1atagDK1kYXiYXCWlytjCFsfl
         LTx1Wqd4Kkbx7XhBFWhngtVCO4wflMW9N+0fxDlt0ZIHnG18PJP6BLqAvc7y+PXDnqr6
         UFcwe1HiOFiO4phji1Kr8f8R6N5xWOwD3tc2yj+yqRldUOI7btj0rFc+XU5QtLKRg+u5
         E0Ub/Oeq0a++ir0h70ZkrHBQnP4WW5eZLkKH6BunnkS7m8i0d+D7xSQuNNAnBB5ue9eo
         RWJQ==
X-Gm-Message-State: AAQBX9e4RaBzi0ztV07aQkQIbzZm+OdcivAoxcGXoA/4AsWh4fTUDjNn
	cOuc3w/KrPTpEaglpCdKsXUVPALHxL9VralnLJPulVvK941tt4QqpJB/C9lvOMe3sptp4Moy27z
	8rgem6XhBIrff91F4H2AEECI7GYDJ
X-Received: by 2002:a05:6402:1842:b0:4fd:21a6:a649 with SMTP id v2-20020a056402184200b004fd21a6a649mr28884550edy.40.1680534414287;
        Mon, 03 Apr 2023 08:06:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350aI4Aq4a5QDKVoZ2QKRSmzeCqO7cLjoLBsmFhSxb9Lpx1R8DL5KQpptipgenHuWe5X8tYwmKg==
X-Received: by 2002:a05:6402:1842:b0:4fd:21a6:a649 with SMTP id v2-20020a056402184200b004fd21a6a649mr28884529edy.40.1680534413999;
        Mon, 03 Apr 2023 08:06:53 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:06:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230403110320-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device

On Mon, Apr 03, 2023 at 02:57:26PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 3, 2023 10:53 AM
> > 
> > On Fri, Mar 31, 2023 at 05:43:11PM -0400, Parav Pandit wrote:
> > > > I can not say I thought about this
> > > > deeply so maybe there's some problem, or maybe it's a worse approach
> > > > - could you comment on this? It looks like this could be a smaller
> > > > change, but maybe it isn't? Did you consider this option?
> > >
> > > We can possibly let both the options open for device vendors to implement.
> > >
> > > Change wise transport VQ is fairly big addition for both hypervisor
> > > driver and also for the device.
> > 
> > OTOH it is presumably required for scalability anyway, no?
> No.
> Most new generation SIOV and SR-IOV devices operate without any para-virtualization.

Don't see the connection to PV. You need an emulation layer in the host
if you want to run legacy guests. Looks like it could do transport vq
just as well.

> > And presumably it can all be done in firmware ...
> > Is there actual hardware that can't implement transport vq but is going to
> > implement the mmr spec?
> > 
> Nvidia and Marvell DPUs implement MMR spec.

Hmm implement it in what sense exactly?

> Transport VQ has very high latency and DMA overheads for 2 to 4 bytes read/write.

How many of these 2 byte accesses trigger from a typical guest?

> And before discussing "why not that approach", lets finish reviewing "this approach" first.

That's a weird way to put it. We don't want so many ways to do legacy
if we can help it.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

