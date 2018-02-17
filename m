Return-Path: virtio-dev-return-3233-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 21B945818F75
	for <virtio-dev@lists.oasis-open.org>; Sat, 17 Feb 2018 09:12:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216183817.42b07af6@cakuba.netronome.com>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com> <20180216183817.42b07af6@cakuba.netronome.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 17 Feb 2018 09:12:01 -0800
Message-ID: <CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jakub Kicinski <kubakici@wp.pl>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 16, 2018 at 6:38 PM, Jakub Kicinski <kubakici@wp.pl> wrote:
> On Fri, 16 Feb 2018 10:11:19 -0800, Sridhar Samudrala wrote:
>> Ppatch 2 is in response to the community request for a 3 netdev
>> solution.  However, it creates some issues we'll get into in a moment.
>> It extends virtio_net to use alternate datapath when available and
>> registered. When BACKUP feature is enabled, virtio_net driver creates
>> an additional 'bypass' netdev that acts as a master device and controls
>> 2 slave devices.  The original virtio_net netdev is registered as
>> 'backup' netdev and a passthru/vf device with the same MAC gets
>> registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
>> associated with the same 'pci' device.  The user accesses the network
>> interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
>> as default for transmits when it is available with link up and running.
>
> Thank you do doing this.
>
>> We noticed a couple of issues with this approach during testing.
>> - As both 'bypass' and 'backup' netdevs are associated with the same
>>   virtio pci device, udev tries to rename both of them with the same name
>>   and the 2nd rename will fail. This would be OK as long as the first netdev
>>   to be renamed is the 'bypass' netdev, but the order in which udev gets
>>   to rename the 2 netdevs is not reliable.
>
> Out of curiosity - why do you link the master netdev to the virtio
> struct device?

The basic idea of all this is that we wanted this to work with an
existing VM image that was using virtio. As such we were trying to
make it so that the bypass interface takes the place of the original
virtio and get udev to rename the bypass to what the original
virtio_net was.

> FWIW two solutions that immediately come to mind is to export "backup"
> as phys_port_name of the backup virtio link and/or assign a name to the
> master like you are doing already.  I think team uses team%d and bond
> uses bond%d, soft naming of master devices seems quite natural in this
> case.

I figured I had overlooked something like that.. Thanks for pointing
this out. Okay so I think the phys_port_name approach might resolve
the original issue. If I am reading things correctly what we end up
with is the master showing up as "ens1" for example and the backup
showing up as "ens1nbackup". Am I understanding that right?

The problem with the team/bond%d approach is that it creates a new
netdevice and so it would require guest configuration changes.

> IMHO phys_port_name == "backup" if BACKUP bit is set on slave virtio
> link is quite neat.

I agree. For non-"backup" virio_net devices would it be okay for us to
just return -EOPNOTSUPP? I assume it would be and that way the legacy
behavior could be maintained although the function still exists.

>> - When the 'active' netdev is unplugged OR not present on a destination
>>   system after live migration, the user will see 2 virtio_net netdevs.
>
> That's necessary and expected, all configuration applies to the master
> so master must exist.

With the naming issue resolved this is the only item left outstanding.
This becomes a matter of form vs function.

The main complaint about the "3 netdev" solution is a bit confusing to
have the 2 netdevs present if the VF isn't there. The idea is that
having the extra "master" netdev there if there isn't really a bond is
a bit ugly.

The downside of the "2 netdev" solution is that you have to deal with
an extra layer of locking/queueing to get to the VF and you lose some
functionality since things like in-driver XDP have to be disabled in
order to maintain the same functionality when the VF is present or
not. However it looks more like classic virtio_net when the VF is not
present.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

