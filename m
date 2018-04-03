Return-Path: virtio-dev-return-3705-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 33F375818F7C
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Apr 2018 05:25:23 -0700 (PDT)
Date: Tue, 3 Apr 2018 15:25:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180403152308-mutt-send-email-mst@kernel.org>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-2-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522573990-5242-2-git-send-email-si-wei.liu@oracle.com>
Subject: [virtio-dev] Re: [RFC PATCH 1/3] qemu: virtio-bypass should explicitly bind to a
 passthrough device
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jiri@resnulli.us, stephen@networkplumber.org, alexander.h.duyck@intel.com, davem@davemloft.net, jesse.brandeburg@intel.com, kubakici@wp.pl, jasowang@redhat.com, sridhar.samudrala@intel.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Apr 01, 2018 at 05:13:08AM -0400, Si-Wei Liu wrote:
> @@ -896,6 +898,68 @@ void qmp_device_del(const char *id, Error **errp)
>      }
>  }
>  
> +int pci_get_busdevfn_by_id(const char *id, uint16_t *busnr,
> +                           uint16_t *devfn, Error **errp)
> +{
> +    uint16_t busnum = 0, slot = 0, func = 0;
> +    const char *pc, *pd, *pe;
> +    Error *local_err = NULL;
> +    ObjectClass *class;
> +    char value[1024];
> +    BusState *bus;
> +    uint64_t u64;
> +
> +    if (!(pc = strchr(id, ':'))) {
> +        error_setg(errp, "Invalid id: backup=%s, "
> +                   "correct format should be backup="
> +                   "'<bus-id>:<slot>[.<function>]'", id);
> +        return -1;
> +    }
> +    get_opt_name(value, sizeof(value), id, ':');
> +    if (pc != id + 1) {
> +        bus = qbus_find(value, errp);
> +        if (!bus)
> +            return -1;
> +
> +        class = object_get_class(OBJECT(bus));
> +        if (class != object_class_by_name(TYPE_PCI_BUS) &&
> +            class != object_class_by_name(TYPE_PCIE_BUS)) {
> +            error_setg(errp, "%s is not a device on pci bus", id);
> +            return -1;
> +        }
> +        busnum = (uint16_t)pci_bus_num(PCI_BUS(bus));
> +    }

pci_bus_num is almost always a bug if not done within
a context of a PCI host, bridge, etc.

In particular this will not DTRT if run before guest assigns bus
numbers.


> +
> +    if (!devfn)
> +        goto out;
> +
> +    pd = strchr(pc, '.');
> +    pe = get_opt_name(value, sizeof(value), pc + 1, '.');
> +    if (pe != pc + 1) {
> +        parse_option_number("slot", value, &u64, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return -1;
> +        }
> +        slot = (uint16_t)u64;
> +    }
> +    if (pd && *(pd + 1) != '\0') {
> +        parse_option_number("function", pd, &u64, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return -1;
> +        }
> +        func = (uint16_t)u64;
> +    }
> +
> +out:
> +    if (busnr)
> +        *busnr = busnum;
> +    if (devfn)
> +        *devfn = ((slot & 0x1F) << 3) | (func & 0x7);
> +    return 0;
> +}
> +
>  BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>  {
>      DeviceState *dev;
> -- 
> 1.8.3.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

