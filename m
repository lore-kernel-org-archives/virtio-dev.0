Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <fdbcd6d4-5b2b-dacd-f60f-b3ec4e354fa4@nvidia.com>
Date: Thu, 10 Mar 2022 15:08:54 +0200
Subject: Re: [PATCH v1 0/5] Introduce virtio subsystem and Admin virtqueue
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220309024115-mutt-send-email-mst@kernel.org>
 <5ba012be-cd17-e6b8-547d-01a8adaa22fd@nvidia.com>
 <20220310072743-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220310072743-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 3/10/2022 2:49 PM, Michael S. Tsirkin wrote:
> On Thu, Mar 10, 2022 at 12:38:38PM +0200, Max Gurtovoy wrote:
>> On 3/9/2022 9:42 AM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 02, 2022 at 05:56:03PM +0200, Max Gurtovoy wrote:
>>>> Hi,
>>>> A virtio subsystem definition will help extending the virtio specefication for
>>>> various future features that require a notion of grouping devices together or
>>>> managing devices inside a group. It also might be used splitting or sharing a
>>>> single virtio backend between multiple devices (e.g. Multipath IO for virtio-blk
>>>> devices). A virtio subsystem include one or more virtio devices.
>>> A large patch, need a bit more time for review. Meanwhile,
>>> how about adding migration related capabilities?
>>> I would very much like that to make progress before
>>> people start using high overhead solutions like
>>> VQ shadowing.
>> Sure I can start working on rebasing old LM proposal to virtio subsystem
>> framework.
>>
>> But can you be precise for what you mean capabilities ? only caps without
>> the commands and LM logic ?
> There are at least four distinct bits, and they can be worked on mostly
> separately:
>
>
> 1.  We need a bunch of stuff to migrate a device to a different host right?
> - device specific state
> - transport state
> - vq ring state
> and of course we need
> - ability to stop/resume device
> This is useful by itself e.g. for snapshoting.
>
> Then to reduce downtime we also need to run device during memory
> migration, which requires support for
>
> 2. page faults (postcopy) and optionally
> 3. dirty tracking (precopy) - though dirty tracking can be done
> with faults too, so maybe just faults.
> Faults are definitely useful for a bunch of stuff like memory migration.
> Dirty tracking is more of a boutique feature, but I guess uses
> beyond memory migration can still be found.
>
> 4.  Finally, feature compatibility is a problem: not any configuration of a
> device can be migrated to any other device. A simplest example is a
> device feature not present on destination. Can be solved by not exposing
> the feature to the guest. Another example is layout of pci configuration
> space. Spec allows a lot of flexibility here, however things like
> # of VQs will affect the memory bar size.
> I am not exactly sure what we want to do in this space, maybe for
> starters enumerating what are the things that need to match on source
> and destination?
> We can start with a non-normative sections describing the issues
> generally at least.

MST,

I really like us to push these 5 patches before we deep dive to LM stuff.

This was our plan we agreed together - push infrastructure with 
relatively small feature (we choose MSIX management) to the spec.

This infrastructure should fit for future features such as: VQ 
management, LM management and more.

I think it does. Now the TG need to review and agree.

If we'll start talking about LM during this series review we will end up 
again with nothing merged to the spec and waste more precious time.

So I'm taking the bits above into account for the internal LM work that 
I'm preparing for the future (after we'll merge the current series).

agreed ?

>
>
>
>> Initial feedback will be great for this series since every rebase cost a
>> lot... and it grows if we add more caps and logic.
>>
>>>
>>>> Also introduce the admin facility to allow manipulating features and configurations
>>>> in a generic manner. Using the admin command set, one can manipulate the device itself
>>>> and/or to manipulate, if possible, another device within the same virtio subsystem (the
>>>> following patch set).
>>>>
>>>> The admin virtqueue is the first management interface to issue Admin commands from
>>>> the admin command set.
>>>>
>>>> The admin virtqueue interface will be extended in the future with more and more
>>>> features that some of them already in discussions. Some of these features don't
>>>> fit to MMIO/config_space characteristics, therefore a queue is selected to address
>>>> admin commands.
>>>>
>>>> Motivation for choosing admin queue:
>>>> 1. It is anticipated that admin queue will be used for managing and configuring
>>>>      many different type of resources. For example,
>>>>      a. PCI PF configuring PCI VF attributes.
>>>>      b. virtio device creating/destroying/configuring subfunctions discussed in [1]
>>>>      c. composing device config space of VF or SF such as mac address, number of VQs, virtio features
>>>>
>>>>      Mapping all of them as configuration registers to MMIO will require large MMIO space,
>>>>      if done for each VF/SF. Such MMIO implementation in physical devices such as PCI PF and VF
>>>>      requires on-chip resources to complete within MMIO access latencies. Such resources are very
>>>>      expensive.
>>>>
>>>> 2. Such limitation can be overcome by having smaller MMIO register set to build
>>>>      a command request response interface. However, such MMIO based command interface
>>>>      will be limited to serve single outstanding command execution. Such limitation can
>>>>      resulting in high device creation and composing time which can affect VM startup time.
>>>>      Often device can queue and service multiple commands in parallel, such command interface
>>>>      cannot use parallelism offered by the device.
>>>>
>>>> 3. When a command wants to DMA data from one or more physical addresses, for example in the future a
>>>>      live migration command may need to fetch device state consist of config space, tens of
>>>>      VQs state, VLAN and MAC table, per VQ partial outstanding block IO list database and more.
>>>>      Packing one or more DMA addresses over new command interface will be burden some and continue
>>>>      to suffer single outstanding command execution latencies. Such limitation is not good for time
>>>>      sensitive live migration use cases.
>>>>
>>>> 4. A virtio queue overcomes all the above limitations. It also supports DMA and multiple outstanding
>>>>      descriptors. Similar mechanism exist today for device specific configuration - the control VQ.
>>>>
>>>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F202108%2Fmsg00025.html&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7C99739e80d00a4fe3394b08da02947d10%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637825134024839108%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=PSDymc6cSXtjry%2BIx2oqSZUbdAaffmUov%2BMApHPnAbY%3D&amp;reserved=0
>>>>
>>>> This series was extended and splitted from the V3 of the "VIRTIO: Provision maximum MSI-X vectors for a VF".
>>>> This series include the comments and fixes from V1-V3 of the initial patch set from above.
>>>> The following series introduce the management devices and MSI-X configuration of virtio devices.
>>>>
>>>> Open issues:
>>>> 1. CCW and MMIO specification for admin_queue_index register
>>>>
>>>> Max Gurtovoy (5):
>>>>     virtio: Introduce virtio subsystem
>>>>     Introduce Admin Command Set
>>>>     Introduce DEVICE INFO Admin command
>>>>     Add virtio Admin virtqueue
>>>>     Add miscellaneous configuration structure for PCI
>>>>
>>>>    admin.tex        | 177 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>    conformance.tex  |   3 +
>>>>    content.tex      |  33 ++++++++-
>>>>    introduction.tex |  20 ++++++
>>>>    4 files changed, 231 insertions(+), 2 deletions(-)
>>>>    create mode 100644 admin.tex
>>>>
>>>> -- 
>>>> 2.21.0

