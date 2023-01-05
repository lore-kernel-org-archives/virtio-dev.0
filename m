Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1672917622.6090338-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 0/1] introduce virtio-ism: internal shared memory device
Date: Thu, 5 Jan 2023 19:20:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221223081939.26506-1-xuanzhuo@linux.alibaba.com>
 <c572aa1f-e2a9-721e-5389-aec605fc439f@linux.ibm.com>
 <88bdae7b-4ee0-8da8-5bb7-473957002bbe@linux.ibm.com>
In-Reply-To: <88bdae7b-4ee0-8da8-5bb7-473957002bbe@linux.ibm.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 4 Jan 2023 14:52:10 +0100, Alexandra Winter <wintera@linux.ibm.com> wrote:
>
>
>
> On 23.12.22 09:19, Xuan Zhuo wrote:
> > Hello everyone,
> >
> > # Background
> >
> >     Nowadays, there is a common scenario to accelerate communication between
> >     different VMs and containers, including light weight virtual machine based
> >     containers. One way to achieve this is to colocate them on the same host.
> >     However, the performance of inter-VM communication through network stack is
> >     not optimal and may also waste extra CPU cycles. This scenario has been
> >     discussed many times, but still no generic solution available [1] [2] [3].
> >
> >     With pci-ivshmem + SMC(Shared Memory Communications: [4]) based PoC[5],
> >     We found that by changing the communication channel between VMs from TCP to
> >     SMC with shared memory, we can achieve superior performance for a common
> >     socket-based application[5]:
> >       - latency reduced by about 50%
> >       - throughput increased by about 300%
> >       - CPU consumption reduced by about 50%
> >
> >     Since there is no particularly suitable shared memory management solution
> >     matches the need for SMC(See ## Comparison with existing technology), and
> >     virtio is the standard for communication in the virtualization world, we
> >     want to implement a virtio-ism device based on virtio, which can support
> >     on-demand memory sharing across VMs, containers or VM-container. To match
> >     the needs of SMC, the virtio-ism device need to support:
> >
> >     1. Dynamic provision: shared memory regions are dynamically allocated and
> >        provisioned.
> >     2. Multi-region management: the shared memory is divided into regions,
> >        and a peer may allocate one or more regions from the same shared memory
> >        device.
> >     3. Permission control: the permission of each region can be set seperately.
> >     4. Dynamic connection: each ism region of a device can be shared with
> >        different devices, eventually a device can be shared with thousands of
> >        devices
> >
> > # Virtio ISM device
> >
> >     ISM devices provide the ability to share memory between different guests on
> >     a host. A guest's memory got from ism device can be shared with multiple
> >     peers at the same time. This shared relationship can be dynamically created
> >     and released.
> >>     The shared memory obtained from the device is divided into multiple ism
> >     regions for share. ISM device provides a mechanism to notify other ism
> >     region referrers of content update events.


Thank you very much for your reply.

>
> As this should work with SMC-D, let me point out some aspect of the ISM devices we use today:
>
> 1) Owner-User
> For such a memory region one peer is the owner and the other peer is the user.
> I don't see that in your diagram below. Maybe you could point that out more clearly.

Indeed, we only emphasize the creator. After the creation, all the references of
this region are similar.

The user's management authority for region is reflected through permission, and
this permissions can be transferred to other users.


> I think the concept of user and owner simplifies device management (reset, recovery, etc..) and is
> useful for other scenarios that use ISM as well.

Can you be more specific? What is the benefit of the concept of owner for
device management?

> After reading the whole thread, it seems to me that you propose a 'single owner, multiple
> users' scenario, do I understand this correctly?

Yes, we allow the scenes of multiple users.

> Then SMC-D would use a subset of 'single owner-single user' which is fine.
>
>
> 2) unidirectional buffers (memory regions)
> For the ISM devices today only the user writes into the memory region and the owner only reads
> from this memory region. This suits the SMC-D usecase and probably maximises performance in
> other usecases as well.
> So for compatibility, I would ask that the virtio-ism spec does not mandate to provide for
> bidirectional usage of the memory regions. It should suffice, if the user can write and
> the owner can read.

I think there will be bidirectional write or creator-write scenes.

SMC-D can be set up based on permission to read only for creator.


>
> 3) Memory provided by the owner
> In your diagram it seems that the hipervisor provides the memory for the buffers.
> That puts the burden of providing enough memory or the risk of OOM on the Hipervisor
> which is kind of unfair. In case of memory shortage this results in a first-come-first-serve
> race.
> We thought it more suitable that the instances that use ISM
> (the owners of the buffers) provide for the memory. Then they can make the tradeoff
> of memory for performance and do not impact other connections.


Good Point.

Indeed, it is a fair solution provided by creator.

Our design considers that a user may maliciously occupys a region from other vm.

When creator allocated a memory from the guest and it is attached by one
maliciously user, this user may not release the reference normally after the
connection (may not smc connection) is closed.

If the region is provided by hypervisor, other user (including creator) can
directly detach the region. And if one vm takes up too much regions, hypervisor
can prevent this VM from alloc/attach new region.

Thanks.


>
> >
> > ## Design
> >
> >     This is a structure diagram based on ism sharing between two vms.
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
> > ## Inspiration
> >
> >     Our design idea for virtio-ism comes from IBM's ISM device, to pay tribute,
> >     we directly name this device "ism".
> >
> >     Information about IBM ism device and SMC:
> >       1. SMC reference: https://www.ibm.com/docs/en/zos/2.5.0?topic=system-shared-memory-communications
> >       2. SMC-Dv2 and ISMv2 introduction: https://www.newera.com/INFO/SMCv2_Introduction_10-15-2020.pdf
> >       3. ISM device: https://www.ibm.com/docs/en/linux-on-systems?topic=n-ism-device-driver-1
> >       4. SMC protocol (including SMC-D): https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202_2.pdf
> >       5. SMC-D FAQ: https://www.ibm.com/support/pages/system/files/inline-files/2021-02-09-SMC-D-FAQ.pdf
> >
> > ## ISM VLAN
> >
> >     Since SMC uses TCP to handshake with IP facilities, virtio-ism device is not
> >     bound to existing IP device, and the latest ISMv2 device doesn't require
> >     VLAN. So it is not necessary for virtio-ism to support VLAN attributes.
> >
> > ## Live Migration
> >
> >     Currently SMC-D doesn't support migration to another device or fallback. And
> >     SMC-R supports migration to another link, no fallback.
> >
> >     So we may not support live migration for the time being.
> >
> > ## About hot plugging of the ism device
> >
> >     Hot plugging of devices is a heavier, possibly failed, time-consuming, and
> >     less scalable operation. So, we don't plan to support it for now.
> >
> >
> > # Usage (SMC as example)
> >
> >     There is one of possible use cases:
> >
> >     1. SMC calls the interface ism_alloc_region() of the ism driver to return
> >        the location of a memory region in the PCI space and a token.
> >     2. The ism driver mmap the memory region and return to SMC with the token
> >     3. SMC passes the token to the connected peer
> >     4. the peer calls the ism driver interface ism_attach_region(token) to
> >        get the location of the PCI space of the shared memory
> >     5. The connected pair communicating through the shared memory
> >
> > # Comparison with existing technology
> >
> > ## ivshmem or ivshmem 2.0 of Qemu
> >
> >    1. ivshmem 1.0 is a large piece of memory that can be seen by all devices
> >       that use this VM, so the security is not enough.
> >
> >    2. ivshmem 2.0 is a shared memory belonging to a VM that can be read-only by
> >       all other VMs that use the ivshmem 2.0 shared memory device, which also
> >       does not meet our needs in terms of security.
> >
> > ## vhost-pci and virtiovhostuser
> >
> >     1. does not support dynamic allocation
> >     2. one device just support connect to one vm
> >
> >
> > # POC CODE
> >
> > There are no functions related to eventq and perm yet.
> >
> > ## Qemu (virtio ism device):
> >
> >      https://github.com/fengidri/qemu/compare/7d66b74c4dd0d74d12c1d3d6de366242b13ed76d...ism-upstream-1216?expand=1
> >
> >     Start qemu with option "--device virtio-ism-pci,disable-legacy=on, disable-modern=off".
> >
> > ##  Kernel (virtio ism driver and smc support):
> >
> >      https://github.com/fengidri/linux-kernel-virtio-ism/compare/6f8101eb21bab480537027e62c4b17021fb7ea5d...ism-upstream-1223
> >
> >
> > ### SMC
> >
> >     Support SMC-D works with virtio-ism.
> >
> >     Use SMC with virtio-ism to accelerate inter-VM communication.
> >
> >     1. insmod virtio-ism and smc module.
> >     2. use smc-tools [1] to get the device name of SMC-D based on virtio-ism.
> >
> >       $ smcd d # here is _virtio2_
> >       FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
> >       0000 0     virtio2       0000   Yes       1  *C1
> >
> >     3. add the nic and SMC-D device to the same pnet, do it in both client and server.
> >
> >       $ smc_pnet -a -I eth1 c1 # use eth1 to setup SMC connection
> >       $ smc_pnet -a -D virtio2 c1 # virtio2 is the virtio-ism device
> >
> >     4. use SMC to accelerate your application, smc_run in [1] can do this.
> >
> >       # smc_run use LD_PRELOAD to hijack socket syscall with AF_SMC
> >       $ smc_run sockperf server --tcp # run in server
> >       $ smc_run sockperf tp --tcp -i a.b.c.d # run in client
> >
> >     [1] https://github.com/ibm-s390-linux/smc-tools
> >
> >     Notice: The current POC state, we only tested some basic functions.
> >
> > ### App inside user space
> >
> >     The ism driver provide /dev/vismX interface, allow users to use Virtio-ISM
> >     device in user space directly.
> >
> >     Try tools/virtio/virtio-ism/virtio-ism-mmap
> >
> >     Usage:
> >          cd tools/virtio/virtio-ism/; make
> >          insmode virtio-ism.ko
> >
> >     case1: communicate
> >
> >        vm1: ./virtio-ism-mmap alloc -> token
> >        vm2: ./virtio-ism-mmap attach -t <token> --write-msg AAAA --commit
> >
> >        vm2 will write msg to shared memory, then notify vm1. After vm1 receive
> >        notify, then read from shared memory.
> >
> >     case2: ping-pong test.
> >
> >         vm1: ./virtio-ism-mmap server
> >         vm2: ./virtio-ism-mmap -i 192.168.122.101 pp
> >
> >         1. server alloc one ism region
> >         2. client get the token by tcp
> >
> >         3. client commit(kick) to server, server recv notify, commit(kick) to client
> >         4. loop #3
> >
> >     case3: throughput test.
> >
> >         vm1: ./virtio-ism-mmap server
> >         vm2: ./virtio-ism-mmap -i 192.168.122.101 tp
> >
> >         1. server alloc one ism region
> >         2. client get the token by tcp
> >
> >         3. client write 1M data to ism region
> >         4. client commit(kick) to server
> >         5. server recv notify, copy the data, the commit(kick) back to client
> >         6. loop #3-#5
> >
> >     case4: throughput test with protocol defined by user.
> >
> >         vm1: ./virtio-ism-mmap server
> >         vm2: ./virtio-ism-mmap -i 192.168.122.101 tp --polling --tp-chunks 15 --msg-size 64k -n 50000
> >
> >         Used the ism region as a ring.
> >
> >         In this scene, client and server are in the polling mode. Test it on
> >         my machine, the maximum can reach 12GBps
> >
> > # References
> >
> >     [1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.html
> >     [2] https://dl.acm.org/doi/10.1145/2847562
> >     [3] https://hal.archives-ouvertes.fr/hal-00368622/document
> >     [4] https://lwn.net/Articles/711071/
> >     [5] https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@linux.alibaba.com/T/
> >
> >
> > If there are any problems, please point them out.
> > Hope to hear from you, thank you.
> >
> > v2:
> >    1. add Attach/Detach event
> >    2. add Events Filter
> >    3. allow Alloc/Attach huge region
> >    4. remove host/guest terms
> >
> > v1:
> >    1. cover letter adding explanation of ism vlan
> >    2. spec add gid
> >    3. explain the source of ideas about ism
> >    4. POC support virtio-ism-smc.ko virtio-ism-dev.ko and support virtio-ism-mmap
> >
> >
> > Xuan Zhuo (1):
> >   virtio-ism: introduce new device virtio-ism
> >
> >  conformance.tex |  24 +++
> >  content.tex     |   1 +
> >  virtio-ism.tex  | 472 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 497 insertions(+)
> >  create mode 100644 virtio-ism.tex
> >

