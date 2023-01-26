Return-Path: <virtio-dev-return-10665-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Message-ID: <cac7cac4-7985-e157-d71a-2505c1d4d292@oracle.com>
Date: Wed, 25 Jan 2023 16:46:24 -0800
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
 <20230125155204-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810534C4518320B28BC9D6DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>



On 1/25/2023 3:46 PM, Parav Pandit wrote:
>> From: Parav Pandit
>> Sent: Wednesday, January 25, 2023 6:31 PM
>> To: Michael S. Tsirkin <mst@redhat.com>; Halil Pasic <pasic@linux.ibm.com>
>>
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Wednesday, January 25, 2023 3:56 PM
>>>
>>> On Wed, Jan 25, 2023 at 07:04:54PM +0100, Halil Pasic wrote:
>>>>> +
>>>>> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST accept
>>>>> +all VLAN tagged packets whose VLAN tag is present in the VLAN
>>>>> +filter table and SHOULD drop all VLAN tagged packets whose VLAN
>>>>> +tag is absent in the VLAN filter table.
>>>> We could also add "as per device configuration" here as well...
>>>>
>>>> >From the other thread
>>>>
>>>> On Mon, 23 Jan 2023 12:41:16 +0000
>>>> Parav Pandit <parav@nvidia.com> wrote:
>>>>
>>>>>> BTW why SHOULD drop?
>>>>> This is the offload feature to drop such packets so that OS driver
>>>>> doesn't need to do the filtering work. :)
>>>> Why not MUST drop? If the device is allowed to produce false
>>>> negatives, then I think the OS probably wants to check again to
>>>> filter out
>>> those.
>>>> Can we change SHOULD to MUST, so the conforming device is guaranteed
>>>> to do the filtering, and the OS can rely on it?
>>> Well the spec says:
>>> 	Similar to the MAC address based filtering, the VLAN filtering
>>> 	is also best-effort: unwanted packets could still arrive.
>>>
>>>   am not sure why - IIRC MAC filtering is best effort because a. we
>>> don't expose table size to guests so the table can always overflow.
>>> b. we like to rely on bridge to filter for performance and *that* is
>>>     best effort.
>>>
>>> but vlans are different aren't they? Anyway changing that will need a
>>> new feature bit.
>> I do not the history for about "Note" on why it was made best effort.
>> To best of my knowledge, it should not be best effort.
>> Device should not overflow the table. It should fail the ADD call.
>>
>> If the above claim of "Note" is not strong enough, we can probably run a
>> different issue to make it "MUST".
>> I am not sure we really need feature bit it we fix the note.
> I clicked too early while typing.
> Since DEL operation doesn't synchronize with the data path of device and driver, at some point a packet in pipe can be still received with removed VLAN.
> So may be the note was added.
> But for sure ADD should not be best effort basis.
If I recall the software backend implementation correctly, it's even 
unsynchronized for ADD. That's where the best effort came from (existing 
artifact in some software implementation). While I don't think it's 
worth adding another feature representing the difference. That said, I 
agree we SHOULD try to synchronize packet reception with ADD and DEL if 
at all possible.

-Siwei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

