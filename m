Return-Path: virtio-dev-return-4010-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C6CF0581810F
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Apr 2018 20:00:45 -0700 (PDT)
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
 <20180428082433.GK5632@nanopsycho.orion>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <62f3b81b-70f6-6991-8e23-2bf650ecea2d@intel.com>
Date: Sun, 29 Apr 2018 20:00:33 -0700
MIME-Version: 1.0
In-Reply-To: <20180428082433.GK5632@nanopsycho.orion>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/28/2018 1:24 AM, Jiri Pirko wrote:
> Fri, Apr 27, 2018 at 07:06:59PM CEST, sridhar.samudrala@intel.com wrote:
>> This patch enables virtio_net to switch over to a VF datapath when a VF
>> netdev is present with the same MAC address. It allows live migration
>> of a VM with a direct attached VF without the need to setup a bond/team
>> between a VF and virtio net device in the guest.
>>
>> The hypervisor needs to enable only one datapath at any time so that
>> packets don't get looped back to the VM over the other datapath. When a VF
> Why? Both datapaths could be enabled at a time. Why the loop on
> hypervisor side would be a problem. This in not an issue for
> bonding/team as well.

Somehow the hypervisor needs to make sure that the broadcasts/multicasts from the VM
sent over the VF datapath don't get looped back to the VM via the virtio-net datapth.
This can happen if both datapaths are enabled at the same time.

I would think this is an issue even with bonding/team as well when virtio-net and
VF are backed by the same PF.


>
>
>> is plugged, the virtio datapath link state can be marked as down. The
>> hypervisor needs to unplug the VF device from the guest on the source host
>> and reset the MAC filter of the VF to initiate failover of datapath to
> "reset the MAC filter of the VF" - you mean "set the VF mac"?

Yes.  the PF should take away the MAC address assigned to the VF so that the PF
starts receiving those packets.

>
>
>> virtio before starting the migration. After the migration is completed,
>> the destination hypervisor sets the MAC filter on the VF and plugs it back
>> to the guest to switch over to VF datapath.
>>
>> It uses the generic failover framework that provides 2 functions to create
>> and destroy a master failover netdev. When STANDBY feature is enabled, an
>> additional netdev(failover netdev) is created that acts as a master device
>> and tracks the state of the 2 lower netdevs. The original virtio_net netdev
>> is marked as 'standby' netdev and a passthru device with the same MAC is
>> registered as 'primary' netdev.
>>
>> This patch is based on the discussion initiated by Jesse on this thread.
>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
> [...]
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

