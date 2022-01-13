Return-Path: <mst@redhat.com>
Date: Thu, 13 Jan 2022 13:32:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 0/5] VIRTIO: Provision maximum MSI-X vectors for a VF
Message-ID: <20220113132436-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220113145103.26894-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 13, 2022 at 04:50:58PM +0200, Max Gurtovoy wrote:
> Hi,
> 
> In a PCI SR-IOV configuration, MSI-X vectors of the device is precious
> device resource. Hence making efficient use of it based on the use case
> that aligns to the VM configuration is desired for best system
> performance.
> 
> For example, today's static assignment of the amount of MSI-X vectors
> doesn't allow sophisticated utilization of resources.
> 
> A typical cloud provider SR-IOV use case is to create many VFs for
> use by guest VMs. Each VM might have a different purpose and different
> amount of resources accordingly (e.g. number of CPUs). A common driver
> usage of device's MSI-X vectors is proportional to the number of CPUs in
> the VM. Since the system administrator might know the amount of CPUs in
> the requested VM, he can also configure the VF's MSI-X vectors amount
> proportional to the number of CPUs in the VM. In this way, the
> utilization of the physical hardware will be improved.
> 
> Today we have some operating systems that support provisioning MSI-X
> vectors for PCI VFs.
> 
> Update the specification to have a method to change the number of MSI-X
> vectors supported by a VF using the PF admin virtqueue interface. For that,
> create a generic infrastructure for managing PCI resources of the managed
> VF by its parent PF.

Can you describe in the cover letter or the commit log of
the admin VQ patch the motivation for using a VQ and not
memory mapped space for this capability?
In fact I feel at least some commands would be better replaced
with a memory mapped structure.


> Patches (1/5)-(2/5) introduce the admin virtqueue concept and feature bits.
> Patches (3/5)-(4/5) add the admin virtq to virtio-blk and virtio-net
> devices.
> Patch (5/5) introduce MSI-X mgmt support.
> 
> Max Gurtovoy (5):
>   Add virtio Admin Virtqueue specification
>   Introduce VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
>   virtio-blk: add support for VIRTIO_F_ADMIN_VQ
>   virtio-net: add support for VIRTIO_F_ADMIN_VQ
>   Add support for dynamic MSI-X vector mgmt for VFs
> 
>  admin-virtq.tex | 145 ++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex     |  91 +++++++++++++++++++++++++++---
>  packed-ring.tex |  26 ++++-----
>  split-ring.tex  |  35 ++++++++----
>  4 files changed, 263 insertions(+), 34 deletions(-)
>  create mode 100644 admin-virtq.tex
> 
> -- 
> 2.21.0

