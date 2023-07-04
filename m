Return-Path: <virtio-dev-return-13217-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE97EB64DA
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 15:40:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7D0EA755F6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 15:40:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CF53986718
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 15:40:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5ACBA986599; Tue,  4 Jul 2023 15:40:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A67F9865A4
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Jul 2023 15:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Z1l6UjlAMsu_hI1nP6UUMg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485250; x=1691077250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLCs5ObAunt1T4KeHUrzIcA1+Owd8XKlARaRIHHB2OA=;
        b=lfuHJmaiiq4DZFMo5/LtGGAATiF7ML2tEAfuNzwWxQC1QLdRbmGfI7sa9eaYbFBsA4
         Th+5ac2gWlJPtSfhKqIriT1yGdKw2nxZm7xxGylC6ebeT7HLpmIU1iPO0zgtGe8AvjLU
         muRBlwDu52QSwhGRFXyihLBjnqUQ77Vs3YTmEeU1OdZzuLniBCf2TRHekb6AclQFE1QR
         wdWiwj5qHFyGX38MxLIC+/A83CoFEGYSuYWewnLbNopq1bAqQhIwCi4MSxtpKuaWpwYB
         hq74M38oISCcLUR6UaKqw4ERWA996x0UZxOBaVd2vj+gLhJn94U3Zi3rQEf/R68DaaFx
         cehQ==
X-Gm-Message-State: AC+VfDy49mdcgOSP+A6s1xw2VifGoRkW1Tmhvy/NujRlb7a5lsBqUYgR
	B8lzcOdhbDKmUDQFS2IkFLIUsJykPLmRlu8ZSTL89TjITArjkH2Qgo+BpxnjXtzP/2F0INb9Unt
	KJmtrpza/KxPlFlfs5xzr/iLE6MOv
X-Received: by 2002:a7b:cbd8:0:b0:3f8:fac0:ad40 with SMTP id n24-20020a7bcbd8000000b003f8fac0ad40mr11712333wmi.29.1688485250696;
        Tue, 04 Jul 2023 08:40:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55CsflXtS1rOBjycF8bOTky96I6L36NEzBiHcUEJFsex9OJTIltUbfv0Kfwz0tG95SogYCNg==
X-Received: by 2002:a7b:cbd8:0:b0:3f8:fac0:ad40 with SMTP id n24-20020a7bcbd8000000b003f8fac0ad40mr11712321wmi.29.1688485250355;
        Tue, 04 Jul 2023 08:40:50 -0700 (PDT)
Date: Tue, 4 Jul 2023 11:40:46 -0400
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
Message-ID: <20230704114012-mutt-send-email-mst@kernel.org>
References: <20230630042006.1569920-1-parav@nvidia.com>
 <PH0PR12MB54811B4999A4249C55AAB41FDC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811B4999A4249C55AAB41FDC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v8 0/4] admin: Access legacy registers using admin
 commands

On Tue, Jul 04, 2023 at 01:26:20PM +0000, Parav Pandit wrote:
> Hi Michael,
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Friday, June 30, 2023 12:20 AM
> > 
> > This short series introduces legacy registers access commands for the owner
> > group member access the legacy registers of the member VFs.
> > This short series introduces legacy region access commands by the group owner
> > device for its member devices.
> > Currently it is applicable to the PCI PF and VF devices. If in future any SIOV
> > devices to support legacy registers, they can be easily supported using same
> > commands by using the group member identifiers of the future SIOV devices.
> > 
> > More details as overview, motivation, use case are further described below.
> > 
> > Patch summary:
> > --------------
> > patch-1 split rows of admin opcode tables by a line
> > patch-2 fix section numbering
> > patch-3 add generic legacy region access commands
> > patch-4 add pci specific definition
> 
> [..]
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > ---
> > changelog:
> > v7->v8:
> > - remove empty line at the end of file
> > - removed white space at the end
> > - addressed comments from Michael add link to pci
> > - renamed region to region_data
> > - made region_data width to be 16 bytes to cover for 8 bytes offset
> > - moved generic notification region related normative from pci to
> >   generic section
> > - made bar offset 64-bit
> > - prefix legacy specific structure with _legacy
> > - moved generic normative from pci to generic section
> > - added link to virtio pci capabilities when referring to bar 0
> > - remove 'should' from generic description
> 
> Do you have any further comments on 3rd and 4th patch?
> I fixed your comments of v7, and some more were fixed.


Hope to send review tonight, max tomorrow.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

