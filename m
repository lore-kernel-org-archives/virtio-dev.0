Return-Path: <virtio-dev-return-12066-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C50FC77B61
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:51:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 89E8D2AC78
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:51:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67A259865EB
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:51:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F3529840C0; Fri,  7 Apr 2023 15:51:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DA789865DB
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 15:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oZJmScl1Nzu9ZF_J6Z4Jsw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w45+Vpcr/bn42afjsip00wv8fRfzd8zaLnmN884dyY=;
        b=XW9D7awZexUQ56o+yO3kTPTs2+D2ozRMmuMXtxaNuNTa2XYnj9DrOpzBh/T0w4v7gb
         wIz/iCBjYJimcJ+FL6AEAKrK4iym1UUnwfTv2k3NzFootkBabENDN2hbSi885zqSVujt
         pxVoXYI5RWCCPQfW0kTb5n3WGXspzIgAi9nilTgFUjJcXvF6Pef5SPDG7dk+9KjJ2fvh
         XjW2PopYaCsfG7ELuvxFUYYkTybPFF0NSOGrfms1/UDlGM8ayRKZyMgJ98qR5gPdxmaw
         3FKtwP+l0yAs228Ac7sYMUYmg5iq/MJ1ihK6E22DO+gc4mf30H6K+OSXYhEM45HDmlkR
         aeCQ==
X-Gm-Message-State: AAQBX9e63FgR934qSxSRk35COUmdhp52jelDcm6euByliirPqYih5xIk
	MO8wsnorfGUYtHXqqg2lvlJk0xN8l320eyrb80FWZnxCAJtPJ+o/JFOxnW/5fsqHx2iSMXy5uN8
	Q//rjcXiL9HdtwMnosEZiUnCvVC+O
X-Received: by 2002:a05:6000:1249:b0:2cf:ec49:958b with SMTP id j9-20020a056000124900b002cfec49958bmr1588903wrx.12.1680882692920;
        Fri, 07 Apr 2023 08:51:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvCgbjK00P9/1No/VpC5ZGGUiOTzN/dy6p8UX6tOAGqDtHocyftXkoyb8Jn5OT7jC5JeEfWA==
X-Received: by 2002:a05:6000:1249:b0:2cf:ec49:958b with SMTP id j9-20020a056000124900b002cfec49958bmr1588887wrx.12.1680882692524;
        Fri, 07 Apr 2023 08:51:32 -0700 (PDT)
Date: Fri, 7 Apr 2023 11:51:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230407113737-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
 <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
 <20230407074605-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BF6222A169B898B6A5BEDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BF6222A169B898B6A5BEDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id

On Fri, Apr 07, 2023 at 03:18:47PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, April 7, 2023 8:03 AM
> > 
> > On Tue, Apr 04, 2023 at 12:08:54PM -0400, Parav Pandit wrote:
> 
> [..]
> > > > I took a fresh look at it, and I don't get it: what exactly is wrong
> > > > with just using modern ID? Why do we need new ones?
> > >
> > > A modern (non transitional device) do not support legacy functionality
> > > such as virtio net hdr,
> > 
> > It's all a question of terminology, but it is not worth sacrificing functionality for
> > cleaner terminology.
> > Basically most of the spec just talks about the legacy interface, and will work
> > fine with this.
> > 
> > Yes we do say:
> > Devices or drivers with no legacy compatibility are referred to as non-
> > transitional devices and drivers, respectively.
> > 
> > 
> > So we will want to refine this somewhat. Maybe:
> > 
> > 	Devices not compatible with legacy drivers and drivers not compatible
> > 	with legacy devices are referred to as non-transitional devices and
> > 	drivers, respectively.
> > 
> > 
> > This allows non-transitional devices to expose the legacy capability - having this
> > capability does not make them compatible with
> > 
> > Similarly in the conformance section:
> > 
> > An implementation MAY choose to implement OPTIONAL support for the
> > legacy interface, including support for legacy drivers or devices, by conforming
> > to all of the MUST or REQUIRED level requirements for the legacy interface for
> > the transitional devices and drivers.
> > 
> > we would just remove "for the transitional devices and drivers"
> > here as now non-transitional can have a legacy interface.
> > 
> > Similarly:
> > 
> > The requirements for the legacy interface for transitional implementations
> > 
> > would become:
> > 
> > "The requirements for the legacy interface"
> > 
> >
> I will hold to respond to other emails in this series, because the key part is here.
> 
> If I understand you correctly, will above wording translate to below behavior?
> 
> 1. A non-transitional device will expose a capability (not a feature bit, but a capability at transport level).

Note that we can allow this capability in transitional devices too.
This is useful since IO bar might not be enabled even if present.

> This capability indicates that, it supports legacy interface.
> Lets name it legacy_if_emulation for sake of this discussion.
> It is a two-way pci capability.
> Device reports it.
> And driver enables it. (Why two way and why driver needs to enable it, described later in point #d below).
> 
> Hence, such non transitional device does not need to comply to below listed requirements #a and #b.
> 
> a. A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
> (Because hypervisor driver is a passthrough driver; and legacy driver will not accept this feature bit).

This is not a device requirement at all.

> b. device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.

This is optional not a requirement.

> c. A non-transitional device with above legacy_if_supported capability, will allow device reset sequence, described in
> [1] Driver Requirements: Device Initialization (3.1.1)
> [2] Legacy Interface: Device Initialization (3.1.2)
> 
> > > device reset sequence.
> > 
> > what is this one?
> 
> I listed above in #c.
> And 
> 
> d. When legacy_if_emulation capability is offered and hypervisor driver enabled it, when driver perform device reset, driver will not wait for device reset to go zero.
> When legacy_if_emulation capability is not enabled by (hypervisor or other say existing) driver, driver will wait for device reset to turn 0. (Following the driver requirement 2.4.2).

It might not be a bad idea to enable it, but I observe that it is
possible for hypervisor to expose a standard transitional device on top
of this MMR capability. Thus it will not be known whether guest driver
accesses legacy or modern BAR until guest runs.
I propose, instead, that device exposes same registers
at two addresses and executes reset correctly depending
on which address it was accessed through. WDYT?



-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

