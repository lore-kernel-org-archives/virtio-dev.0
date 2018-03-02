Return-Path: virtio-dev-return-3394-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 89E4258180EF
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 15:12:22 -0800 (PST)
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ23tForX9HSvYpC-1wV9v_u15-mzeg8jY7nOO2gaVdjgMw@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <617c7d97-b79f-3425-68d4-11eda19dd4ff@intel.com>
Date: Fri, 2 Mar 2018 15:12:19 -0800
MIME-Version: 1.0
In-Reply-To: <CADGSJ23tForX9HSvYpC-1wV9v_u15-mzeg8jY7nOO2gaVdjgMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use
 VF datapath when available
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On 3/2/2018 1:11 PM, Siwei Liu wrote:
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
> What if the systemd/udevd is not new enough to enforce the
> n<phys_port_name> naming? Would virtio_bypass get a different name
> than the original virtio_net? Should we detect this earlier and fall
> back to legacy mode without creating the bypass netdev and ensalving
> the VF?

If udev doesn't support renaming of the devices,  then the upper bypass device
should get the original name and the lower virtio netdev will get the next name.
Hopefully the distros updating the kernel will also move to the new systemd/udev.


>
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
>> +
>> +       child_netdev = rtnl_dereference(vbi->backup_netdev);
>> +       if (child_netdev)
>> +               virtnet_bypass_child_open(dev, child_netdev);
>> +
>> +       return 0;
>> +}
>> +
>> +static int virtnet_bypass_close(struct net_device *dev)
>> +{
>> +       struct virtnet_bypass_info *vi = netdev_priv(dev);
>> +       struct net_device *child_netdev;
>> +
>> +       netif_tx_disable(dev);
>> +
>> +       child_netdev = rtnl_dereference(vi->active_netdev);
>> +       if (child_netdev)
>> +               dev_close(child_netdev);
>> +
>> +       child_netdev = rtnl_dereference(vi->backup_netdev);
>> +       if (child_netdev)
>> +               dev_close(child_netdev);
>> +
>> +       return 0;
>> +}
>> +
>> +static netdev_tx_t virtnet_bypass_drop_xmit(struct sk_buff *skb,
>> +                                           struct net_device *dev)
>> +{
>> +       atomic_long_inc(&dev->tx_dropped);
>> +       dev_kfree_skb_any(skb);
>> +       return NETDEV_TX_OK;
>> +}
>> +
>> +static bool virtnet_bypass_xmit_ready(struct net_device *dev)
>> +{
>> +       return netif_running(dev) && netif_carrier_ok(dev);
>> +}
>> +
>> +static netdev_tx_t virtnet_bypass_start_xmit(struct sk_buff *skb,
>> +                                            struct net_device *dev)
>> +{
>> +       struct virtnet_bypass_info *vbi = netdev_priv(dev);
>> +       struct net_device *xmit_dev;
>> +
>> +       /* Try xmit via active netdev followed by backup netdev */
>> +       xmit_dev = rcu_dereference_bh(vbi->active_netdev);
>> +       if (!xmit_dev || !virtnet_bypass_xmit_ready(xmit_dev)) {
>> +               xmit_dev = rcu_dereference_bh(vbi->backup_netdev);
>> +               if (!xmit_dev || !virtnet_bypass_xmit_ready(xmit_dev))
>> +                       return virtnet_bypass_drop_xmit(skb, dev);
>> +       }
>> +
>> +       skb->dev = xmit_dev;
>> +       skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
>> +
>> +       return dev_queue_xmit(skb);
>> +}
>> +
>> +static u16 virtnet_bypass_select_queue(struct net_device *dev,
>> +                                      struct sk_buff *skb, void *accel_priv,
>> +                                      select_queue_fallback_t fallback)
>> +{
>> +       /* This helper function exists to help dev_pick_tx get the correct
>> +        * destination queue.  Using a helper function skips a call to
>> +        * skb_tx_hash and will put the skbs in the queue we expect on their
>> +        * way down to the bonding driver.
>> +        */
>> +       u16 txq = skb_rx_queue_recorded(skb) ? skb_get_rx_queue(skb) : 0;
>> +
>> +       /* Save the original txq to restore before passing to the driver */
>> +       qdisc_skb_cb(skb)->slave_dev_queue_mapping = skb->queue_mapping;
>> +
>> +       if (unlikely(txq >= dev->real_num_tx_queues)) {
>> +               do {
>> +                       txq -= dev->real_num_tx_queues;
>> +               } while (txq >= dev->real_num_tx_queues);
>> +       }
>> +
>> +       return txq;
>> +}
>> +
>> +/* fold stats, assuming all rtnl_link_stats64 fields are u64, but
>> + * that some drivers can provide 32bit values only.
>> + */
>> +static void virtnet_bypass_fold_stats(struct rtnl_link_stats64 *_res,
>> +                                     const struct rtnl_link_stats64 *_new,
>> +                                     const struct rtnl_link_stats64 *_old)
>> +{
>> +       const u64 *new = (const u64 *)_new;
>> +       const u64 *old = (const u64 *)_old;
>> +       u64 *res = (u64 *)_res;
>> +       int i;
>> +
>> +       for (i = 0; i < sizeof(*_res) / sizeof(u64); i++) {
>> +               u64 nv = new[i];
>> +               u64 ov = old[i];
>> +               s64 delta = nv - ov;
>> +
>> +               /* detects if this particular field is 32bit only */
>> +               if (((nv | ov) >> 32) == 0)
>> +                       delta = (s64)(s32)((u32)nv - (u32)ov);
>> +
>> +               /* filter anomalies, some drivers reset their stats
>> +                * at down/up events.
>> +                */
>> +               if (delta > 0)
>> +                       res[i] += delta;
>> +       }
>> +}
>> +
>> +static void virtnet_bypass_get_stats(struct net_device *dev,
>> +                                    struct rtnl_link_stats64 *stats)
>> +{
>> +       struct virtnet_bypass_info *vbi = netdev_priv(dev);
>> +       const struct rtnl_link_stats64 *new;
>> +       struct rtnl_link_stats64 temp;
>> +       struct net_device *child_netdev;
>> +
>> +       spin_lock(&vbi->stats_lock);
>> +       memcpy(stats, &vbi->bypass_stats, sizeof(*stats));
>> +
>> +       rcu_read_lock();
>> +
>> +       child_netdev = rcu_dereference(vbi->active_netdev);
>> +       if (child_netdev) {
>> +               new = dev_get_stats(child_netdev, &temp);
>> +               virtnet_bypass_fold_stats(stats, new, &vbi->active_stats);
>> +               memcpy(&vbi->active_stats, new, sizeof(*new));
>> +       }
>> +
>> +       child_netdev = rcu_dereference(vbi->backup_netdev);
>> +       if (child_netdev) {
>> +               new = dev_get_stats(child_netdev, &temp);
>> +               virtnet_bypass_fold_stats(stats, new, &vbi->backup_stats);
>> +               memcpy(&vbi->backup_stats, new, sizeof(*new));
>> +       }
>> +
>> +       rcu_read_unlock();
>> +
>> +       memcpy(&vbi->bypass_stats, stats, sizeof(*stats));
>> +       spin_unlock(&vbi->stats_lock);
>> +}
>> +
>> +static int virtnet_bypass_change_mtu(struct net_device *dev, int new_mtu)
>> +{
>> +       struct virtnet_bypass_info *vbi = netdev_priv(dev);
>> +       struct net_device *child_netdev;
>> +       int ret = 0;
>> +
>> +       child_netdev = rcu_dereference(vbi->active_netdev);
>> +       if (child_netdev) {
>> +               ret = dev_set_mtu(child_netdev, new_mtu);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       child_netdev = rcu_dereference(vbi->backup_netdev);
>> +       if (child_netdev) {
>> +               ret = dev_set_mtu(child_netdev, new_mtu);
>> +               if (ret)
>> +                       netdev_err(child_netdev,
>> +                                  "Unexpected failure to set mtu to %d\n",
>> +                                  new_mtu);
> Shouldn't we unwind the MTU config on active_netdev if failing to set
> it on backup_netdev?

backup_netdev is virtio_net and  it is not expected to fail as it supports
MTU all the way upto 64K.


>
>> +       }
>> +
>> +       dev->mtu = new_mtu;
>> +       return 0;
>> +}
>> +
>> +static void virtnet_bypass_set_rx_mode(struct net_device *dev)
>> +{
>> +       struct virtnet_bypass_info *vbi = netdev_priv(dev);
>> +       struct net_device *child_netdev;
>> +
>> +       rcu_read_lock();
>> +
>> +       child_netdev = rcu_dereference(vbi->active_netdev);
>> +       if (child_netdev) {
>> +               dev_uc_sync_multiple(child_netdev, dev);
>> +               dev_mc_sync_multiple(child_netdev, dev);
>> +       }
>> +
>> +       child_netdev = rcu_dereference(vbi->backup_netdev);
>> +       if (child_netdev) {
>> +               dev_uc_sync_multiple(child_netdev, dev);
>> +               dev_mc_sync_multiple(child_netdev, dev);
>> +       }
>> +
> If VF comes up later than when set_rx_mode is called where do you sync
> up the unicast and multicast address?

I could include sync up of unicast and multicast list along with
MTU when the child is registered.


>
> The rest looks good.
>
> Thanks,
> -Siwei
>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

