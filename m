Return-Path: virtio-dev-return-3537-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DA9395818F87
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Mar 2018 17:28:25 -0700 (PDT)
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ23unj7P_d_vpitAp9JZ7F76i-Y8msaHU4_pOV_4-UUinw@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <eac018bf-58fe-188d-0dad-f454c9affebb@intel.com>
Date: Tue, 13 Mar 2018 17:28:07 -0700
MIME-Version: 1.0
In-Reply-To: <CADGSJ23unj7P_d_vpitAp9JZ7F76i-Y8msaHU4_pOV_4-UUinw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On 3/12/2018 3:44 PM, Siwei Liu wrote:
> Apologies, still some comments going. Please see inline.
>
> On Thu, Mar 1, 2018 at 12:08 PM, Sridhar Samudrala
> <sridhar.samudrala@intel.com> wrote:
>> This patch enables virtio_net to switch over to a VF datapath when a VF
>> netdev is present with the same MAC address. It allows live migration
>> of a VM with a direct attached VF without the need to setup a bond/team
>> between a VF and virtio net device in the guest.
>>
>> The hypervisor needs to enable only one datapath at any time so that
>> packets don't get looped back to the VM over the other datapath. When a VF
>> is plugged, the virtio datapath link state can be marked as down. The
>> hypervisor needs to unplug the VF device from the guest on the source host
>> and reset the MAC filter of the VF to initiate failover of datapath to
>> virtio before starting the migration. After the migration is completed,
>> the destination hypervisor sets the MAC filter on the VF and plugs it back
>> to the guest to switch over to VF datapath.
>>
>> When BACKUP feature is enabled, an additional netdev(bypass netdev) is
>> created that acts as a master device and tracks the state of the 2 lower
>> netdevs. The original virtio_net netdev is marked as 'backup' netdev and a
>> passthru device with the same MAC is registered as 'active' netdev.
>>
>> This patch is based on the discussion initiated by Jesse on this thread.
>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> ---
>>   drivers/net/virtio_net.c | 683 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 682 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index bcd13fe906ca..f2860d86c952 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -30,6 +30,8 @@
>>   #include <linux/cpu.h>
>>   #include <linux/average.h>
>>   #include <linux/filter.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/pci.h>
>>   #include <net/route.h>
>>   #include <net/xdp.h>
>>
>> @@ -206,6 +208,9 @@ struct virtnet_info {
>>          u32 speed;
>>
>>          unsigned long guest_offloads;
>> +
>> +       /* upper netdev created when BACKUP feature enabled */
>> +       struct net_device *bypass_netdev;
>>   };
>>
>>   struct padded_vnet_hdr {
>> @@ -2236,6 +2241,22 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>>          }
>>   }
>>
>> +static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
>> +                                     size_t len)
>> +{
>> +       struct virtnet_info *vi = netdev_priv(dev);
>> +       int ret;
>> +
>> +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_BACKUP))
>> +               return -EOPNOTSUPP;
>> +
>> +       ret = snprintf(buf, len, "_bkup");
>> +       if (ret >= len)
>> +               return -EOPNOTSUPP;
>> +
>> +       return 0;
>> +}
>> +
>>   static const struct net_device_ops virtnet_netdev = {
>>          .ndo_open            = virtnet_open,
>>          .ndo_stop            = virtnet_close,
>> @@ -2253,6 +2274,7 @@ static const struct net_device_ops virtnet_netdev = {
>>          .ndo_xdp_xmit           = virtnet_xdp_xmit,
>>          .ndo_xdp_flush          = virtnet_xdp_flush,
>>          .ndo_features_check     = passthru_features_check,
>> +       .ndo_get_phys_port_name = virtnet_get_phys_port_name,
>>   };
>>
>>   static void virtnet_config_changed_work(struct work_struct *work)
>> @@ -2647,6 +2669,653 @@ static int virtnet_validate(struct virtio_device *vdev)
>>          return 0;
>>   }
>>
>> +/* START of functions supporting VIRTIO_NET_F_BACKUP feature.
>> + * When BACKUP feature is enabled, an additional netdev(bypass netdev)
>> + * is created that acts as a master device and tracks the state of the
>> + * 2 lower netdevs. The original virtio_net netdev is registered as
>> + * 'backup' netdev and a passthru device with the same MAC is registered
>> + * as 'active' netdev.
>> + */
>> +
>> +/* bypass state maintained when BACKUP feature is enabled */
>> +struct virtnet_bypass_info {
>> +       /* passthru netdev with same MAC */
>> +       struct net_device __rcu *active_netdev;
>> +
>> +       /* virtio_net netdev */
>> +       struct net_device __rcu *backup_netdev;
>> +
>> +       /* active netdev stats */
>> +       struct rtnl_link_stats64 active_stats;
>> +
>> +       /* backup netdev stats */
>> +       struct rtnl_link_stats64 backup_stats;
>> +
>> +       /* aggregated stats */
>> +       struct rtnl_link_stats64 bypass_stats;
>> +
>> +       /* spinlock while updating stats */
>> +       spinlock_t stats_lock;
>> +};
>> +
>> +static void virtnet_bypass_child_open(struct net_device *dev,
>> +                                     struct net_device *child_netdev)
>> +{
>> +       int err = dev_open(child_netdev);
>> +
>> +       if (err)
>> +               netdev_warn(dev, "unable to open slave: %s: %d\n",
>> +                           child_netdev->name, err);
>> +}
> Why ignoring the error?? i.e. virtnet_bypass_child_open should have
> return value. I don't believe the caller is in a safe context to
> guarantee the dev_open always succeeds.

OK.  Will handle this in the next revision.


>
>> +
>> +static int virtnet_bypass_open(struct net_device *dev)
>> +{
>> +       struct virtnet_bypass_info *vbi = netdev_priv(dev);
>> +       struct net_device *child_netdev;
>> +
>> +       netif_carrier_off(dev);
>> +       netif_tx_wake_all_queues(dev);
>> +
>> +       child_netdev = rtnl_dereference(vbi->active_netdev);
>> +       if (child_netdev)
>> +               virtnet_bypass_child_open(dev, child_netdev);
> Handle the error?
>
>> +
>> +       child_netdev = rtnl_dereference(vbi->backup_netdev);
>> +       if (child_netdev)
>> +               virtnet_bypass_child_open(dev, child_netdev);
> Handle the error and unwind?

Sure.

<snip>

> +
> +static int virtnet_bypass_register_child(struct net_device *child_netdev)
> +{
> +       struct virtnet_bypass_info *vbi;
> +       struct net_device *dev;
> +       bool backup;
> +       int ret;
> +
> +       if (child_netdev->addr_len != ETH_ALEN)
> +               return NOTIFY_DONE;
> +
> +       /* We will use the MAC address to locate the virtnet_bypass netdev
> +        * to associate with the child netdev. If we don't find a matching
> +        * bypass netdev, move on.
> +        */
> +       dev = get_virtnet_bypass_bymac(dev_net(child_netdev),
> +                                      child_netdev->perm_addr);
> +       if (!dev)
> +               return NOTIFY_DONE;
> +
> +       vbi = netdev_priv(dev);
> +       backup = (child_netdev->dev.parent == dev->dev.parent);
> +       if (backup ? rtnl_dereference(vbi->backup_netdev) :
> +                       rtnl_dereference(vbi->active_netdev)) {
> +               netdev_info(dev,
> +                           "%s attempting to join bypass dev when %s already present\n",
> +                           child_netdev->name, backup ? "backup" : "active");
> +               return NOTIFY_DONE;
> +       }
> +
> +       /* Avoid non pci devices as active netdev */
> +       if (!backup && (!child_netdev->dev.parent ||
> +                       !dev_is_pci(child_netdev->dev.parent)))
> +               return NOTIFY_DONE;
> +
> There's a problem here in terms of error (particularly on the active
> slave, e.g. VF), see below:
>
>> +       ret = netdev_rx_handler_register(child_netdev,
>> +                                        virtnet_bypass_handle_frame, dev);
>> +       if (ret != 0) {
>> +               netdev_err(child_netdev,
>> +                          "can not register bypass receive handler (err = %d)\n",
>> +                          ret);
>> +               goto rx_handler_failed;
>> +       }
>> +
>> +       ret = netdev_upper_dev_link(child_netdev, dev, NULL);
>> +       if (ret != 0) {
>> +               netdev_err(child_netdev,
>> +                          "can not set master device %s (err = %d)\n",
>> +                          dev->name, ret);
>> +               goto upper_link_failed;
>> +       }
>> +
>> +       child_netdev->flags |= IFF_SLAVE;
>> +
>> +       if (netif_running(dev)) {
>> +               ret = dev_open(child_netdev);
>> +               if (ret && (ret != -EBUSY)) {
>> +                       netdev_err(dev, "Opening child %s failed ret:%d\n",
>> +                                  child_netdev->name, ret);
>> +                       goto err_interface_up;
>> +               }
>> +       }
>> +
>> +       /* Align MTU of child with master */
>> +       ret = dev_set_mtu(child_netdev, dev->mtu);
>> +       if (ret) {
>> +               netdev_err(dev,
>> +                          "unable to change mtu of %s to %u register failed\n",
>> +                          child_netdev->name, dev->mtu);
>> +               goto err_set_mtu;
>> +       }
> If any of the above calls returns non-zero, the current code steps
> back to undo what's being done on that spefic slave previously. For
> instance, if the netdev_rx_handler_register returns non-zero because
> of busy rx handler, this register_child function would give up
> enslaving the VF and leave the upper virtio_bypass interface behind
> once it returns.

virtio_bypass interface is the upper master netdev and it is always present when
BACKUP feature is enabled.
If there is failure with enslaving VF, there will be 2 netdevs,
master virtio_bypass and slave virtio_net and the VM can be migrated.


> I am not sure if it's a good idea to leave the
> virtio_bypass around if running into failure: the guest is not
> migratable as the VF doesn't have a backup path,

Are you talking about a failure when registering backup netdev?  This should not
happen, but i guess we can improve error handling in such scenario.


> And perhaps the worse
> part is that, it now has two interfaces with identical MAC address but
> one of them is invalid (user cannot use the virtio interface as it has
> a dampened datapath). IMHO the virtio_bypass and its lower netdev
> should be destroyed at all when it fails to bind the VF, and
> technically, there should be some way to propogate the failure status
> to the hypervisor/backend, indicating that the VM is not migratable
> because of guest software errors (maybe by clearing out the backup
> feature from the guest virtio driver so host can see/learn it).

In BACKUP mode, user can only use the upper virtio_bypass netdev and that will
always be there. Any failure to enslave VF netdev is not fatal, but i will see
if we can improve the error handling of failure to enslave backup netdev.
Also, i don't think the BACKUP feature bit is negotiable with the host.

Thanks
Sridhar



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

