Return-Path: <virtio-dev-return-11876-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25947C6FD18
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 07:03:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5418023D42
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 07:03:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C39C986563
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 07:03:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3C2CE986561; Fri, 31 Mar 2023 07:03:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29728986566
	for <virtio-dev@lists.oasis-open.org>; Fri, 31 Mar 2023 07:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: GAYlQD6VMZCj53qy2th9iQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680246190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZcmhUpWjXjjmI3q+cTY6IuwD4OUKhPJJVF/0zJnYEo=;
        b=OzXlPcAkzCxTlfJ87JK+XyN3oDWMcD3J6Y+OvEIqUuAWaTzpnJM8k8FUJYAEL4ly+/
         mJrfDESKWoDdg6+S5B4LSi8ktU0Hv1stoWQB2v/ucabuJq73wz+Wlgwuyyzj+Nx2PScx
         tdVgsFE3aPipr+kG1OYIoj1SujZjzBCCJdFq/rT1kKCjSdADybT5Tc60Njb6Xg5J/Kyf
         VbEX1IJU1UjDOXg0el/qZu/ybh0k7LcrMpI4k+KKefp2tuHglSZPLI+TCt/eXiEHvPQC
         VtJ/pul6UCh/I3Q4l3INvu4lajWyWdw6yIHmYB2sfpNyw9GHRb5tRjL1DjQ9aPvJ3TR8
         aczA==
X-Gm-Message-State: AO0yUKVAci+A4CqkDZ46ZnftFYJ40OMQ0eJQW9AXEq4Oaq6G1BVe+7Uo
	XJ2XgEKQ2lthFFdUKsG48Zsi3YOcD7WOSo+75MlR6tytHKfcRl1EgTul26+/xP89qaVQltkUmjO
	bJcOSudGiDr9fMHGeU5V1T+sUzcS7
X-Received: by 2002:a05:600c:2046:b0:3e9:f15b:935b with SMTP id p6-20020a05600c204600b003e9f15b935bmr20080714wmg.32.1680246189763;
        Fri, 31 Mar 2023 00:03:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+uwvBwswZAmtRNw6n/61lQkXuTELPYz1yM9Zh9IvfhUnB+8MJLh7EPw0qmOjsvcDljd/xGrA==
X-Received: by 2002:a05:600c:2046:b0:3e9:f15b:935b with SMTP id p6-20020a05600c204600b003e9f15b935bmr20080693wmg.32.1680246189381;
        Fri, 31 Mar 2023 00:03:09 -0700 (PDT)
Date: Fri, 31 Mar 2023 03:03:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230331024500-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device

On Fri, Mar 31, 2023 at 01:58:23AM +0300, Parav Pandit wrote:
> Overview:
> ---------
> The Transitional MMR device is a variant of the transitional PCI device.
> It has its own small Device ID range. It does not have I/O
> region BAR; instead it exposes legacy configuration and device
> specific registers at an offset in the memory region BAR.
> 
> Such transitional MMR devices will be used at the scale of
> thousands of devices using PCI SR-IOV and/or future scalable
> virtualization technology to provide backward
> compatibility (for legacy devices) and also future
> compatibility with new features.
> 
> Usecase:
> --------
> 1. A hypervisor/system needs to provide transitional
>    virtio devices to the guest VM at scale of thousands,
>    typically, one to eight devices per VM.
> 
> 2. A hypervisor/system needs to provide such devices using a
>    vendor agnostic driver in the hypervisor system.
> 
> 3. A hypervisor system prefers to have single stack regardless of
>    virtio device type (net/blk) and be future compatible with a
>    single vfio stack using SR-IOV or other scalable device
>    virtualization technology to map PCI devices to the guest VM.
>    (as transitional or otherwise)
> 
> Motivation/Background:
> ----------------------
> The existing transitional PCI device is missing support for
> PCI SR-IOV based devices. Currently it does not work beyond
> PCI PF, or as software emulated device in reality. It currently
> has below cited system level limitations:
> 
> [a] PCIe spec citation:
> VFs do not support I/O Space and thus VF BARs shall not
> indicate I/O Space.
> 
> [b] cpu arch citiation:
> Intel 64 and IA-32 Architectures Software Developer’s Manual:
> The processor’s I/O address space is separate and distinct from
> the physical-memory address space. The I/O address space consists
> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
> 
> [c] PCIe spec citation:
> If a bridge implements an I/O address range,...I/O address range
> will be aligned to a 4 KB boundary.
> 
> [d] I/O region accesses at PCI system level is slow as they are non-posted
> operations in PCIe fabric.
> 
> The usecase requirements and limitations above can be solved by
> extending the transitional device, mapping legacy and device
> specific configuration registers in a memory PCI BAR instead
> of using non composable I/O region.
> 
> Please review.

So as you explain in a lot of detail above, IO support is going away,
so the transitional device can no longer be used through the
legacy interface.

OK but this does not answer the following question:
since a legacy driver can not bind to this type of MMR device,
a new driver is needed anyway so
why not implement a modern driver?


I think we discussed this at some call and it made some kind of sense.
Unfortunately it has been a while and I am not sure I remember the
detail, so I can no longer say for sure whether this proposal is fit for
the purpose.  Here is what I vaguely remember:

A valid use-case is an emulation layer (e.g. a hypervisor) translating
a legacy driver I/O accesses to MMIO. Ideally layering this emulation
on top of a modern device would work ok
but there are several things making this approach problematic.
One is a different virtio net header size between legacy and modern
driver. Another is use of control VQ by modern where legacy used
IO writes. In both cases the different would require the
emulation getting involved on the DMA path, in particular
somehow finding private addresses for communication between
emulation and modern device.


Does above summarize it reasonably?


And if yes, would an alternative approach of adding legacy config
support to transport vq work well?  I can not say I thought about this
deeply so maybe there's some problem, or maybe it's a worse approach -
could you comment on this? It looks like this could be a smaller change,
but maybe it isn't? Did you consider this option?


More review later.



> Patch summary:
> --------------
> patch 1 to 5 prepares the spec
> patch 6 to 11 defines transitional mmr device
> 
> patch-1 uses lower case alphabets to name device id
> patch-2 move transitional device id in legay section along with
>         revision id
> patch-3 splits legacy feature bits description from device id
> patch-4 rename and moves virtio config registers next to 1.x
>         registers section
> patch-5 Adds missing helper verb in terminology definitions
> patch-6 introduces transitional mmr device
> patch-7 introduces transitional mmr device pci device ids
> patch-8 introduces virtio extended pci capability
> patch-9 describes new pci capability to locate legacy mmr
>         registers
> patch-10 extended usage of driver notification capability for
>          the transitional mmr device
> patch-11 adds conformance section of the transitional mmr device
> 
> This design and details further described below.
> 
> Design:
> -------
> Below picture captures the main small difference between current
> transitional PCI SR-IOV VF and transitional MMR SR-IOV VF.
> 
> +------------------+ +--------------------+ +--------------------+
> |virtio 1.x        | |Transitional        | |Transitional        |
> |SRIOV VF          | |SRIOV VF            | |MMR SRIOV VF        |
> |                  | |                    | |                    |
> ++---------------+ | ++---------------+   | ++---------------+   |
> ||dev_id =       | | ||dev_id =       |   | ||dev_id =       |   |
> ||{0x1040-0x106C}| | ||{0x1000-0x103f}|   | ||{0x10f9-0x10ff}|   |
> |+---------------+ | |+---------------+   | |+---------------+   |
> |                  | |                    | |                    |
> |+------------+    | |+------------+      | |+-----------------+ |
> ||Memory BAR  |    | ||Memory BAR  |      | ||Memory BAR       | |
> |+------------+    | |+------------+      | ||                 | |
> |                  | |                    | || +--------------+| |
> |                  | |+-----------------+ | || |legacy virtio || |
> |                  | ||IOBAR impossible | | || |+ dev cfg     || |
> |                  | |+-----------------+ | || |registers     || |
> |                  | |                    | || +--------------+| |
> |                  | |                    | |+-----------------+ |
> +------------------+ +--------------------+ +--------------------+
> 
> Here transitional MMR SR-IOV VF has legacy configuration and
> legacy device specific registers located at an offset in the memory
> region BAR.
> 
> A memory region can be dedicated at BAR0 or it can be in an
> existing BAR, allowing flexibility when implementing support
> in a hardware device.
> 
> Transitional MMR SR-IOV VFs use a distinct device ID range to that
> of existing virtio SR-IOV VFs to allow flexibility in driver
> binding.
> 
> A more zoom-in version of transitional MMR SR-IOV device shows
> that the location of the legacy registers are discovered by the
> driver using a new capability.
> 
> +------------------------------+
> |Transitional                  |
> |MMR SRIOV VF                  |
> |                              |
> ++---------------+             |
> ||dev_id =       |             |
> ||{0x10f9-0x10ff}|             |
> |+---------------+             |
> |                              |
> ++--------------------+        |
> || PCIe ext cap = 0xB |        |
> || cfg_type = 10      |        |
> || offset   = 0x1000  |        |
> || bar      = N {0..5}|        |
> |+--|-----------------+        |
> |   |                          |
> |   |                          |
> |   |    +-------------------+ |
> |   |    | Memory BAR = A    | |
> |   |    |                   | |
> |   +------>+--------------+ | |
> |        |  |legacy virtio | | |
> |        |  |+ dev cfg     | | |
> |        |  |registers     | | |
> |        |  +--------------+ | |
> |        +-----------------+ | |
> +------------------------------+
> 
> Software usage:
> ---------------
> Transitional MMR device can be used by multiple ways.
> 
> 1. The most common way to use and map to the guest VM is by
> using vfio driver framework in Linux kernel.
> 
>                 +----------------------+
>                 |pci_dev_id = 0x100X   |
> +---------------|pci_rev_id = 0x0      |-----+
> |vfio device    |BAR0 = I/O region     |     |
> |               |Other attributes      |     |
> |               +----------------------+     |
> |                                            |
> +   +--------------+     +-----------------+ |
> |   |I/O to memory |     | Other vfio      | |
> |   |rd/wr mapper  |     | functionalities | |
> |   +--------------+     +-----------------+ |
> |                                            |
> +-------------------+------------------------+
>                     |
>        +------------+-----------------+
>        |         Transitional         |
>        |         MMR SRIOV VF         |
>        +------------------------------+
> 
> 2. Virtio pci driver to bind to the listed device id and
>    use it as native device in the host.
> 
> 3. Use it in a light weight hypervisor to run bare-metal OS.
> 
> Parav Pandit (11):
>   transport-pci: Use lowecase alphabets
>   transport-pci: Move transitional device id to legacy section
>   transport-pci: Split notes of PCI Device Layout
>   transport-pci: Rename and move legacy PCI Device layout section
>   introduction: Add missing helping verb
>   introduction: Introduce transitional MMR interface
>   transport-pci: Introduce transitional MMR device id
>   transport-pci: Introduce virtio extended capability
>   transport-pci: Describe PCI MMR dev config registers
>   transport-pci: Use driver notification PCI capability
>   conformance: Add transitional MMR interface conformance
> 
>  conformance.tex      |  11 +-
>  introduction.tex     |  34 +++-
>  tmmr-conformance.tex |  27 +++
>  transport-pci.tex    | 405 ++++++++++++++++++++++++++++++-------------
>  4 files changed, 354 insertions(+), 123 deletions(-)
>  create mode 100644 tmmr-conformance.tex
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

