Return-Path: virtio-dev-return-4256-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DE9A658180C6
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Jun 2018 13:51:05 -0700 (PDT)
Date: Fri, 1 Jun 2018 15:50:43 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180601205043.GA5944@vbusired-vm>
References: <20180523151613.3914-1-venu.busireddy@oracle.com>
 <20180601184033-mutt-send-email-mst@kernel.org>
 <20180601170126.GA10908@vbusired-vm>
 <20180601230119-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601230119-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH 0/1] Add "Group Identifier" to virtio PCI
 capabilities.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2018-06-01 23:03:16 +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 01, 2018 at 12:01:26PM -0500, Venu Busireddy wrote:
> > On 2018-06-01 18:42:06 +0300, Michael S. Tsirkin wrote:
> > > On Wed, May 23, 2018 at 11:16:12AM -0400, Venu Busireddy wrote:
> > > > During live migration involving passthrough devices, the guest needs
> > > > to know which virtio device will be a fail-over device for a given
> > > > passthrough device.
> > > > 
> > > > Extending the virtio specification with a new "Group Identifier"
> > > > capability allows qemu to set up the grouping at the time the guest
> > > > is created. The "Group Identifier" can be as simple as a number, or an
> > > > UUID. The driver can use the group identifier to pair the virtio device
> > > > with the passthrough device. The passthrough device can contain the
> > > > group identifier in the PCIe bridge to which it is attached.
> > > > 
> > > > Venu Busireddy (1):
> > > >   Add "Group Identifier" to virtio PCI capabilities.
> > > > 
> > > >  content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 43 insertions(+)
> > > 
> > > Is this a PCI thing, or can this somehow be used with non-PCI
> > 
> > This is applicable to all virtio PCI devices, but not to non-PCI
> > devices.
> > 
> > > devices? If PCI, we can just add a PCI UUID capability to
> > > virtio without need to worry about the spec.
> > 
> > What is a "PCI UUID capability?" "PCI Local Bus Specification
> > Revision 3.0, Appendix H" does not list any such capability.
> > 
> > Regards,
> > 
> > Venu
> 
> Sorry that I'm unclear. What I meant is the
> PCI Express serial number capability (0003h).

0003h is the VPD capability. Serial Number ("SN") is part of the VPD. QEMU
does not support VPD, and adding the VPD capability to QEMU is lot more
involved than storing the UUID in Vendor-Specific capability.

Do you strongly believe that adding VPD is required? Or, can we live
with using Vendor-Specific capability? The bridge device is going to be
QEMU specific device anyway, so there should be no ambiguity of mixing
up with other bridges.

Thanks,

Venu


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

