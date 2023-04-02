Return-Path: <virtio-dev-return-11883-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5B9C76196
	for <virtio-dev@archiver.kernel.org>; Sun,  2 Apr 2023 07:55:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 501A12AF8B
	for <virtio-dev@archiver.kernel.org>; Sun,  2 Apr 2023 07:55:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3968B98638E
	for <virtio-dev@archiver.kernel.org>; Sun,  2 Apr 2023 07:55:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2257C983DE2; Sun,  2 Apr 2023 07:55:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E4029862AF
	for <virtio-dev@lists.oasis-open.org>; Sun,  2 Apr 2023 07:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9xf-HJwmN4-mvg1oH3TFDQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680422099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZToUCdrF5oVL58PGOoAFHIspk/TTUDJwyri3NCOgmsw=;
        b=w0FtNBqrRp3pkfmjQgP4ZhXsAM4i9PIVE7eyLIoRAAfuURKmGc6UNTkXbN+gmjulB0
         /VuIZwixhIe9DRIQxYHMVgY8/wMb3RVqrTxZe4EKh4WYAaML7vFHng9yxKleE/rgJjMH
         SRahF7jHevMW+bLJma+e/pXonuXNKPuu/9JSNqGtQmlGBSH5WPg2/nRL+H4Qsxiw0GKW
         arpWgRZObr4b7oPrdLeW/3LuFtbge2EVGo4844HqHomALnq5f3VfWqpmfQ9I67YR93kP
         TyydwJeo8NKipG8f0G20sqZDQoa6vrUPZvgNATyerF2c5P/KQHVPnFKXIG30LOyMCCZN
         frdg==
X-Gm-Message-State: AO0yUKWP64P3N88zMWfph60Sps3XLJnyrFnbcvKFAmxtymDwk5weOVI+
	9PkojQpVkEkkMsk/kTEMmcMrAtrHx/zu2JU6a5K5lqc4WIV2jileHxQvgWFS9nDpuqAgGRio2am
	t1GVubp5P8eKShIp+V7PWrDWg5id/
X-Received: by 2002:a1c:4b04:0:b0:3dc:5b88:e6dd with SMTP id y4-20020a1c4b04000000b003dc5b88e6ddmr25649924wma.10.1680422099622;
        Sun, 02 Apr 2023 00:54:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Ha0McUVP3+FMAQTF9k0tYE4gZLObgrEIVjaVtTfmslB2feB0Er/IZyGMCFXZ8Vs9RU/mxQA==
X-Received: by 2002:a1c:4b04:0:b0:3dc:5b88:e6dd with SMTP id y4-20020a1c4b04000000b003dc5b88e6ddmr25649908wma.10.1680422099150;
        Sun, 02 Apr 2023 00:54:59 -0700 (PDT)
Date: Sun, 2 Apr 2023 03:54:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230402035420-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-3-parav@nvidia.com>
 <20230331024233-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481977FD9EF430B891A1F3FDC8F9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481977FD9EF430B891A1F3FDC8F9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section

On Fri, Mar 31, 2023 at 09:24:21PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, March 31, 2023 2:44 AM
> > 
> > On Fri, Mar 31, 2023 at 01:58:25AM +0300, Parav Pandit wrote:
> > > Currently PCI device discovery details for the transitional device are
> > > documented in two different sections.
> > >
> > > For example, PCI device and vendor ID registers are documented in
> > > 'Device Requirements: PCI Device Discovery' section, while PCI
> > > revision id is documented in 'Legacy Interfaces: A Note on PCI Device
> > > Discovery' section.
> > >
> > > Transitional devices requirements should be documented in "legacy
> > > interfaces" section as clearly mentioned in 'Legacy Interface: A Note
> > > on Feature Bits'.
> > 
> > I already commented on this, I disagree.
> > Modern drivers must be able
> > to completely ignore legacy interface sections, but they do bind to transitional
> > device IDs.
> > This change breaks this assumption.
> > 
> Legacy interface section holds the detail about transitional devices.
> We do not have,
> "Legacy only" section.
> 
> It doesn't make sense to partial information in legacy and partial in other place.
> Modern drivers are not mentioned in the spec terminology section.
> 
> Can you please explain, how can modern driver ignore the text " Transitional devices MUST have a PCI Revision ID of 0." written in legacy interface section?

Modern drivers ignore revision ID. It is 0 to accomodate legacy drivers.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

