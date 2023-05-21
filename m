Return-Path: <virtio-dev-return-12765-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC50C77B73
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 05:57:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2FFB029FDE
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 05:57:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0D1698628B
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 05:57:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C9E09984090; Sun, 21 May 2023 05:57:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2DE59859E5
	for <virtio-dev@lists.oasis-open.org>; Sun, 21 May 2023 05:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: SKWLlbDvNyKlvkI5j37b8Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684648667; x=1687240667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neEnWwdBJs1CHdHlkglta2HaEq1W3RW8Zwqq2ZQfi78=;
        b=T4eLG9oYXgG+A9fBjvCgQWRl1jPLU4I68y1pEJWR5KIZqnXvb0JCjUAYiqWFikQzUC
         aTMjAIxMeCIAHUYjU2zmOfaqb8cnWCbIePfXv8Dfxv921bRqUMYJAs9QBVIjCHBvqQrZ
         HXCyI2/nXDEKeo/lbQJkuEHGxBl+ABkIdJcnqI8zWea08Zidw3Yetf5DuFHMrSmWCNTJ
         fhEdUdzpkqgaGDLBpaJGAbY0yx1YzRFnY9dmo+7vM7Wz8Fpl+7gkhf2m7bV5cNuJRNxW
         U7U98Bi4SI8aXV8e0vyuGHhBJQ/a60gs+oF8RevAH36Hv3c3eCazSfTYMtq4B87ftMNX
         SekA==
X-Gm-Message-State: AC+VfDzYcCSD8RGF6Ir1EKI7ZNrWf9D3EheBSOPud6zvZYUHP84UTsVI
	fTU+LtRb/MqjSauLjxaqRH/dI3PuR3wk/k1S7WjLvfQqSlKfal9D+hBY5fzG3jzGN5LW/C8RL/H
	XPnXB4G4d2b7gMO6RSwti0GcpmIDe
X-Received: by 2002:adf:f409:0:b0:2fe:e137:dbad with SMTP id g9-20020adff409000000b002fee137dbadmr4251123wro.51.1684648666832;
        Sat, 20 May 2023 22:57:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7jJX+90+JUA0pXXmGVdq7vGbr8TYXK9Jix6Ol6UlmCNNudlg5fjcjSHvJ8vjbQeVQVz9sJ/g==
X-Received: by 2002:adf:f409:0:b0:2fe:e137:dbad with SMTP id g9-20020adff409000000b002fee137dbadmr4251119wro.51.1684648666498;
        Sat, 20 May 2023 22:57:46 -0700 (PDT)
Date: Sun, 21 May 2023 01:57:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230521015236-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230519020737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E912A8CDE621DF4344DEDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E912A8CDE621DF4344DEDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Fri, May 19, 2023 at 09:02:58PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, May 19, 2023 2:10 AM
> > 
> > So looking at this in isolation, it probably warrants an extra github issue. So I
> > would like to find out whether we should introduce this capability and switch to
> > it for new devices.
> > 
> > My main question is whether e.g. seabios will be able to use it.
> > Could you take a look at the source and let us all know?
> > 
> Existing unmodified seabios cannot use it because it is not looking at the new offset and cap_id.

Yes but neither can it support new devices because it does not look
for the new device id. So it's fine - I was talking about new devices
using extended capability.

We shouldn't just laser-focus on existing software and devices,
there's probably more to come.


> But that is the case with any existing software, not just seabios.
> 
> New capability is in addition to the existing one.
> And code already exists to refer to the old one, so I am not seeing any gain to create them now.
> Any new capability that one creates in the future can be in the extended area.

Question is about MCFG in general.  Is adding capability to access MCFG
to seabios for pci accesses practical? hard?

> You mentioned a perf angle that it takes half the time, but I don't
> see how as the only change between legacy and ext is: offset.

For a variety of reasons Linux does not use memory mapped
accesses for legacy config space, it uses cf8/cfc for that.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

