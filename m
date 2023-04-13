Return-Path: <virtio-dev-return-12213-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD65C77B6E
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:02:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E5AEA339B7
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:02:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7DEB98661B
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:02:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CA9D5986197; Thu, 13 Apr 2023 21:02:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B590F986600
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 21:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: IgLjceicMcOESXPS-HWDTg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681419746; x=1684011746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6YURbU31d9CI+8xSqryrr/Lnkke9uPnprEkHHofmyM=;
        b=gHE+jH++E99zUC8kOCo/ZOV83DgOYyefqc7dS6bwkd/17DCqb+SymBXZJvqVH9zxWr
         Sy0gyGrfbZcZ0fqIiVfEGm2pWjxb3j+F8unETqjmaO6uz6MjBiKx8iPulARtj+dNlZh/
         5DgPJ9spnV53J2+OemGKX86dMevMTpCHiKD2H/KD5iqQIE37OHxZJwJ4ffPPj7RbDuDI
         IiI+hwH/7/6xu0D+8D6Mi/oA+4mAxBVCKPIh9SSfcx5ex2CE99zhVbIXp6omUm/MUBhP
         frMctH2rJLEsSTO03vGTMkBIemj+35FykVhs4IYUjaqiKh08ybyI8xLRBqA2rItfLgkq
         IgYw==
X-Gm-Message-State: AAQBX9cQmyMl0+8l2u4U3MzQVpEONAvA2rlURp5acwIzxdbdLq6hyGXE
	b+oS6t+nnpMOJyDQ/PpI307qoU6MoiR1QJuzS0JvxQc5XYbcFi+F+P7SiNbPSMye9/P4l3P5HEH
	R3RUdJ7UTpLkRS6v/73fbmye0z0Jg
X-Received: by 2002:adf:eb50:0:b0:2f5:a651:6bb4 with SMTP id u16-20020adfeb50000000b002f5a6516bb4mr2641913wrn.24.1681419746237;
        Thu, 13 Apr 2023 14:02:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350YvqjvQonuH+2P6EFyV1DqtVNaQBtnl0icbAohRkz3ltBUbn4OrPKIvSZUcIshZoWIYTsT2XQ==
X-Received: by 2002:adf:eb50:0:b0:2f5:a651:6bb4 with SMTP id u16-20020adfeb50000000b002f5a6516bb4mr2641902wrn.24.1681419745937;
        Thu, 13 Apr 2023 14:02:25 -0700 (PDT)
Date: Thu, 13 Apr 2023 17:02:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230413163216-mutt-send-email-mst@kernel.org>
References: <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Thu, Apr 13, 2023 at 01:24:24PM -0400, Parav Pandit wrote:
> > > > - work for virtualization (and it work even without dedicated
> > > > mediation for some setups)
> > > I am not aware where can it work without mediation. Do you know any
> > > specific kernel version where it actually works?
> > 
> > E.g current Linux driver did:
> > 
> > rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
> > 
> > It doesn't differ from I/O with memory. It means if you had a
> > "transitional" device with legacy MMIO BAR0, it just works.
> > 
> 
> Thanks to the abstract PCI API in Linux.

Right. I do however at least see the point of what Jason is proposing,
which is to enable some legacy guests without mediation in software.

This thing ... you move some code to the card and reduce the amount of
virtio knowledge in software but do not eliminate it completely.
Seems kind of pointless. Minimal hardware changes make more sense to
me, I'd say. Talking about that, what is a minimal hardware change
to allow a vdpa based solution?
I think that's VIRTIO_NET_F_LEGACY_HEADER, right?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

