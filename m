Return-Path: virtio-dev-return-5301-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA21A985CEF
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 13:39:55 +0000 (UTC)
Date: Wed, 9 Jan 2019 14:39:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190109143944.14b2f98b.cohuck@redhat.com>
In-Reply-To: <1546900184-27403-3-git-send-email-venu.busireddy@oracle.com>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-3-git-send-email-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v3 2/5] virtio_net: Add support for "Data
 Path Switching" during Live Migration.
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon,  7 Jan 2019 17:29:41 -0500
Venu Busireddy <venu.busireddy@oracle.com> wrote:

> Added a new event, FAILOVER_STANDBY_CHANGED, which is emitted whenever
> the status of the virtio_net driver in the guest changes (either the
> guest successfully loads the driver after the F_STANDBY feature bit
> is negotiated, or the guest unloads the driver or reboots). Management
> stack can use this event to determine when to plug/unplug the VF device
> to/from the guest.
> 
> Also, the Virtual Functions will be automatically removed from the guest
> if the guest is rebooted. To properly identify the VFIO devices that
> must be removed, a new property named "failover-primary" is added to
> the vfio-pci devices. Only the vfio-pci devices that have this property
> enabled are removed from the guest upon reboot.
> 
> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> ---
>  hw/acpi/pcihp.c      | 27 +++++++++++++++++++++++++++
>  hw/net/virtio-net.c  | 24 ++++++++++++++++++++++++
>  hw/vfio/pci.c        |  3 +++
>  hw/vfio/pci.h        |  1 +
>  include/hw/pci/pci.h |  1 +
>  qapi/net.json        | 28 ++++++++++++++++++++++++++++
>  6 files changed, 84 insertions(+)
> 
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


It seems that you rely on acpi to get the processing right. On a
non-acpi system, you won't get the required changes done. Maybe only
advertise the failover feature if you are actually on a system that
supports handling of the primary correctly (which, at least currently,
means a system with acpi)?

> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 411f8fb..7b1bcde 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -248,6 +248,29 @@ static void virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
>      }
>  }
>  
> +static void virtio_net_failover_notify_event(VirtIONet *n, uint8_t status)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +
> +    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_STANDBY)) {
> +        const char *ncn = n->netclient_name;
> +        gchar *path = object_get_canonical_path(OBJECT(n->qdev));
> +        /*
> +         * Emit FAILOVER_STANDBY_CHANGED event with enabled=true
> +         *   when the status transitions from 0 to VIRTIO_CONFIG_S_DRIVER_OK
> +         * Emit FAILOVER_STANDBY_CHANGED event with enabled=false
> +         *   when the status transitions from VIRTIO_CONFIG_S_DRIVER_OK to 0
> +         */
> +        if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +                (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))) {
> +            qapi_event_send_failover_standby_changed(!!ncn, ncn, path, true);
> +        } else if ((!(status & VIRTIO_CONFIG_S_DRIVER_OK)) &&
> +                (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +            qapi_event_send_failover_standby_changed(!!ncn, ncn, path, false);
> +        }

Do you also need a notification if something goes wrong in the guest
and it sets VIRTIO_CONFIG_S_FAILED?

> +    }
> +}
> +
>  static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

