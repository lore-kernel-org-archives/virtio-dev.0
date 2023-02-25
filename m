Return-Path: <virtio-dev-return-11288-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330B3C7EE2D
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:58:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 60F9E29FE5
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:58:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C79F986792
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:58:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 51B119866A9; Sat, 25 Feb 2023 22:58:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FAC398413F
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 22:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9qB81qgaOjuzACkijqQIsQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsTHZOy3v0aWFrHwHLQt5zTO2NWU5UVggJ+6xusruDs=;
        b=A7IhPjeMrzL5z3x99FR7JWB74GeR3hc8FISTk62lOs5IfcAZUkvZ+8UqHqp59VePSy
         Bp43UQWi21faeTDaTrv5Q0g/1s4qWxPubR4e4SoWSUHpmf74hrPXuowfNPp3w0M7i8rJ
         8GgpA6LI6W805p4/xKdp5OYls9ovlqRQQ4UopnZT2EINGvNTV+t7dE9hP5BlEa0V9Ajz
         qv2V83/8KQfQaid4IYo499U7N+GBG1LJY4n+jQ89cNoIaXTaY5NoajhJws2IwE5qSvuO
         lzzxdzfYCmzPpBVmC8MI1mKqSQiDE7rIJAHj9rwdTxKD0ViAP356OMCacj++V15tXNgY
         5d3A==
X-Gm-Message-State: AO0yUKWqxWkWYaIRNoXm2G9yfQ3d1Sha9uWP7/jTSIJezdCzJzl/6mYj
	O+7qzVq483rS36FnlAqf4+TRhlT+EQfAfKaog/kyMzhe4KHMViZ9uuJl4s54F4BwZKzS1EDKwzr
	xYzFReP2leAzwExdp5vZQrG+gNxQQ
X-Received: by 2002:a05:600c:714:b0:3e2:a8e:ba4a with SMTP id i20-20020a05600c071400b003e20a8eba4amr14340156wmn.21.1677365902096;
        Sat, 25 Feb 2023 14:58:22 -0800 (PST)
X-Google-Smtp-Source: AK7set8A+bH/0jCn14E/kM0H/UEu40lAsyjRq0Z4Wimv5LMUadw6LtXCj16i0Kvof/O7WcDr8GJ1GQ==
X-Received: by 2002:a05:600c:714:b0:3e2:a8e:ba4a with SMTP id i20-20020a05600c071400b003e20a8eba4amr14340145wmn.21.1677365901686;
        Sat, 25 Feb 2023 14:58:21 -0800 (PST)
Date: Sat, 25 Feb 2023 17:58:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230225174948-mutt-send-email-mst@kernel.org>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-3-parav@nvidia.com>
 <20230225121237-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481088CBC9B4C99D2527A92DCA99@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481088CBC9B4C99D2527A92DCA99@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 2/2] transport-pci: Move transitional device id to legacy
 section
Message-ID: <20230225225817.gQEa8yWM6CJO_UK4VcwHyqiHfcaR4IhyHdz-0iEIGMY@z>

On Sat, Feb 25, 2023 at 09:38:16PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Saturday, February 25, 2023 12:27 PM
> > 
> > On Sat, Feb 25, 2023 at 01:12:32AM +0200, Parav Pandit wrote:
> > > Currently PCI device requirements section contains mix of normative
> > > statements for for regular (non transitional) device and transitional
> > > device under one section.
> > >
> > > Some requirements of the transitional device are also located in
> > > legacy interface section which is the right section for it.
> > 
> > > Hence,
> > > 1. Move transitional device requirements to their designated Legacy
> > >    interface section
> > > 2. Describe regular device requirements without quoting it as "non
> > >    transitional device"
> > 
> > I do not think this is the way to go.
> > 
> > Spec covers the functioning of modern devices and the transitional devices
> > when operated by modern drivers.
> We do not have a modern driver term in the spec.
> We have the legacy driver and the transitional driver in spec.
> The modern driver is the way of Linux implementation as far as I understand that binds to transitional and nontransitional devices.

Technically, non-transitional:

	Devices or drivers with no legacy compatibility are referred to as
	non-transitional devices and drivers, respectively.


> > The text that covers using modern interfaces belongs in the regular section.
> >
> What do you mean by modern interfaces in the context of spec?
> 
> Spec at beginning says "Requirements pertaining to transitional devices and drivers is contained in sections named 'Legacy Interface'
> like this one."

yes, but also:

	When device is used through the legacy interface, transitional
	devices and transitional drivers MUST operate according to the
	requirements documented within these legacy interface sections.
	Specification text within these sections generally does not apply
	to non-transitional devices.


> So the content I moved is for the "transitional device" to the Legacy interface section.
> 
> A Linux implementation is free to implement a modern driver that probes transitional and non-transitional devices.

Let's not confuse things please. Legacy sections talk about the legacy
interface. If something applies when device is not used through
the legacy interface then it does not belong in the legacy section.

What you are missing is that a non-transitional driver must
work with a transitional device. Similarly a non-transitional
device must work with a transitional driver.
Things you are trying to move are relevant for this.



> > Legacy devices and drivers are covered in separate legacy sections which are
> > non-normative (not because they have to, but simply because writing
> > normative sections for legacy devices would be extra effort).
> > 
> > Take this example. Modern drivers ignore revision, but transitional ones need
> > to have 0 because this is what legacy drivers expect.
> > Reporting 0 in revision this belongs in legacy section.
> > 
> Sure. And that is how the spec is documented as you have described.
> 
> "Transitional devices MUST have a PCI Revision ID of 0.".

And that's in the legacy section.

> > >
> > > While at it, write the description using a singular object definition.
> > >
> > > This is only an editorial change.
> > >
> > > This patch is on top of [1].
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> > >
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  transport-pci.tex | 70
> > > ++++++++++++++++++++++++-----------------------
> > >  1 file changed, 36 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/transport-pci.tex b/transport-pci.tex index
> > > e271d51..9686cc8 100644
> > > --- a/transport-pci.tex
> > > +++ b/transport-pci.tex
> > > @@ -28,46 +28,24 @@ \subsection{PCI Device Discovery}\label{sec:Virtio
> > > Transport Options / Virtio Ov
> > >
> > >  \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio
> > > Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
> > >
> > > -Devices MUST have the PCI Vendor ID 0x1AF4.
> > > -Devices MUST either have the PCI Device ID calculated by adding
> > > 0x1040
> > > +The device MUST have the PCI Vendor ID 0x1AF4.
> > > +The device MUST calculate PCI Device ID by adding 0x1040
> > >  to the Virtio Device ID, as indicated in section \ref{sec:Device
> > > -Types} or have the Transitional PCI Device ID depending on the device
> > > type, -as follows:
> > > -
> > > -\begin{tabular}{|l|c|}
> > > -\hline
> > > -Transitional PCI Device ID  &  Virtio Device    \\
> > > -\hline \hline
> > > -0x1000      &   network device     \\
> > > -\hline
> > > -0x1001     &   block device     \\
> > > -\hline
> > > -0x1002     & memory ballooning (traditional)  \\
> > > -\hline
> > > -0x1003     &      console       \\
> > > -\hline
> > > -0x1004     &     SCSI host      \\
> > > -\hline
> > > -0x1005     &  entropy source    \\
> > > -\hline
> > > -0x1009     &   9P transport     \\
> > > -\hline
> > > -\end{tabular}
> > > +Types}
> > >
> > >  For example, the network device with the Virtio Device ID 1 -has the
> > > PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> > > -
> > > -The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
> > > reflect -the PCI Vendor and Device ID of the environment (for informational
> > purposes by the driver).
> > > +has the PCI Device ID 0x1041.
> > >
> > > -Non-transitional devices SHOULD have a PCI Device ID in the range
> > > -0x1040 to 0x107F.
> > > -Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
> > > -Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or
> > higher.
> > > +The device SHOULD have a PCI Device ID in the range 0x1040 to 0x107F.
> > > +The device SHOULD have a PCI Revision ID of 1 or higher.
> > > +The device SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
> > >
> > >  This is to reduce the chance of a legacy driver attempting  to drive
> > > the device.
> > >
> > > +The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
> > > +reflect the PCI Vendor and Device ID of the environment (for informational
> > purposes by the driver).
> > > +
> > >  \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio
> > > Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
> > > Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and  the PCI
> > > Device ID in the range 0x1040 to 0x107F, @@ -85,8 +63,32 @@
> > > \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio
> > Ov  PCI Subsystem Device ID value.
> > >
> > >  \subsubsection{Legacy Interfaces: A Note on PCI Device
> > > Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI
> > Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery} -
> > Transitional devices MUST have a PCI Revision ID of 0.
> > > -Transitional devices MUST have the PCI Subsystem Device ID
> > > +
> > > +The transitional device has one of the following PCI Device ID
> > > +depending on the device type:
> > > +
> > > +\begin{tabular}{|l|c|}
> > > +\hline
> > > +Transitional PCI Device ID  &  Virtio Device    \\
> > > +\hline \hline
> > > +0x1000      &   network device     \\
> > > +\hline
> > > +0x1001     &   block device     \\
> > > +\hline
> > > +0x1002     & memory ballooning (traditional)  \\
> > > +\hline
> > > +0x1003     &      console       \\
> > > +\hline
> > > +0x1004     &     SCSI host      \\
> > > +\hline
> > > +0x1005     &  entropy source    \\
> > > +\hline
> > > +0x1009     &   9P transport     \\
> > > +\hline
> > > +\end{tabular}
> > > +
> > > +The transitional device MUST have a PCI Revision ID of 0.
> > > +The transitional device MUST have the PCI Subsystem Device ID
> > >  matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
> > >  Transitional devices MUST have the Transitional PCI Device ID in  the
> > > range 0x1000 to 0x103F.
> > > --
> > > 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

