Return-Path: virtio-dev-return-4358-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D9D758191E1
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Jun 2018 19:41:18 -0700 (PDT)
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
 <20180605152344-mutt-send-email-mst@kernel.org>
 <a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
 <20180612144743-mutt-send-email-mst@kernel.org>
 <7aa6dbe7-bac2-96f6-d96c-f51e5173c556@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6c7666e6-dc00-d9ed-8814-68e8b3998eef@redhat.com>
Date: Wed, 13 Jun 2018 10:41:01 +0800
MIME-Version: 1.0
In-Reply-To: <7aa6dbe7-bac2-96f6-d96c-f51e5173c556@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY feature
 bit to virtio_net
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jesse.brandeburg@intel.com, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年06月13日 08:20, Samudrala, Sridhar wrote:
> On 6/12/2018 4:54 AM, Michael S. Tsirkin wrote:
>> On Wed, Jun 06, 2018 at 10:29:03AM +0800, Jason Wang wrote:
>>>
>>> On 2018年06月05日 20:33, Michael S. Tsirkin wrote:
>>>> I don't think this is sufficient.
>>>>
>>>> If both primary and standby devices are present, a legacy guest 
>>>> without
>>>> support for the feature might see two devices with same mac and get
>>>> confused.
>>>>
>>>> I think that we should only make primary visible after guest acked the
>>>> backup feature bit.
>>> I think we want exactly the reverse? E.g fail the negotiation when 
>>> guest
>>> does not ack backup feature.
>>>
>>> Otherwise legacy guest won't even have the chance to see primary 
>>> device in
>>> the guest.
>> That's by design.
>>
>>>> And on reset or when backup is cleared in some other way, unplug the
>>>> primary.
>>> What if guest does not support hotplug?
>> It shouldn't ack the backup feature then and it's a good point.
>> We should both document this and check kernel config has
>> hotplug support. Sridhar could you take a look pls?
>
> Right now we select NET_FAILOVER when virtio-net is enabled, Should we 
> select
> PCI_HOTPLUG when NET_FAILOVER is enabled? 

Maybe I was wrong but it looks to me PCI_HOTPLUG is no sufficient since 
it depends on other to work e.g HOTPLUG_PCI_ACPI.

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

