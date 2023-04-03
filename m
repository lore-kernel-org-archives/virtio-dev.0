Return-Path: <virtio-dev-return-11905-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82101C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:15:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C78512B04E
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:15:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEBFE9863FA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:15:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 93ACE9863DD; Mon,  3 Apr 2023 15:15:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 781BE9863DE
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7MZgEhcaPRSywRn7DxhrVQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgwH4oCBCf0jPkwxlx8km3PNg9Z2yw82zl1hnVHYuwk=;
        b=yunuPyTZNJoN6Ey4CKIhzm4YAz7LgNlIROg9uMS2A3H3qGnI0TXPsnPAKdZ2Q1mR+Q
         FJnrWSD2nmC6MYw9Mo8tFLV9NPB4L29GqxeysnAim4Tt5nWC/y+YjrCQM4ne9ydTLJbs
         b9maz7YdcBeAwDjxSo90XjpRuEjvu7NIpjWBaRTvF6OTtwM3cVDw8pjto7IHtdzQte+5
         XhOiqWEfxI67bEUW7e6MonYZGwYvBVCpr7SrnhbFzvEu2Nlw79vJwukpQeHRobgOikop
         klWWTOZT8wbNvX464y/sKHRsZbkbIBbUolmfgbyaQyOxeo6jdLdABlipJ3TPk0fi3HDd
         5CFA==
X-Gm-Message-State: AAQBX9cYiEn7iehFZkm4cKu5Zi/7qlkTCEzBrE6hJNcvKneLQDjXesm1
	jOsGwOq+6I6nDGO+QXmnJDOrpvWrF5hDlDXIx3n+yDEzA5ajhFMNttaxEEIoTekI4lMahtXS3BQ
	5DP7tWvLj9sbPdYyGW9XOoE67ku1E0CGT0JXm27V9NQ==
X-Received: by 2002:aa7:d313:0:b0:4f9:e6f1:5c7c with SMTP id p19-20020aa7d313000000b004f9e6f15c7cmr36506441edq.32.1680534899177;
        Mon, 03 Apr 2023 08:14:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z7I+xAmAjxoaMeKqToeR2B9SXFBmg0l8PDgaabjM1MkCb30pwDKYEDDduWc3j/pKCledJ9JQ==
X-Received: by 2002:aa7:d313:0:b0:4f9:e6f1:5c7c with SMTP id p19-20020aa7d313000000b004f9e6f15c7cmr36506430edq.32.1680534898934;
        Mon, 03 Apr 2023 08:14:58 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:14:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230403110702-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-3-parav@nvidia.com>
 <20230331024233-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481977FD9EF430B891A1F3FDC8F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230402035420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FEAA37D23191932F5C7FDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403104716-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548146C767C1425EC9CC620CDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548146C767C1425EC9CC620CDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section

On Mon, Apr 03, 2023 at 02:58:52PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 3, 2023 10:50 AM
> 
> > 
> > No idea what all this means, sorry.  Please do not move text that affects modern
> > drivers to a legacy section. And we've spilled way too much ink on this already.
> 
> I disagree because spec do not describe modern driver and what you are describing is not aligned the way current spec is written.
> I prefer to avoid mentioning it again the same feature bits section that talks about Transitional interface.

Sorry I don't understand what you are trying to say here.  This is all
cosmetics, matter of personal preference.  But I did my best to try to
explain the reason this is not a cleanup but a breaking change. Was I
misunderstood or you just don't agree? No idea.
The reason for current placement is this:

	A conformant implementation MUST be either transitional or
	non-transitional, see \ref{intro:Legacy
	Interface: Terminology}.

	An implementation MAY choose to implement OPTIONAL support for the
	legacy interface, including support for legacy drivers
	or devices, by conforming to all of the MUST or
	REQUIRED level requirements for the legacy interface
	for the transitional devices and drivers.

	The requirements for the legacy interface for transitional implementations
	are located in sections named ``Legacy Interface'' listed below:


Binding to a transitional ID is mandatory for modern drivers.
*This* is why this ID can not go to legacy section - all of legacy sections
are and must stay optional.

What is true (and unfortunate) is that legacy sections are not as formal
as modern ones - originally we wanted them to be informational only. For
example there is no clear separation between driver and device
conformance sections.  Work on this if you like, that is welcome.
But please stop moving mandatory text to legacy sections.

-- 
MSR


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

