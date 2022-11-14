Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1668399034.6701903-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 0/2] introduce virtio-ism: internal shared memory device
Date: Mon, 14 Nov 2022 12:10:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221101120428.9500-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20221101120428.9500-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Do you have other opinions? I hope to hear your thoughts.

Thanks.

On Tue,  1 Nov 2022 20:04:26 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Hello everyone,
>
> # Background
>
>     Nowadays, there is a common scenario to accelerate communication between
>     different VMs and containers, including light weight virtual machine based
>     containers. One way to achieve this is to colocate them on the same host.
>     However, the performance of inter-VM communication through network stack is
>     not optimal and may also waste extra CPU cycles. This scenario has been
>     discussed many times, but still no generic solution available [1] [2] [3].
>
>     With pci-ivshmem + SMC(Shared Memory Communications: [4]) based PoC[5],
>     We found that by changing the communication channel between VMs from TCP to
>     SMC with shared memory, we can achieve superior performance for a common
>     socket-based application[5]:
>       - latency reduced by about 50%
>       - throughput increased by about 300%
>       - CPU consumption reduced by about 50%
>
>     Since there is no particularly suitable shared memory management solution
>     matches the need for SMC(See ## Comparison with existing technology), and
>     virtio is the standard for communication in the virtualization world, we
>     want to implement a virtio-ism device based on virtio, which can support
>     on-demand memory sharing across VMs, containers or VM-container. To match
>     the needs of SMC, the virtio-ism device need to support:
>
>     1. Dynamic provision: shared memory regions are dynamically allocated and
>        provisioned.
>     2. Multi-region management: the shared memory is divided into regions,
>        and a peer may allocate one or more regions from the same shared memory
>        device.
>     3. Permission control: the permission of each region can be set seperately.
>     4. Dynamic connection: each ism region of a device can be shared with
>        different devices, eventually a device can be shared with thousands of
>        devices
>
> # Virtio ISM device
>
>     ISM devices provide the ability to share memory between different guests on
>     a host. A guest's memory got from ism device can be shared with multiple
>     peers at the same time. This shared relationship can be dynamically created
>     and released.
>
>     The shared memory obtained from the device is divided into multiple ism
>     regions for share. ISM device provides a mechanism to notify other ism
>     region referrers of content update events.
>
> ## Design
>
>     This is a structure diagram based on ism sharing between two vms.
>
>     |-------------------------------------------------------------------------------------------------------------|
>     | |------------------------------------------------|       |------------------------------------------------| |
>     | | Guest                                          |       | Guest                                          | |
>     | |                                                |       |                                                | |
>     | |   ----------------                             |       |   ----------------                             | |
>     | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
>     | |   ----------------       |      |      |       |       |   ----------------               |      |      | |
>     | |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
>     | |    |  |                  |      |      |       |       |    |  |                          |      |      | |
>     | |    |  |                -------------------     |       |    |  |                --------------------    | |
>     | |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
>     | |    |  |                -------------------     |       |    |  |                --------------------    | |
>     | |                                |               |       |                               |                | |
>     | |                                |               |       |                               |                | |
>     | | Qemu                           |               |       | Qemu                          |                | |
>     | |--------------------------------+---------------|       |-------------------------------+----------------| |
>     |                                  |                                                       |                  |
>     |                                  |                                                       |                  |
>     |                                  |------------------------------+------------------------|                  |
>     |                                                                 |                                           |
>     |                                                                 |                                           |
>     |                                                   --------------------------                                |
>     |                                                    | M1 |   | M2 |   | M3 |                                 |
>     |                                                   --------------------------                                |
>     |                                                                                                             |
>     | HOST                                                                                                        |
>     ---------------------------------------------------------------------------------------------------------------
>
> ## Inspiration
>
>     Our design idea for virtio-ism comes from IBM's ISM device, to pay tribute,
>     we directly name this device "ism".
>
>     Information about IBM ism device and SMC:
>       1. SMC reference: https://www.ibm.com/docs/en/zos/2.5.0?topic=system-shared-memory-communications
>       2. SMC-Dv2 and ISMv2 introduction: https://www.newera.com/INFO/SMCv2_Introduction_10-15-2020.pdf
>       3. ISM device: https://www.ibm.com/docs/en/linux-on-systems?topic=n-ism-device-driver-1
>       4. SMC protocol (including SMC-D): https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202_2.pdf
>       5. SMC-D FAQ: https://www.ibm.com/support/pages/system/files/inline-files/2021-02-09-SMC-D-FAQ.pdf
>
> ## ISM VLAN
>
>     Since SMC uses TCP to handshake with IP facilities, virtio-ism device is not
>     bound to existing IP device, and the latest ISMv2 device doesn't require
>     VLAN. So it is not necessary for virtio-ism to support VLAN attributes.
>
> ## Live Migration
>
>     Currently SMC-D doesn't support migration to another device or fallback. And
>     SMC-R supports migration to another link, no fallback.
>
>     So we may not support live migration for the time being.
>
> ## About hot plugging of the ism device
>
>     Hot plugging of devices is a heavier, possibly failed, time-consuming, and
>     less scalable operation. So, we don't plan to support it for now.
>
>
> # Usage (SMC as example)
>
>     There is one of possible use cases:
>
>     1. SMC calls the interface ism_alloc_region() of the ism driver to return
>        the location of a memory region in the PCI space and a token.
>     2. The ism driver mmap the memory region and return to SMC with the token
>     3. SMC passes the token to the connected peer
>     4. the peer calls the ism driver interface ism_attach_region(token) to
>        get the location of the PCI space of the shared memory
>     5. The connected pair communicating through the shared memory
>
> # Comparison with existing technology
>
> ## ivshmem or ivshmem 2.0 of Qemu
>
>    1. ivshmem 1.0 is a large piece of memory that can be seen by all devices
>       that use this VM, so the security is not enough.
>
>    2. ivshmem 2.0 is a shared memory belonging to a VM that can be read-only by
>       all other VMs that use the ivshmem 2.0 shared memory device, which also
>       does not meet our needs in terms of security.
>
> ## vhost-pci and virtiovhostuser
>
>     1. does not support dynamic allocation
>     2. one device just support connect to one vm
>
>
> # POC CODE
> ## Qemu:
>         https://github.com/fengidri/qemu/compare/7422cd20c4780ccdc7395d2dfaee33cb7d246d43...ism?expand=1
>
>     Start qemu with option "--device virtio-ism-pci,disable-legacy=on, disable-modern=off".
>
> ##  Kernel (ism driver and smc support):
>         https://github.com/fengidri/linux-kernel-virtio-ism/compare/6f8101eb21bab480537027e62c4b17021fb7ea5d...xuanzhuo/smc-d-virtio-ism
>
>     There are three modules:
>
>         virtio-ism.ko
>         virtio-ism-smc.ko
>         virtio-ism-dev.ko.
>
>     The latter two modules depend on the first one.
>
>     virtio-ism-smc.ko virtio-ism-dev.ko should not be used at the same time.
>
> ### virtio-ism-smc.ko
>     Support SMC-D works with virtio-ism.
>
>     Use SMC with virtio-ism to accelerate inter-VM communication.
>
>     1. insmod virtio-ism-smc module, this module bridges SMC and virio-ism.
>     2. use smc-tools [1] to get the device name of SMC-D based on virtio-ism.
>
>       $ smcd d # here is _virtio2_
>       FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>       0000 0     virtio2       0000   Yes       1  *C1
>
>     3. add the nic and SMC-D device to the same pnet, do it in both client and server.
>
>       $ smc_pnet -a -I eth1 c1 # use eth1 to setup SMC connection
>       $ smc_pnet -a -D virtio2 c1 # virtio2 is the virtio-ism device
>
>     4. use SMC to accelerate your application, smc_run in [1] can do this.
>
>       # smc_run use LD_PRELOAD to hijack socket syscall with AF_SMC
>       $ smc_run sockperf server --tcp # run in server
>       $ smc_run sockperf tp --tcp -i a.b.c.d # run in client
>
>     [1] https://github.com/ibm-s390-linux/smc-tools
>
>     Notice: The current POC state, we only tested some basic functions.
>
> ### virtio-ism-dev.ko
>     Provide /dev/virtio-ism interface, allow users to use Virtio-ISM device
>     directly.
>
>     Try tools/virtio/virtio-ism/virtio-ism-mmap.c
>
>     Usage:
>          insmod virtio-ism-dev module.
>
>          vm1: virtio-ism-mmap alloc -> token
>          vm2: virtio-ism-mmap attach <token>
>
>          vm1 will write to shared memory, then notify vm2.
>          After vm2 receive notify, then read from shared memory.
>
>
> # References
>
>     [1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.html
>     [2] https://dl.acm.org/doi/10.1145/2847562
>     [3] https://hal.archives-ouvertes.fr/hal-00368622/document
>     [4] https://lwn.net/Articles/711071/
>     [5] https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@linux.alibaba.com/T/
>
>
> If there are any problems, please point them out.
> Hope to hear from you, thank you.
>
> v1:
>    1. cover letter adding explanation of ism vlan
>    2. spec add gid
>    3. explain the source of ideas about ism
>    4. POC support virtio-ism-smc.ko virtio-ism-dev.ko and support virtio-ism-mmap
>
>
> Xuan Zhuo (2):
>   Reserve device id for ISM device
>   virtio-ism: introduce new device virtio-ism
>
>  content.tex    |   3 +
>  virtio-ism.tex | 350 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 353 insertions(+)
>  create mode 100644 virtio-ism.tex
>
> --
> 2.32.0.3.g01195cf9f
>

