Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <5df18bee-1e68-865c-fdbc-6b765e654452@nvidia.com>
Date: Mon, 13 Feb 2023 17:07:34 +0200
Subject: Re: [virtio-comment] Re: [PATCH v10 03/10] admin: introduce group
 administration commands
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212044245-mutt-send-email-mst@kernel.org>
 <af4f4530-406f-cc30-748f-94ee916a6b8a@nvidia.com>
 <20230213031358-mutt-send-email-mst@kernel.org>
 <fce510fd-6329-cb0f-c97b-adaeb13af1f7@nvidia.com> <878rh1d9dz.fsf@redhat.com>
 <680c32ee-5dac-ab20-981a-bec134ca33c8@nvidia.com> <87wn4lbtdk.fsf@redhat.com>
 <1152549b-4a2d-a8e1-5b93-cedcc5d6413c@nvidia.com> <87ttzpbsb0.fsf@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <87ttzpbsb0.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 13/02/2023 15:36, Cornelia Huck wrote:
> On Mon, Feb 13 2023, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> 
>> On 13/02/2023 15:13, Cornelia Huck wrote:
>>> On Mon, Feb 13 2023, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>
>>>> On 13/02/2023 14:42, Cornelia Huck wrote:
>>>>> On Mon, Feb 13 2023, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>
>>>>>> On 13/02/2023 10:16, Michael S. Tsirkin wrote:
>>>>>>> On Mon, Feb 13, 2023 at 02:54:47AM +0200, Max Gurtovoy wrote:
>>>>>>>>> For some system calls and library functions (e.g.,
>>>>>>>>>             getpriority(2)), -1 is a valid return on success.  In such cases,
>>>>>>>>>             a successful return can be distinguished from an error return by
>>>>>>>>>             setting errno to zero before the call, and then, if the call
>>>>>>>>>             returns a status that indicates that an error may have occurred,
>>>>>>>>>             checking to see if errno has a nonzero value.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Description is already good enough to describe what they are.
>>>>>>>>>> Can we please drop Linux wording?
>>>>>>>>>
>>>>>>>>> But why should we? It's where 22 comes from so this way people are not
>>>>>>>>> wondering about the value, and it's somewhat helpful for Linux
>>>>>>>>> developers.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I also think we should not mention Linux. I don't think it's mentioned
>>>>>>>> currently in the spec and no good reason to do so now.
>>>>>>>
>>>>>>> But we do: fuse, input at least both do.
>>>>>>>
>>>>>>>> Also value of 22 is not mandatory for this EINVAL status code. It can be
>>>>>>>> just 1 (the first number after the OK status).
>>>>>>>
>>>>>>> 22 makes it a tiny bit easier for kvm. So why not.
>>>>>>
>>>>>> Because people comment on that in the review :) and because a
>>>>>> specification should be OS independent.
>>>>>> 22 might be EINVAL in Linux but a success in MyOS is my lucky number is 22.
>>>>>>
>>>>>> not a big issue for me, but I prefer to have a cleaner spec than maybe
>>>>>> simplify something in a very specific OS.
>>>>>
>>>>> Well, my take is:
>>>>> - we have to pick *something*
>>>>> - using EINVAL == 22 is very convenient for one of the most common (the
>>>>>      most common?) implementors
>>>>> - noting that we're trying to follow what Linux uses makes it clear what
>>>>>      to pick for any new return codes
>>>>>
>>>>
>>>> Can we agree on 22 without mentioning Linux ?
>>>
>>> See my third point above: we want people to be aware why we chose 22, so
>>> any new values will match up as well.
>>
>> Why we need people to be aware ?
> 
> people == people adding new error codes

These people should submit a patch for review and get comments from 
maintainers.

> 
>>
>> In NVMe spec for example there are many status codes (~30-50) and people
>> are not aware why the committee choose  0x02 for "Invalid Field in Command".
>> And frankly, I don't think they care.
>>
>> My point is that we need to make our lives, as spec developers and
>> maintainers, easier.
> 
> And that's why I think we should keep the proposed wording :) I think it
> will make the life of Future Me easier.
> 

I see.
Again, my stand for spec wording is not mentioning Linux and not 
following it's errnos.

Having said that, I don't really mind ignoring this sentence, although 
it wasn't part of my original patch.

