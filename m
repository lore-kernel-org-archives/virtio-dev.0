Return-Path: virtio-dev-return-3242-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CD3EC581922D
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 08:26:37 -0800 (PST)
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180216183817.42b07af6@cakuba.netronome.com>
 <CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ@mail.gmail.com>
 <20180218221140.6c7fb32e@cakuba.netronome.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <94062cc0-fe88-86c6-3dc8-40cb8422f9df@intel.com>
Date: Tue, 20 Feb 2018 08:26:33 -0800
MIME-Version: 1.0
In-Reply-To: <20180218221140.6c7fb32e@cakuba.netronome.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jakub Kicinski <kubakici@wp.pl>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 2/18/2018 10:11 PM, Jakub Kicinski wrote:
> On Sat, 17 Feb 2018 09:12:01 -0800, Alexander Duyck wrote:
>>>> We noticed a couple of issues with this approach during testing.
>>>> - As both 'bypass' and 'backup' netdevs are associated with the same
>>>>    virtio pci device, udev tries to rename both of them with the same name
>>>>    and the 2nd rename will fail. This would be OK as long as the first netdev
>>>>    to be renamed is the 'bypass' netdev, but the order in which udev gets
>>>>    to rename the 2 netdevs is not reliable.
>>> Out of curiosity - why do you link the master netdev to the virtio
>>> struct device?
>> The basic idea of all this is that we wanted this to work with an
>> existing VM image that was using virtio. As such we were trying to
>> make it so that the bypass interface takes the place of the original
>> virtio and get udev to rename the bypass to what the original
>> virtio_net was.
> That makes sense.  Is it udev/naming that you're most concerned about
> here?  I.e. what's the user space app that expects the netdev to be
> linked?  This is just out of curiosity, the linking of netdevs to
> devices is a bit of a PITA in the switchdev eswitch mode world, with
> libvirt expecting only certain devices to be there..  Right now we're
> not linking VF reprs, which breaks naming.  I wanted to revisit that.

For live migration usecase, userspace is only aware of one virtio_net 
interface and
it doesn't expect it to be linked with any lower dev.  So it should be 
fine even if the
lower netdev is not present. Only the master netdev should be assigned 
the same
name so that userspace configuration scripts  in the VM don't need to 
change.

>
>>> FWIW two solutions that immediately come to mind is to export "backup"
>>> as phys_port_name of the backup virtio link and/or assign a name to the
>>> master like you are doing already.  I think team uses team%d and bond
>>> uses bond%d, soft naming of master devices seems quite natural in this
>>> case.
>> I figured I had overlooked something like that.. Thanks for pointing
>> this out. Okay so I think the phys_port_name approach might resolve
>> the original issue. If I am reading things correctly what we end up
>> with is the master showing up as "ens1" for example and the backup
>> showing up as "ens1nbackup". Am I understanding that right?
> Yes, provided systemd is new enough.

Yes. I did a quick test to confirm that adding ndo_phys_port_name() to 
virtio_net
ndo_ops fixes the udev naming issue with 2 virtio netdevs.  This is on 
fedora27.


>
>> The problem with the team/bond%d approach is that it creates a new
>> netdevice and so it would require guest configuration changes.
>>
>>> IMHO phys_port_name == "backup" if BACKUP bit is set on slave virtio
>>> link is quite neat.
>> I agree. For non-"backup" virio_net devices would it be okay for us to
>> just return -EOPNOTSUPP? I assume it would be and that way the legacy
>> behavior could be maintained although the function still exists.
> That's my understanding too.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

