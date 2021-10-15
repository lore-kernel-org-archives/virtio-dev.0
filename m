Return-Path: <virtio-dev-return-8897-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A02D9865C0
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Oct 2021 09:26:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <DM8PR12MB5480C1A24131E23A5568AAA5DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com>
 <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211011115716-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548198414B1F64D5F7A149C8DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211012045448-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DB5D0F4F3EAAEB26B047DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481C5C0EB93191416E36D4EDCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211014182437-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54806B9EEECE8920F450F86BDCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <87czo6vkza.fsf@redhat.com>
 <DM8PR12MB5480C1A24131E23A5568AAA5DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
Date: Fri, 15 Oct 2021 11:25:54 +0200
Message-ID: <87a6javdul.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 15 2021, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Friday, October 15, 2021 12:22 PM
>> 
>> On Fri, Oct 15 2021, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> >> From: Michael S. Tsirkin <mst@redhat.com>
>> >> Sent: Friday, October 15, 2021 3:59 AM
>> >>
>> >> On Thu, Oct 14, 2021 at 05:35:37PM +0000, Parav Pandit wrote:
>> >> > Below changes are good for v3?
>> >> > 1. driver should use device reset time during initialization stage
>> >>
>> >> How does driver identify this though?
>> > Existence of device_reset_timeout field in struct virtio_pci_common_cfg
>> indicates that this field exists.
>> > If device support it, it will place non zero value and driver knows that this
>> field should be used.
>> 
>> But how does the driver know? The very first step in the initialization sequence
>> is "reset the device", before it may read the config space.
> PCI configuration space is always accessible when a PCI device exists at PCI level even before virtio layer can operate it.
> So struct virtio_pci_common_cfg is accessible to the virtio transport layer before resetting the device.
> It needs to contains what the timeout is, just like reset of the fields.
>
> I made mistake in understanding last time between virtio config space such as (struct virtio_net_config) vs PCI config space.
> So want to double check, did you mean pci config space and struct virtio_pci_common_cfg or something else when you mentioned _config_space_?
> Virtio_net_config certainly accessible only after reset.
> But transport level pci capabilities are accessible before reset by the PCI spec.

So, how does that work for non-pci? Can mmio access its config space
like that?

>
>> 
>> >
>> >>
>> >> > 2. remove feature bit as feature bits are only readable after reset
>> >> > is completed 3. device reset timeout field of zero indicates that
>> >> > device doesn't
>> >> support it.
>> >>
>> >> I'm not sure about 3. I think each transport will need its own way to do it.
>> >>
>> > For pci a value of zero indicates it isn't supported.
>> > For mmio DeviceResetTimeout at offset 0x04c indicates same.
>> > Currently only these 2 transports have the use.
>> 
>> I don't think we want to force all transports, including not yet existing ones, to
>> use that mechanism. They might as well use a command to retrieve the value
>> and fail the command, for example.
>> 
> ok. it is interesting for me to understand that virtio spec care for even an undefined transport.
>
> So when such undefined transport gets defined in virtio spec, a spec will get updated anyway to describes that new_transport performs reset via cmd interface.
>
> Though I do not well understand how driver can reset a device via a command without establishing a command channel.
> A device usually needs to respond/accept the command channel bits to accept the command.

[As a side note: s390 channel I/O works just like that. You have the
channel subsystem (and the control units) take care of the mechanism, no
device involvement required until the command is actually processed, and
even that is not needed for all commands.]

> But there may be some transport that behave differently that I didn't anticipate yet.
>
> So let's define such transport specific changes when such transport will be done for real in virtio spec.

My point is: don't make it harder for future transports than really
neccessary. If you look at today's transports, ccw is already
substantially different from pci in many ways, and yet both are
functional virtio transports. Take the concept of "config space": ccw
devices do not have such a thing. I created two channel commands to
basically emulate that concept for *virtio* *only*. Should we want to
introduce the timeout value for ccw (which is not likely, but let's go
for it for the sake of the argument), we cannot put it into a
non-existing config space; it needs to use something else, like a
command to retrieve the value. A future transport might be in a similar
position, and "put it into the config space" may simply not be possible.

Look at it that way: You come from the PCI perspective, and you have an
idea how to model things there. I come from a channel I/O background,
and I have an idea how to model things there. Both are quite different;
if we can come up with something that can work for both transports,
chances are good that a future transport can also work with it. If we
say that the driver retrieves that information in a transport-specific
way without any mention of config spaces, we should be fine.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

