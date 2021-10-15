Return-Path: <virtio-dev-return-8892-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F0039865C0
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Oct 2021 06:52:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <DM8PR12MB54806B9EEECE8920F450F86BDCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
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
Date: Fri, 15 Oct 2021 08:51:53 +0200
Message-ID: <87czo6vkza.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 15 2021, Parav Pandit <parav@nvidia.com> wrote:

>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Friday, October 15, 2021 3:59 AM
>> 
>> On Thu, Oct 14, 2021 at 05:35:37PM +0000, Parav Pandit wrote:
>> > Below changes are good for v3?
>> > 1. driver should use device reset time during initialization stage
>> 
>> How does driver identify this though?
> Existence of device_reset_timeout field in struct virtio_pci_common_cfg indicates that this field exists.
> If device support it, it will place non zero value and driver knows that this field should be used.

But how does the driver know? The very first step in the initialization
sequence is "reset the device", before it may read the config space.

>
>> 
>> > 2. remove feature bit as feature bits are only readable after reset is
>> > completed 3. device reset timeout field of zero indicates that device doesn't
>> support it.
>> 
>> I'm not sure about 3. I think each transport will need its own way to do it.
>> 
> For pci a value of zero indicates it isn't supported.
> For mmio DeviceResetTimeout at offset 0x04c indicates same.
> Currently only these 2 transports have the use.

I don't think we want to force all transports, including not yet
existing ones, to use that mechanism. They might as well use a command
to retrieve the value and fail the command, for example.

>
>> So I propose: maybe a capability like this, with a timeout field?
> Do you mean a new capability like say VIRTIO_PCI_DEVICE_TIMEOUT like VIRTIO_PCI_CAP_COMMON_CFG?
> This will contain one or more timeout? For example with his proposal it contains only device reset timeout.
> Later same capability will be further extended to contains command timeout too? Yes?
>
>> And within VMs, we can just do without, since it got out of reset once it will
>> surely get out of reset again...
> Yes, VM might not need it. It is really the HV's choice to implement and not part of the virtio spec.
> Our internal cloud passthrough a PF to the VM.
> It is probably better to let HV to choose if they want to do ctrl+c or have timeout.

But you want it in the spec, don't you? Confused.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

