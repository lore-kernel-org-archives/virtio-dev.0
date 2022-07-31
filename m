Return-Path: <mst@redhat.com>
Date: Sun, 31 Jul 2022 12:27:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 0/5] Introduce device group and device management
Message-ID: <20220731122521-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220731154354.15698-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jul 31, 2022 at 06:43:49PM +0300, Max Gurtovoy wrote:
> Hi,
> A device group definition will help extending the virtio specefication for
> various future features that require a notion of grouping devices together or
> managing devices inside a group. A device group include one or more virtio devices.
> For now, only support 2 device group types was added.
> 
> Also introduce the admin facility to allow manipulating features and configurations
> in a generic manner. Using the admin command set, one can manipulate the device itself
> and/or to manipulate, if possible, another device within the same device group (for now,
> introduce only support of PCI SR-IOV devices grouping managemant).
> 
> The admin command set will be extended in the future to support more functionalities.
> Some of these functionalities are already under discussions.
> 
> The admin virtqueue is the first management interface to issue admin commands from
> the admin command set.
> Motivation for choosing admin queue as first management interface:
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
> A future work can add another management interface to issue admin commands.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202108/msg00025.html
> 
> This series include the comments and fixes from V1-V5 of the initial patch sets ("VIRTIO: Provision maximum
> MSI-X vectors for a VF" and "Introduce virtio subsystem and Admin virtqueue" [2]).
> This series was updated with management for device feature bits instead of MSI-X vector provisioning as example for
> using admin command set. Also add dedicated feature bits for the new management capabilities as was discussed in the
> previous atempts.
> 
> [2] https://lists.oasis-open.org/archives/virtio-comment/202203/msg00005.html
> 
> 
> Open issues:
> 1. CCW and MMIO specification for admin_queue_index register
> 
> Changelog:
>  - remove MSI-X configuration patch from current version.
>  - Addressed comments from MST, Jason Wang and others (feature bits, self device group).
>  - simplified the interface.
> 


Thanks a lot! Will review. I assume these are changes since v5.
So in the next revision (if any) you will want to list
- changes in v7
	... future changes
- changes in v6
	this list

> 
> Max Gurtovoy (5):
>   Introduce device group
>   Introduce admin command set
>   Introduce virtio admin virtqueue
>   Add admin_queue_index register to PCI common configuration structure
>   Introduce MGMT admin commands
> 
>  admin.tex        | 188 +++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex      |  68 ++++++++++++++++-
>  introduction.tex |  54 ++++++++++++++
>  3 files changed, 308 insertions(+), 2 deletions(-)
>  create mode 100644 admin.tex
> 
> -- 
> 2.21.0

