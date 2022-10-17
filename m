Return-Path: <virtio-dev-return-10024-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 300FC986301
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Oct 2022 07:47:30 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Mon, 17 Oct 2022 15:47:22 +0800
Message-Id: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared memory device
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hello everyone,

# Background

Nowadays, there is a common scenario to accelerate communication between
different VMs and containers, including light weight virtual machine based
containers. One way to achieve this is to colocate them on the same host.
However, the performance of inter-VM communication through network stack is=
 not
optimal and may also waste extra CPU cycles. This scenario has been discuss=
ed
many times, but still no generic solution available [1] [2] [3].

With pci-ivshmem + SMC(Shared Memory Communications: [4]) based PoC[5],
We found that by changing the communication channel between VMs from TCP to=
 SMC
with shared memory, we can achieve superior performance for a common
socket-based application[5]:
  - latency reduced by about 50%
  - throughput increased by about 300%
  - CPU consumption reduced by about 50%

Since there is no particularly suitable shared memory management solution
matches the need for SMC(See ## Comparison with existing technology), and v=
irtio
is the standard for communication in the virtualization world, we want to
implement a virtio-ism device based on virtio, which can support on-demand
memory sharing across VMs, containers or VM-container. To match the needs o=
f SMC,
the virtio-ism device need to support:

1. Dynamic provision: shared memory regions are dynamically allocated and
   provisioned.
2. Multi-region management: the shared memory is divided into regions,
   and a peer may allocate one or more regions from the same shared memory
   device.
3. Permission control: The permission of each region can be set seperately.

# Virtio ism device

ISM devices provide the ability to share memory between different guests on=
 a
host. A guest's memory got from ism device can be shared with multiple peer=
s at
the same time. This shared relationship can be dynamically created and rele=
ased.

The shared memory obtained from the device is divided into multiple ism reg=
ions
for share. ISM device provides a mechanism to notify other ism region refer=
rers
of content update events.

# Usage (SMC as example)

Maybe there is one of possible use cases:

1. SMC calls the interface ism_alloc_region() of the ism driver to return t=
he
   location of a memory region in the PCI space and a token.
2. The ism driver mmap the memory region and return to SMC with the token
3. SMC passes the token to the connected peer
3. the peer calls the ism driver interface ism_attach_region(token) to
   get the location of the PCI space of the shared memory


# About hot plugging of the ism device

   Hot plugging of devices is a heavier, possibly failed, time-consuming, a=
nd
   less scalable operation. So, we don't plan to support it for now.

# Comparison with existing technology

## ivshmem or ivshmem 2.0 of Qemu

   1. ivshmem 1.0 is a large piece of memory that can be seen by all device=
s that
   use this VM, so the security is not enough.

   2. ivshmem 2.0 is a shared memory belonging to a VM that can be read-onl=
y by all
   other VMs that use the ivshmem 2.0 shared memory device, which also does=
 not
   meet our needs in terms of security.

## vhost-pci and virtiovhostuser

   Does not support dynamic allocation and therefore not suitable for SMC.

# Design

   This is a structure diagram based on ism sharing between two vms.

    |----------------------------------------------------------------------=
---------------------------------------|
    | |------------------------------------------------|       |-----------=
-------------------------------------| |
    | | Guest                                          |       | Guest     =
                                     | |
    | |                                                |       |           =
                                     | |
    | |   ----------------                             |       |   --------=
--------                             | |
    | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    dri=
ver    |             [M2]   [M3]     | |
    | |   ----------------       |      |      |       |       |   --------=
--------               |      |      | |
    | |    |cq|                  |map   |map   |map    |       |    |cq|   =
                       |map   |map   | |
    | |    |  |                  |      |      |       |       |    |  |   =
                       |      |      | |
    | |    |  |                -------------------     |       |    |  |   =
             --------------------    | |
    | |----|--|----------------|  device memory  |-----|       |----|--|---=
-------------|  device memory   |----| |
    | |    |  |                -------------------     |       |    |  |   =
             --------------------    | |
    | |                                |               |       |           =
                    |                | |
    | |                                |               |       |           =
                    |                | |
    | | Qemu                           |               |       | Qemu      =
                    |                | |
    | |--------------------------------+---------------|       |-----------=
--------------------+----------------| |
    |                                  |                                   =
                    |                  |
    |                                  |                                   =
                    |                  |
    |                                  |------------------------------+----=
--------------------|                  |
    |                                                                 |    =
                                       |
    |                                                                 |    =
                                       |
    |                                                   -------------------=
-------                                |
    |                                                    | M1 |   | M2 |   =
| M3 |                                 |
    |                                                   -------------------=
-------                                |
    |                                                                      =
                                       |
    | HOST                                                                 =
                                       |
    -----------------------------------------------------------------------=
----------------------------------------

# POC code

   Kernel: https://github.com/fengidri/linux-kernel-virtio-ism/commits/ism
   Qemu:   https://github.com/fengidri/qemu/commits/ism

If there are any problems, please point them out.

Hope to hear from you, thank you.

[1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.html
[2] https://dl.acm.org/doi/10.1145/2847562
[3] https://hal.archives-ouvertes.fr/hal-00368622/document
[4] https://lwn.net/Articles/711071/
[5] https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@linux.alib=
aba.com/T/


Xuan Zhuo (2):
  Reserve device id for ISM device
  virtio-ism: introduce new device virtio-ism

 content.tex    |   3 +
 virtio-ism.tex | 340 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 343 insertions(+)
 create mode 100644 virtio-ism.tex

--
2.32.0.3.g01195cf9f


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

