Return-Path: <virtio-dev-return-12793-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5C9C7EE26
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 18:17:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 179BF190921
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 18:17:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0939298641B
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 18:17:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE135986387; Tue, 23 May 2023 18:17:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D51659863FC
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 May 2023 18:17:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: dvevgDxUMHyElaO_JcqQAQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684865819; x=1687457819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50vp9IUVKc4aJTq7o4kyUrwCeg2bZHDm3SwuEPSUQY4=;
        b=PEJsN22MIXcPKvJklAYHTujj+V8PsJSRBJC9ehRmpzkoeIY/FvZFEg1WRUbR/+dWMB
         efGxIZSGFgmzDFzkn9lWvZxPlq+KWWwJj2feSS4kPktPrhuI3BLaztYFi4WdZ9eT7jZj
         RyfZzM+WFcoZZUycWgHcVLuKJFe56w/usYEzryE3S3oxDViEToPIGr9avrOpwRbM/JdM
         VclqTW+FiVQx0FPYGhDZbhfFgqu/nAgcQuRVeheFLUBQ5FY+SnrxQzTHLQydu2edgmMf
         egTggjS6Gj7Kt1mWRRAaX0K5QoBOAaqxOT/Z8SPWqSxwG+3IlA3AoZj8zL3Vtt7R9dQU
         F1iw==
X-Gm-Message-State: AC+VfDwC2zIi8WBhwQG9DAZQHZWFSdHfDVShIeNSFwjyH4tUwSvy/QVe
	cWzUYS6oZ3RO5B3al7JxJH3B5IU1+oh2MfNyBkOt11VPNtc20rC+vhIHu1z29mXA+rMvoKNhlie
	+VuI4TLg53jgteh979VZ+tcWFEtbp
X-Received: by 2002:a7b:cb87:0:b0:3f6:37b:6390 with SMTP id m7-20020a7bcb87000000b003f6037b6390mr6476170wmi.32.1684865819635;
        Tue, 23 May 2023 11:16:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Bt4HbmOhM4xDmUp6UIsuGvYVvrY/s/+qlDptoym3KcEaN3HoTDfeEMrF/uCKF1IoIeAj93A==
X-Received: by 2002:a7b:cb87:0:b0:3f6:37b:6390 with SMTP id m7-20020a7bcb87000000b003f6037b6390mr6476161wmi.32.1684865819358;
        Tue, 23 May 2023 11:16:59 -0700 (PDT)
Date: Tue, 23 May 2023 14:16:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230523141439-mutt-send-email-mst@kernel.org>
References: <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <20230515060641-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Mon, May 15, 2023 at 02:30:55PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, May 15, 2023 6:09 AM
> > To be more specific, device config often has the same layout under legacy and
> > modern. Thus if getting an offset within device config, same decoding logic
> > should be reusable between legacy and modern.
> Modern device registers are directly accessible from the guest driver without mediation for VF,SF,SIOV.
> Hence, there is no need to have commands for modern register access over some VQ.

Yes, there's need, and some of it you were pushing yourself.
AQ will allow reduced memory with SRIOV, and support for SIOV.

> Will reply to rest of the Jason's comments in some time.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

