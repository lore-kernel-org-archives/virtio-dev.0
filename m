Return-Path: <virtio-dev-return-12752-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6687BC7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 08:09:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B57504290E
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 08:09:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B17F6986702
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 08:09:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A691C9866F8; Thu, 18 May 2023 08:09:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 920719866F7;
	Thu, 18 May 2023 08:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Viw103m_1684397359;
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtio-comment@lists.oasis-open.org
Cc: hans@linux.alibaba.com,
	herongguang@linux.alibaba.com,
	zmlcc@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	zhenzao@linux.alibaba.com,
	helinguo@linux.alibaba.com,
	gerry@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	mst@redhat.com,
	cohuck@redhat.com,
	jasowang@redhat.com,
	Jan Kiszka <jan.kiszka@siemens.com>,
	wintera@linux.ibm.com,
	kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	hca@linux.ibm.com,
	twinkler@linux.ibm.com,
	raspl@linux.ibm.com,
	virtio-dev@lists.oasis-open.org,
	pasic@linux.ibm.com
Date: Thu, 18 May 2023 16:09:18 +0800
Message-Id: <20230518080919.48797-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 7478fa9
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v4 0/1] introduce virtio-ism: internal shared memory device

Hello everyone,

# Background

    Nowadays, there is a common scenario to accelerate communication between
    different VMs and containers, including light weight virtual machine based
    containers. One way to achieve this is to colocate them on the same host.
    However, the performance of inter-VM communication through network stack is
    not optimal and may also waste extra CPU cycles. This scenario has been
    discussed many times, but still no generic solution available [1] [2] [3].

    We also have a lot of such scenarios internally, except for general network
    communication, there are also many application scenarios of shared
    memory. Due to various reasons, it is difficult for us to realize these
    business data using network communication. For example, in some scenarios,
    the application needs to exchange a large amount of data with the physical
    device on the host, so shared memory is the most suitable solution.

    Shared memory is an efficient communication method, so we hope to implement
    a cross-vm shared memory method. We were inspired by the IBM ism device[4],
    we use virtio-ism to achieve memory sharing between vm on the same host.

# virtio-ism

    An ISM(Internal Shared Memory) device provides the ability to access memory
    shared between multiple devices. This allows low-overhead communication in
    presence of such memory. For example, memory can be shared with guests of
    multiple virtual machines running on the same host, with each virtual
    machine including an ism device and with the guests getting the shared
    memory by the ism devices.

    An ism device can communicate with multiple peers simultaneously. This
    communication can be dynamically started and ended.

    This is a structure diagram based on ism sharing between two vms.

    |-------------------------------------------------------------------------------------------------------------|
    | |------------------------------------------------|       |------------------------------------------------| |
    | | Guest                                          |       | Guest                                          | |
    | |                                                |       |                                                | |
    | |   ----------------                             |       |   ----------------                             | |
    | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
    | |   ----------------       |      |      |       |       |   ----------------               |      |      | |
    | |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
    | |    |  |                  |      |      |       |       |    |  |                          |      |      | |
    | |    |  |                -------------------     |       |    |  |                --------------------    | |
    | |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
    | |    |  |                -------------------     |       |    |  |                --------------------    | |
    | |                                |               |       |                               |                | |
    | |                                |               |       |                               |                | |
    | | Qemu                           |               |       | Qemu                          |                | |
    | |--------------------------------+---------------|       |-------------------------------+----------------| |
    |                                  |                                                       |                  |
    |                                  |                                                       |                  |
    |                                  |------------------------------+------------------------|                  |
    |                                                                 |                                           |
    |                                                                 |                                           |
    |                                                   --------------------------                                |
    |                                                    | M1 |   | M2 |   | M3 |                                 |
    |                                                   --------------------------                                |
    |                                                                                                             |
    | HOST                                                                                                        |
    ---------------------------------------------------------------------------------------------------------------

    On the top, we found that for the existing tcp network communication
    scenario, if it is replaced with smc + shared memory, a great performance
    improvement can also be obtained. And for smc, user processes just need to
    do little modification.
      - latency reduced by about 50%
      - throughput increased by about 300%
      - CPU consumption reduced by about 50%

    Since there is no particularly suitable shared memory management solution
    matches the need for SMC(See ## Comparison with existing technology), and
    virtio is the standard for communication in the virtualization world, we
    want to implement a virtio-ism device based on virtio, which can support
    on-demand memory sharing across VMs, containers or VM-container. To match
    the needs of SMC, the virtio-ism device need to support:

    1. Dynamic provision: shared memory regions are dynamically allocated and
       provisioned.
    2. Multi-region management: the shared memory is divided into regions,
       and a peer may allocate one or more regions from the same shared memory
       device.
    3. Permission control: the permission of each region can be set separately.
    4. Dynamic connection: each ism region of a device can be shared with
       different devices, eventually a device can be shared with thousands of
       devices

## Live Migration

    If two VMs is migrated from the same host to two different physical hosts,
    it is impossible to share memory, so we will not consider supporting
    migration for the time being.

# Comparison with existing technology

## ivshmem or ivshmem 2.0 of Qemu

   1. ivshmem 1.0 is a large piece of memory that can be seen by all devices
      that use this VM, so the security is not enough.

   2. ivshmem 2.0 is a shared memory belonging to a VM that can be read-only by
      all other VMs that use the ivshmem 2.0 shared memory device, which also
      does not meet our needs in terms of security.

## vhost-pci and virtiovhostuser

    1. does not support dynamic allocation
    2. one device just support connect to one vm

# Usage
    This is the usage steps by the user process.

    |                                                | user process syscall                     | driver to device
 ---|------------------------------------------------|------------------------------------------|-------------------------------
  1 | got memory and token                           | ioctl(fd, VIRTIO_ISM_IOCTL_ALLOC, &ctl)  | VIRTIO_ISM_CTRL_ALLOC_REGION
 ---|------------------------------------------------|------------------------------------------|-------------------------------
  2 | send token to peer process                     |                                          |
 ---|------------------------------------------------|------------------------------------------|-------------------------------
  3 | got shared memory(two process share the memory)| ioctl(fd, VIRTIO_ISM_IOCTL_ATTACH, &ctl) | VIRTIO_ISM_CTRL_ATTACH_REGION
 ---|------------------------------------------------|------------------------------------------|-------------------------------
  4 | notify peer process                            | ioctl(fd, VIRTIO_ISM_IOCTL_KICK)         | write notify area
 ---|------------------------------------------------|------------------------------------------|-------------------------------
  5 | receive notify from other process              | wakeup by select/epoll/....              | driver recv interrupt
 ---|------------------------------------------------|------------------------------------------|-------------------------------
  6 | release the reference to the shared memory     | ioctl(fd, VIRTIO_ISM_IOCTL_DETACH, &ctl) | VIRTIO_ISM_CTRL_DETACH_REGION
 ---|------------------------------------------------|------------------------------------------|-------------------------------

# POC CODE

    There are no functions related to eventq and perm yet.
    This implementation is for V2 version spec. So some details are not match
    this version.

    Qemu   (virtio ism device): https://github.com/fengidri/qemu/compare/7d66b74c4dd0d74d12c1d3d6de366242b13ed76d...ism-upstream-1216?expand=1
    Kernel (virtio ism driver): https://github.com/fengidri/linux-kernel-virtio-ism/compare/6f8101eb21bab480537027e62c4b17021fb7ea5d...ism-upstream-1223

    Start qemu with option "--device virtio-ism-pci,disable-legacy=on, disable-modern=off".

### User Space APP

    The ism driver provide /dev/vismX interface, allow users to use Virtio-ISM
    device in user space directly.

    Try tools/virtio/virtio-ism/virtio-ism-mmap

    Usage:
         cd tools/virtio/virtio-ism/; make
         insmode virtio-ism.ko

    case1: communicate

       vm1: ./virtio-ism-mmap alloc -> token
       vm2: ./virtio-ism-mmap attach -t <token> --write-msg AAAA --commit

       vm2 will write msg to shared memory, then notify vm1. After vm1 receive
       notify, then read from shared memory.

    case2: ping-pong test.

        vm1: ./virtio-ism-mmap server
        vm2: ./virtio-ism-mmap -i 192.168.122.101 pp

        1. server alloc one ism region
        2. client get the token by tcp

        3. client commit(kick) to server, server recv notify, commit(kick) to client
        4. loop #3

    case3: throughput test.

        vm1: ./virtio-ism-mmap server
        vm2: ./virtio-ism-mmap -i 192.168.122.101 tp

        1. server alloc one ism region
        2. client get the token by tcp

        3. client write 1M data to ism region
        4. client commit(kick) to server
        5. server recv notify, copy the data, the commit(kick) back to client
        6. loop #3-#5

    case4: throughput test with protocol defined by user.

        vm1: ./virtio-ism-mmap server
        vm2: ./virtio-ism-mmap -i 192.168.122.101 tp --polling --tp-chunks 15 --msg-size 64k -n 50000

        Used the ism region as a ring.

        In this scene, client and server are in the polling mode. Test it on
        my machine, the maximum can reach 12GBps

## About smc with virtio-ism

    At present, my colleagues are advancing the work of this area, and have
    contacted IBM's developers, but smc may need to do some modification, which
    may involve some complicated things, please give them more time.

# References

    [1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.html
    [2] https://dl.acm.org/doi/10.1145/2847562
    [3] https://hal.archives-ouvertes.fr/hal-00368622/document
    [4] Information about IBM ism device and SMC:
            1. SMC reference: https://www.ibm.com/docs/en/zos/2.5.0?topic=system-shared-memory-communications
            2. SMC-Dv2 and ISMv2 introduction: https://www.newera.com/INFO/SMCv2_Introduction_10-15-2020.pdf
            3. ISM device: https://www.ibm.com/docs/en/linux-on-systems?topic=n-ism-device-driver-1
            4. SMC protocol (including SMC-D): https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202_2.pdf
            5. SMC-D FAQ: https://www.ibm.com/support/pages/system/files/inline-files/2021-02-09-SMC-D-FAQ.pdf


If there are any problems, please point them out.
Hope to hear from you, thank you.

v4:
   1. reorganize the structure of the spec
   2. fix some problems

v3:
   1. support to apply memory from vm
   2. add query operation
   3. optimize the description of spec and enrich some details
   4. use the communication domain as a term
   5. replace gid with cdid

v2:
   1. add Attach/Detach event
   2. add Events Filter
   3. allow Alloc/Attach huge region
   4. remove host/guest terms

v1:
   1. cover letter adding explanation of ism vlan
   2. spec add gid
   3. explain the source of ideas about ism
   4. POC support virtio-ism-smc.ko virtio-ism-dev.ko and support virtio-ism-mmap



Xuan Zhuo (1):
  virtio-ism: introduce new device virtio-ism

 conformance.tex                         |   2 +
 content.tex                             |   1 +
 device-types/ism/description.tex        | 591 ++++++++++++++++++++++++
 device-types/ism/device-conformance.tex |  17 +
 device-types/ism/driver-conformance.tex |  13 +
 device-types/ism/layout-pic.tex         | 112 +++++
 virtio-html.tex                         |   9 +
 virtio.tex                              |   9 +
 8 files changed, 754 insertions(+)
 create mode 100644 device-types/ism/description.tex
 create mode 100644 device-types/ism/device-conformance.tex
 create mode 100644 device-types/ism/driver-conformance.tex
 create mode 100644 device-types/ism/layout-pic.tex

-- 
2.32.0.3.g01195cf9f


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

