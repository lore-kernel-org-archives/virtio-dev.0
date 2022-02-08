Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <d4265ec1-8eab-0a53-f2a5-3764d6e2cda5@nvidia.com>
Date: Tue, 8 Feb 2022 10:34:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <d9c93540-4838-c18e-12c6-9ef4dc0028de@nvidia.com>
 <20220207111649-mutt-send-email-mst@kernel.org>
 <e29a241b-ebd6-ccb5-1f8c-1ca7fad471d9@nvidia.com>
 <20220208014332-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220208014332-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2/8/2022 8:45 AM, Michael S. Tsirkin wrote:
> On Tue, Feb 08, 2022 at 02:41:44AM +0200, Max Gurtovoy wrote:
>> On 2/7/2022 6:18 PM, Michael S. Tsirkin wrote:
>>> On Mon, Feb 07, 2022 at 04:58:19PM +0200, Max Gurtovoy wrote:
>>>> On 2/7/2022 12:39 PM, Michael S. Tsirkin wrote:
>>>>> On Thu, Feb 03, 2022 at 09:57:13AM +0200, Max Gurtovoy wrote:
>>>>>> +\begin{lstlisting}
>>>>>> +struct virtio_admin_cmd {
>>>>>> +        /* Device-readable part */
>>>>>> +        u16 command;
>>>>>> +        u8 command_specific_data[];
>>>>>> +
>>>>>> +        /* Device-writable part */
>>>>>> +        u8 status;
>>>>>> +        u8 command_specific_error;
>>>>>> +        u8 command_specific_result[];
>>>>>> +};
>>>>>> +\end{lstlisting}
>>>>> ok this abstraction is an improvement, thanks!
>>>>>
>>>>> What I'd like to see is moving a bit more format to this generic structure.
>>>>>
>>>>>    From what I could gather, some commands affect a group as a whole, and
>>>>> some commands just a single member of the group. We could have a
>>>>> "destination" field for that, and a special "all of the group"
>>>>> destination for commands affecting the whole group.
>>>>>
>>>>>
>>>>> Next, trying to think about scalable iov extensions. So we
>>>>> will have groups of VFs and then SFs as the next level.
>>>>> How does one differentiate between the two?
>>>>> Maybe reserve a field for "destination type"?
>>>> For now we have only a PCI group that composed of VFs and the PF.
>>>>
>>>> What you suggest, IMO is a definition of a generic virtio group/subsystem
>>>> that I've mentioned in the discussion of V1.
>>>>
>>>> Once we have virtio group - it should have a group id and them the admin
>>>> command can have a field calld group_id for commands that are targeted to
>>>> the whole group.
>>>>
>>>> Some commands are referring to a specific device in the group so only a
>>>> vdev_id is needed.
>>>>
>>>> Some commands are even targeted to the same device to query some info (we
>>>> have examples in this series for that), so in this case there is no need for
>>>> vdev_id nor group_id.
>>>>
>>>> So I'm sure sure we can improve common virtio_admin_cmd structure to have
>>>> these attributes since they are not mandatory because of the reasons I've
>>>> mentioned.
>>> I'm not sure I understand 100%, but try to address in the next
>>> revision and we'll discuss.
>> I meant to say that I'm *not* sure we can improve the common structure...
>>
>> It was a typo.
>>
>> And I don't understand why this info can't be in the command_specific_data
>> because of all the reasons I mentioned above.
> It can, but as declared admin commands are there to handle
> groups of VFs, so let's standardize how they refer to groups.

"Admin virtqueue is one of the management interface that used to send administrative
commands to manipulate various features of the *device* and/or to manipulate
various features, if possible, of *another device* within the same group"

It's not only for groups.

>
>>>>> The point of all this is to allow making sense of commands and
>>>>> e.g. virtualizing them for nested virt without necessarily
>>>>> knowing all of the detail about the specific command.
>>>> I don't understand this, sorry.
>>> Basically try to move stuff into generic format so it's possible
>>> to understand things without knowing detail of the command.
>> But we don't develop a networking protocol here. The management device is
>> not sending packets towards its managed devices, right ?
>>
>> This is an interface for a specific device that can manage others but also
>> manage itself.
>>
>> We didn't introduce a notion of broadcasting admin commands for other
>> devices.
> It's all entities communicating by message passing whether
> you call these "commands", "packets" or whatever.

We're extending a spec that introduce a driver-device communication via 
queue.

Your suggestion is an internal fabric with packets, headers, 
broadcasting commands (what about error flows ? is this fabric reliable 
? etc etc..).

I feel like this can be a nice future extension and shouldn't block 
current basic (and already big enough) proposal.

>

