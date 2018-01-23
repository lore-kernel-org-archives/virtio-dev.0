Return-Path: virtio-dev-return-3025-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A866258191EF
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2018 17:37:31 -0800 (PST)
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
 <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
 <20180117213527-mutt-send-email-mst@kernel.org>
 <CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
 <20180122231713-mutt-send-email-mst@kernel.org>
 <7edf772b-627c-6121-3332-479caed524da@intel.com>
 <20180122160204.130451f2@xeon-e3>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <f44e28d8-d96e-e8b5-594a-2a66957a902d@intel.com>
Date: Mon, 22 Jan 2018 17:37:20 -0800
MIME-Version: 1.0
In-Reply-To: <20180122160204.130451f2@xeon-e3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/22/2018 4:02 PM, Stephen Hemminger wrote:
>
>>>   
>>>> In the case of SwitchDev it
>>>> should be possible for the port representors and the switch to provide
>>>> data on which interfaces are bonded on the host side and which aren't.
>>>> With that data it would be pretty easy to just put together a list of
>>>> addresses that would prefer to go the para-virtual route instead of
>>>> being transmitted through physical hardware.
>>>>
>>>> In addition a bridge implies much more overhead since normally a
>>>> bridge can receive a packet in on one interface and transmit it on
>>>> another. We don't really need that. This is more of a VEPA type setup
>>>> and doesn't need to be anything all that complex. You could probably
>>>> even handle the Tx queue selection via a simple eBPF program and map
>>>> since the input for whatever is used to select Tx should be pretty
>>>> simple, destination MAC, source NUMA node, etc, and the data-set
>>>> shouldn't be too large.
>>> That sounds interesting. A separate device might make this kind of setup
>>> a bit easier.  Sridhar, did you look into creating a separate device for
>>> the virtual bond device at all?  It does not have to be in a separate
>>> module, that kind of refactoring can come later, but once we commit to
>>> using the same single device as virtio, we can't change that.
>> No. I haven't looked into creating a separate device. If we are going to
>> create a new
>> device, i guess it has to be of a new device type with its own driver.
>>
>> As we are using virtio_net to control and manage the VF data path, it is
>> not clear to me
>> what is the advantage of creating a new device rather than extending
>> virtio_net to manage
>> the VF datapath via transparent bond mechanism.
>>
>> Thanks
>> Sridhar
>>
>>
> The requirement with Azure accelerated network was that a stock distribution image from the
> store must be able to run unmodified and get accelerated networking.
> Not sure if other environments need to work the same, but it would be nice.
>
> That meant no additional setup scripts (aka no bonding) and also it must
> work transparently with hot-plug. Also there are diverse set of environments:
> openstack, cloudinit, network manager and systemd. The solution had to not depend
> on any one of them, but also not break any of them.
Yes. Cloud Service Providers using KVM as hypervisor have a similar 
requirement to provide accelerated
networking with VM images that support virtio_net.

Thanks
Sridhar



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

