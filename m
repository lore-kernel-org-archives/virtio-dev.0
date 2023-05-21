Return-Path: <virtio-dev-return-12766-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C9C7EE29
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 09:16:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1462742A92
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 09:16:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00C0A9862FE
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 09:16:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E52D29859E5; Sun, 21 May 2023 09:16:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3B1D9859E6
	for <virtio-dev@lists.oasis-open.org>; Sun, 21 May 2023 09:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lpWnQbOIOEKBCiDBDBBauA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684660602; x=1687252602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6Z0PGKRWJgwF/vuXGYFhq9YXaLWw67KbEJUntKVQ60=;
        b=kacCEiKfdmZyJTT0vX6ry8m3Sbt/275Mwk4XOgVk7JdD+xyqUuhhWF30r/aX6PI/Ng
         b7B1Ssv8F5uQ+dWEX5Y32cqx8ZGeLydgIxqWZX+XRzyqsihiuaYgzIwGGrr6slQMxuKC
         QSd+6osGMCSwWk9QYQ07IQNNDBFkTwti0iT4ofRHmLaA6kYzzzCMw2ywahi0rBYZQzNV
         EiiaHcjA1orU7+MXVeD+wIT7HI6MYOYZAlnI5HvwqsZbTsUdzlnwXu0mTPLnHc++iM3s
         o8UwHqGtzb+ztp0VhKvf5grn9q8xd0udBBfWwGXAnxKfC7s2mDu5ZTAbbC3baybRGxjU
         Jb5A==
X-Gm-Message-State: AC+VfDz1PyFCOIXOZByg5KiMAN6/PaPfKcWxP1Bv7vQe2ejOddil8/BJ
	qzXS8qr6Jloz2ZhTsLvuA4bMJ63H8EKLOclR8sedRVce5QCSSAb3HTc+UqksvmBFYnsfzi+uBfE
	Vscd4fKzP/VQ+T8ro66P6o7Y5YTWd
X-Received: by 2002:a5d:4d51:0:b0:2f3:e981:f183 with SMTP id a17-20020a5d4d51000000b002f3e981f183mr5334660wru.10.1684660602536;
        Sun, 21 May 2023 02:16:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OMgpNWHq8lpeE3aP35prfmS8E1zjKNmaruf5bp/fALEh7UUuhnz7qwla8Cx9XH92JceZhWg==
X-Received: by 2002:a5d:4d51:0:b0:2f3:e981:f183 with SMTP id a17-20020a5d4d51000000b002f3e981f183mr5334644wru.10.1684660602213;
        Sun, 21 May 2023 02:16:42 -0700 (PDT)
Date: Sun, 21 May 2023 05:16:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230521050829-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Fri, May 19, 2023 at 04:37:16PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, May 19, 2023 2:07 AM
> > 
> > On Thu, May 18, 2023 at 03:42:19PM -0400, Michael S. Tsirkin wrote:
> > > > > Does this sound like a reasonable
> > > > > compromize to you?
> > > >
> > > > Splitting proposed one command to two commands, 1. one for accessing
> > > > legacy common config 2. second for accessing legacy device specific
> > > > config
> > > >
> > > > seems fine to me as below.
> > > >
> > > > So we will have total 5 commands (instead of 3).
> > > >
> > > > 1. legacy common config read
> > > > 2. legacy common config write
> > > >
> > > > 3. legacy device config read
> > > > 4. legacy device config write
> > > > 5. query device notification area
> > > >
> > > > #1 and #3 same cmd signature but different opcode.
> > > > #2 and #4 same cmd signature but different opcode.
> > > >
> > >
> > > Sounds reasonable. Jason?
> > >
> > > notification thing needs more thought I feel though.
> > > It feels weirdly bolted on, but I can't put my finger on what's wrong
> > > exactly yet. Will think it over.
> > 
> > 
> > So with a fresh mind, at least three things:
> > 
> > 1. given driver attaches to the PF, it should be possible to forward
> >    notifications there, as opposed to individual VFs.  NumVFs is 16 bit so
> >    it will fit in a 32 bit write together with VQ index.
> >
> The Notification of the VFs are on the VF BAR for modern or legacy.
> One needs to build additional cross forwarding hardware from PF to VF for the doorbells.

I think doorbells are driver notifications (linux driver calls them
kicks)?
I don't understand what you are saying above really.
what can and what can't be done?

Again all this idea (as opposed to Jason's transport vq)
is to have a simple software model. Attaching a driver to two
devices at the same time is hard to achive e.g. under windows.


> And it cannot utilize what already exists for 1.x VF.
> 
>  > 2. It should be possible to send notifications through an admin command too,
> >    otherwise admin commands are an incomplete set of functionality.
> > 
> Yes. it is only for the functionality. As we discussed in past already, this will not get any performance.

Performance might be ok if hardware disables kicks most of the time.



> > 3. I feel using a capability to describe legacy notification
> >    area would be better just because we already have a
> >    structure for this. make it an express capability if you like.
> The AQ command interface is far more programable object than PCI capability to return this admin info.
> Hence I prefer AQ cmd.

I feel your preferences for 1 and 3 conflict. If you really insist on
kicks being on VFs then at least let us make VF driver in the
host simple. If it has to talk to PF driver things are really
complex. At this point we are very very far from VFIO model,
and then what exactly have we gained by implementing
legacy control path in hardware? Let's do software with
maybe a couple of features such as VIRTIO_NET_F_LEGACY_HEADER.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

