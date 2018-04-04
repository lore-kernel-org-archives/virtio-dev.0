Return-Path: virtio-dev-return-3718-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F1A4581904E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Apr 2018 01:02:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403152308-mutt-send-email-mst@kernel.org>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-2-git-send-email-si-wei.liu@oracle.com> <20180403152308-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Wed, 4 Apr 2018 01:02:37 -0700
Message-ID: <CADGSJ23jr7xrq8h9rFHLtXkbpsB+AK8wcUzOQnpeftbhiYdOvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/3] qemu: virtio-bypass should
 explicitly bind to a passthrough device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, David Miller <davem@davemloft.net>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 3, 2018 at 5:25 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Apr 01, 2018 at 05:13:08AM -0400, Si-Wei Liu wrote:
>> @@ -896,6 +898,68 @@ void qmp_device_del(const char *id, Error **errp)
>>      }
>>  }
>>
>> +int pci_get_busdevfn_by_id(const char *id, uint16_t *busnr,
>> +                           uint16_t *devfn, Error **errp)
>> +{
>> +    uint16_t busnum = 0, slot = 0, func = 0;
>> +    const char *pc, *pd, *pe;
>> +    Error *local_err = NULL;
>> +    ObjectClass *class;
>> +    char value[1024];
>> +    BusState *bus;
>> +    uint64_t u64;
>> +
>> +    if (!(pc = strchr(id, ':'))) {
>> +        error_setg(errp, "Invalid id: backup=%s, "
>> +                   "correct format should be backup="
>> +                   "'<bus-id>:<slot>[.<function>]'", id);
>> +        return -1;
>> +    }
>> +    get_opt_name(value, sizeof(value), id, ':');
>> +    if (pc != id + 1) {
>> +        bus = qbus_find(value, errp);
>> +        if (!bus)
>> +            return -1;
>> +
>> +        class = object_get_class(OBJECT(bus));
>> +        if (class != object_class_by_name(TYPE_PCI_BUS) &&
>> +            class != object_class_by_name(TYPE_PCIE_BUS)) {
>> +            error_setg(errp, "%s is not a device on pci bus", id);
>> +            return -1;
>> +        }
>> +        busnum = (uint16_t)pci_bus_num(PCI_BUS(bus));
>> +    }
>
> pci_bus_num is almost always a bug if not done within
> a context of a PCI host, bridge, etc.
>
> In particular this will not DTRT if run before guest assigns bus
> numbers.
>
I was seeking means to reserve a specific pci bus slot from drivers,
and update the driver when guest assigns the bus number but it seems
there's no low-hanging fruits. Because of that reason the bus_num is
only obtained until it's really needed (during get_config) and I
assume at that point the pci bus assignment is already done. I know
the current one is not perfect, but we need that information (PCI
bus:slot.func number) to name the guest device correctly.

Regards,
-Siwei
>
>> +
>> +    if (!devfn)
>> +        goto out;
>> +
>> +    pd = strchr(pc, '.');
>> +    pe = get_opt_name(value, sizeof(value), pc + 1, '.');
>> +    if (pe != pc + 1) {
>> +        parse_option_number("slot", value, &u64, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return -1;
>> +        }
>> +        slot = (uint16_t)u64;
>> +    }
>> +    if (pd && *(pd + 1) != '\0') {
>> +        parse_option_number("function", pd, &u64, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return -1;
>> +        }
>> +        func = (uint16_t)u64;
>> +    }
>> +
>> +out:
>> +    if (busnr)
>> +        *busnr = busnum;
>> +    if (devfn)
>> +        *devfn = ((slot & 0x1F) << 3) | (func & 0x7);
>> +    return 0;
>> +}
>> +
>>  BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>>  {
>>      DeviceState *dev;
>> --
>> 1.8.3.1
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

