Return-Path: <virtio-dev-return-13284-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FE9EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:59:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5885371C8B
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:59:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BF2C98680A
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:59:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 22BDD98672D; Thu,  6 Jul 2023 19:59:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D9569867B6
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 19:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: g_9_OKB4NrigWv3-v3Bczw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688673563; x=1691265563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN9yN0o6JGcedJtqsCccBeC7Jj0fEUBUbujbpym+p7c=;
        b=Z3uMG5RMIhdLvDaibwJ9kMCg+IUCPRLNZohEKLnN5qpHl7MW65CZj65OApFuoN8Jgl
         OugG7gOsfLUUivImrT7L1XvnAJUeLzWDbg7Ha4usgQA09WgQ7id4xoBG4DbomBo1fVxo
         xCYLpx09sZx0Skajp6bjHRnqHBVsRaTeZr+rZjHn1jJ+fpuQpCLe9Reqk69O66KvFJRV
         RB30vC1VRJb7bpbzJuR6U2dInU9tUtOAOkhlL/B6pWpIaXDWL6xuCu81YrtWdz0T9ygk
         +kdIxzNWm+8epXCJbL7kBv28jJ5W9e5n0gnLP0INBovIqBZbicgQxjN9SWeusP/VnjQB
         RIig==
X-Gm-Message-State: ABy/qLalTReoPOBbw4EO4oxU5jXUV30OgWEzKt3szTfYELXtN+S6lj6a
	VekdQuwagyTpR70QrU9AMz1ST+EwvdWWgRCyf0eltVOJzCJwJSMDVACNFdFc2z1JWBDsQMA9ieu
	dWv1glV/t73KgzPcgI2HJG3BTBF7Q
X-Received: by 2002:a05:622a:44b:b0:403:8927:7cfb with SMTP id o11-20020a05622a044b00b0040389277cfbmr3763762qtx.43.1688673563539;
        Thu, 06 Jul 2023 12:59:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRX3X9jCbs6OJ1ZgPANQjRKBPggJU7J3UwZ/1hJyNik38Jhv/kvNnBvMBa1eXPrAg+1I6Tbg==
X-Received: by 2002:a05:622a:44b:b0:403:8927:7cfb with SMTP id o11-20020a05622a044b00b0040389277cfbmr3763745qtx.43.1688673563232;
        Thu, 06 Jul 2023 12:59:23 -0700 (PDT)
Date: Thu, 6 Jul 2023 15:59:17 -0400
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
Message-ID: <20230706154426-mutt-send-email-mst@kernel.org>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
 <20230706145646-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481071FC01163C48E4CA674DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481071FC01163C48E4CA674DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10 4/4] transport-pci: Introduce
 group legacy group member config region access

On Thu, Jul 06, 2023 at 07:07:42PM +0000, Parav Pandit wrote:
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> > Sent: Thursday, July 6, 2023 3:01 PM
> 
> > > +\begin{lstlisting}
> > > +struct virtio_pci_legacy_notify_region {
> > > +        u8 owner;  /* When set to 1, notification region is of the
> > > +owner device */
> > 
> > I propose we rename this to flags:
> > 	0x0 - end of list (driver should ignore following values until end of list)
> > 	0x1 - owner
> > 	0x2 - member
> > other values - reserved
> >
> 
> > and prescribe that driver ignores any reserved values.
> > 
> > basically we are following how the virtio capabilities work.
> >
> Looks good. Will change it.
> 
> > > +The group owner device hardwires VF BAR0 to zero in the SR-IOV
> > > +Extended capability.
> > > +
> > > +The group member device does not use PCI BAR0 in all the Virtio PCI
> > > +capabilities listed in section \ref{sec:Virtio Transport Options / Virtio Over
> > PCI Bus / Virtio Structure PCI Capabilities}.
> > 
> > Just drop this last one. How can they use it if there's no VF BAR0?
> >
> Hardwaring BAR0 is in BAR area of the VF.
> But virtio pci capabilities without this can still report bar 0 and virtio capabilities.

How do they do this?

> Ofcourse, it is a broken device.
> But skipping this line imply that "because VF BAR0 is hardwired", this metadata in pci capability must not expose it.
> 
> Why not write it extra thing instead of implying it?
> We already wrote few duplicate things to make reader life easier.

If you really want to go ahead, but prefix it with "In consequence" and
do not start a new paragraph, so reader knows it's not an extra
requirement.

So I started writing it using correct grammar and spec terminology:

	In consequence, non of the group member devices has BAR0, and
	in particular none of the virtio structure capabilities
	of a member device has \field{bar} with the value of 0.


However, this actually is kind of wrong (and so is your text).  Not all
caps have a RO bar value.  virtio_pci_cfg_cap has bar that is RW by
driver.  So if we are going this route we also need to explain that it's
true for all caps except virtio_pci_cfg_cap.  And for virtio_pci_cfg_cap
driver is not allowed to write 0 there.

Frankly too much trouble but if you want to, keep trying.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

