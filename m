Return-Path: virtio-dev-return-3024-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2649F58191F7
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2018 17:34:51 -0800 (PST)
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
 <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
 <20180117213527-mutt-send-email-mst@kernel.org>
 <CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
 <20180122231713-mutt-send-email-mst@kernel.org>
 <7edf772b-627c-6121-3332-479caed524da@intel.com>
 <20180123020332-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
Date: Mon, 22 Jan 2018 17:34:37 -0800
MIME-Version: 1.0
In-Reply-To: <20180123020332-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 1/22/2018 4:05 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
>>>> You could probably
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
> Well not necessarily - just a separate netdev ops.
> Kind of like e.g. vlans share a driver with the main driver.

Not sure what you meant by vlans sharing a driver with the main driver.
IIUC, vlans are supported via 802.1q driver and  creates a netdev of 
type 'vlan'
with vlan_netdev_ops
>
>> As we are using virtio_net to control and manage the VF data path, it is not
>> clear to me
>> what is the advantage of creating a new device rather than extending
>> virtio_net to manage
>> the VF datapath via transparent bond mechanism.
>>
>> Thanks
>> Sridhar
> So that XDP redirect actions can differentiate between virtio, PT
> device and the bond. Without it there's no way to redirect
> to virtio specifically.
I guess this usecase is for a guest admin to add bpf programs to VF 
netdev and
redirect frames to virtio.  How does bond enable this feature?


Thanks
Sridhar

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

