Return-Path: <mst@redhat.com>
Date: Wed, 9 Mar 2022 02:42:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 0/5] Introduce virtio subsystem and Admin virtqueue
Message-ID: <20220309024115-mutt-send-email-mst@kernel.org>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220302155608.24189-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 02, 2022 at 05:56:03PM +0200, Max Gurtovoy wrote:
> Hi,
> A virtio subsystem definition will help extending the virtio specefication for
> various future features that require a notion of grouping devices together or
> managing devices inside a group. It also might be used splitting or sharing a
> single virtio backend between multiple devices (e.g. Multipath IO for virtio-blk
> devices). A virtio subsystem include one or more virtio devices.


A large patch, need a bit more time for review. Meanwhile,
how about adding migration related capabilities?
I would very much like that to make progress before
people start using high overhead solutions like
VQ shadowing.


> Also introduce the admin facility to allow manipulating features and configurations
> in a generic manner. Using the admin command set, one can manipulate the device itself
> and/or to manipulate, if possible, another device within the same virtio subsystem (the
> following patch set).
> 
> The admin virtqueue is the first management interface to issue Admin commands from
> the admin command set.
> 
> The admin virtqueue interface will be extended in the future with more and more
> features that some of them already in discussions. Some of these features don't
> fit to MMIO/config_space characteristics, therefore a queue is selected to address
> admin commands.
> 
> Motivation for choosing admin queue:
> 1. It is anticipated that admin queue will be used for managing and configuring
>    many different type of resources. For example,
>    a. PCI PF configuring PCI VF attributes.
>    b. virtio device creating/destroying/configuring subfunctions discussed in [1]
>    c. composing device config space of VF or SF such as mac address, number of VQs, virtio features
> 
>    Mapping all of them as configuration registers to MMIO will require large MMIO space,
>    if done for each VF/SF. Such MMIO implementation in physical devices such as PCI PF and VF
>    requires on-chip resources to complete within MMIO access latencies. Such resources are very
>    expensive.
> 
> 2. Such limitation can be overcome by having smaller MMIO register set to build
>    a command request response interface. However, such MMIO based command interface
>    will be limited to serve single outstanding command execution. Such limitation can
>    resulting in high device creation and composing time which can affect VM startup time.
>    Often device can queue and service multiple commands in parallel, such command interface
>    cannot use parallelism offered by the device.
> 
> 3. When a command wants to DMA data from one or more physical addresses, for example in the future a
>    live migration command may need to fetch device state consist of config space, tens of
>    VQs state, VLAN and MAC table, per VQ partial outstanding block IO list database and more.
>    Packing one or more DMA addresses over new command interface will be burden some and continue
>    to suffer single outstanding command execution latencies. Such limitation is not good for time
>    sensitive live migration use cases.
> 
> 4. A virtio queue overcomes all the above limitations. It also supports DMA and multiple outstanding
>    descriptors. Similar mechanism exist today for device specific configuration - the control VQ.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202108/msg00025.html
> 
> This series was extended and splitted from the V3 of the "VIRTIO: Provision maximum MSI-X vectors for a VF".
> This series include the comments and fixes from V1-V3 of the initial patch set from above.
> The following series introduce the management devices and MSI-X configuration of virtio devices.
> 
> Open issues:
> 1. CCW and MMIO specification for admin_queue_index register
> 
> Max Gurtovoy (5):
>   virtio: Introduce virtio subsystem
>   Introduce Admin Command Set
>   Introduce DEVICE INFO Admin command
>   Add virtio Admin virtqueue
>   Add miscellaneous configuration structure for PCI
> 
>  admin.tex        | 177 +++++++++++++++++++++++++++++++++++++++++++++++
>  conformance.tex  |   3 +
>  content.tex      |  33 ++++++++-
>  introduction.tex |  20 ++++++
>  4 files changed, 231 insertions(+), 2 deletions(-)
>  create mode 100644 admin.tex
> 
> -- 
> 2.21.0

