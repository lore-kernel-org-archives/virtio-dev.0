Return-Path: virtio-dev-return-4864-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06FFB985D3B
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Sep 2018 05:05:31 +0000 (UTC)
References: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
 <20180907173251-mutt-send-email-mst@kernel.org>
 <9bc2db49-77ea-1391-b964-a29da44ff617@intel.com>
 <20180912111819-mutt-send-email-mst@kernel.org>
 <20180918122052.349ba42e.cohuck@redhat.com>
 <CAKPgXcGpQt1OSOHnXxTfo0j4H5z+TPZSgRkz2BsiT3+Qo_7AwQ@mail.gmail.com>
 <20180918091231-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <0aa3b8a6-68d4-3275-bb3c-2b2d69be18cc@intel.com>
Date: Tue, 18 Sep 2018 22:03:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180918091231-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>, Sameeh Jubran <sameeh@daynix.com>
Cc: cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 9/18/2018 6:25 AM, Michael S. Tsirkin wrote:
> On Tue, Sep 18, 2018 at 01:37:35PM +0300, Sameeh Jubran wrote:
>> On Tue, Sep 18, 2018 at 1:21 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>> On Wed, 12 Sep 2018 11:22:12 -0400
>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>
>>>> On Wed, Sep 12, 2018 at 08:17:45AM -0700, Samudrala, Sridhar wrote:
>>>>>
>>>>> On 9/7/2018 2:34 PM, Michael S. Tsirkin wrote:
>>>>>> On Wed, Aug 15, 2018 at 11:49:15AM -0700, Sridhar Samudrala wrote:
>>>>>>> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
>>>>>>> device to act as a standby for another device with the same MAC address.
>>>>>>>
>>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>>>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18
>>>>>> Applied but when do you plan to add documentation as pointed
>>>>>> out by Jan and Halil?
>>>>> I thought additional documentation will be done as part of the Qemu enablement
>>>>> patches and i hope someone in RH is looking into it.
>>>>>
>>>>> Does it make sense to add a link to to the kernel documentation of this feature in
>>>>> the spec
>>>>>   https://www.kernel.org/doc/html/latest/networking/net_failover.html
>>>>
>>>> I do not think this will address the comments posted.  Specifically we
>>>> should probably include documentation for what is a standby and primary:
>>>> what is expected of driver (maintain configuration on standby, support
>>>> primary coming and going, transmit on standby only if there is no
>>>> primary) and of device (have same mac for standby as for standby).
>>> Yes, we need some definitive statements of what a driver and a device
>>> is supposed to do in order to conform; it might make sense to discuss
>>> this in conjunction with discussion on any QEMU patches (have not
>>> checked whether anything has been posted, just returned from vacation).
>>>
>>> I assume that we still stick with the plan to implement/document
>>> MAC-based handling first and then enhance with other methods later?
>> I am currently in the process of writing the patches for this feature,
>> I have thought about how the feature should be implemented
>> and decided to go with a different approach. I've decided that the id
>> of the vfio attached device will be specified in the virtio-net
>> arguments as follows:
>>
>> -device virtio-net,standby=<device_id_of_vfio_device>
>> -vfio #address,id=<device_id_of_vfio_device>
>>
>> This approach makes minimal changes to the current infrastructure and
>> does so elegantly without adding unnecessary ids to the bridges.
>>
>> The mac address approach seems to be very complicated as there is no
>> standard way to find the mac address of a given device and it is
>> vendor dependent,
>> which makes the task of identifying the target standby device by it's
>> mac address a very tough one.
> Oh mac address is used by guest. I agree it's not a great qemu
> interface.
> The idea was basically to have -vfio #address,primary=<id>
>
>
>> Please share your thoughts so I'll move forward with the patches.
> Can this actually support hotplug add and remove of the vfio device though?
> E.g. hotplug add vfio device while VM is already running?
> With the primary=<> it works because standby must always exist
> even when primary isn't there.

Also, how do we want to handle a scenario where a VM has a direct attached VF
device and virtio-net in standby mode is hotplugged/unplugged?

What should be the behavior if guest unloads a virtio-net driver that is acting
as a standby? Do we want qemu to unplug VF device too?


>
>
>> An initial patch which implements hiding the device from pci bus
>> before the feature is acked is provided below:
>>
>> commit b716371bf4807fe16ffb4ffd901b69a110902a3c (HEAD -> failover)
>> Author: Sameeh Jubran <sjubran@redhat.com>
>> Date:   Sun Sep 16 13:21:41 2018 +0300
>>
>>      virtio-net: Implement standby feature
>>
>>      Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index f154756e85..46386c0e1b 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -26,7 +26,9 @@
>>   #include "qapi/qapi-events-net.h"
>>   #include "hw/virtio/virtio-access.h"
>>   #include "migration/misc.h"
>> +#include "hw/pci/pci.h"
>>   #include "standard-headers/linux/ethtool.h"
>> +#include "hw/vfio/vfio-common.h"
>>
>>   #define VIRTIO_NET_VM_VERSION    11
>>
>> @@ -1946,6 +1948,13 @@ void virtio_net_set_netclient_name(VirtIONet
>> *n, const char *name,
>>       n->netclient_type = g_strdup(type);
>>   }
>>
>> +static bool standby_device_present(VirtIONet *n, const char *id,
>> +        struct PCIDevice **pdev)
>> +{
>> +    return pci_qdev_find_device(id, pdev) >= 0 && pdev &&
>> +    vfio_is_vfio_pci(*pdev);
>> +}
>> +
>>   static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> @@ -1976,6 +1985,21 @@ static void
>> virtio_net_device_realize(DeviceState *dev, Error **errp)
>>           n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>>       }
>>
>> +    if (n->net_conf.standby_id_str && standby_device_present(n,
>> +                n->net_conf.standby_id_str, &n->standby_pdev)) {
>> +        DeviceState *dev = DEVICE(n->standby_pdev);
>> +        DeviceClass *klass = DEVICE_GET_CLASS(dev);
>> +        /* Hide standby from pci till the feature is acked */
>> +        if (klass->hotpluggable)
>> +        {
>> +            qdev_unplug(dev, errp);
>
> Does this really hide the device?
> I see:
>      hdc = HOTPLUG_HANDLER_GET_CLASS(hotplug_ctrl);
>      if (hdc->unplug_request) {
>          hotplug_handler_unplug_request(hotplug_ctrl, dev, errp);
>      } else {
>          hotplug_handler_unplug(hotplug_ctrl, dev, errp);
>      }
>
> which seems to just send an eject request to guest - the reverse of
> what we want to do.
>
>> +            if (errp == NULL)
>> +            {
>> +                n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
>> +            }
> I'm not sure how is this error handling supposed to work.
>
>> +        }
>> +    }
>> +
>>       virtio_net_set_config_size(n, n->host_features);
>>       virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
>>
>> @@ -2198,6 +2222,7 @@ static Property virtio_net_properties[] = {
>>                        true),
>>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>> +    DEFINE_PROP_STRING("standby", VirtIONet, net_conf.standby_id_str),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 866f0deeb7..593debe56e 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -220,6 +220,12 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>>   #endif
>>   }
>>
>> +bool vfio_is_vfio_pci(PCIDevice* pdev)
>> +{
>> +    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
>> +    return vdev->vbasedev.type == VFIO_DEVICE_TYPE_PCI;
>> +}
>> +
>>   static void vfio_intx_update(PCIDevice *pdev)
>>   {
>>       VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 821def0565..26dfde805f 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -195,5 +195,6 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>                                hwaddr *pgsize);
>>   int vfio_spapr_remove_window(VFIOContainer *container,
>>                                hwaddr offset_within_address_space);
>> +bool vfio_is_vfio_pci(PCIDevice* pdev);
>>
>>   #endif /* HW_VFIO_VFIO_COMMON_H */
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index 4d7f3c82ca..94388b40cb 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -42,6 +42,7 @@ typedef struct virtio_net_conf
>>       int32_t speed;
>>       char *duplex_str;
>>       uint8_t duplex;
>> +    char *standby_id_str;
>>   } virtio_net_conf;
>>
>>   /* Maximum packet size we can receive from tap device: header + 64k */
>> @@ -103,6 +104,7 @@ typedef struct VirtIONet {
>>       int announce_counter;
>>       bool needs_vnet_hdr_swap;
>>       bool mtu_bypass_backend;
>> +    PCIDevice *standby_pdev;
>>   } VirtIONet;
>>
>>   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>> (END)
>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>>
>> -- 
>> Respectfully,
>> Sameeh Jubran
>> Linkedin
>> Software Engineer @ Daynix.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

