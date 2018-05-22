Return-Path: virtio-dev-return-4121-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 91266581803B
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 06:49:12 -0700 (PDT)
Date: Tue, 22 May 2018 08:48:58 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180522134858.GA27663@troi>
References: <20180517130604.9036-1-venu.busireddy@oracle.com>
 <20180517130604.9036-2-venu.busireddy@oracle.com>
 <20180518160623.GB21655@stefanha-x1.localdomain>
 <20180518214336.GA26509@troi>
 <20180522100337.GK21655@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522100337.GK21655@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH 1/1] Allow "Vendor Specific" extension to
 virtio PCI capabilities.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2018-05-22 11:03:37 +0100, Stefan Hajnoczi wrote:
> On Fri, May 18, 2018 at 04:43:36PM -0500, Venu Busireddy wrote:
> > On 2018-05-18 17:06:23 +0100, Stefan Hajnoczi wrote:
> > > On Thu, May 17, 2018 at 09:06:04AM -0400, Venu Busireddy wrote:
> > > 
> > > Can you describe a use case where vendor-specific extensions make sense
> > > as opposed to extending the VIRTIO specification?
> > 
> > Sometimes, qemu may need to group certain devices together. In our
> > problem scenario, qemu needed to tell the driver which virtio device is a
> > fallback device for a given vfio-pci device. If the virtio device's PCI
> > capabilities are extended, the new capability could be used to store a
> > unique ID (say, the bus:device:function) that identifies the vfio-pci
> > device. The driver can use that information when needed to pair the
> > virtio device with the vfio-pci device.
> 
> This feature seems generic and could be in the VIRTIO spec proper.  What
> is vendor-specific about it?
> 
> > Extending the VIRTIO specification is also a good alternative, but
> > every time the vendor needs something new, the specification needs to
> > be changed again. A generic "vendor specific" mechanism alleviates that.
> 
> If you plan to push Linux code changes upstream to implement this
> feature then a vendor-specific extension is inappropriate and you should
> extend the VIRTIO spec.

I will redo the patch to extend the virtio specification.

Since the new patch will be conceptually different, shall I create a
new thread, or should I post it as v2?

Venu


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

