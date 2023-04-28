Return-Path: <virtio-dev-return-12475-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D82C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:47:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EBD3341A2A
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:47:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D15E798668D
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:47:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BEE58984284; Fri, 28 Apr 2023 04:47:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C1E29866E6
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 04:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: FXQ2HijpOkmtc1FB6aHw6Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682657237; x=1685249237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwZgIZi01YZ26DMCFZikjl59Fw+i9fp1ny9gzjwTkcA=;
        b=LHlJsyeT7uDQqPDv2HCFtq6aX1FXvtVCfB42iqKhe2G0k4uLPf3X1IhHuHpwGpK0J4
         LATJ7WysRlKb3V4WvgBV3tOAmyhIbn8oGEKHAlvTUWHsEy2ViCawKc/WstPOeWFE6Zyc
         0Zv49xZw7lk1IKqwrbrtmVMonavhHLGyDklNqhjLyEskB9dxWwhNQlLYdDkdefqfuVpd
         jyhwZPa7WI/e+OWhO6QRfJLyT6b3C7UkzAvvP6DhiIeow3ZSvrQH3MZud26aLtvYcR3C
         lP77yh+aVmfxm7lVELb4HIUayvhso7cEYvHhvlz+KwX0o3LiB7m6nclw/PONt3e+mdaE
         Vz+A==
X-Gm-Message-State: AC+VfDyH5YLyWKFq5qjzvvrZqy+CQ68Vr0isORBQcEIH1LONbP1b0lkC
	+/1u085xk9XOxT7Q2a+qC0AJuWrd12uBxMG2Sn06aShpnjNaHxqVm7ar8f81Y6ahDaP/1MzX16C
	he/G9Kn0EkdIWm4GUQNXXPgEPR8XC
X-Received: by 2002:a1c:c902:0:b0:3f0:7f4f:2aa8 with SMTP id f2-20020a1cc902000000b003f07f4f2aa8mr2941665wmb.9.1682657237026;
        Thu, 27 Apr 2023 21:47:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4x8x6gZNMI7Rt0wQvsqC40q/Xv6CiuzdAcGCpedtocrcU1afrPaKt+bcOATw8Da/QBdPPrIg==
X-Received: by 2002:a1c:c902:0:b0:3f0:7f4f:2aa8 with SMTP id f2-20020a1cc902000000b003f07f4f2aa8mr2941658wmb.9.1682657236716;
        Thu, 27 Apr 2023 21:47:16 -0700 (PDT)
Date: Fri, 28 Apr 2023 00:47:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230428004638-mutt-send-email-mst@kernel.org>
References: <20230421145434.83774-1-parav@nvidia.com>
 <20230422061011-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
 <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230428004335-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230428004335-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/2] transport-pci: msix register desc improve

On Fri, Apr 28, 2023 at 12:46:13AM -0400, Michael S. Tsirkin wrote:
> On Fri, Apr 28, 2023 at 04:10:21AM +0000, Parav Pandit wrote:
> > Hi,
> > 
> > > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > > open.org> On Behalf Of Parav Pandit
> > > Sent: Monday, April 24, 2023 11:15 AM
> > 
> > > > LGTM.
> > > > Given the amount of back and forth, I guess we should vote.
> > > >
> > > Ok. created github at [1].
> > > Will wait for few more days to ask for vote for any other review comments.
> > > 
> > > [1] https://github.com/oasis-tcs/virtio-spec/issues/169
> > 
> > Can you please raise the ballot for this?
> 
> ok if you put in link to lore, not to oasis archive, then
> please also include date and subject so people can still locate
> it in the oasis archive if they need to.

Also please link to virtio-comment archive. virtio-dev is
for device/driver developers not for comments.

> -- 
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

