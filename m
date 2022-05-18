Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <bbec8c81-12e5-e0bd-acf0-eea4eef81a9e@nvidia.com>
Date: Wed, 18 May 2022 17:36:05 +0300
Subject: Re: [PATCH v5 3/7] Introduce new destination type for admin commands
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-4-mgurtovoy@nvidia.com>
 <20220515110536-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB099226A96CF3DDD4D0DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220516193046-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220516193046-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/17/2022 2:33 AM, Michael S. Tsirkin wrote:
> On Mon, May 16, 2022 at 09:21:11PM +0000, Parav Pandit wrote:
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Sunday, May 15, 2022 11:09 AM
>>>
>>>> ---
>>>>   admin.tex | 18 ++++++++++++++----
>>>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/admin.tex b/admin.tex
>>>> index 6725daa..f816c3b 100644
>>>> --- a/admin.tex
>>>> +++ b/admin.tex
>>>> @@ -11,11 +11,13 @@ \section{Administration command
>>> set}\label{sec:Basic Facilities of a Virtio Devi
>>>>           le16 command;
>>>>           /*
>>>>            * 0 - self
>>>> -         * 1 - 65535 are reserved
>>>> +         * 1 - other virtio device (identified by vdev_id) in the same device
>>> group
>>>> +         * 2 - 65535 are reserved
>>>>            */
>>>>           le16 dst_type;
>>>> +        le64 vdev_id;
>>> Alignment problems. Proposal:
>>>
>>> vdev_id
>>> dst_type
>>> command
>> I remember that this has come up internal review as well.
>> Though it is certainly good to naturally align, I don't think we have alignment problem spec wise based on below snippet of the spec [1].
>> It was kind of counter intuitive to see vdev_id before seeing what the actual command is.
>> That way current layout made more sense.
> vdev_id and dst_type tell you where to send the command. They do not
> depend on the command. In fact vdev_id -> dst_id might make sense.

vdev_id -> dst_id ??

what is this supposed to be ? Do you have example for -> in the spec ?

>
>> There was some internal version or external, do not recall, where vdev_id was optional or was union.
>>
>> But I think if we always going have vdev_id, it can be naturally aligned like your above proposal.
>>
>> [1] "Structure Specifications
>> Many device and driver in-memory structure layouts are documented using the C struct syntax. All structures
>> are assumed to be without additional padding. To stress this, cases where common C compilers are known
>> to insert extra padding within structures are tagged using the GNU C __attribute__((packed)) syntax."
> These are pathological cases due to legacy. Better avoided.
>

