Return-Path: virtio-dev-return-4066-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CC9FE1CB80ED
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 May 2018 08:41:11 -0700 (PDT)
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
 <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
 <20180507164632.4f6c2eef@xeon-e3>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <64956a7f-31bb-a2c6-19e7-fc5cb0f9a3e5@intel.com>
Date: Fri, 11 May 2018 08:40:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180507164632.4f6c2eef@xeon-e3>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 5/7/2018 4:46 PM, Stephen Hemminger wrote:
> On Mon,  7 May 2018 15:10:44 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> This provides a generic interface for paravirtual drivers to listen
>> for netdev register/unregister/link change events from pci ethernet
>> devices with the same MAC and takeover their datapath. The notifier and
>> event handling code is based on the existing netvsc implementation.
>>
>> It exposes 2 sets of interfaces to the paravirtual drivers.
>> 1. For paravirtual drivers like virtio_net that use 3 netdev model, the
>>     the failover module provides interfaces to create/destroy additional
>>     master netdev and all the slave events are managed internally.
>>            net_failover_create()
>>            net_failover_destroy()
>>     A failover netdev is created that acts a master device and controls 2
>>     slave devices. The original virtio_net netdev is registered as 'standby'
>>     netdev and a passthru/vf device with the same MAC gets registered as
>>     'primary' netdev. Both 'standby' and 'failover' netdevs are associated
>>     with the same 'pci' device.  The user accesses the network interface via
>>     'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
>>     default for transmits when it is available with link up and running.
>> 2. For existing netvsc driver that uses 2 netdev model, no master netdev
>>     is created. The paravirtual driver registers each instance of netvsc
>>     as a 'failover' netdev  along with a set of ops to manage the slave
>>     events. There is no 'standby' netdev in this model. A passthru/vf device
>>     with the same MAC gets registered as 'primary' netdev.
>>            net_failover_register()
>>            net_failover_unregister()
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> You are conflating the net_failover device (3 device model) with
> the generic network failover infrastructure into one file. There should be two
> seperate files net/core/failover.c and drivers/net/failover.c which splits
> the work into two parts (and acts a check for the api).

OK. I started splitting net_failover.c into 2 files.

net/core/failover.c (CONFIG_FAILOVER)
- implements the generic failover infrastructure that exports failover_register(),
   failover_unregister() and failover_slave_unregister() as the API that will be
   used by netvsc and the net_failover drivers(3 netdev model)

drivers/net/net_failover.c (CONFIG_NET_FAILOVER)
- implements the net_failover netdev as the upper dev for the 3-netdev model and
   exports net_failover_create() and net_failover_destroy() as the API that is
   used by virtio_net.

HYPERV_NET and NET_FAILOVER selects FAILOVER
VIRTIO_NET selects NET_FAILOVER

Does this look good? Any better suggestion for the prefix to be used for generic
network failover api rather than 'failover'?



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

