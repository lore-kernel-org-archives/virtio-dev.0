Return-Path: <virtio-dev-return-12474-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A21C77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:46:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B1B092AED4
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:46:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95118986682
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:46:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 81824984284; Fri, 28 Apr 2023 04:46:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C46298667E
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 04:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: koNND7apMbalwPOZn0tZfQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682657173; x=1685249173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbyBGMrk+bT6/gviHYwRSZ2oCtXMQTxGEjZKTSovU4s=;
        b=dS60L31srECQVlgJzNyOdqqg5es1MuQbvsHxcH6z0N7jkCMaLYKWkxFOKlSHHzvpU1
         SsuiubibHqUHnCcJ9lwe5Jg/togepKvMuwhS1oBBDagszVYI32EdgfN/QrHINHpIVwwk
         U83Q5u9ISVb0ggpBGf0cSITplRVCxGnkmeZ5SIQ/4rTNmwnLWfYwLQCfdPm/xUcWE9da
         8bjPna/c15UH1lBiNoQt1Sqfbp37uwGB52uO8A/lRBRNzjkmi9QigEn+ZFIwET0S8YNP
         1efnqVI02D85o8iR778kvVHWMhyzrv0wz87h08UgVMQYDt7HeMPPPo9oKHiiB3B0gV2d
         KrQw==
X-Gm-Message-State: AC+VfDxueu9G50ehkhEXHHKM/h0+Wio2KNPY9c/0of1Mf57NDYtB83rr
	i7e+tQ0lWdiVPxk3ReJJlNLrmlS29P4hS5DIzgDSOq6BVqJubIKuM3K9PAvMukWco2kC2ZEi57O
	UXh6utCslaGWFnIyDXNwAVBsDGTIp
X-Received: by 2002:a5d:6a8b:0:b0:2f8:7cac:101a with SMTP id s11-20020a5d6a8b000000b002f87cac101amr2677176wru.41.1682657173278;
        Thu, 27 Apr 2023 21:46:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5O8Czbt4NVuJpxBnEWOwl/twgF+u5Cnu7p9SsZQXkZ/N57HWIylGM6rbRXWjA7b0xqWFzvUQ==
X-Received: by 2002:a5d:6a8b:0:b0:2f8:7cac:101a with SMTP id s11-20020a5d6a8b000000b002f87cac101amr2677161wru.41.1682657172959;
        Thu, 27 Apr 2023 21:46:12 -0700 (PDT)
Date: Fri, 28 Apr 2023 00:46:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230428004335-mutt-send-email-mst@kernel.org>
References: <20230421145434.83774-1-parav@nvidia.com>
 <20230422061011-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
 <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/2] transport-pci: msix register desc improve

On Fri, Apr 28, 2023 at 04:10:21AM +0000, Parav Pandit wrote:
> Hi,
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Parav Pandit
> > Sent: Monday, April 24, 2023 11:15 AM
> 
> > > LGTM.
> > > Given the amount of back and forth, I guess we should vote.
> > >
> > Ok. created github at [1].
> > Will wait for few more days to ask for vote for any other review comments.
> > 
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/169
> 
> Can you please raise the ballot for this?

ok if you put in link to lore, not to oasis archive, then
please also include date and subject so people can still locate
it in the oasis archive if they need to.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

