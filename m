Return-Path: virtio-dev-return-2897-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E2F5B58191AA
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 06:34:58 -0800 (PST)
References: <20171222064151.29266-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fcf3858e-6643-350c-37b9-71698f1d26a5@redhat.com>
Date: Wed, 3 Jan 2018 22:34:36 +0800
MIME-Version: 1.0
In-Reply-To: <20171222064151.29266-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [RFC 0/3] Extend vhost-user to support VFIO based
 accelerators
To: Tiwei Bie <tiwei.bie@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2017年12月22日 14:41, Tiwei Bie wrote:
> This RFC patch set does some small extensions to vhost-user protocol
> to support VFIO based accelerators, and makes it possible to get the
> similar performance of VFIO passthru while keeping the virtio device
> emulation in QEMU.
>
> When we have virtio ring compatible devices, it's possible to setup
> the device (DMA mapping, PCI config, etc) based on the existing info
> (memory-table, features, vring info, etc) which is available on the
> vhost-backend (e.g. DPDK vhost library). Then, we will be able to
> use such devices to accelerate the emulated device for the VM. And
> we call it vDPA: vhost DataPath Acceleration. The key difference
> between VFIO passthru and vDPA is that, in vDPA only the data path
> (e.g. ring, notify and queue interrupt) is pass-throughed, the device
> control path (e.g. PCI configuration space and MMIO regions) is still
> defined and emulated by QEMU.
>
> The benefits of keeping virtio device emulation in QEMU compared
> with virtio device VFIO passthru include (but not limit to):
>
> - consistent device interface from guest OS;
> - max flexibility on control path and hardware design;
> - leveraging the existing virtio live-migration framework;
>
> But the critical issue in vDPA is that the data path performance is
> relatively low and some host threads are needed for the data path,
> because some necessary mechanisms are missing to support:
>
> 1) guest driver notifies the device directly;
> 2) device interrupts the guest directly;
>
> So this patch set does some small extensions to vhost-user protocol
> to make both of them possible. It leverages the same mechanisms (e.g.
> EPT and Posted-Interrupt on Intel platform) as the VFIO passthru to
> achieve the data path pass through.
>
> A new protocol feature bit is added to negotiate the accelerator feature
> support. Two new slave message types are added to enable the notify and
> interrupt passthru for each queue. From the view of vhost-user protocol
> design, it's very flexible. The passthru can be enabled/disabled for
> each queue individually, and it's possible to accelerate each queue by
> different devices. More design and implementation details can be found
> from the last patch.
>
> There are some rough edges in this patch set (so this is a RFC patch
> set for now), but it's never too early to hear the thoughts from the
> community! So any comments and suggestions would be really appreciated!
>
> Tiwei Bie (3):
>    vhost-user: support receiving file descriptors in slave_read
>    vhost-user: introduce shared vhost-user state
>    vhost-user: add VFIO based accelerators support
>
>   docs/interop/vhost-user.txt     |  57 ++++++
>   hw/scsi/vhost-user-scsi.c       |   6 +-
>   hw/vfio/common.c                |   2 +-
>   hw/virtio/vhost-user.c          | 430 +++++++++++++++++++++++++++++++++++++++-
>   hw/virtio/vhost.c               |   3 +-
>   hw/virtio/virtio-pci.c          |   8 -
>   hw/virtio/virtio-pci.h          |   8 +
>   include/hw/vfio/vfio.h          |   2 +
>   include/hw/virtio/vhost-user.h  |  43 ++++
>   include/hw/virtio/virtio-scsi.h |   6 +-
>   net/vhost-user.c                |  30 +--
>   11 files changed, 561 insertions(+), 34 deletions(-)
>   create mode 100644 include/hw/virtio/vhost-user.h
>

I may miss something, but may I ask why you must implement them through 
vhost-use/dpdk. It looks to me you could put all of them in qemu which 
could simplify a lots of things (just like userspace NVME driver wrote 
by Fam).

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

