Return-Path: virtio-dev-return-3993-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AAD295818EAE
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 10:53:07 -0700 (PDT)
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <20180427174523.GE5632@nanopsycho.orion>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <a60d08cd-6c8b-ea1e-e76c-4decba563e99@intel.com>
Date: Fri, 27 Apr 2018 10:53:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180427174523.GE5632@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 0/4] Enable virtio_net to act as a standby for
 a passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/27/2018 10:45 AM, Jiri Pirko wrote:
> Fri, Apr 27, 2018 at 07:06:56PM CEST, sridhar.samudrala@intel.com wrote:
>> v9:
>> Select NET_FAILOVER automatically when VIRTIO_NET/HYPERV_NET
>> are enabled. (stephen)
>>
>> Tested live migration with virtio-net/AVF(i40evf) configured in
>> failover mode while running iperf in background.
>> Build tested netvsc module.
>>
>> The main motivation for this patch is to enable cloud service providers
>> to provide an accelerated datapath to virtio-net enabled VMs in a
>> transparent manner with no/minimal guest userspace changes. This also
>> enables hypervisor controlled live migration to be supported with VMs that
>> have direct attached SR-IOV VF devices.
>>
>> Patch 1 introduces a new feature bit VIRTIO_NET_F_STANDBY that can be
>> used by hypervisor to indicate that virtio_net interface should act as
>> a standby for another device with the same MAC address.
>>
>> Patch 2 introduces a failover module that provides a generic interface for
>> paravirtual drivers to listen for netdev register/unregister/link change
>> events from pci ethernet devices with the same MAC and takeover their
>> datapath. The notifier and event handling code is based on the existing
>> netvsc implementation. It provides 2 sets of interfaces to paravirtual
>> drivers to support 2-netdev(netvsc) and 3-netdev(virtio_net) models.
>>
>> Patch 3 extends virtio_net to use alternate datapath when available and
>> registered. When STANDBY feature is enabled, virtio_net driver creates
>> an additional 'failover' netdev that acts as a master device and controls
>> 2 slave devices.  The original virtio_net netdev is registered as
>> 'standby' netdev and a passthru/vf device with the same MAC gets
>> registered as 'primary' netdev. Both 'standby' and 'primary' netdevs are
>> associated with the same 'pci' device.  The user accesses the network
>> interface via 'failover' netdev. The 'failover' netdev chooses 'primary'
>> netdev as default for transmits when it is available with link up and
>> running.
>>
>> Patch 4 refactors netvsc to use the registration/notification framework
>> supported by failover module.
>>
>> As this patch series is initially focusing on usecases where hypervisor
>> fully controls the VM networking and the guest is not expected to directly
>> configure any hardware settings, it doesn't expose all the ndo/ethtool ops
>> that are supported by virtio_net at this time. To support additional usecases,
>> it should be possible to enable additional ops later by caching the state
>> in virtio netdev and replaying when the 'primary' netdev gets registered.
>>
>> The hypervisor needs to enable only one datapath at any time so that packets
>> don't get looped back to the VM over the other datapath. When a VF is
>> plugged, the virtio datapath link state can be marked as down.
>> At the time of live migration, the hypervisor needs to unplug the VF device
> >from the guest on the source host and reset the MAC filter of the VF to
>> initiate failover of datapath to virtio before starting the migration. After
>> the migration is completed, the destination hypervisor sets the MAC filter
>> on the VF and plugs it back to the guest to switch over to VF datapath.
>>
>> This patch is based on the discussion initiated by Jesse on this thread.
>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>
> No changes in v9?

I listed v9 updates at the start of the message.

v9:
Select NET_FAILOVER automatically when VIRTIO_NET/HYPERV_NET
are enabled. (stephen)

Tested live migration with virtio-net/AVF(i40evf) configured in
failover mode while running iperf in background.
Build tested netvsc module.



>
>> v8:
>> - Made the failover managment routines more robust by updating the feature
>>   bits/other fields in the failover netdev when slave netdevs are
>>   registered/unregistered. (mst)
>> - added support for handling vlans.
>> - Limited the changes in netvsc to only use the notifier/event/lookups
>>   from the failover module. The slave register/unregister/link-change
>>   handlers are only updated to use the getbymac routine to get the
>>   upper netdev. There is no change in their functionality. (stephen)
>> - renamed structs/function/file names to use net_failover prefix. (mst)
>>
>> v7
>> - Rename 'bypass/active/backup' terminology with 'failover/primary/standy'
>>   (jiri, mst)
>> - re-arranged dev_open() and dev_set_mtu() calls in the register routines
>>   so that they don't get called for 2-netdev model. (stephen)
>> - fixed select_queue() routine to do queue selection based on VF if it is
>>   registered as primary. (stephen)
>> -  minor bugfixes
>>
>> v6 RFC:
>>   Simplified virtio_net changes by moving all the ndo_ops of the
>>   bypass_netdev and create/destroy of bypass_netdev to 'bypass' module.
>>   avoided 2 phase registration(driver + instances).
>>   introduced IFF_BYPASS/IFF_BYPASS_SLAVE dev->priv_flags
>>   replaced mutex with a spinlock
>>
>> v5 RFC:
>>   Based on Jiri's comments, moved the common functionality to a 'bypass'
>>   module so that the same notifier and event handlers to handle child
>>   register/unregister/link change events can be shared between virtio_net
>>   and netvsc.
>>   Improved error handling based on Siwei's comments.
>> v4:
>> - Based on the review comments on the v3 version of the RFC patch and
>>   Jakub's suggestion for the naming issue with 3 netdev solution,
>>   proposed 3 netdev in-driver bonding solution for virtio-net.
>> v3 RFC:
>> - Introduced 3 netdev model and pointed out a couple of issues with
>>   that model and proposed 2 netdev model to avoid these issues.
>> - Removed broadcast/multicast optimization and only use virtio as
>>   backup path when VF is unplugged.
>> v2 RFC:
>> - Changed VIRTIO_NET_F_MASTER to VIRTIO_NET_F_BACKUP (mst)
>> - made a small change to the virtio-net xmit path to only use VF datapath
>>   for unicasts. Broadcasts/multicasts use virtio datapath. This avoids
>>   east-west broadcasts to go over the PCI link.
>> - added suppport for the feature bit in qemu
>>
>> Sridhar Samudrala (4):
>>   virtio_net: Introduce VIRTIO_NET_F_STANDBY feature bit
>>   net: Introduce generic failover module
>>   virtio_net: Extend virtio to use VF datapath when available
>>   netvsc: refactor notifier/event handling code to use the failover
>>     framework
>>
>> drivers/net/Kconfig             |   1 +
>> drivers/net/hyperv/Kconfig      |   1 +
>> drivers/net/hyperv/hyperv_net.h |   2 +
>> drivers/net/hyperv/netvsc_drv.c | 134 ++----
>> drivers/net/virtio_net.c        |  37 +-
>> include/linux/netdevice.h       |  16 +
>> include/net/net_failover.h      |  62 +++
>> include/uapi/linux/virtio_net.h |   3 +
>> net/Kconfig                     |  10 +
>> net/core/Makefile               |   1 +
>> net/core/net_failover.c         | 892 ++++++++++++++++++++++++++++++++++++++++
>> 11 files changed, 1046 insertions(+), 113 deletions(-)
>> create mode 100644 include/net/net_failover.h
>> create mode 100644 net/core/net_failover.c
>>
>> -- 
>> 2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

