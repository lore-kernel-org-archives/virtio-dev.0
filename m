Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <df605f77-9623-45c3-f340-1a36fadec3b0@nvidia.com>
Date: Mon, 7 Feb 2022 12:14:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com> <87tudgw0yi.fsf@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <87tudgw0yi.fsf@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, mst@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2/3/2022 3:09 PM, Cornelia Huck wrote:
> On Thu, Feb 03 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>> In one of the many use cases a user wants to manipulate features and
>> configuration of the virtio devices regardless of the device type
>> (net/block/console). Some of this configuration is generic enough. i.e
>> Number of MSI-X vectors of a virtio PCI VF device. There is a need to do
>> such features query and manipulation by its parent PCI PF.
>>
>> Currently virtio specification defines control virtqueue to manipulate
>> features and configuration of the device it operates on. However,
>> control virtqueue commands are device type specific, which makes it very
>> difficult to extend for device agnostic commands.
>>
>> To support this requirement in elegant way, this patch introduces a new
>> admin virtqueue interface. Admin virtqueue is proposed as one of the
>> interfaces to issue admin commands that have the same command format for
>> all type of virtio devices.
>>
>> Manipulate features via admin virtqueue is asynchronous, scalable, easy
>> to extend and doesn't require additional and expensive on-die resources
>> to be allocated for every new feature that will be added in the future.
>>
>> Subsequent patches make use of this admin virtqueue.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   admin.tex       | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   conformance.tex |  1 +
>>   content.tex     |  8 +++--
>>   3 files changed, 101 insertions(+), 2 deletions(-)
>>   create mode 100644 admin.tex
>>
>> diff --git a/admin.tex b/admin.tex
>> new file mode 100644
>> index 0000000..fa9c993
>> --- /dev/null
>> +++ b/admin.tex
>> @@ -0,0 +1,94 @@
> [some wording only, have not yet thought about the rest]
>
>> +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
>> +
>> +Admin virtqueue is one of the management interface that used to send administrative
> "An admin virtqueue is a management interface of a device that can be used..."

OK thanks.

>
>> +commands to manipulate various features of the device and/or to manipulate
>> +various features, if possible, of another device within the same group (e.g. PCI VFs
> Maybe add
>
> "Which devices are actually considered a group is transport specific."
>
> ?

Not sure we want to restrict ourselves for that.

>
>> +of a parent PCI PF device are grouped together. These devices can be optionally
>> +managed by its parent PCI PF using its admin virtqueue.).
> I would move the content in the brackets to a separate paragraph. Maybe
>
> "An example of a group is PCI virtual functions (VFs) being grouped
> together with their parent PCI physical function (PF). These VFs can be
> optionally managed by their parent PF using its admin virtqueue."

Sounds good.


>
>> +
>> +An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ is
>> +negotiated. The index of the admin virtqueue exposed by the device in a
> s/exposed/is exposed/
thanks.
>
>> +transport specific manner.
>> +
>> +When VIRTIO_F_ADMIN_VQ is negotiated with the device, driver will send all admin commands
>> +through the admin virtqueue.
> That sounds a bit like the driver might use an alternative interface for
> the admin commands as well? What about

Yes if there will be an alternative for AQ and this feature bit will not 
be negotiated so the driver will use a different channel.

This was explicitly discussed in previous versions.

What is the issue with this assumption ?

>
> "If VIRTIO_F_ADMIN_VQ has been negotiated, the driver used the admin
> virtqueue to send admin commands."

maybe:

"If VIRTIO_F_ADMIN_VQ has been negotiated, the driver will use the admin 
virtqueue to send
all admin commands."


>

