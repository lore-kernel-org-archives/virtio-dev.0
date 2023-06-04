Return-Path: <virtio-dev-return-12841-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4685C7EE23
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:35:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2F5A8190934
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95E0E9867F9
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:35:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0F0F59862E2; Sun,  4 Jun 2023 13:35:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B0F59862DD
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Jun 2023 13:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: n49R7VckPCSXldiiHIKl6w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685885667; x=1688477667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rT+IgkT3MSC6dHbitzhXnSu7VOJOWTD6MKh+j0d8G5I=;
        b=lj1E5jb+ji0yIrB8KGlNQKRviv+RJUhSX5W9GX+BICMTfxqzxlzLQdqD9r7UipXNbl
         lqGbDFRy+adGao9PBJgWT7A7QrPI1YHfwd+2/TzCzOSl8I6m6jy+9updWgOJNwYAu8/j
         8+DMb1AM5JyNRdjQqzMttmO1K5KxpA+MATa+y8nHf5Tm0Um0LGZKYk1EZ5fRCrjOsP+F
         /uVqRrYJNl7LeO4V+tIic/mZDp7IfRgy8S/3yjfj8FkDe/My3RztgFtb7sCirKfYxHij
         kDFyBVrwjE3KW42RrL/2vSKPmoGnmrCaekZMDdmRjh/B3Q1HOnuEVSUz0TKQe4xGkBxL
         +O3g==
X-Gm-Message-State: AC+VfDyOfW1LaA+bNlGqAA5j5V4w8YVRAsWEbR/xU893KJ7USIt7Z0uk
	x4s9K0mcmBfcIGWFBgOdZKqtsbgULwxCeHSHp857Gb0Hc4t0cN6Bs1mBoOA/K7HcRDPH3yvycm0
	+S81WLW3Aksqyoa6xeacyhut7imHv
X-Received: by 2002:a17:907:86a0:b0:96f:32ae:a7e1 with SMTP id qa32-20020a17090786a000b0096f32aea7e1mr4489092ejc.63.1685885667696;
        Sun, 04 Jun 2023 06:34:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Fy1H1od0upmQxaZY27Y45vzMEFjaohO5eVXH0YYDaAOJ1lA66MxJw3McPYNcb1vsZR5vBDQ==
X-Received: by 2002:a17:907:86a0:b0:96f:32ae:a7e1 with SMTP id qa32-20020a17090786a000b0096f32aea7e1mr4489081ejc.63.1685885667374;
        Sun, 04 Jun 2023 06:34:27 -0700 (PDT)
Date: Sun, 4 Jun 2023 09:34:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230604092441-mutt-send-email-mst@kernel.org>
References: <20230602203604.627661-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230602203604.627661-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

On Fri, Jun 02, 2023 at 11:36:01PM +0300, Parav Pandit wrote:
> This short series introduces legacy registers access commands for the owner
> group member PCI PF to access the legacy registers of the member VFs.

Note that some work will be needed here to fix up grammar and spelling
mistakes.

> If in future any SIOV devices to support legacy registers, they
> can be easily supported using same commands by using the group
> member identifiers of the future SIOV devices.

Yes, with the exception of
VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY - currently refers to VF BAR,
subfunctions do not have it.
Can we find a way to have it in the PF BAR instead?
E.g. the notification can include VF# + VQ#?
At least as an option?
If not can you add some info explaining why not?


> More details as overview, motivation, use case are further described
> below.
> 
> Patch summary:
> --------------
> patch-1 split rows of admin opcode tables by a line
> patch-2 adds administrative virtuqueue commands
> patch-3 adds its conformance section
> 
> This short series is on top of latest work [1] from Michael.
> It uses the newly introduced administrative virtqueue facility with 3 new
> commands which uses the existing virtio_admin_cmd.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00112.html
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
> The existing virtio transitional PCI device is missing support for
> PCI SR-IOV based devices. Currently it does not work beyond
> PCI PF, or as software emulated device in reality. Currently it
> has below cited system level limitations:
> 
> [a] PCIe spec citation:
> VFs do not support I/O Space and thus VF BARs shall not indicate I/O Space.
> 
> [b] cpu arch citiation:
> Intel 64 and IA-32 Architectures Software Developer’s Manual:
> The processor’s I/O address space is separate and distinct from
> the physical-memory address space. The I/O address space consists
> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
> 
> [c] PCIe spec citation:
> If a bridge implements an I/O address range,...I/O address range will be
> aligned to a 4 KB boundary.
> 
> Overview:
> ---------
> Above usecase requirements can be solved by PCI PF group owner accessing
> its group member PCI VFs legacy registers using an admin virtqueue of
> the group owner PCI PF.
> 
> Two new admin virtqueue commands are added which read/write PCI VF
> registers.
> 
> The third command suggested by Jason queries the VF device's driver
> notification region.
> 
> Software usage example:
> -----------------------
> One way to use and map to the guest VM is by using vfio driver
> framework in Linux kernel.
> 
>                 +----------------------+
>                 |pci_dev_id = 0x100X   |
> +---------------|pci_rev_id = 0x0      |-----+
> |vfio device    |BAR0 = I/O region     |     |
> |               |Other attributes      |     |
> |               +----------------------+     |
> |                                            |
> +   +--------------+     +-----------------+ |
> |   |I/O BAR to AQ |     | Other vfio      | |
> |   |rd/wr mapper  |     | functionalities | |
> |   +--------------+     +-----------------+ |
> |                                            |
> +------+-------------------------+-----------+
>        |                         |
>        |                    Driver notification
>        |                         |
>        |                         |
>   +----+------------+       +----+------------+
>   | +-----+         |       | PCI VF device A |
>   | | AQ  |-------------+---->+-------------+ |
>   | +-----+         |   |   | | legacy regs | |
>   | PCI PF device   |   |   | +-------------+ |
>   +-----------------+   |   +-----------------+
>                         |
>                         |   +----+------------+
>                         |   | PCI VF device N |
>                         +---->+-------------+ |
>                             | | legacy regs | |
>                             | +-------------+ |
>                             +-----------------+
> 
> 2. Virtio pci driver to bind to the listed device id and
>    use it as native device in the host.
> 
> 3. Use it in a light weight hypervisor to run bare-metal OS.
> 
> Please review.
> 
> Alternatives considered:
> ========================
> 1. Exposing BAR0 as MMIO BAR that follows legacy registers template
> Pros:
> a. Kind of works with legacy drivers as some of them have API
>    which is agnostic to MMIO vs IOBAR.
> b. Does not require hypervisor intervantion
> Cons:
> a. Device reset is extremely hard to implement in device at scale as
>    driver does not wait for reset completion
> b. Device register width related problems persist that hypervisor if
>    wishes, cannot fix it.
> 
> 2. Accessing VF registers by tunneling it through new legacy PCI capability
> Pros:
> a. Self contained, but cannot work with future PCI SIOV devices
> Cons:
> a. Equally slow as AQ access
> b. Still requires new capability for notification access
> 
> conclusion for picking AQ approach:
> ==================================
> 1. Overall AQ based access is simpler to implement with combination of
>    best from software and device so that legacy registers do not get baked
>    in the device hardware
> 2. AQ allows hypervisor software to intercept legacy registers and make
>    corrections if needed
> 3. Provides trade-off between performance, device complexity vs spec,
>    while still maintaining passthrough mode for the VFs with minimal
>    hypervisor intercepts only for legacy registers access
> 4. AQ mechanism is designed for accessing other member devices registers
>    as noted in AQ submission, it utilizes the existing infrastructure over
>    other alternatives.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v2->v3:
> - added new patch to split raws of admin vq opcode table
> - adddressed Jason and Michael's comment to split single register
>   access command to common config and device specific commands.
> - dropped the suggetion to introduce enable/disable command as
>   admin command cap bit already covers it.
> - added other alternative design considered and discussed in detail in v0, v1 and v2
> 
> v1->v2:
> - addressed comments from Michael
> - added theory of operation
> - grammar corrections
> - removed group fields description from individual commands as
>   it is already present in generic section
> - added endianness normative for legacy device registers region
> - renamed the file to drop vf and add legacy prefix
> - added overview in commit log
> - renamed subsection to reflect command
> 
> v0->v1:
> - addressed comments, suggesetions and ideas from Michael Tsirkin and Jason Wang
> - far more simpler design than MMR access
> - removed complexities of MMR device ids
> - removed complexities of MMR registers and extended capabilities
> - dropped adding new extended capabilities because if if they are
>   added, a pci device still needs to have existing capabilities
>   in the legacy configuration space and hypervisor driver do not
>   need to access them
> 
> 
> 
> Parav Pandit (3):
>   admin: Split opcode table rows with a line
>   transport-pci: Introduce legacy registers access commands
>   transport-pci: Add legacy register access conformance section
> 
>  admin.tex                     |  14 ++-
>  conformance.tex               |   2 +
>  transport-pci-legacy-regs.tex | 189 ++++++++++++++++++++++++++++++++++
>  transport-pci.tex             |   2 +
>  4 files changed, 206 insertions(+), 1 deletion(-)
>  create mode 100644 transport-pci-legacy-regs.tex
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

