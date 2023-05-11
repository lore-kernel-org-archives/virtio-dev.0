Return-Path: <virtio-dev-return-12649-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC03C77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 393DD16E5C7
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B49FC986755
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 24F6E9865E1; Thu, 11 May 2023 13:05:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7ECE19865E0
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 13:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PBAtKvtHMcWde5f39_sIbg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683810293; x=1686402293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9if8nYLfVEkrPhjsZ41dK12xYXk2/ZHUAgHNSZ282Q=;
        b=kg0NlZAc5aaGFj/1tdDcC+249dbe3VlhYWOPl/D6jKN+kPZ1Hv0p6njexEXBIOLbpn
         nijXhl4lJyd/y5SFFiuVq2c+FA/si6EQvmfdJsrOjahZ5ZTgqSJaSeM8mBFpugI28kVv
         SD78QBC0VuyW8Si3owQfsMnuhmqXhSmRIGTKM6RrySoDjqdW2Lhvh/SbwK8c5n9Mb8D0
         9RwizzcBHfqk6KBxVVwxkbXQQvtnIgZdcotYanQflKqhyNggCv1plfdl4WfOO7WbkA9Q
         UKh5EfaRc1ETXJ7tqc+yxjaXTzKQRF11JWaJ7XUCx33fsYj+fvNxjScuaXwVagsMJPkp
         4llg==
X-Gm-Message-State: AC+VfDwlU7HAlcfLleMDKqTBH85DyxvbwCJDnY4UvK0UmFcbouTAATjl
	wTxcRdTVHqmXANnYBfz/aYgfF3Y1+WN9nNjYbGD5uZXSYbvveAkKRHxDJQLHkmiE+cy/DY/0bMC
	yU+wNA8aAtt3vjxOeeh95RGO/9ijL
X-Received: by 2002:a05:600c:cf:b0:3f4:2a06:dc59 with SMTP id u15-20020a05600c00cf00b003f42a06dc59mr8516642wmm.12.1683810293232;
        Thu, 11 May 2023 06:04:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77L2jtC3hQ3FVNZSyBZiuIyrQVrglKDHAJkcMaBerCsnNTsszQ5FzU2Uwf0Ht7JxjQyKB4mg==
X-Received: by 2002:a05:600c:cf:b0:3f4:2a06:dc59 with SMTP id u15-20020a05600c00cf00b003f42a06dc59mr8516609wmm.12.1683810292830;
        Thu, 11 May 2023 06:04:52 -0700 (PDT)
Date: Thu, 11 May 2023 09:04:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230511085519-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Thu, May 11, 2023 at 03:06:48PM +0800, Jason Wang wrote:
> > With that I don't see legacy 3 commands anyway conflict with [1].
> 
> It doesn't, but it's not elegant since:
> 
> 1) Modern transport, admin virtqueue with well defined transport commands
> 2) Legacy transport, works moe like a PCI transport on top of the
> admin virtqueue
> 
> Transport virtqueue tend to be transport independent, but 2) tie it
> somehow to the PCI.

This "somehow" matters though. The connection is really just the
common config layout.

> That's why I suggest to
> 
> 1) introduce legacy transport commands
> 
> or
> 
> 2) tweak your proposal to become a PCI over admin virtqueue

So you are saying it's really not generally "legacy over
admin queue" it is more like "legacy pci over admin queue"?
Good point.

And I feel it's a good point that this chooses legacy pci but it could
really be mmio or ccw or the upcoming vq transport just as well.  I suspect
mmio or ccw won't work well for a physical pci card though.
transport vq might, but I am worried we'll have to spend extra
work clarifying it's a legacy interface. For example we will
have to explain that only 32 bits of features must be used.
Focusing more effort on transport vq is attractive though ...
It is worth examining this option in more depth.
Did you? Want to share how is transport vq closer than
legacy pci to what we might want?


> > Some commands functionality is common between [1] and this proposal.
> > But that's how the legacy is. It is confined to legacy emulation.
> > So [1] can be done as follow_on to AQ and these series.
> >
> > A small note about [2].
> > virtio_transportq_ctrl_dev_attribute should be detached from CREATE call and split to two commands.
> > So that VF and SF/SIOV can both utilize it.
> > SF/SIOV_R1 can use the creation and config part.
> > VFs will use only the device features + config space.
> 
> Good point. This could be fixed.
> 
> Thanks
> 
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

