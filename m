Return-Path: <virtio-dev-return-13053-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165F7EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:37:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7338F444A
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:37:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 577909865D6
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:37:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 402899865D0; Thu, 22 Jun 2023 17:37:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C3219865D4
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 17:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2qWJaCiQPFuvas44qf9W0A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687455465; x=1690047465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwe5lsVAJ+y2vL6RBRQX4tStJcZcYnKTBo3ift2ySaQ=;
        b=k7/zBUqWjjxOWAbgiEsJVsbWsNIXE42nzRKFfH6fSfnU+Rcl7+P/kFx0AdntCj0F6S
         VY+FQiHn5ptpiKehBoxYcYtlf1nNpuiOo4/ECYlOA5zuGDH+mxuAiQv8SAyX0CPnjYeu
         pXNy6jm5+1nB30fJmAWPjudcgX8BN/rPgvqk7v89iVrINsvrek9Vknd/Y/xNdKknOAtG
         taC7aXKbev6pKOsyTwup7t4VyXyaNK4kjKfF8GkhTAiavBVLMgOyDMC/KhD2Ry8zxkaQ
         MA5ux7gOjKSUbVSafhxXrmzabRj2FSI59WJw3kK1wnacwWeaeEmzzxgP3j4iaCWQQ0x8
         TmBw==
X-Gm-Message-State: AC+VfDz1UtU2ZSfwgy9tqN+Y/AEi4QKdY0cqZBPi6oV7YinwVKIUluBX
	8j+Cd/Pg5wgeclCkTSVnVA7Mexm+nRyqtHPvUFz/AmLCHKXY2AjYqXYgt9Kcnsyuw7oSfLaQ39h
	yqinU2+se/SEhuoe0Ayy6ZJGmW1Qv
X-Received: by 2002:a17:906:85d4:b0:98d:63c5:d133 with SMTP id i20-20020a17090685d400b0098d63c5d133mr289092ejy.45.1687455464864;
        Thu, 22 Jun 2023 10:37:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ah+TC9Wl0YDju6y/Gd3A2Chso539wQpApr4ZQjDFZCD9xD/+bhopePWGw6K+DDJLW1VtvRg==
X-Received: by 2002:a17:906:85d4:b0:98d:63c5:d133 with SMTP id i20-20020a17090685d400b0098d63c5d133mr289085ejy.45.1687455464567;
        Thu, 22 Jun 2023 10:37:44 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:37:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622132837-mutt-send-email-mst@kernel.org>
References: <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Thu, Jun 22, 2023 at 05:15:50PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 22, 2023 1:11 PM
> 
> > > Provisioning driver usually do not attach to the member device directly.
> > > This requires device reset, followed by reaching _DRIVER stage, querying
> > features etc and config area.
> > > And unbinding it and second reset by member driver. Ugh.
> > > Provisioning driver also needs to get the state or capabilities even when
> > member driver is already attached.
> > > So config space is not much a gain either.
> > 
> > Actually it's RO so you *can* read it without any issues:
> 
> It is RO but not same across all devices.

If you provision VFs differently. I got it.

> > - block guest access to status
> > - check DRIVER.
> > If set:
> > 	- read features, config
> > If not set:
> > 	- read features, config
> > 	- reset
> > 
> This is what I explained.
> It is more messy if you equate to GET command has mess.

At least it works.

> > I am not saying it is elegant but then all of vdpa pile of hacks is not elegant.
> > 
> I don't want to comment for vdpa. But it is not part of the spec...

Neither is QEMU.  It's one of spec implementations. Yes, we care about
not adding blockers for features that, superficially, might make
sense for them.

> > And I am all for building something better but we didn't build it yet.
> 
> The proposal for 1.4 is literally very simple as below.
> 1. All existing fields of cfg space stays in cfg space
> 2. Any new capabilities to be queried, query using a vq (aq, cfgvq, whatevervq).
> 3. Optionally existing fields can be queries over vq of #2
> Once this arrive, no need for new GET commands.
> Till that time, don't keep infinitely grow the cfg space.
> Any next addition to cfg space, should work on defining the cfgvq.

Simple, but short sighted. I know you guys don't support your
hardware for 10-20 years but for software people do.
And so "All existing fields of cfg space stays in cfg space" is a bad
idea simply because this does not allow removing things from config
space not in 10 not in 20 years not ever.


Instead we need to allow two ways to access config space.  Teach drivers
about both, actually mandate supporting both.  And then devices will
make their own cost/benefit decision about which features they want to
support in MMIO.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

