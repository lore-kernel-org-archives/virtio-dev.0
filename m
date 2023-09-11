Return-Path: <virtio-dev-return-13675-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0735CEEB57D
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 10:15:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4FE8EEEA20
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 10:15:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED71C98658F
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 10:15:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D75E798635C; Mon, 11 Sep 2023 10:15:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7A539866CF
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Sep 2023 10:15:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yICE77vaNDmWj3jR84nD_g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694427307; x=1695032107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxiwxp0bW8jt18giaWNogdzlb2xgehRukN+u779xslw=;
        b=tNNn0fdCcwYMsfqlbY8L770I7JpPfkiXaUZlPUxQ1K4y3IHpZopGcnBdoWeKH0+ZGx
         VqD0CN0/cVdx02Hg4JXNPA9KUSKLim3T1mePBNO6VfpgrWT5MmS1v/rM6klplwHYDcmH
         5UDr5to7lNpqUi5IXi4W1fgNgqOkhFY7XYd971sFynaA+mzYPpK686LFMAEywvMa09g4
         VteprtCTf57h3l5iIzyC2Y2U4AlaPo7roq0Lw76YuM7/HOyfQgykwoHCaDVr9OoRf/Jk
         B8RXKNJzXcBgbsNgEzr3xRj8zyPwAQfXxky4AmB2SWO/GRvoN93Bqke1z4FAxhZlmdwu
         FD/Q==
X-Gm-Message-State: AOJu0YwJcanpBO5cCm5zBqVeqeTfExzrAaSlhi87HRUY8wnAihKsSvQk
	LLoisoK6LLyVNTi72NZdAHodOVuomy4ZiHzDDwYtoF+iuOXAEJKyV9Mw9eBdZmBrT5SrSjF1JCy
	oPgD73xzDyfuvCM3DYfHXFylg3uax
X-Received: by 2002:a17:906:749b:b0:9a5:852f:10bd with SMTP id e27-20020a170906749b00b009a5852f10bdmr7358146ejl.62.1694427306973;
        Mon, 11 Sep 2023 03:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDf5MrUCYNPHCVIf7O11V9vtA09YTru1ALsOK1XpVVG5JTHdEtTU56supvysrY6uFzbXCf3Q==
X-Received: by 2002:a17:906:749b:b0:9a5:852f:10bd with SMTP id e27-20020a170906749b00b009a5852f10bdmr7358137ejl.62.1694427306621;
        Mon, 11 Sep 2023 03:15:06 -0700 (PDT)
Date: Mon, 11 Sep 2023 06:15:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230911061236-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

On Mon, Sep 11, 2023 at 02:30:31PM +0800, Jason Wang wrote:
> Customers don't want to have admin stuff, SR-IOV or PASID in the guest
> in order to migrate a single virtio device in the nest.

Built an alternative facility to implement admin commands then.
The advantage of admin commands is they are nicely contained.
This proposal is way too intrusive.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

