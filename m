Return-Path: <virtio-dev-return-11984-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E0CC761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 19:08:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29EFA2A894
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 19:08:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22C24986596
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 19:08:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 12C91986524; Tue,  4 Apr 2023 19:08:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F33F498658A
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 19:08:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HS56FdULNqGJQ5Lb-VgWDg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680635304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCH1lFA9IIYGetreEhigBYkX3QHNz6MTurP0gBeQ7mQ=;
        b=zXywEMr/5Xpammt6zGVabYhDwRVCKGI6ZTmy7PF3xHyl0zKgGaPRW1YUz17na5+8Do
         lOO4/D5KdDe6czK4A16fPvLlDZrQQMZOFDYy/1awKMUKmUs35lH15B7uqcNUuCYKecfC
         jDmB2tUF6ZM26EmA/59qvcquRVPjhO5wAT9McdVHRHokY47QKuYqsBvH03Xg02ndajmH
         UdpbwWOLSEBlmdx1chy/vK/nclgCOKkE/R3MShF2xmB89+Gve/P/SfrNyNc4NuLeVkaZ
         t4YkZOAbhLzY/m13sybNN97d292aEzeqXXyqcVmFnTbom6h2jxGpHngo9m0kXLiVu4k0
         iMFA==
X-Gm-Message-State: AAQBX9dhx895lgUqNej+TwNWcD412yp+WJlxRMv7EOs0epY4xCz6WhbU
	u24p5zlPtiUvkvTeZZWjEPJl3Nrr09Mn8+8M2pPGkWwsTrQ2c4EhxBFP12qLN8AdTKl6dntefKN
	ZYwuHWE5Sj5r9GYE/o1O3IrBFZLR1
X-Received: by 2002:a17:906:ef2:b0:93f:9ef3:945b with SMTP id x18-20020a1709060ef200b0093f9ef3945bmr653614eji.17.1680635304118;
        Tue, 04 Apr 2023 12:08:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZTNnmnUL48vQHLb7AE3HnshDCYMLShwbCrWVBHjRboyyuVMDFIgWL+HZesH2VCYFfjrDbV+A==
X-Received: by 2002:a17:906:ef2:b0:93f:9ef3:945b with SMTP id x18-20020a1709060ef200b0093f9ef3945bmr653595eji.17.1680635303852;
        Tue, 04 Apr 2023 12:08:23 -0700 (PDT)
Date: Tue, 4 Apr 2023 15:08:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404150555-mutt-send-email-mst@kernel.org>
References: <20230324013534.280820-1-parav@nvidia.com>
 <20230324013534.280820-4-parav@nvidia.com>
 <20230404031723-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548194B8F1C22EEB74164ABCDC939@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548194B8F1C22EEB74164ABCDC939@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 3/3] transport-pci: Improve queue msix vector register
 desc

On Tue, Apr 04, 2023 at 06:14:20PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 4, 2023 3:21 AM
> 
> > Ok but "receiving" is confusing here. And the verb writes seems to ask for
> > direction, look at queue_desc as an example.
> > 
> What is the confusion in receiving?
> Driver some reason is configuring queue's vector even if it doesn't want to "receive" interrupts?
> Do you mean it is more verbose?

I mean driver does not even receive interrupts, APIC does.


> Word here "here" isn't necessary when describing the register itself, though it exists at other places.

if nothing else let's be consistent. without here it is not immediately clear
weather it's the register that is written to or the value specified
is written somewhere else.

> > Following that example:
> > 
> > 	The driver writes the MSI-X vector number used for virtqueue
> > interrupts here.
> > 
> Since a specific number is used here, article "an" is appropriate one.

No because it's the specific value used for interrupts.
Again, check other examples.

> > would you agree?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

