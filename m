Return-Path: virtio-dev-return-4590-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7382E581922B
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Jun 2018 16:08:19 -0700 (PDT)
Date: Wed, 27 Jun 2018 18:07:59 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180627230758.GA14856@vbusired-vm>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
 <20180627034935.20276-4-venu.busireddy@oracle.com>
 <20180627065943-mutt-send-email-mst@kernel.org>
 <20180627040812.GA20446@troi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627040812.GA20446@troi>
Subject: Re: [virtio-dev] Re: [PATCH v2 3/4] Add "Group Identifier" support
 to Red Hat PCI bridge.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2018-06-26 23:08:12 -0500, Venu Busireddy wrote:
> On 2018-06-27 07:02:36 +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 26, 2018 at 10:49:33PM -0500, Venu Busireddy wrote:
> > > Add the "Vendor-Specific" capability to the Red Hat PCI bridge device
> > > "pci-bridge", to contain the "Group Identifier" (UUID) that will be
> > > used to pair a virtio device with the passthrough device attached to
> > > that bridge.
> > > 
> > > This capability is added to the bridge iff the "uuid" option is specified
> > > for the bridge.
> > 
> > I think the name should be more explicit. How about "failover-group-id"?
> 
> I can change it. But don't you think it is bit long?
> 
> > > 
> > > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > 
> > I'd like to also tweak the device id in this case,
> > to make it easier for guests to know it's a grouping bridge.
> 
> Could you please recommend a name for the new ID'd definition? Something
> in lines of PCI_DEVICE_ID_REDHAT_<blah blah>.

How about these names and values for the device IDs?

  PCI_DEVICE_ID_REDHAT_PCI_BRIDGE_GRP (0x0010) for pci-bridge, and 
  PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE_GRP (0x0011) for pcie-downstream

Thanks,

Venu

> > > ---
> > >  hw/pci-bridge/pci_bridge_dev.c |  8 ++++++++
> > >  hw/pci/pci_bridge.c            | 26 ++++++++++++++++++++++++++
> > >  include/hw/pci/pcie.h          |  1 +
> > >  3 files changed, 35 insertions(+)
> > > 
> > > diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> > > index b2d861d216..bbbc6fa1c6 100644
> > > --- a/hw/pci-bridge/pci_bridge_dev.c
> > > +++ b/hw/pci-bridge/pci_bridge_dev.c
> > > @@ -71,6 +71,12 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
> > >          bridge_dev->msi = ON_OFF_AUTO_OFF;
> > >      }
> > >  
> > > +    err = pci_bridge_vendor_init(dev, 0, errp);
> > > +    if (err < 0) {
> > > +        error_append_hint(errp, "Can't init group ID, error %d\n", err);
> > > +        goto vendor_cap_err;
> > > +    }
> > > +
> > >      err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0, errp);
> > >      if (err) {
> > >          goto slotid_error;
> > > @@ -109,6 +115,7 @@ slotid_error:
> > >      if (shpc_present(dev)) {
> > >          shpc_cleanup(dev, &bridge_dev->bar);
> > >      }
> > > +vendor_cap_err:
> > >  shpc_error:
> > >      pci_bridge_exitfn(dev);
> > >  }
> > > @@ -162,6 +169,7 @@ static Property pci_bridge_dev_properties[] = {
> > >                              ON_OFF_AUTO_AUTO),
> > >      DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
> > >                      PCI_BRIDGE_DEV_F_SHPC_REQ, true),
> > > +    DEFINE_PROP_UUID(COMPAT_PROP_UUID, PCIDevice, uuid, false),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >  
> > > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> > > index 40a39f57cb..cb8b3dad2a 100644
> > > --- a/hw/pci/pci_bridge.c
> > > +++ b/hw/pci/pci_bridge.c
> > > @@ -34,12 +34,17 @@
> > >  #include "hw/pci/pci_bus.h"
> > >  #include "qemu/range.h"
> > >  #include "qapi/error.h"
> > > +#include "qemu/uuid.h"
> > >  
> > >  /* PCI bridge subsystem vendor ID helper functions */
> > >  #define PCI_SSVID_SIZEOF        8
> > >  #define PCI_SSVID_SVID          4
> > >  #define PCI_SSVID_SSID          6
> > >  
> > > +#define PCI_VENDOR_SIZEOF             20
> > > +#define PCI_VENDOR_CAP_LEN_OFFSET      2
> > > +#define PCI_VENDOR_GROUP_ID_OFFSET     4
> > > +
> > >  int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
> > >                            uint16_t svid, uint16_t ssid,
> > >                            Error **errp)
> > > @@ -57,6 +62,27 @@ int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
> > >      return pos;
> > >  }
> > >  
> > > +int pci_bridge_vendor_init(PCIDevice *d, uint8_t offset, Error **errp)
> > > +{
> > > +    int pos;
> > > +
> > > +    if (qemu_uuid_is_null(&d->uuid)) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    pos = pci_add_capability(d, PCI_CAP_ID_VNDR, offset, PCI_VENDOR_SIZEOF,
> > > +            errp);
> > > +    if (pos < 0) {
> > > +        return pos;
> > > +    }
> > > +
> > > +    pci_set_word(d->config + pos + PCI_VENDOR_CAP_LEN_OFFSET,
> > > +            PCI_VENDOR_SIZEOF);
> > > +    memcpy(d->config + pos + PCI_VENDOR_GROUP_ID_OFFSET, &d->uuid,
> > > +            sizeof(QemuUUID));
> > > +    return pos;
> > > +}
> > > +
> > >  /* Accessor function to get parent bridge device from pci bus. */
> > >  PCIDevice *pci_bridge_get_device(PCIBus *bus)
> > >  {
> > > diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> > > index b71e369703..b4189d0ce3 100644
> > > --- a/include/hw/pci/pcie.h
> > > +++ b/include/hw/pci/pcie.h
> > > @@ -82,6 +82,7 @@ struct PCIExpressDevice {
> > >  };
> > >  
> > >  #define COMPAT_PROP_PCP "power_controller_present"
> > > +#define COMPAT_PROP_UUID "uuid"
> > >  
> > >  /* PCI express capability helper functions */
> > >  int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

