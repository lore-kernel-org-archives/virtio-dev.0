Return-Path: <virtio-dev-return-12994-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98623EB64D7
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 10:21:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B32D11318CA
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 10:21:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CC48986509
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 10:21:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 57A0D9863BD; Tue, 20 Jun 2023 10:21:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B0949863E1
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Jun 2023 10:21:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rtWHqUgHM0GOr9ehS_jghg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256507; x=1689848507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWWJ2fNMBRGNE2hivpcDMJoPQ+e9JnPFCXKfqH4wRRo=;
        b=NnFBfgRVVdVJriqXMk0gOC/lzJIYd54XbgZgjApU/bmwyVgogURyGg/Zc1L27F6HJp
         KINoCWREdc65fsrefHAQf6yoDW+F/+AM1S4qIpMK9Z37O0xysLR6t1bd81FF1Aa/0oQB
         FFuy4b6H9GUjuwRNEgpJmQmqfEXO0sM7Jw3tDvnpu/6QCoMT1mMpbspuoJtDlhcW4HkB
         WNapkJKDgdO5AduzFatezpTJxWyczZBYhkoRlqPnA+m/6CuuGgaSSkUHucYGuQJgUDAb
         kT3+xPwtDJzk6VYzaFCR4d5NGcGCD/xyTkl7iKUSm7lkU+Ozm8sbybF9qT1EWSSWHfkS
         XBMg==
X-Gm-Message-State: AC+VfDwbnC4/qrX9BobFCyXjPptksIZ4nbdDR1cmA/XWd4t7yVCYW0CR
	9xlGk/Ont3fnDzCE6DhrMzj4/PhdFvta/9wfd41i5Z2K6Lvyx7t8rwEMXmaCiKYa+sQHtgQUySV
	/XEoad1nBnJtPSmkxtRula9J7KtkF
X-Received: by 2002:a05:600c:3783:b0:3f9:b061:7e4 with SMTP id o3-20020a05600c378300b003f9b06107e4mr4582750wmr.31.1687256506965;
        Tue, 20 Jun 2023 03:21:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RXo7pPgq2pTfVPYtuWTPuGgss7rb3kIJM6DiTfvAAF2GhBmyw/hifP7DtpE2uCNjuKBTRtw==
X-Received: by 2002:a05:600c:3783:b0:3f9:b061:7e4 with SMTP id o3-20020a05600c378300b003f9b06107e4mr4582730wmr.31.1687256506561;
        Tue, 20 Jun 2023 03:21:46 -0700 (PDT)
Date: Tue, 20 Jun 2023 06:21:42 -0400
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
Message-ID: <20230620060110-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619124042-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619132018-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7DD7654CF3B18939956DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133754-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548155EE749082B769487988DC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548155EE749082B769487988DC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access

On Tue, Jun 20, 2023 at 12:14:16AM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: Monday, June 19, 2023 1:46 PM
> 
> > These devices have a legacy interface yes?
> Yes. partially.
> 
> > So they should be transitional to avoid breaking assumption.
> > 
> > 
> > But they are not *exactly*
> > in that they don't have a transitional device ID.
> > 
> Right. They do not have transitional device ID.

I was trying to think whether we need a conformance statement
stating so. I guess this is up to the device?
Then let's make it clear. Something like:
	For the SR-IOV group type,
	the owner device supporting legacy configuration access commands
	[assuming this is the term - do we define it somewhere? or just
	list the commands]
	MAY follow the rules for the PCI Device ID, Revision ID
	and Subsystem Device ID for the non-transitional devices
	documented in
	{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}

or do you want to make it a SHOULD?


> > At least the device id section needs extra text then to explain this?
> >
> We don't modify any of the transitional device attributes.
> In respective conformance section, it is described what requirements of legacy interface to follow.
> > Or do you just want to make them have transitional ID?
> Don't want to do that.
> Non transitional device id with the extension is just fine.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

