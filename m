Return-Path: virtio-dev-return-4098-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1120458191D0
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 May 2018 14:43:50 -0700 (PDT)
Date: Fri, 18 May 2018 16:43:36 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180518214336.GA26509@troi>
References: <20180517130604.9036-1-venu.busireddy@oracle.com>
 <20180517130604.9036-2-venu.busireddy@oracle.com>
 <20180518160623.GB21655@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518160623.GB21655@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH 1/1] Allow "Vendor Specific" extension to
 virtio PCI capabilities.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2018-05-18 17:06:23 +0100, Stefan Hajnoczi wrote:
> On Thu, May 17, 2018 at 09:06:04AM -0400, Venu Busireddy wrote:
> 
> Can you describe a use case where vendor-specific extensions make sense
> as opposed to extending the VIRTIO specification?

Sometimes, qemu may need to group certain devices together. In our
problem scenario, qemu needed to tell the driver which virtio device is a
fallback device for a given vfio-pci device. If the virtio device's PCI
capabilities are extended, the new capability could be used to store a
unique ID (say, the bus:device:function) that identifies the vfio-pci
device. The driver can use that information when needed to pair the
virtio device with the vfio-pci device.

Extending the VIRTIO specification is also a good alternative, but
every time the vendor needs something new, the specification needs to
be changed again. A generic "vendor specific" mechanism alleviates that.

> This proposal only supports the PCI transport, so do extensions only
> affect the PCI transport behavior or also other aspects of VIRTIO
> (device behavior, vring, etc)?

The proposal is only for PCI transport. It does not affect other
transports.

> > +\devicenormative{\paragraph}{Vendor Specific Extension capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Vendor Specific Extension capability}
> > +
> > +The device may or may not present the VIRTIO_PCI_CAP_VENDOR_EXT_CFG capability.
> 
> s/may or may not/MAY/

Will change that, along with any other suggestions, in v2.

> > +
> > +\drivernormative{\paragraph}{Vendor Specific Extension capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Vendor Specific Extension capability}
> > +
> > +The driver MUST NOT write to vendor_specific_data[] area or the BAR region.
> 
> How does a driver identify vendor-specific extensions that it supports?
> No Vendor ID is included in the capability, just an opaque blob, so how
> are collisions avoided?

Sorry for not making this clear! Since the capability is vendor specific,
the driver also needs to have corresponding vendor specific changes. The
driver needs to look at the Subsystem ID and Subsystem Vendor ID of the
virtio device, and interpret the data associated with the new capability
only when the IDs match with the IDs built into the driver. Vendors are
free to implement their own versioning scheme into that data to maintain
backward/forward compatibility.

> How does a driver behave upon encountering an unknown vendor-specific
> extension?

Drivers should ignore the data associated with the new capability if
the Subsystem ID and Subsystem Vendor ID do not match with the IDs built
into the driver. And, the specification already mandates that the drivers
should ignore VIRTIO_PCI_CAP_VENDOR_EXT_CFG if they don't know about it.

Venu


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

