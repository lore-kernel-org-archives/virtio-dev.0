Return-Path: <virtio-dev-return-12085-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B8CC76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 10:20:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C058E2AC60
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 10:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id 5230C2A8CF; Mon, 10 Apr 2023 10:20:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA293986319
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 10:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: WW_hpbsKP-6pvHS6NTOSnw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681121928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9D8g6JM4RFf5BNrxOoN3+FMaZQgXh3X/OKhZXG5SoE=;
        b=BUUjuIQOTI5MD+1RxaC/qtEocugqe14yzGEjsO8PET70IrIzrzTgQ9MjX0WWo/jDDJ
         8se6h+UNZBz25e1P+BxsUUlbxSbVMFwqwNCHtIIh2EU5fSpBynu9UFoh+1MAYYJBA5Sq
         RdfRJ19PzEKTxovR6sIseHBhmZ3M0AL5Pz6HnZUbKO7dKfW0k+uNVpfzqO+eCbnUEvzs
         HvUP9bxypNTr+uNDR4wdAHTn6/XFYzebka70PEpR7Tr5G0693QdTfOQpTLv+DAkaKHpI
         cD5/Ay3fDEEyXXNiatskQ/j3oO0tgUZE6E5BzvptDojTPRSmslZyWHxFAFJf3JXO+pTz
         bIVA==
X-Gm-Message-State: AAQBX9fYXB01nz5sRYyCbJHcym3mRGfsyOjxfl9TH/rRRZvvpo+Rqli0
	SdF53J+abhYaAOT3SFH/kaQhZMFi6LU31nvRpqEvV4XFvRoGiQ+fK5AHHDNmBp+3UVnBmF0GmmP
	d0QeMZ/hG8L6F4Bg1phWT76V+CJbA
X-Received: by 2002:adf:f6c9:0:b0:2f1:112d:826 with SMTP id y9-20020adff6c9000000b002f1112d0826mr1925266wrp.22.1681121928690;
        Mon, 10 Apr 2023 03:18:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZivHqhomdjHSj9s17gM4vguAwnHkMFzHwpkzx3zFmiWDQ6l1z6gOW6GEf4xXuhpmNH+FJXdA==
X-Received: by 2002:adf:f6c9:0:b0:2f1:112d:826 with SMTP id y9-20020adff6c9000000b002f1112d0826mr1925253wrp.22.1681121928392;
        Mon, 10 Apr 2023 03:18:48 -0700 (PDT)
Date: Mon, 10 Apr 2023 06:18:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230410060842-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
 <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
 <20230407074605-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BF6222A169B898B6A5BEDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407113737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481097A6BE0F55E6F626935DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481097A6BE0F55E6F626935DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id

On Sun, Apr 09, 2023 at 03:15:01AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, April 7, 2023 11:51 AM
> 
> > > 1. A non-transitional device will expose a capability (not a feature bit, but a
> > capability at transport level).
> > 
> > Note that we can allow this capability in transitional devices too.
> > This is useful since IO bar might not be enabled even if present.
> >
> This capability exposure makes a device transitional in some sense.

not in the sense spec uses it at the moment: transitional devices
are those that legacy drivers can bind to. transitional drivers
btw are those that can bind to legacy devices.

perhaps suprisingly, a transitional driver using a transitional
device does not rely on any legacy spec at all, they will
use the standard interfaces.


> > > This capability indicates that, it supports legacy interface.
> > > Lets name it legacy_if_emulation for sake of this discussion.
> > > It is a two-way pci capability.
> > > Device reports it.
> > > And driver enables it. (Why two way and why driver needs to enable it,
> > described later in point #d below).
> > >
> > > Hence, such non transitional device does not need to comply to below listed
> > requirements #a and #b.
> > >
> > > a. A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
> > > (Because hypervisor driver is a passthrough driver; and legacy driver will not
> > accept this feature bit).
> > 
> > This is not a device requirement at all.
> > 
> Those this is written as driver requirement; a device expects this feature bit to be negotiated.
> What should device implementor do? It should allow driver to not negotiate bit, right?
> 
> Which means, below line to be change:
> 
> from:
> device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.
> 
> to:
> Non transitional device that does not have legacy interface capability MAY fail to operate further if V_1 is not accepted.
> Non transitional device that has legacy interface capability SHOULD operate further even if V_1 is not accepted.



Look nothing changes with MMR capability at all.
We currently have:

	A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
	if VIRTIO_F_VERSION_1 is not accepted.

it's implied that this does not refer to legacy interface.


You want to clarify this adding to legacy interface section text
explaining that of course VIRTIO_F_VERSION_1 must not
be offered through that? Sure but it's a separate issue
from MMR capability. don't try to drink the ocean.





> > > b. device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.
> > 
> > This is optional not a requirement.
> > 
> Please see above wording, if its acceptable.


you don't need any of that for this effort, generally
VIRTIO_F_VERSION_1 thing needs a lot of work, if you
want to invest the time just ask I'll try to list the issues.

But nothing to do with memory mapped legacy interface
directly.



> > > c. A non-transitional device with above legacy_if_supported
> > > capability, will allow device reset sequence, described in [1] Driver
> > > Requirements: Device Initialization (3.1.1) [2] Legacy Interface:
> > > Device Initialization (3.1.2)
> > >
> > > > > device reset sequence.
> > > >
> > > > what is this one?
> > >
> > > I listed above in #c.
> > > And
> > >
> > > d. When legacy_if_emulation capability is offered and hypervisor driver
> > enabled it, when driver perform device reset, driver will not wait for device
> > reset to go zero.
> > > When legacy_if_emulation capability is not enabled by (hypervisor or other
> > say existing) driver, driver will wait for device reset to turn 0. (Following the
> > driver requirement 2.4.2).
> > 
> > It might not be a bad idea to enable it, but I observe that it is possible for
> > hypervisor to expose a standard transitional device on top of this MMR
> > capability. Thus it will not be known whether guest driver accesses legacy or
> > modern BAR until guest runs.
> > I propose, instead, that device exposes same registers at two addresses and
> > executes reset correctly depending on which address it was accessed through.
> > WDYT?
> Yep, this the exact proposal here.
> Legacy registers exposes via AQ (aka TVQ) or MMR location, behaves like legacy.
> And regular registers at their location as-is.
> 
> With that feature bit negotiation is the only thing to relax like worded above.

It's not really different from IO port legacy then.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

