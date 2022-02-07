Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <c4258e9b-4a9b-9320-cbea-6a38bbc7f7b0@nvidia.com>
Date: Mon, 7 Feb 2022 16:34:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com> <87tudgw0yi.fsf@redhat.com>
 <df605f77-9623-45c3-f340-1a36fadec3b0@nvidia.com>
 <20220207052554-mutt-send-email-mst@kernel.org> <87a6f2x5c7.fsf@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <87a6f2x5c7.fsf@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2/7/2022 1:51 PM, Cornelia Huck wrote:
> On Mon, Feb 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Mon, Feb 07, 2022 at 12:14:33PM +0200, Max Gurtovoy wrote:
>>> On 2/3/2022 3:09 PM, Cornelia Huck wrote:
>>>> On Thu, Feb 03 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>> +commands to manipulate various features of the device and/or to manipulate
>>>>> +various features, if possible, of another device within the same group (e.g. PCI VFs
>>>> Maybe add
>>>>
>>>> "Which devices are actually considered a group is transport specific."
>>>>
>>>> ?
>>> Not sure we want to restrict ourselves for that.
>> do restrict this please, if we want to extend the scope we can
>> always do that down the road.
> I'm also not sure how grouping can _not_ be transport specific... the
> PF/VF example is obviously a pci thing; for ccw, in a non-virtio
> context, there's sometimes the concept of some subchannels/devices being
> grouped together with no clear hierarchy, and for mmio, I don't really
> have an idea how "grouping" might work there.

Yes today it's transport specific.

But if one day there will be a definition for virtio fabric (over 
TCP/RDMA) it might not be true.

>>>>> +When VIRTIO_F_ADMIN_VQ is negotiated with the device, driver will send all admin commands
>>>>> +through the admin virtqueue.
>>>> That sounds a bit like the driver might use an alternative interface for
>>>> the admin commands as well? What about
>>> Yes if there will be an alternative for AQ and this feature bit will not be
>>> negotiated so the driver will use a different channel.
>>>
>>> This was explicitly discussed in previous versions.
>>>
>>> What is the issue with this assumption ?
>> it's not an issue down the road but we want to be clear
>> that right now that is the only way, to make sure
>> reader does not waste time looking for more ways
>> in the spec. maybe just say so.
> Yes, we should be explicit that admin commands are independent of the
> conduit they are using, and that currently the only conduit is the admin
> vq. Someone reading the spec does not know about previous discussions on
> the mailing list.
>
> Maybe reorder this? First have a section where the admin commands are
> defined, and then have a section that lists the different channels admin
> commands can use, where the admin vq is the only one currently
> supported?

I'll reorder it for V4.


>

