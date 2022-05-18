Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <72e6713e-31ef-06b3-4859-61d524bbf11e@nvidia.com>
Date: Wed, 18 May 2022 18:32:42 +0300
Subject: Re: [PATCH v5 0/7] Introduce device group and device management
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220515112715-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220515112715-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/15/2022 6:27 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 27, 2022 at 01:58:17AM +0300, Max Gurtovoy wrote:
>> Hi,
>> A device group definition will help extending the virtio specefication for
>> various future features that require a notion of grouping devices together or
>> managing devices inside a group. A device group include one or more virtio devices.
>> For now, only support for type 1 device group was added.
>
> OK good progress here. Sent a bunch of comments, most of them
> cosmetic.
>

Is there a chance to get some reviewed-by for few commits in the series ?

to see some progress from v5 -> v6.

>> Also introduce the admin facility to allow manipulating features and configurations
>> in a generic manner. Using the admin command set, one can manipulate the device itself
>> and/or to manipulate, if possible, another device within the same device group (for now,
>> introduce only support of PCI SR-IOV devices grouping).
>>
>> The admin command set will be extended in the future  to support more functionalities.
>> Some of these functionalities are already under discussions.
>>
>> The admin virtqueue is the first management interface to issue admin commands from
>> the admin command set.
>>
>> Motivation for choosing admin queue as first management interface:
>> 1. It is anticipated that admin queue will be used for managing and configuring
>>     many different type of resources. For example,
>>     a. PCI PF configuring PCI VF attributes.
>>     b. virtio device creating/destroying/configuring subfunctions discussed in [1]
>>     c. composing device config space of VF or SF such as mac address, number of VQs, virtio features
>>
>>     Mapping all of them as configuration registers to MMIO will require large MMIO space,
>>     if done for each VF/SF. Such MMIO implementation in physical devices such as PCI PF and VF
>>     requires on-chip resources to complete within MMIO access latencies. Such resources are very
>>     expensive.
>>
>> 2. Such limitation can be overcome by having smaller MMIO register set to build
>>     a command request response interface. However, such MMIO based command interface
>>     will be limited to serve single outstanding command execution. Such limitation can
>>     resulting in high device creation and composing time which can affect VM startup time.
>>     Often device can queue and service multiple commands in parallel, such command interface
>>     cannot use parallelism offered by the device.
>>
>> 3. When a command wants to DMA data from one or more physical addresses, for example in the future a
>>     live migration command may need to fetch device state consist of config space, tens of
>>     VQs state, VLAN and MAC table, per VQ partial outstanding block IO list database and more.
>>     Packing one or more DMA addresses over new command interface will be burden some and continue
>>     to suffer single outstanding command execution latencies. Such limitation is not good for time
>>     sensitive live migration use cases.
>>
>> 4. A virtio queue overcomes all the above limitations. It also supports DMA and multiple outstanding
>>     descriptors. Similar mechanism exist today for device specific configuration - the control VQ.
>>
>> A future work can add another management interface to issue admin commands.
>>
>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F202108%2Fmsg00025.html&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7Cbc35d233eaa34e20897408da36877f01%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637882252823323958%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=nP3IpYLl7cwk5SkibfDTdguBfzIsUKBwMPDffMG5Vk4%3D&amp;reserved=0
>>
>> This series include the comments and fixes from V1-V4 of the initial patch sets ("VIRTIO: Provision maximum
>> MSI-X vectors for a VF" and "Introduce virtio subsystem and Admin virtqueue" [2]).
>> This series was extended with additional RFC for setting managed device feature bits as another example for
>> using admin command set. Also device/driver negotiation for admin caps was introduced as a response for previous
>> comments on the mailing list.
>>
>> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F202203%2Fmsg00005.html&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7Cbc35d233eaa34e20897408da36877f01%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637882252823323958%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WAxPBmPb%2BcyMNACTGzcwzCv1kFdjX0iIbXzM8Zl%2Bv4M%3D&amp;reserved=0
>>
>>
>> Open issues:
>> 1. CCW and MMIO specification for admin_queue_index register
>>
>> Changelog:
>>   - Merged MSI-X configuration series to current one.
>>   - Addressed comments from MST, Jason Wang and others.
>>   - simplified the interface.
>>   - added another resource management  as RFC (feature bits).
>>
>> Max Gurtovoy (7):
>>    Introduce device group
>>    Introduce admin command set
>>    Introduce new destination type for admin commands
>>    Introduce virtio admin virtqueue
>>    Add miscellaneous configuration structure for PCI
>>    Introduce MGMT admin commands
>>    RFC: add initial support for configuring feature bits
>>
>>   admin.tex        | 282 +++++++++++++++++++++++++++++++++++++++++++++++
>>   conformance.tex  |   3 +
>>   content.tex      | 118 +++++++++++++++++++-
>>   introduction.tex |  42 +++++++
>>   4 files changed, 443 insertions(+), 2 deletions(-)
>>   create mode 100644 admin.tex
>>
>> -- 
>> 2.21.0

