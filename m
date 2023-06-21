Return-Path: <virtio-dev-return-13003-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117CEEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 05:05:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C002F613F6
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 05:05:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A510E986549
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 05:05:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8E5B69862F9; Wed, 21 Jun 2023 05:05:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64A1F986510
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 05:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qCzwpyuHPZmBtyo_gohQHQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687323926; x=1689915926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwj/tBklY7JNN+x5Msk7yq7P2iYVVU0IaoiEMc+Hqts=;
        b=MKoOeZy8CWMF61pntSgvHL81UfioziLPcNbFACz55fXuhSIgIlyeL1PkBCECV0YA8A
         23n27bkl5Gi5VVZsmOxwB32MDxVqr5xjJ06JSE0QswIhExwj6ihk6bB2Mp81O1TVvgQz
         abMQczWOi9SbCjFgVL59maR6cqLUZxRXIsX5o9oyv/5rTZ8F+G3FyiPSLv3iOjcnzXTd
         3OQlRA/IGTJwzVskHiz0WUbpfnqbxwY//NDkAsKg4NpnFk3UVAg/+uX5Rmhl798VMMQ1
         jOOlPqJkpthq3radwghAQOPMEQUhTdQ4YwGSVb5So7Zx9LyyM0JwJd8mCttwOjCjpIiD
         wiBQ==
X-Gm-Message-State: AC+VfDz4mnOqAvgMPvpX/4B6dYYUa87BlbM5hKGYIrrYx2MIaQP5wblb
	YMGhCcbYAfu/I3mJG/ejkSrLnU4vtg1n4bO8pOBrbdROKd6Dy65A0ZxnXxH8LMPVJ0r/5l2aHeJ
	ObvbVuhf4fr3Q6ZrJ9+0S/7vArZJK
X-Received: by 2002:a05:600c:3652:b0:3f8:11ec:7c06 with SMTP id y18-20020a05600c365200b003f811ec7c06mr14034258wmq.39.1687323926349;
        Tue, 20 Jun 2023 22:05:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QXvf06UmrfuQazlY6AXx6B+g4lD0N3O2gTBxOZTCc403x/bph2YUd+eCAiDwWq+W+qPLN4A==
X-Received: by 2002:a05:600c:3652:b0:3f8:11ec:7c06 with SMTP id y18-20020a05600c365200b003f811ec7c06mr14034246wmq.39.1687323926001;
        Tue, 20 Jun 2023 22:05:26 -0700 (PDT)
Date: Wed, 21 Jun 2023 01:05:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230621004904-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619124042-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619132018-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7DD7654CF3B18939956DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133754-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548155EE749082B769487988DC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230620060110-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548183AC0E47AA8BFE76C042DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548183AC0E47AA8BFE76C042DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access

On Wed, Jun 21, 2023 at 01:09:40AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, June 20, 2023 6:22 AM
> > 
> > On Tue, Jun 20, 2023 at 12:14:16AM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: virtio-dev@lists.oasis-open.org
> > > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> > > > Sent: Monday, June 19, 2023 1:46 PM
> > >
> > > > These devices have a legacy interface yes?
> > > Yes. partially.
> > >
> > > > So they should be transitional to avoid breaking assumption.
> > > >
> > > >
> > > > But they are not *exactly*
> > > > in that they don't have a transitional device ID.
> > > >
> > > Right. They do not have transitional device ID.
> > 
> > I was trying to think whether we need a conformance statement stating so. I
> > guess this is up to the device?
> > Then let's make it clear. Something like:
> > 	For the SR-IOV group type,
> > 	the owner device supporting legacy configuration access commands
> > 	[assuming this is the term - do we define it somewhere? or just
> > 	list the commands]
> This term is largely defined as section name currently.

Right. A sentence saying "the following legacy configuration access
commands allow access to the legacy interface of a member device through
the owner device ..."  at the beginning of the section might be a good idea.

> > 	MAY follow the rules for the PCI Device ID, Revision ID
> > 	and Subsystem Device ID for the non-transitional devices
> > 	documented in
> > 	{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
> > 
> > or do you want to make it a SHOULD?
> >
> SHOULD seems fine to me as one cannot build PCI VF hw practically with IOBAR anyway.
> So better to extended above line as,
> 
> For the SR-IOV group type, the owner device ... and member device SHOULD fllow the rules for...


ok

> > 
> > > > At least the device id section needs extra text then to explain this?
> > > >
> > > We don't modify any of the transitional device attributes.
> > > In respective conformance section, it is described what requirements of
> > legacy interface to follow.
> > > > Or do you just want to make them have transitional ID?
> > > Don't want to do that.
> > > Non transitional device id with the extension is just fine.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

