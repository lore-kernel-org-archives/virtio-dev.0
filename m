Return-Path: <virtio-dev-return-13235-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D95EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 11:09:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1A1452AEF2
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 11:09:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10D28986728
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 11:09:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0440F986712; Wed,  5 Jul 2023 11:09:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4682986717
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Jul 2023 11:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: AvY_ORX_PlGRHMyGWiYsNg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688555356; x=1691147356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8o5AzeXnz8aEnTpWvpYA01McRN6cILy0BjVtugLy2Y=;
        b=hd+V4zRZ7pyvcFjdBawOP2coD8RfYu/tWlyjX3mpPyPePCrpCDOH+57xjwWI6vcZuY
         nJJB0a6Pa+8WgaD+6ac6QdX3sSbFqZDmQcMfWSSv2rMPrC4rKf754QMgkEuwKH7cwuU1
         UoOtwA8k/DtnsMuPxqpS7X9R9rYWEDnX3mt1dwwXVxR6pAPuCpChKHdaTMx6E4tSlKFM
         IBsAIPG06uLQsQ47YQFauY9Fr24GselV2vHoMP40tAORO4W0SR46Q7LpVOA6XWgvsoot
         z6sfRDeg9lQePd5B/ntSaqXZJWW8/rK4Gks5+SU1TtfF1MUWxlE/S9s1ips2gMqLcYjA
         54WA==
X-Gm-Message-State: AC+VfDyF0C8DzPEoR5gxPQlD08lA0WRPDGtI1ml5p+byMYh0MQVgxIBi
	a01ao9oASo2Vg6jtP4OCLePGTZLny6U6v6tlbPFuiNzxd4hK9NDsQtl7T2QwUQS7JINVConIB/3
	7QW40LaMEpr755HfQ+YUnIOys5/+R
X-Received: by 2002:a7b:c7d3:0:b0:3fb:a937:6024 with SMTP id z19-20020a7bc7d3000000b003fba9376024mr15089580wmk.29.1688555356227;
        Wed, 05 Jul 2023 04:09:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4P5K6DVlcNS7xq9CO6ugvYUSwlrC3iwlVdM5YQb6ykP5QLlL2wd7faBpbGGrEhlsWE9PxgMQ==
X-Received: by 2002:a7b:c7d3:0:b0:3fb:a937:6024 with SMTP id z19-20020a7bc7d3000000b003fba9376024mr15089553wmk.29.1688555355830;
        Wed, 05 Jul 2023 04:09:15 -0700 (PDT)
Date: Wed, 5 Jul 2023 07:09:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230705070758-mutt-send-email-mst@kernel.org>
References: <20230704233724.22394-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230704233724.22394-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands

On Wed, Jul 05, 2023 at 02:37:20AM +0300, Parav Pandit wrote:
> This short series introduces legacy registers access commands for the owner
> group member access the legacy registers of the member VFs.
> This short series introduces legacy region access commands by the group owner
> device for its member devices.
> Currently it is applicable to the PCI PF and VF devices. If in future any
> SIOV devices to support legacy registers, they can be easily supported using
> same commands by using the group member identifiers of the future SIOV devices.
> 
> More details as overview, motivation, use case are further described
> below.

OK I sent a bunch of comments. Pls try to address, unfortunately I
didn't go in depth over the last patch, but I feel it should be
squashed into the generic legacy command sections avoiding
need for indirection, so rewriting it now wouldn't be
efficient.

Thanks!

> Patch summary:
> --------------
> patch-1 split rows of admin opcode tables by a line
> patch-2 fix section numbering
> patch-3 add generic legacy region access commands
> patch-4 add pci specific definition
> 
> It uses the newly introduced administration command facility with 4 new
> commands and a new optional command to query the legacy notification region.
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
> Above usecase requirements is solved by PCI PF group owner accessing
> its group member PCI VFs legacy registers using an admin virtqueue of
> the group owner PCI PF.
> 
> Two new admin virtqueue commands are added which read/write PCI VF
> registers.
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
>    Legacy region            Driver notification
>     access                       |
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
>    use it in the host.
> 
> 3. Use it in a light weight hypervisor to run bare-metal OS.
> 
> Please review.
> 
> Alternatives considered:
> ========================
> 1. Exposing BAR0 as MMIO BAR that follows legacy registers template
> Pros:
> a. Kind of works with legacy drivers as some of them have used API
>    which is agnostic to MMIO vs IOBAR.
> b. Does not require hypervisor intervantion
> Cons:
> a. Device reset is extremely hard to implement in device at scale as
>    driver does not wait for device reset completion
> b. Device register width related problems persist that hypervisor if
>    wishes, it cannot be fixed.
> 
> 2. Accessing VF registers by tunneling it through new legacy PCI capability
> Pros:
> a. Self contained, but cannot work with future PCI SIOV devices
> Cons:
> a. Equally slow as AQ access
> b. Still requires new capability for notification access
> c. Requires hardware to build low level registers access which is not worth
>    for long term future
> 
> 3. Accessing VF notification region using new PF BAR
> Cons:
> a. Requires hardware to build new PCI steering logic per PF to forward
>    notification from the PF to VF, requires double the amount of logic
>    compared to today
> b. Requires very large additional PF BAR whose size must be max_Vfs * BAR size.
> 
> 4. Trapping CVQ, configuration region, LEGACY_HDR
> Cons:
> a. This does not fullfil the very basic requirement to not trap the
>    1.x objects (configuration registers, vqs)
> b. Requires feature negotiations mediation in hypervisor software
> c. Requires constant device type specific knowledge in hypervisor driver
>    (Does not scale for 30+ device types)
> 
> 4. F_LEACY_HDR, F_WRITE_MAC
> Cons:
> a. Requires device support to have read/write mac address which is
>    hard to implement on every member device.
> b. such functionality is duplicate of existing cvq per device.
> c. config space is only for the initialization specific purpose.
> d. Requires mediation of 1.x objects, which is not good design.
> e. Solves only for the net device.
> Pros:
> a. May work for nested env
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
> 5. Uses existing driver notification region similar to legacy notification
>    saves hardware resources
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v8->v9:
> - add missing articles in notify query command
> - replaced 'this notification' with 'such a notification'
> - addressed below comments from Michael
> - dropped 'Region' from the commands
> - added 7 reserved pad bytes in config write commands
> - rewrote from 'use following structure' to 'field' has the following
>   struct..
> - dropped mentioning to follow struct virtio_admin_cmd.
> - added note about command limited to only sriov group type for now
> - rewrote the description little differently
> v7->v8:
> - remove empty line at the end of file
> - removed white space at the end
> - addressed comments from Michael add link to pci
> - renamed region to region_data
> - made region_data width to be 16 bytes to cover for 8 bytes offset
> - moved generic notification region related normative from pci to
>   generic section
> - addressed comments from Michael
> - made bar offset 64-bit
> - prefix legacy specific structure with _legacy
> - moved generic normative from pci to generic section
> - added link to virtio pci capabilities when referring to bar 0
> - remove 'should' from generic description
> v6->v7:
> - addressed several comments from Michael
> - use AQ command to query legacy notify region, dropped pci capability
>   modifications
> - moved most part of the text to the generic admin command section
> - replace administrative to administration
> - replace admin vq citation to admin commands
> - added normatives for device and driver side
> - made BAR0 to be not used at all when supporting legacy interface
> - added normative around BAR0 and SR-IOV extended capability
> - grammar corrections
> v5->v6:
> - fixed previous missed abbreviation of LCC and LD
> - added text for the PCI capability for the group member device
> v4->v5:
> - split pci transport and generic command section to new patch
> - removed multiple references to the VF
> - written the description of the command as generic with member
>   and group device terminology
> - reflected many section names to remove VF
> - split from pci transport specific patch
> - split conformance to transport and generic sections
> - written the description of the command as generic with member
>   and group device terminology
> - reflected many section names to remove VF
> - rename fields from register to region
> - avoided abbreviation for legacy, device and config
> v3->v4:
> - moved noted to the conformance section details in next patch
> - removed queue notify address query AQ command on Michael's suggestion,
>   though it is fine. Instead replaced with extending virtio_pci_notify_cap
>   to indicate that legacy queue notifications can be done on the
>   notification location
> - fixed spelling errors
> - replaced administrative virtqueue to administration virtqueue
> - moved legacy interface normative references to legacy conformance
>   section
> v2->v3:
> - added new patch to split raws of admin vq opcode table
> - adddressed Jason and Michael's comment to split single register
>   access command to common config and device specific commands.
> - dropped the suggetion to introduce enable/disable command as
>   admin command cap bit already covers it.
> - added other alternative design considered and discussed in detail in v0, v1 and v2
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
> Parav Pandit (4):
>   admin: Split opcode table rows with a line
>   admin: Fix section numbering
>   admin: Add group member legacy register access commands
>   transport-pci: Introduce group legacy group member config region
>     access
> 
>  admin-cmds-legacy-interface.tex | 205 ++++++++++++++++++++++++++++++++
>  admin.tex                       |  20 +++-
>  conformance.tex                 |   3 +
>  transport-pci-legacy-regs.tex   |  41 +++++++
>  transport-pci.tex               |   2 +
>  5 files changed, 268 insertions(+), 3 deletions(-)
>  create mode 100644 admin-cmds-legacy-interface.tex
>  create mode 100644 transport-pci-legacy-regs.tex
> 
> -- 
> 2.26.2
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

