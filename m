Return-Path: <virtio-dev-return-11306-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3FCC64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:35:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9CE3F1EAED
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:35:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A65F59863ED
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:35:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1308998640A; Mon, 27 Feb 2023 07:35:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AE569863F0
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 07:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 5g1SI_dBNPy-npUuemLZ3A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DO1TTmF+ygn0Ak7Fbb4cv3FGwGZc2QIsxkXDLnWFqQ=;
        b=68Hrl4qICJsIn5BGngQUb8WzRZW9yJmJrFkXPbJv6CVb325BGqDuq3HxldTg5K1oYJ
         ufoE41lDafMOysjy/aAFWtKUb1BqT1ymlp/1jwr2rggqGVip5M7rDEqfBKxsBxHyn2lb
         IZw1qcNeZsxKL1Bf27uaIPM1zBekGTveHz9YgBBc+hpqOdq0K+os1YIMHcd4P85rkIbz
         DWxDB4gxpzYUmCGuU+L6QHvRqsxMssk12k9ufFesm4s3gswEAaiduTtGMsXXGJhUYdhd
         aZPd7Ijfe+CKitYNzFGWgMjkg98uHGNEQwg//JGRatMPyR4Id03C5WAKfkiKtpw8+tPo
         Cspg==
X-Gm-Message-State: AO0yUKXvM7XCop62aj6pwxjl6j6At6h519gv2FRz35yRgxMCh6cE5bYX
	kYFziRJXn+mnZbvFF9N67U+UeUa4eRxcXOlWQHCbRbMb1mbOnQ4Lq6Jim3cAUPARzxTv2IXHUm7
	4TPVYW1jfovYh7KanAi49KzPNapTL
X-Received: by 2002:a50:ec94:0:b0:4ab:2504:c7ff with SMTP id e20-20020a50ec94000000b004ab2504c7ffmr23939641edr.23.1677483246873;
        Sun, 26 Feb 2023 23:34:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+iC06BxrW6Owwv6F296cAA/r/GMPE3W5/FP6T7fEjxPr7gFQrM/598jcQ2Tux/VnPjGbjpeg==
X-Received: by 2002:a50:ec94:0:b0:4ab:2504:c7ff with SMTP id e20-20020a50ec94000000b004ab2504c7ffmr23939625edr.23.1677483246580;
        Sun, 26 Feb 2023 23:34:06 -0800 (PST)
Date: Mon, 27 Feb 2023 02:34:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230227023028-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-2-parav@nvidia.com>
 <20230225180014-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817FED59372B4F965B473FDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817FED59372B4F965B473FDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 1/3] transport-pci: Improve PCI legacy device layout
 description
Message-ID: <20230227073401.Z6ncfW_HgMneGoiJxDHRcUejIrkerllOi3L3-KAEdmU@z>

On Mon, Feb 27, 2023 at 03:02:10AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Saturday, February 25, 2023 6:09 PM
> > On Sun, Feb 26, 2023 at 12:29:59AM +0200, Parav Pandit wrote:
> > > Legacy interface PCI Device layout description has following issues.
> > >
> > > 1. repeated 'structure' word
> > > 2. virtio header was defined the 0.9.5 spec. In a legacy interface
> > >    section it is referred with different keywards
> > >    as (a) virtio header, (b) general headers, (c) legacy configuration
> > >    structure, (d) virtio common configuration structure and
> > >    (e) other fields.
> > > 3. Driver and device requirements listing is intermixed.
> > > 4. spelling error of structure
> > >
> > > Hence, rewrite the description to eliminate above issues as below.
> > >
> > > 1. Removed repeated structure word
> > > 2. Fix spelling of structure
> > > 3. Place all device requirements toegether 3. Define legacy
> > > configuration structure that consist of
> > >    a. legacy common configuration structure and
> > >    b. device specific configuration structure 4. Rewrite section
> > > around above changes
> > >
> > > This is only an editorial change.
> > 
> > No, editorial changes are things like spelling corrections.
> > 
> Got it. Will drop this remark.
> 
> > I have trouble reviewing
> > because I have no idea why you are making each change.
> > 
> After documenting legacy interface in the spec, we cannot claim that driver is the source = specification.

We document the *legacy interface*. What we don't is we don't document
legacy devices and drivers:

    Legacy devices and legacy drivers are not compliant with this
    specification.



> Currently transitional device and pci device do not scale well (or doesn't scale at all).
> We are working on supporting it and having better defined transitional device seems important part of it.
> 
> > E.g. you just rewrote a bunch of text and I frankly don't know why. For example:
> > 
> > 	-When using the legacy interface, transitional drivers
> > 	-MUST use the legacy configuration structure in BAR0 in the first
> > 	-I/O region of the PCI device, as documented below.
> > 
> > is now apparently:
> > 
> > 	+When used through the legacy interface, the legacy common
> > 	+configuration structure has the following layout:
> > 
> > and this is better? why? we are replacing a clear requirement which applied to
> 
> Because as I explained in the commit log, that one structure is named using 5 different names.

So maybe try just renaming. What you did is also convert a normative
statement to a non-normative one.


> > drivers with a vague statement which I can't say what it applies to.
> > 
> > Any chance of splitting these things up? Maybe that will help.
> > 
> That's a good idea. Yes. I will split these patches to smaller one.
> 
> > Apropos I don't know that we want to spend much time on legacy sections.
> Transitional devices are very much in use and documenting them well is important to build scalable transitional devices.
> 
> > Really with legacy code is the main source of documentation - if drivers work
> > then you are golden. If they don't appealing to spec will not help.
> 
> Yes, so don't want to add additional text. Just correcting the current one.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

