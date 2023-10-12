Return-Path: <virtio-dev-return-14004-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A328CDB46E
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 14:39:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8572B3E56B
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 14:39:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6947B98683D
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 14:39:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4969998660F; Thu, 12 Oct 2023 14:39:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A8DB98680A
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Oct 2023 14:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hAVyacLdPj-_P_cWFzjTWQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121536; x=1697726336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzml0iyqfQH/MdpjCphG/JYkQGuFv9sIOQJFHoxBFEA=;
        b=PEdUQptbJHgnC4tcajZ0c6ufOGcnyYFH6NaY0OsoOhqgyZsu9r+YJK/GfREiSVGMS3
         a4QMLUY9Wyu5uu9MJYPt4cjqPWOE5tpCudqhZYZWSvzykkKzKKiLf1L6iTUFXUtPZ463
         jUgaQIM09E8C90cDLvH1DN4HpOVSF1xSNLXAAJ+c3axpfTBBBAns0oxcVXFf/fXbeDFa
         lAEgmtyNPaF6oDP3wjnuP7SbVeaZD8zeiQbBHWncIVBornyklm/EmiGVkq3zKFf0fpwh
         FmwDY9YMfrQfugN9EygyMS+oVgYsgzArBBV7QFmiCChZj0SRyAlKMmD1niPid8jvgyYS
         Q9qw==
X-Gm-Message-State: AOJu0YzYdVB99Is4OurKK3gpTkG0jQZWE17crxHC3coDtrDD/r6txEWJ
	prohZewEDNE3aAPPFb/tpVNc/19xTcUOnv0VduFK5TOStwD9TXIsz2x7VflqhVqAjUjPR6LMC8z
	zWKNPqSdvkQC/BBk54CoW3TIiJm+B
X-Received: by 2002:a7b:c7c5:0:b0:404:4b6f:d70d with SMTP id z5-20020a7bc7c5000000b004044b6fd70dmr22371446wmk.17.1697121536684;
        Thu, 12 Oct 2023 07:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH32/juQ6369zcCWKv75wMn3oAkYXTyqoEkH3QJNi1WwVtByF9w1YCqXpeF924HT+wHlEc8Zg==
X-Received: by 2002:a7b:c7c5:0:b0:404:4b6f:d70d with SMTP id z5-20020a7bc7c5000000b004044b6fd70dmr22371432wmk.17.1697121536300;
        Thu, 12 Oct 2023 07:38:56 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:38:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20231012101046-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
 <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
 <20230927113510-mutt-send-email-mst@kernel.org>
 <558fe3d6-0b81-4def-7256-52ac3cbffa8f@intel.com>
 <20231011061508-mutt-send-email-mst@kernel.org>
 <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
 <20231012054804-mutt-send-email-mst@kernel.org>
 <ce8a8000-8ed8-66fc-71f9-db560975c100@intel.com>
MIME-Version: 1.0
In-Reply-To: <ce8a8000-8ed8-66fc-71f9-db560975c100@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH 0/5] virtio:
 introduce SUSPEND bit and vq state

On Thu, Oct 12, 2023 at 06:49:51PM +0800, Zhu, Lingshan wrote:
> For PCI based configuration, like MSI, we need to fetch from config space
> anyway.
> For others like dirty page, we can store the bitmap in host memory, and use
> PASID for isolation.

Ok. So how a about a simple interface along the lines of
u64 cmd_address
u8 ready_flags:1

For this kind of stuff?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

