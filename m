Return-Path: virtio-dev-return-2899-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2AF5558191AB
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 10:14:14 -0800 (PST)
References: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
 <20180102181603.7fe4fd1e@cakuba.netronome.com>
 <CAKgT0Ue7E3ubPOP-d8femP1Yf=XK0j8MJRC7Wg8L7N59rugL4A@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <843c77a1-98bb-e667-3b4d-cc8bf7cd1668@intel.com>
Date: Wed, 3 Jan 2018 10:14:10 -0800
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ue7E3ubPOP-d8femP1Yf=XK0j8MJRC7Wg8L7N59rugL4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next 0/2] Enable virtio to act as a master for a
 passthru device
To: Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski <kubakici@wp.pl>
Cc: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, Alexander Duyck <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 1/3/2018 8:59 AM, Alexander Duyck wrote:
> On Tue, Jan 2, 2018 at 6:16 PM, Jakub Kicinski <kubakici@wp.pl> wrote:
>> On Tue,  2 Jan 2018 16:35:36 -0800, Sridhar Samudrala wrote:
>>> This patch series enables virtio to switch over to a VF datapath when a VF
>>> netdev is present with the same MAC address. It allows live migration of a VM
>>> with a direct attached VF without the need to setup a bond/team between a
>>> VF and virtio net device in the guest.
>>>
>>> The hypervisor needs to unplug the VF device from the guest on the source
>>> host and reset the MAC filter of the VF to initiate failover of datapath to
>>> virtio before starting the migration. After the migration is completed, the
>>> destination hypervisor sets the MAC filter on the VF and plugs it back to
>>> the guest to switch over to VF datapath.
>>>
>>> It is based on netvsc implementation and it may be possible to make this code
>>> generic and move it to a common location that can be shared by netvsc and virtio.
>>>
>>> This patch series is based on the discussion initiated by Jesse on this thread.
>>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>> How does the notion of a device which is both a bond and a leg of a
>> bond fit with Alex's recent discussions about feature propagation?
>> Which propagation rules will apply to VirtIO master?  Meaning of the
>> flags on a software upper device may be different.  Why muddy the
>> architecture like this and not introduce a synthetic bond device?
> It doesn't really fit with the notion I had. I think there may have
> been a bit of a disconnect as I have been out for the last week or so
> for the holidays.
>
> My thought on this was that the feature bit should be spawning a new
> para-virtual bond device and that bond should have the virto and the
> VF as slaves. Also I thought there was some discussion about trying to
> reuse as much of the netvsc code as possible for this so that we could
> avoid duplication of effort and have the two drivers use the same
> approach. It seems like it should be pretty straight forward since you
> would have the feature bit in the case of virto, and netvsc just does
> this sort of thing by default if I am not mistaken.
This patch is mostly based on netvsc implementation. The only change is 
avoiding the
explicit dev_open() call of the VF netdev after a delay. I am assuming 
that the guest userspace
will bring up the VF netdev and the hypervisor will update the MAC 
filters to switch to
the right data path.
We could commonize the code and make it shared between netvsc and 
virtio. Do we want
to do this right away or later? If so, what would be a good location for 
these shared functions?
Is it net/core/dev.c?

Also, if we want to go with a solution that creates a bond device, do we 
want virtio_net/netvsc
drivers to create a upper device?  Such a solution is already possible 
via config scripts that can
create a bond with virtio and a VF net device as slaves.  netvsc and 
this patch series is trying to
make it as simple as possible for the VM to use directly attached 
devices and support live migration
by switching to virtio datapath as a backup during the migration process 
when the VF device
is unplugged.

Thanks
Sridhar

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

