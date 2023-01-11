Return-Path: <david@redhat.com>
Message-ID: <c3d29199-df2a-6a13-e88c-b52d20fa04ff@redhat.com>
Date: Wed, 11 Jan 2023 16:42:35 +0100
MIME-Version: 1.0
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-7-parav@nvidia.com>
 <b95d3aab-21c0-8256-a8bd-09e5b45cd206@redhat.com>
 <PH0PR12MB54814D2E4FAABC0A72EA5CE3DCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 06/20] virtio-mem-balloon: Maintain mem
 balloon device spec in separate directory
In-Reply-To: <PH0PR12MB54814D2E4FAABC0A72EA5CE3DCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.01.23 16:01, Parav Pandit wrote:
> Hi David,

Hi Parav,

> 
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Wednesday, January 11, 2023 9:14 AM
>> To: Parav Pandit <parav@nvidia.com>; mst@redhat.com; virtio-dev@lists.oasis-
>> open.org; cohuck@redhat.com
>> Cc: virtio-comment@lists.oasis-open.org
>> Subject: Re: [virtio-dev] [PATCH v3 06/20] virtio-mem-balloon: Maintain mem
>> balloon device spec in separate directory
>>
>> On 11.01.23 00:03, Parav Pandit wrote:
>>> Move virtio memory balloon device specification to its own file
>>> similar to recent virtio devices.
>>> While at it, place device specification, its driver and device
>>> conformance into its own directory to have self contained device
>>> specification.
>>>
>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
>>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>>
>>
>> There is virtio-mem and there is virtio-balloon. Calling virtio-balloon "virtio-
>> mem-balloon" can easily lead to quite some confusion. Any particular reason
>> why not to stick to "virtio-balloon" ?
>>
> Historically Linux memory balloon driver in linux is placed as virtio_balloon.c

See below. id=5 has widespread "virtio-balloon" terminology use. id=13 
is what creates confusion.

> In virtio spec, in the device type is it named as "Traditional memory balloon device".
> So, I named the directory name close to actual spec content name.
> Adding legacy/traditional was too long. :)
> May be virtio-mem-legacy is better to differentiate between legacy and new mem device?

As it has nothing to do with virtio-mem, that would be confusing. Also, 
legacy doesn't quite catch the semantics.

> 
> In this patchset, directories are named with "virtio-" prefix such as virtio-pmem, virtio-sound.
> 
> Another option (which I prefer as I write now) is,
> How about we drop "virtio-" prefix in the directory name because this is the virtio spec.
> 
> And have names as
> device-types/sound
> device-types/legacy-mem-balloon
> device-types/mem
> device-types/pmem
> 
> This is short and covers balloon part too?

Looking at 
https://lore.kernel.org/all/20220516204913.542894-71-mst@redhat.com/

We seem to have virtio-balloon (id=5) and virtio-mem-balloon (if=13).

virtio-balloon is what's actually implemented and used. "Traditional" is 
a bit misleading here.

IMHO, we could/should

* Name it "balloon" here
* Make "id=13" reserved and remove the notion of "memory balloon" from
   the spec
* Call "id=5" "Memory Balloon" and remove the notion of "Traditional".
   It's the one that exists.

@MST?

-- 
Thanks,

David / dhildenb

