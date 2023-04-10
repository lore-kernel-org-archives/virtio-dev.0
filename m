Return-Path: <virtio-dev-return-12099-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12774C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:58:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 69949A7E4C
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:58:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 610A69863A7
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:58:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5356998632A; Mon, 10 Apr 2023 19:58:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 433BE986321
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 19:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lH-Ia95xNZigToCI8lFlZQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pfCt5W4S6Ef/C5ZymJh58W3fzEjE2EyMyMfmLAk/jI=;
        b=b986EsAWoovWzYRKt9T588yixZ2w31tkM4lPI6NUtLt1zrzSHzH+MR+KCDMgSxSYHW
         c0nKHoQSPJIZlD13wjvArJvl4kjt/iaZrn0dl1zI1BW9Br6VQOPN70L9kw++P1tgIqF7
         Vw4YiE0/Gr3bVpbYhHFuz+sZcDGTfrdOcTGBinfzui/QgjgfoZeH7Xq0wDQJ9OYDbaJB
         1UkUTBmkpwNdXBhH1TJf3p2IFXpl5OeqTYIzboBs5LyJkqZvpyCvScP5DV2eOtNQd6VG
         C6cF4eYVcxFJaObFRdCI8xMJNQ6yh/U8vNR/cc5aX3H500xHN7M3TbmhG1VKhSj0qqVf
         2fnA==
X-Gm-Message-State: AAQBX9ed3kea4mODIwgVQtfnFbsZSEecS9kAYv6b/Vu7iBFfP8Abr3ny
	Igp8hDlZlMnMvRT/8mwxnyFQlvrYVHfYovYPYgK/3lBQihtZG+HpcNWH3dI0IqMzc1rczenTjw7
	r2BFLngWs/4qcqB8o6yX0RyVMDEZz
X-Received: by 2002:a05:600c:22c7:b0:3eb:4150:a476 with SMTP id 7-20020a05600c22c700b003eb4150a476mr380112wmg.0.1681156691575;
        Mon, 10 Apr 2023 12:58:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350ariYPCZwgmyYLr+uj1m9CoBZu/z8WLB3Ri1sGmd0HWTwEfs7pOfWEWM2GDnwB37woo7NeQ1Q==
X-Received: by 2002:a05:600c:22c7:b0:3eb:4150:a476 with SMTP id 7-20020a05600c22c700b003eb4150a476mr380103wmg.0.1681156691187;
        Mon, 10 Apr 2023 12:58:11 -0700 (PDT)
Date: Mon, 10 Apr 2023 15:58:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230410154959-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
 <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
 <20230407074605-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BF6222A169B898B6A5BEDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407113737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481097A6BE0F55E6F626935DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230410060842-mutt-send-email-mst@kernel.org>
 <460d2724-5c92-da5c-2f8c-cf29ea6d8080@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <460d2724-5c92-da5c-2f8c-cf29ea6d8080@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id

On Mon, Apr 10, 2023 at 10:34:16AM -0400, Parav Pandit wrote:
> 
> 
> On 4/10/2023 6:18 AM, Michael S. Tsirkin wrote:
> > On Sun, Apr 09, 2023 at 03:15:01AM +0000, Parav Pandit wrote:
> > > 
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Friday, April 7, 2023 11:51 AM
> > > 
> > > > > 1. A non-transitional device will expose a capability (not a feature bit, but a
> > > > capability at transport level).
> > > > 
> > > > Note that we can allow this capability in transitional devices too.
> > > > This is useful since IO bar might not be enabled even if present.
> > > > 
> > > This capability exposure makes a device transitional in some sense.
> > 
> > not in the sense spec uses it at the moment: transitional devices
> > are those that legacy drivers can bind to. transitional drivers
> > btw are those that can bind to legacy devices.
> > 
> > perhaps suprisingly, a transitional driver using a transitional
> > device does not rely on any legacy spec at all, they will
> > use the standard interfaces.
> > 
> > 
> > > > > This capability indicates that, it supports legacy interface.
> > > > > Lets name it legacy_if_emulation for sake of this discussion.
> > > > > It is a two-way pci capability.
> > > > > Device reports it.
> > > > > And driver enables it. (Why two way and why driver needs to enable it,
> > > > described later in point #d below).
> > > > > 
> > > > > Hence, such non transitional device does not need to comply to below listed
> > > > requirements #a and #b.
> > > > > 
> > > > > a. A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
> > > > > (Because hypervisor driver is a passthrough driver; and legacy driver will not
> > > > accept this feature bit).
> > > > 
> > > > This is not a device requirement at all.
> > > > 
> > > Those this is written as driver requirement; a device expects this feature bit to be negotiated.
> > > What should device implementor do? It should allow driver to not negotiate bit, right?
> > > 
> > > Which means, below line to be change:
> > > 
> > > from:
> > > device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.
> > > 
> > > to:
> > > Non transitional device that does not have legacy interface capability MAY fail to operate further if V_1 is not accepted.
> > > Non transitional device that has legacy interface capability SHOULD operate further even if V_1 is not accepted.
> > 
> > 
> > 
> > Look nothing changes with MMR capability at all.
> > We currently have:
> > 
> > 	A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> > 	if VIRTIO_F_VERSION_1 is not accepted.
> > 
> > it's implied that this does not refer to legacy interface.
> > 
> But the interface being exposes is not a legacy interface at the PCI device
> level.
> 
> A PCI device is exposing a interface that can be used
> by either
> a. existing non transitional driver who will negotiate _1, just fine.
> or
> b. by legacy driver in the guest VM, which will not negotiate _1.
> 
> And here device must not fail to operate.
> Hence spec should say that it should not fail to operate.

sorry, what? it's exactly the legacy interface that's the whole
value of this hack, just exposed through another bar.

> > 
> > You want to clarify this adding to legacy interface section text
> > explaining that of course VIRTIO_F_VERSION_1 must not
> > be offered through that?
> It will be offered because hypervisor driver is not getting involved in the
> reset flow and in read/write of the feature bits etc.
> 
> Hypervisor driver is only providing the transport channel from the guest vm
> to the device.
> 
> And since the guest driver may be 1.x, _1 will be offered by the device.

_1 is not offered in the legacy interface. And if you negotiate
_1 you better not touch legacy with a 10 foot pole.


> > Sure but it's a separate issue
> > from MMR capability. don't try to drink the ocean.
> > 
> > 
> > 
> > 
> > 
> > > > > b. device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.
> > > > 
> > > > This is optional not a requirement.
> > > > 
> > > Please see above wording, if its acceptable.
> > 
> > 
> > you don't need any of that for this effort, generally
> > VIRTIO_F_VERSION_1 thing needs a lot of work, if you
> > want to invest the time just ask I'll try to list the issues.
> > 
> > But nothing to do with memory mapped legacy interface
> > directly.
> > 
> I likely dont understand your above point.
> The point is, a device with new capability needs to
> 
> a. offer VERSION_1 offer, allow negotiation VERSION_1
> b. allow not negotiation of VERSION_1
> 
> With single virtio device id, how to frame this in the spec?
> One way I proposed above that a new transport capability indicates this.
> 
> I didnt follow your idea of how above #a and #b can be worded without the
> new capability wording.

Just add a new capability and explain that it exposes
the legacy interface in a window at an offset inside a memory bar.
that is mostly it. if there's an adapting layer that forwards
IO requests from legacy driver to that window, this allows this
driver to work and use the device through the legacy
interface.


There could be a small patch or two on top to tweak wording if there are
places where it says "non transitional devices have no legacy
interfaces". And probably an explicit list of devices
which are allowed to have this capability.


That is it really.



> > 
> > 
> > > > > c. A non-transitional device with above legacy_if_supported
> > > > > capability, will allow device reset sequence, described in [1] Driver
> > > > > Requirements: Device Initialization (3.1.1) [2] Legacy Interface:
> > > > > Device Initialization (3.1.2)
> > > > > 
> > > > > > > device reset sequence.
> > > > > > 
> > > > > > what is this one?
> > > > > 
> > > > > I listed above in #c.
> > > > > And
> > > > > 
> > > > > d. When legacy_if_emulation capability is offered and hypervisor driver
> > > > enabled it, when driver perform device reset, driver will not wait for device
> > > > reset to go zero.
> > > > > When legacy_if_emulation capability is not enabled by (hypervisor or other
> > > > say existing) driver, driver will wait for device reset to turn 0. (Following the
> > > > driver requirement 2.4.2).
> > > > 
> > > > It might not be a bad idea to enable it, but I observe that it is possible for
> > > > hypervisor to expose a standard transitional device on top of this MMR
> > > > capability. Thus it will not be known whether guest driver accesses legacy or
> > > > modern BAR until guest runs.
> > > > I propose, instead, that device exposes same registers at two addresses and
> > > > executes reset correctly depending on which address it was accessed through.
> > > > WDYT?
> > > Yep, this the exact proposal here.
> > > Legacy registers exposes via AQ (aka TVQ) or MMR location, behaves like legacy.
> > > And regular registers at their location as-is.
> > > 
> > > With that feature bit negotiation is the only thing to relax like worded above.
> > 
> > It's not really different from IO port legacy then.
> > 
> Yes, it is no different, because what is provided is just the transport, not
> a new functional behavior.

So let it be, just add stuff where capability is different.
Leave cleanups of legacy and transitional stuff for later.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

