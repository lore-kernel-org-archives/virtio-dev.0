Return-Path: <virtio-dev-return-10028-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD24298633E
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Oct 2022 12:31:40 +0000 (UTC)
Message-ID: <1666009602.9397366-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 17 Oct 2022 20:26:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
In-Reply-To: <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared memory device
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> Adding Stefan.
>
>
> On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Hello everyone,
> >
> > # Background
> >
> > Nowadays, there is a common scenario to accelerate communication between
> > different VMs and containers, including light weight virtual machine based
> > containers. One way to achieve this is to colocate them on the same host.
> > However, the performance of inter-VM communication through network stack is not
> > optimal and may also waste extra CPU cycles. This scenario has been discussed
> > many times, but still no generic solution available [1] [2] [3].
> >
> > With pci-ivshmem + SMC(Shared Memory Communications: [4]) based PoC[5],
> > We found that by changing the communication channel between VMs from TCP to SMC
> > with shared memory, we can achieve superior performance for a common
> > socket-based application[5]:
> >   - latency reduced by about 50%
> >   - throughput increased by about 300%
> >   - CPU consumption reduced by about 50%
> >
> > Since there is no particularly suitable shared memory management solution
> > matches the need for SMC(See ## Comparison with existing technology), and virtio
> > is the standard for communication in the virtualization world, we want to
> > implement a virtio-ism device based on virtio, which can support on-demand
> > memory sharing across VMs, containers or VM-container. To match the needs of SMC,
> > the virtio-ism device need to support:
> >
> > 1. Dynamic provision: shared memory regions are dynamically allocated and
> >    provisioned.
> > 2. Multi-region management: the shared memory is divided into regions,
> >    and a peer may allocate one or more regions from the same shared memory
> >    device.
> > 3. Permission control: The permission of each region can be set seperately.
>
> Looks like virtio-ROCE
>
> https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/
>
> and virtio-vhost-user can satisfy the requirement?
>
> >
> > # Virtio ism device
> >
> > ISM devices provide the ability to share memory between different guests on a
> > host. A guest's memory got from ism device can be shared with multiple peers at
> > the same time. This shared relationship can be dynamically created and released.
> >
> > The shared memory obtained from the device is divided into multiple ism regions
> > for share. ISM device provides a mechanism to notify other ism region referrers
> > of content update events.
> >
> > # Usage (SMC as example)
> >
> > Maybe there is one of possible use cases:
> >
> > 1. SMC calls the interface ism_alloc_region() of the ism driver to return the
> >    location of a memory region in the PCI space and a token.
> > 2. The ism driver mmap the memory region and return to SMC with the token
> > 3. SMC passes the token to the connected peer
> > 3. the peer calls the ism driver interface ism_attach_region(token) to
> >    get the location of the PCI space of the shared memory
> >
> >
> > # About hot plugging of the ism device
> >
> >    Hot plugging of devices is a heavier, possibly failed, time-consuming, and
> >    less scalable operation. So, we don't plan to support it for now.
> >
> > # Comparison with existing technology
> >
> > ## ivshmem or ivshmem 2.0 of Qemu
> >
> >    1. ivshmem 1.0 is a large piece of memory that can be seen by all devices that
> >    use this VM, so the security is not enough.
> >
> >    2. ivshmem 2.0 is a shared memory belonging to a VM that can be read-only by all
> >    other VMs that use the ivshmem 2.0 shared memory device, which also does not
> >    meet our needs in terms of security.
> >
> > ## vhost-pci and virtiovhostuser
> >
> >    Does not support dynamic allocation and therefore not suitable for SMC.
>
> I think this is an implementation issue, we can support VHOST IOTLB
> message then the regions could be added/removed on demand.


1. After the attacker connects with the victim, if the attacker does not
   dereference memory, the memory will be occupied under virtiovhostuser. In the
   case of ism devices, the victim can directly release the reference, and the
   maliciously referenced region only occupies the attacker's resources

2. The ism device of a VM can be shared with multiple (1000+) VMs at the same
   time, which is a challenge for virtiovhostuser

3. The sharing relationship of ism is dynamically increased, and virtiovhostuser
   determines the sharing relationship at startup.

4. For security issues, the device under virtiovhostuser may mmap more memory,
   while ism only maps one region to other devices

Thanks.

>
> Thanks
>
> >
> > # Design
> >
> >    This is a structure diagram based on ism sharing between two vms.
> >
> >     |-------------------------------------------------------------------------------------------------------------|
> >     | |------------------------------------------------|       |------------------------------------------------| |
> >     | | Guest                                          |       | Guest                                          | |
> >     | |                                                |       |                                                | |
> >     | |   ----------------                             |       |   ----------------                             | |
> >     | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
> >     | |   ----------------       |      |      |       |       |   ----------------               |      |      | |
> >     | |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
> >     | |    |  |                  |      |      |       |       |    |  |                          |      |      | |
> >     | |    |  |                -------------------     |       |    |  |                --------------------    | |
> >     | |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
> >     | |    |  |                -------------------     |       |    |  |                --------------------    | |
> >     | |                                |               |       |                               |                | |
> >     | |                                |               |       |                               |                | |
> >     | | Qemu                           |               |       | Qemu                          |                | |
> >     | |--------------------------------+---------------|       |-------------------------------+----------------| |
> >     |                                  |                                                       |                  |
> >     |                                  |                                                       |                  |
> >     |                                  |------------------------------+------------------------|                  |
> >     |                                                                 |                                           |
> >     |                                                                 |                                           |
> >     |                                                   --------------------------                                |
> >     |                                                    | M1 |   | M2 |   | M3 |                                 |
> >     |                                                   --------------------------                                |
> >     |                                                                                                             |
> >     | HOST                                                                                                        |
> >     ---------------------------------------------------------------------------------------------------------------
> >
> > # POC code
> >
> >    Kernel: https://github.com/fengidri/linux-kernel-virtio-ism/commits/ism
> >    Qemu:   https://github.com/fengidri/qemu/commits/ism
> >
> > If there are any problems, please point them out.
> >
> > Hope to hear from you, thank you.
> >
> > [1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.html
> > [2] https://dl.acm.org/doi/10.1145/2847562
> > [3] https://hal.archives-ouvertes.fr/hal-00368622/document
> > [4] https://lwn.net/Articles/711071/
> > [5] https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@linux.alibaba.com/T/
> >
> >
> > Xuan Zhuo (2):
> >   Reserve device id for ISM device
> >   virtio-ism: introduce new device virtio-ism
> >
> >  content.tex    |   3 +
> >  virtio-ism.tex | 340 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 343 insertions(+)
> >  create mode 100644 virtio-ism.tex
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

