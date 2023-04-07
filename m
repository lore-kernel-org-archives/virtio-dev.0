Return-Path: <virtio-dev-return-12063-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B246CC77B61
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 12:03:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1FB48339BD
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 12:03:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17E669865DA
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 12:03:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0BD6D9865D8; Fri,  7 Apr 2023 12:03:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F108D9865D9
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 12:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: FxXcVl7nN_C-4BnmpI9GYQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680868997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbrQX2QqyfPAmqdMPF3L/CY82M7iP6x2XP8o3yw77go=;
        b=1LxLceHAJfxr9o3hnBUUhEjlfKkcowqjCBoolaWkqK9O9bUwpRFoxJCFWp+nbB7OkS
         M2JQusrdWShpC8aE08gCFklCh/p18C7BuvZPdqYBbT85/XXS4UL8NspQNNXGoAjcC1Rd
         Qr+6UDcEZC/IMyXaS7rM4UFag27XGAkJ9FBuTuiUSjHHFOdFXIIRLTPDBk04B3L0dNme
         7liLRaaQbr2lVvu6yp/pt7/cxZc4pK613KD9nZzpsHLs9d3Jl7HaI75BvLvv4v95Xx/3
         rlwrI2i2ZLEMEZM6lupnkNXaTOCCDByW2fMRlTsMJQJ8XxaE51G9xyAdpyAGelCr96nk
         kZ8Q==
X-Gm-Message-State: AAQBX9fcv93dW4GgrT+8LqnHXLbeGENloQwUvMjgd/ftHxxKIkOiWo3Z
	lIM1Wf0X6o79r4/1cqjpI6Tszvsbp5L8u8amLL+ZNqs3PVEO7zx4u24RjKrSyowBGlqRX8JumMB
	/fcNPBPbVQpFjxnWDZHpD5ioNqCi6
X-Received: by 2002:a05:600c:3786:b0:3ed:2b49:1571 with SMTP id o6-20020a05600c378600b003ed2b491571mr1087384wmr.20.1680868996768;
        Fri, 07 Apr 2023 05:03:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350aEZpnKLW3+Akx97JKZpWHz9avQNpVt5anhAG9dW0Xh1CakUUuwOr+V3JjjTkflMqrp/O0PqQ==
X-Received: by 2002:a05:600c:3786:b0:3ed:2b49:1571 with SMTP id o6-20020a05600c378600b003ed2b491571mr1087367wmr.20.1680868996486;
        Fri, 07 Apr 2023 05:03:16 -0700 (PDT)
Date: Fri, 7 Apr 2023 08:03:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230407074605-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
 <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id

On Tue, Apr 04, 2023 at 12:08:54PM -0400, Parav Pandit wrote:
> 
> 
> On 4/4/2023 3:28 AM, Michael S. Tsirkin wrote:
> > On Fri, Mar 31, 2023 at 01:58:30AM +0300, Parav Pandit wrote:
> > > Transitional MMR device PCI Device IDs are unique. Hence,
> > > any of the existing drivers do not bind to it.
> > > This further maintains the backward compatibility with
> > > existing drivers.
> > > 
> > > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > I took a fresh look at it, and I don't get it: what exactly is wrong
> > with just using modern ID? Why do we need new ones?
> 
> A modern (non transitional device) do not support legacy functionality such
> as virtio net hdr,

It's all a question of terminology, but it is not worth
sacrificing functionality for cleaner terminology.
Basically most of the spec just talks about the legacy interface,
and will work fine with this.

Yes we do say:
Devices or drivers with no legacy compatibility are referred to as
non-transitional devices and drivers, respectively.


So we will want to refine this somewhat. Maybe:

	Devices not compatible with legacy drivers and drivers not compatible
	with legacy devices are referred to as non-transitional devices and
	drivers, respectively.


This allows non-transitional devices to expose the legacy
capability - having this capability does not make them
compatible with 

Similarly in the conformance section:

An implementation MAY choose to implement OPTIONAL support for the
legacy interface, including support for legacy drivers
or devices, by conforming to all of the MUST or
REQUIRED level requirements for the legacy interface
for the transitional devices and drivers.

we would just remove "for the transitional devices and drivers"
here as now non-transitional can have a legacy interface.

Similarly:

The requirements for the legacy interface for transitional implementations

would become:

"The requirements for the legacy interface"




> device reset sequence.

what is this one?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

