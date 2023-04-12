Return-Path: <virtio-dev-return-12185-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCAEC77B79
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:23:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0E9E5604C9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:23:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 039A99865ED
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:23:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EA26C986510; Wed, 12 Apr 2023 05:23:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D773D98650E
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 05:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bIwbU2DIP_Gfnne_BVTdUA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr1TWzBPyNrEyAvFAzxTLh0FZ63M+yYKfpMJ43cdj0U=;
        b=4f6ea2TvOCe9IlCK15Pjun5JzdAoD8ET7yH7j9oMJVgJ11ycjFhBd/d4fY1mtjAjwd
         XOMRGhH7glDKeixeQCEYeO+422UIzC1BBqDzUHfFwudUBqZb5ACN3J5MeiLhOFlib78c
         jJmh2H3vYFdKPDvqbnzVy1SEq27jhvX90gah/Ix9DzMfW7znDYSkferPVNTY12tgCFLf
         Onx8ZpblRkdW7btITanDxBINXpjUU0q5beKEg0bBzRbXTyebd3ErbFVTblwdqrHRwJ5N
         y/7RKGAPFP6Uk8e494+yXP3eacuRE9S6GcpY4wG95fYYAgShZJMcgjL37a8hv5CIoI3U
         7qaA==
X-Gm-Message-State: AAQBX9eX6ayuN/th6lAHwZAx2/dmXYYuNSYuFLWI9oFZMpcP5kUWT5gG
	knEijD/6z4wypDTIowz4+9UuFeZfrUtnodJ9XCDWBxuPmYgF85Ah/GhrlLmgE7rfR9JuZb6VTgd
	MaxDCRi/pT8sQdaD7bLWP2h9QluPw
X-Received: by 2002:adf:f546:0:b0:2f2:9198:f0f with SMTP id j6-20020adff546000000b002f291980f0fmr3756690wrp.10.1681277019842;
        Tue, 11 Apr 2023 22:23:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YWFjB0z2S/iHgvh69qOuEh7o4o7qo7LeD5Aevgl9Lp4ci6lwvBwk0c2XMfikMWl4erjQsAgg==
X-Received: by 2002:adf:f546:0:b0:2f2:9198:f0f with SMTP id j6-20020adff546000000b002f291980f0fmr3756667wrp.10.1681277019430;
        Tue, 11 Apr 2023 22:23:39 -0700 (PDT)
Date: Wed, 12 Apr 2023 01:23:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230412011741-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230412004331-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC4B82A0A57F08ABF3F7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412010437-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481912FE593E532F4566AB8DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481912FE593E532F4566AB8DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device

On Wed, Apr 12, 2023 at 05:15:40AM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> 
> > New issue I found today:
> > - if guest disables MSI-X host can not disable MSI-X.
> >   need some other channel to notify device about this.
> >
> I will look into it. 
>  
> > Old issues we discussed before today:
> > - reset needs some special handling because real hardware
> >   can not guarantee returning 0 on the 1st read
> When done through the legacy MMR as we discussed, it will.
> 
> > - if guest writes into mac, reusing host mac (which is RO)
> >   will not work, need extra registers
> No. Again legacy interface section of MMR behaves as legacy.
> 
> > - something about notification makes you want to poke
> >   at modern notification register? which of course
> >   is its own can of worms with VIRTIO_F_NOTIFICATION_DATA
> >   changing the format completely.
> There is no NOTIFICATION_DATA with legacy. So it is not applicable.
> Format is same with only vq index.

You are writing into modern register here. *what* are you writing there?
with modern register the format depends on features. here you did not
negotiate any features. what if NOTIFICATION_DATA is a required feature?
with legacy there's no FEATURES_OK so no way to report failure.  driver
barrels on, sends wrong data in the kick and hangs.


Sure, we can add a section to notification register and come up with
some behaviour. Without even trying to guess how messy or clean that
will be, far from being a small clean contained thing this feature is
sticking its fingers in lots of pies.



Look I know proposed this originally. I thought it's a small thing too.
It was an idea. I am not sure it pans out though. Not all ideas work.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

