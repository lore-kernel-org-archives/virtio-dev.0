Return-Path: virtio-dev-return-5286-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4DEF9849E9
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Jan 2019 01:45:27 +0000 (UTC)
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <20190107182604-mutt-send-email-mst@kernel.org>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
Date: Mon, 7 Jan 2019 17:45:22 -0800
MIME-Version: 1.0
In-Reply-To: <20190107182604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v3 0/5] Support for datapath switching
 during live migration
To: "Michael S. Tsirkin" <mst@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrote:
>> Implement the infrastructure to support datapath switching during live
>> migration involving SR-IOV devices.
>>
>> 1. This patch is based off on the current VIRTIO_NET_F_STANDBY feature
>>     bit and MAC address device pairing.
>>
>> 2. This set of events will be consumed by userspace management software
>>     to orchestrate all the hot plug and datapath switching activities.
>>     This scheme has the least QEMU modifications while allowing userspace
>>     software to build its own intelligence to control the whole process
>>     of SR-IOV live migration.
>>
>> 3. While the hidden device model (viz. coupled device model) is still
>>     being explored for automatic hot plugging (QEMU) and automatic datapath
>>     switching (host-kernel), this series provides a supplemental set
>>     of interfaces if management software wants to drive the SR-IOV live
>>     migration on its own. It should not conflict with the hidden device
>>     model but just offers simplicity of implementation.
>>
>>
>> Si-Wei Liu (2):
>>    vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
>>    pci: query command extension to check the bus master enabling status of the failover-primary device
>>
>> Sridhar Samudrala (1):
>>    virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
>>
>> Venu Busireddy (2):
>>    virtio_net: Add support for "Data Path Switching" during Live Migration.
>>    virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED event.
>>
>> ---
>> Changes in v3:
>>    Fix issues with coding style in patch 3/5.
>>
>> Changes in v2:
>>    Added a query command for FAILOVER_STANDBY_CHANGED event.
>>    Added a query command for FAILOVER_PRIMARY_CHANGED event.
> Hmm it looks like all feedback I sent e.g. here:
> https://patchwork.kernel.org/patch/10721571/
> got ignored.
>
> To summarize I suggest reworking the series adding a new command along
> the lines of (naming is up to you):
>
> query-pci-master - this returns status for a device
> 		   and enables a *single* event after
> 		   it changes
>
> and then removing all status data from the event,
> just notify about the change and *only once*.
Why removing all status data from the event? It does not hurt to keep 
them as the FAILOVER_PRIMARY_CHANGED event in general is of pretty 
low-frequency. As can be seen other similar low-frequent QMP events do 
have data carried over.

As this event relates to datapath switching, there's implication to 
coalesce events as packets might not get a chance to send out as nothing 
would ever happen when  going through quick transitions like 
disabled->enabled->disabled. I would allow at least few packets to be 
sent over wire rather than nothing. Who knows how fast management can 
react and consume these events?

Thanks,
-Siwei

> 	
>
> upon event management does query-pci-master
> and acts accordingly.
>
>
>
>
>>   hmp.c                          |   5 +++
>>   hw/acpi/pcihp.c                |  27 +++++++++++
>>   hw/net/virtio-net.c            |  42 +++++++++++++++++
>>   hw/pci/pci.c                   |   5 +++
>>   hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
>>   hw/vfio/pci.h                  |   1 +
>>   include/hw/pci/pci.h           |   1 +
>>   include/hw/virtio/virtio-net.h |   1 +
>>   include/net/net.h              |   2 +
>>   net/net.c                      |  61 +++++++++++++++++++++++++
>>   qapi/misc.json                 |   5 ++-
>>   qapi/net.json                  | 100 +++++++++++++++++++++++++++++++++++++++++
>>   12 files changed, 309 insertions(+), 1 deletion(-)
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

