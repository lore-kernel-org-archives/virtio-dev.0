Return-Path: <virtio-dev-return-12272-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6629C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 08:01:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F19187DD6A
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 08:01:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD4909863E3
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 08:01:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B50D4983EBE; Tue, 18 Apr 2023 08:01:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1884984043
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 08:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgOc5IF_1681804856;
Message-ID: <1681804788.7404423-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 18 Apr 2023 15:59:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
Cc: Daniel Raho <s.raho@virtualopensystems.com>,
 Michele Paolino <m.paolino@virtualopensystems.com>,
 Alvise Rigo <a.rigo@virtualopensystems.com>,
 chou.kensou@jp.panasonic.com,
 wminer@linuxfoundation.org,
 stefanha@redhat.com,
 virtio-dev@lists.oasis-open.org
References: <CANN35wLsm_RTTKmxFz5jcBujoxfjPwsu37FAw9+W58hjt_nVPQ@mail.gmail.com>
In-Reply-To: <CANN35wLsm_RTTKmxFz5jcBujoxfjPwsu37FAw9+W58hjt_nVPQ@mail.gmail.com>
Subject: Re: [virtio-dev] Virtio-loopback: PoC of a new Hardware Abstraction Layer for non-Hypervisor environments based on Virtio

On Thu, 13 Apr 2023 16:35:59 +0300, Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com> wrote:
> Dear virtio-dev community,
>
> I would like to introduce you Virtio-loopback, Proof of Concept (PoC) that
> we have been working on at Virtual Open Systems in the context of the
> Automotive Grade Linux community (Virtualization & Containers expert
> group - EG-VIRT).
>
> We consider this work as a PoC and we are not currently planning
> upstream. However, if the zero-copy or any other aspect of this work
> is interesting for other Virtio implementations, we would be glad to
> discuss more.

What is the difference between this and vduse?

Thanks.

>
> Overview:
> ---------
>
> Virtio-loopback is a new hardware abstraction layer designed for
> non-Hypervisor
> environments based on virtio. The main objective is to enable applications
> communication with vhost-user devices in a non-hypervisor environment.
>
> More in details, Virtio-loopback's design consists of a new transport
> (Virtio-loopback), a user-space daemon (Adapter), and a vhost-user device.
> The data path has been implemented using the "zero-copy" principle, where
> vhost-user devices access virtqueues directly in the kernel space. This
> first
> implementation supports multi-queues, does not require virtio-protocol
> changes
> and applies minor modifications to the vhost-user library. Supported
> vhost-user
> devices are today vhost-user-rng (both rust and C version), vhost-user-input
> and vhost-user-blk.
>
> Motivation & requirements:
> -------------------------
>
> 1. Enable the usage of the same user-space driver on both virtualized and
>    non-virtualized environments.
>
> 2. Maximize performance with zero copy design principles
>
> 3. Applications using such drivers are unchanged and transparently running
> in
>    both virtualized or non-virtualized environment.
>
> Design description:
> -------------------
>
> a) Component's description:
> --------------------------
>
> The Virtio-loopback architecture consists of three main components
> described below:
>
> 1) Driver: In order to route the VIRTIO communication in user-space
>    virtio-loopback driver was implemented and consists of:
>    - A new transport layer which is based on virtio-mmio and it is
>      responsible of routing the read/write communication of the virtio
>      device to the adapter binary.
>    - A character device which works as an intermediate layer between the
>      user-space components and the transport layer. The character device
> helps
>      the adapter to provide all the required information and initialize the
>      transport and at the same time, provides direct access to the vrings
>      from user-space. The access to the vrings is based on a memory mapping
>      mechanism which gives the ability to the vhost-user device to read and
>      write data directly into kernel's memory without the need of any copy.
>
> 2) Adapter: Implements the role that QEMU had in the corresponding
> virtualized
>    scenario. Specifically, combines the functionality of two main QEMU
>    components, virtio-mmio transport emulation and vhost-user backend, in
> order
>    to work as a bridge between the transport and the vhost-user device. The
> two
>    main parts of the adapter are:
>    - A vhost-user backend which is the main communication point with the
>      vhost-user device.
>    - A virtio-emulation which handles mostly the messages coming from the
>      driver and translates them into vhost-user messages/actions.
>
> 3) Vhost-user device: This components required only minimal modifications to
>    make the vrings directly accessible in kernel's memory.
>
> b) Communication between the virtio-loopback components:
> -------------------------------------------------------
>
> After the describing the role of its component, a few details need to be
> given
> about how they interact with each other and the mechanisms used.
>
> 1) Transport & Adapter:
>    - The two components share a communication data structure which describes
>      the current read/write operation requested by the transport.
>    - When this data structure has been filled with all the required
> information
>      the transport triggers and EventFD and waits. The adapter wakes up,
> takes
>      the corresponding actions and finally notifies and unlocks the
> transport
>      by calling an IOCTL system call.
>    - Compared to the virtualized environment scenario, the adapter calls an
>      IOCTL system call to the driver in place of an interrupt.
>
> 2) Adapter & Vhost-user device:
>    - The mechanisms used between these two component are the same as in
>      the virtualized environment case.
>      a) A UNIX socket is in place to exchange any VHOST-USER messages.
>      b) EventFDs are being used in order to trigger VIRTIO kick/call
>         requests.
>
> 3) Transport & Vhost-user device:
>    - Since the Vrings are allocated into the Kernel's memory, vhost-user
>      device needs to communicate and request access from the virtio-loopback
>      driver. These requirement is served by implementing MMAP and IOCTL
> system
>      calls in the driver.
>
> c) Vrings & Zero copy memory mapping mechanism:
> ----------------------------------------------
>
> The vrings are allocated by the virtio driver into the kernel's memory space
> and in order to be accessible by the user-space, especially by the
> vhost-user
> device, a new memory mapping mechanism needed to be created into the
> virtio-loopback driver. The new memory mapping mechanism is based on a
> page-fault handler which maps the accessed pages on-demand.
>
> Known issues & room for improvement:
> -----------------------------------
>
> Known limitation found in the current implementation:
> - The memory mapping mechanism needs improvements, in the current
>   implementation the device can potentially access the whole kernel's
>   memory. A more fine grained mmapping can be set by the kernel by
>   narrowing down the memory block shared.
>
> Possible next development targets might be about:
> - Security checks for the memory shared with the user-space (vhost
> user-device)
> - Add parallel device handling for the virtio-loopback transport and adapter
> - Add support for more vhost-user devices
>
> More information:
> ----------------
>
> The full description of the technology can be found in the links below:
> - Virtio-loopback design document
> <https://git.virtualopensystems.com/virtio-loopback/docs/-/blob/virtio-loopback-rfc/design_docs/EG-VIRT_VOSYS_virtio_loopback_design_v1.4_2023_04_03.pdf>
> - How to test the technology
> <https://git.virtualopensystems.com/virtio-loopback/docs/-/blob/virtio-loopback-rfc/README.md>
>
> Links for all the key components of the design can be found below:
> 1) Virtio-loopback-transport
> <https://git.virtualopensystems.com/virtio-loopback/loopback_driver/-/tree/virtio-loopback-rfc>
> 2) Adapter
> <https://git.virtualopensystems.com/virtio-loopback/adapter_app/-/tree/virtio-loopback-rfc>
> 3) Vhost-user devices in Qemu
> <https://git.virtualopensystems.com/virtio-loopback/qemu/-/tree/virtio-loopback-rfc>
>
> Virtio-loopback has been tested on RCAR-M3 board (AGL needlefish) and x86
> systems (Fedora 37). The results have been found to be comparable with VDUSE
> technology in virtio-blk case:
> - Automotive Grade Linux All Member Meeting Spring (8-9/03/2023) -
> Presentation
> <https://static.sched.com/hosted_files/aglammspring2023/44/vosys_virtio-loopback-berlin_2023-03-08.pdf>
>   + Activity done in the context of the AERO EU project (grant agreement No
> 101092850)
>
> Thank you for taking the time to review this PoC,
> I would appreciate your feedback and suggestions for improvements.
>
> Best regards,
> Timos Ampelikiotis
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

