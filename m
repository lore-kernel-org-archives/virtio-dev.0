Return-Path: virtio-dev-return-5304-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24C41985D1F
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 15:56:35 +0000 (UTC)
Date: Wed, 9 Jan 2019 10:56:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190109105223-mutt-send-email-mst@kernel.org>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <1546900184-27403-3-git-send-email-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546900184-27403-3-git-send-email-venu.busireddy@oracle.com>
Subject: [virtio-dev] Re: [PATCH v3 2/5] virtio_net: Add support for "Data Path Switching"
 during Live Migration.
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 07, 2019 at 05:29:41PM -0500, Venu Busireddy wrote:
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 80d42e1..2a3ffd3 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -176,6 +176,25 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
>      }
>  }
>  
> +static void acpi_pcihp_cleanup_failover_primary(AcpiPciHpState *s, int bsel)
> +{
> +    BusChild *kid, *next;
> +    PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
> +
> +    if (!bus) {
> +        return;
> +    }
> +    QTAILQ_FOREACH_SAFE(kid, &bus->qbus.children, sibling, next) {
> +        DeviceState *qdev = kid->child;
> +        PCIDevice *pdev = PCI_DEVICE(qdev);
> +        int slot = PCI_SLOT(pdev->devfn);
> +
> +        if (pdev->failover_primary) {
> +            s->acpi_pcihp_pci_status[bsel].down |= (1U << slot);
> +        }
> +    }
> +}
> +
>  static void acpi_pcihp_update_hotplug_bus(AcpiPciHpState *s, int bsel)
>  {
>      BusChild *kid, *next;

So the result here will be that device will be deleted completely,
and will not reappear after guest reboot.
I don't think this is what we wanted.
I think we wanted a special state that will hide device from guest until
guest acks the failover bit.


> @@ -207,6 +226,14 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
>      int i;
>  
>      for (i = 0; i < ACPI_PCIHP_MAX_HOTPLUG_BUS; ++i) {
> +        /*
> +         * Set the acpi_pcihp_pci_status[].down bits of all the
> +         * failover_primary devices so that the devices are ejected
> +         * from the guest. We can't use the qdev_unplug() as well as the
> +         * hotplug_handler to unplug the devices, because the guest may
> +         * not be in a state to cooperate.
> +         */
> +        acpi_pcihp_cleanup_failover_primary(s, i);
>          acpi_pcihp_update_hotplug_bus(s, i);
>      }
>  }

I really don't want acpi to know anything about failover.

All that needs to happen is sending a device delete request
to guest. Should work with any hotplug removal:
pci standard,acpi, etc.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

