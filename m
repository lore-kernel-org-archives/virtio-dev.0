Return-Path: <virtio-dev-return-13171-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F88C001B0
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:07:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 993222B016
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:07:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76E339866EE
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 22:07:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C1F2986677; Thu, 29 Jun 2023 22:07:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 495AE9866E6
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 22:07:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: inkI-e4QNV6hTrbGx8Abug-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688076459; x=1690668459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6Ilwv4/eLR1J6ixF0OhD/47Yj8hiIfIPk3tHqMHrR0=;
        b=k2oeVyGHMETmQIM7RnoUfNiGszuWWOqEIxltyJUwfeEvxyb6VOUyfgFKPLkg1qAnb/
         jylvXSF82bUN/sH8AmnxONSCcAA5WWL8gLlf9bFDUb8g+DLlrWBT7Aiu4HixCV1bWHzX
         0ZdIg2DGp3Y31zf/dsfKCrAAb2occIevuM1ngefO9tHxhVgLsUmoLIYGpaZtiasJRH7C
         YRiVbAhlT8XyzkcLe/5CCQwFXW62O7nbi3yt8HMRfMm3CUm6psWrCOkYrqL0x72//FI5
         Hw6VmvSkSMtqfMtwNjHCgjUp4LqDfrPo0/uElNjCmeHjoTcIgzNCEkxSIUXDoob+mSTw
         TwvQ==
X-Gm-Message-State: ABy/qLbUydDeVjP1AnOqZr3XIkTp7HZYI8sUTNYUgT4PQo52ErQJW2PE
	EsDq6fRHaWc9/N48imMTx/ZCAJIpU4ceZxPJyW0nLO3vAkLNdXsQzKIBzjR1d4r5YxG/+LxMxEs
	0HIiJqAX/w+Vy4o+mXEmPuF0xB8bZ
X-Received: by 2002:adf:fc4e:0:b0:313:f8de:1ff6 with SMTP id e14-20020adffc4e000000b00313f8de1ff6mr633113wrs.51.1688076458979;
        Thu, 29 Jun 2023 15:07:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFz4rYf1Sjl8TSEyDrVyVCaJ8lQLLf3pYRrVXBjWLyYhTp4geGXoY6UluA3/RHS2U1R2eOUuQ==
X-Received: by 2002:adf:fc4e:0:b0:313:f8de:1ff6 with SMTP id e14-20020adffc4e000000b00313f8de1ff6mr633097wrs.51.1688076458714;
        Thu, 29 Jun 2023 15:07:38 -0700 (PDT)
Date: Thu, 29 Jun 2023 18:07:33 -0400
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
Message-ID: <20230629180620-mutt-send-email-mst@kernel.org>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-4-parav@nvidia.com>
 <20230629154634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E7610F4941C615617CA0DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629174443-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548102851D796A39FEC61275DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629175234-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FAD16EDAE283D0356B4BDC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FAD16EDAE283D0356B4BDC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v7 3/4] admin: Add group member legacy register access
 commands

On Thu, Jun 29, 2023 at 10:02:53PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 29, 2023 5:57 PM
> 
> > > I have mixed feelings; I think definition in transport and link in generic section
> > is fine.
> > > Are you ok with that?
> > 
> > I am yet to focus on wording, can't tell you for sure.  My gut feeling is that
> > keeping everything in one place would be more readable, will help us converge
> > more quickly, and the next user of admin commands is expected to be SIOV
> > which would need the same structure anyway (it's also PCI).
> >
> Ok. For v8 I will have link and keep in pci transport section. Later I can move as union if needed.

I can do that too.

> SIOV for PCI and CXL will look very different, so SIOV legacy I am not expecting any change for these commands.

SIOV will need a notification structure within BAR, and it could reuse the same
one.

> > Also look at virtio_pci_notify_cap and check whether any normative statements
> > there should apply here. Alignment I guess?
> 
> I will move below normative from pci to generic.
> 
> The group member driver SHOULD use the notification region supplied by the group owner driver.

By owner device.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

