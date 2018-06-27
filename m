Return-Path: virtio-dev-return-4584-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F9015819221
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Jun 2018 12:31:03 -0700 (PDT)
Date: Wed, 27 Jun 2018 14:29:58 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180627192958.GA17236@vbusired-vm>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
 <20180627122457.GA19714@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627122457.GA19714@rkaganb.sw.ru>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v2 0/4] Use of unique identifier for pairing
 virtio and passthrough devices...
To: Roman Kagan <rkagan@virtuozzo.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2018-06-27 15:24:58 +0300, Roman Kagan wrote:
> On Tue, Jun 26, 2018 at 10:49:30PM -0500, Venu Busireddy wrote:
> > The patch set "Enable virtio_net to act as a standby for a passthru
> > device" [1] deals with live migration of guests that use passthrough
> > devices. However, that scheme uses the MAC address for pairing
> > the virtio device and the passthrough device. The thread "netvsc:
> > refactor notifier/event handling code to use the failover framework"
> > [2] discusses an alternate mechanism, such as using an UUID, for pairing
> > the devices. Based on that discussion, proposals "Add "Group Identifier"
> > to virtio PCI capabilities." [3] and "RFC: Use of bridge devices to
> > store pairing information..." [4] were made.
> 
> I must have missed something in those threads, but where does this UUID
> thing come about?  AFAICS this identifier doesn't need to be
> "universally" unique, nor persistent; it only has to be unique across
> the VM and stable throughout the VM lifetime.

The notion of using UUID came up in the thread

   https://www.spinics.net/lists/netdev/msg499011.html

> FWIW Hyper-V uses a 32-bit integer for this purpose, not a UUID as seems
> to be implied in the thread you refer to.

Yes, Hyper-V uses a serial number (but I think it is 64-bit value).
However, what we are doing is similar to that. Instead of 32 bits,
we are using 128 bits.

> > The current patch set includes all the feedback received for proposals [3]
> > and [4]. For the sake of completeness, patch for the virtio specification
> > is also included here. Following is the updated proposal.
> > 
> > 1. Extend the virtio specification to include a new virtio PCI capability
> >    "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> > 
> > 2. Enhance the QEMU CLI to include a "uuid" option to the virtio device.
> >    The "uuid" is a string in UUID format.
> > 
> > 3. Enhance the QEMU CLI to include a "uuid" option to the bridge device.
> >    The "uuid" is a string in UUID format. Currently, PCIe bridge for
> >    the Q35 model is supported.
> > 
> > 4. The operator creates a unique identifier string using 'uuidgen'.
> > 
> > 5. When the virtio device is created, the operator uses the "uuid" option
> >    (for example, '-device virtio-net-pci,uuid="string"') and specifies
> >    the UUID created in step 4.
> > 
> >    QEMU stores the UUID in the virtio device's configuration space
> >    in the capability "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> > 
> > 6. When assigning a PCI device to the guest in passthrough mode, the
> >    operator first creates a bridge using the "uuid" option (for example,
> >    '-device pcie-downstream,uuid="string"') to specify the UUID created
> >    in step 4, and then attaches the passthrough device to the bridge.
> > 
> >    QEMU stores the UUID in the configuration space of the bridge as
> >    Vendor-Specific capability (0x09). The "Vendor" here is not to be
> >    confused with a specific organization. Instead, the vendor of the
> >    bridge is QEMU. To avoid mixing up with other bridges, the bridge
> >    will be created with vendor ID 0x1b36 (PCI_VENDOR_ID_REDHAT) and
> >    device ID 0x000e (PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE) if the "uuid"
> >    option is specified. Otherwise, current defaults are used.
> 
> I wonder if it makes more sense to drop the concept of failover groups,
> and just refer to the standby device by device-id, like 
> 
>   -device virtio-net-pci,id=foo \
>   -device pcie-downstream,failover=foo

Isn't this the same as what this patch series proposes? In your
suggestion, "foo" is the entity that connects the passthrough device
and the failover device. In this patch set, that "foo" is the UUID,
and the options "id" and "failover" are replaced by "uuid". Do you agree?

Regards,

Venu

> The bridge device will then lookup the failover device, figure out the
> common identifier to expose to the guest, and defer the visibility of
> the PT device behind the bridge until the guest acknowledged the support
> for failover on the PV device.
> 
> Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

