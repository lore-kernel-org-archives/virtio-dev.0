Return-Path: virtio-dev-return-3141-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 784C21CB8080
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Feb 2018 09:48:31 -0800 (PST)
References: <20180125040328.22867-1-tiwei.bie@intel.com>
 <20180125040328.22867-7-tiwei.bie@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e83b7fa-8cec-4c13-003f-f753a13fbfe2@redhat.com>
Date: Mon, 5 Feb 2018 18:47:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180125040328.22867-7-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v1 6/6] vhost-user: add VFIO based
 accelerators support
To: Tiwei Bie <tiwei.bie@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 25/01/2018 05:03, Tiwei Bie wrote:
> The key difference with PCI passthru is that, in this case only
> the data path of the device (e.g. DMA ring, notify region and
> queue interrupt) is pass-throughed to the VM, the device control
> path (e.g. PCI configuration space and MMIO regions) is still
> defined and emulated by QEMU.
> 
> The benefits of keeping virtio device emulation in QEMU compared
> with virtio device PCI passthru include (but not limit to):
> 
> - consistent device interface for guest OS in the VM;
> - max flexibility on the hardware (i.e. the accelerators) design;
> - leveraging the existing virtio live-migration framework;
> 
> The virtual IOMMU isn't supported by the accelerators for now.
> Because vhost-user currently lacks of an efficient way to share
> the IOMMU table in VM to vhost backend. That's why the software
> implementation of virtual IOMMU support in vhost-user backend
> can't support dynamic mapping well. Once this problem is solved
> in vhost-user, virtual IOMMU can be supported by accelerators
> too, and the IOMMU feature bit checking in this patch can be
> removed.

I don't understand why this would use vhost-user.  vhost-user is meant
for connecting to e.g. a user-space switch that is shared between
multiple virtual machines.

In this case, there would be one VFIO device per VM (because different
VM must be in different VFIO groups).  So I don't understand the benefit
of configuring the control path of the VFIO device outside QEMU.

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

