Return-Path: <virtio-dev-return-13296-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE511EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 22:36:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D6A3033097
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 22:36:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCA4D98680F
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 22:36:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C0C1B983B4A; Thu,  6 Jul 2023 22:36:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF9719867B6
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 22:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: u8n6OqpiPeGXo987JUS_4w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682996; x=1691274996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhK/t09cP93kfiRVCwiR52M9rySjJ77qJCyg1F6kFdo=;
        b=j/NezWEpLF9eOQzDFCW8BBmVimHocvcN/enaiBAjVQwMXZ6lrLmCwpTg1MvyJkOvkh
         0gEZV8L9SPCkxvGAliPQPxc7LrElRVfnnvuXboVuIeKqHy3BWxfiOYNDx2EPMJnV2KE3
         G3dsGRdkS96iGvQFGyhnvyMOMN709entdRCEVgTTz8/QJjd+xURL2Myjl2Gxb/9HU2MN
         eV+GTOnp5Tb78Ko1uVg+1uWYsv1LcJqgVQ8sECmi4erXXsHI0r/UoNhLrPoIY76lX/ld
         cQzpz89ZUyMYRmcME3jeBVmi0dFAvYqFkfpsd4N0ggHM8UPxPG1E9wIWmgthiC7jBsaR
         M+Cw==
X-Gm-Message-State: ABy/qLYzUOXXcGVuNzK5wm+JCjKgiQRLaI06/kFcmx99h/BNPGdKBYh7
	DC6+vHzcLm/ygEaNn9R0Aw/W+ZeG17lyAxuCot91c0CY5ZVkzAPDPj5GSVz5oIBFdAcw9B5hm/L
	8LBV+szNrFYWVa2xhPl/qdVysCgdM2T8lOsA4
X-Received: by 2002:a7b:c409:0:b0:3fb:e206:ca5f with SMTP id k9-20020a7bc409000000b003fbe206ca5fmr2349666wmi.31.1688682995677;
        Thu, 06 Jul 2023 15:36:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFTrRNaEDVhV6Nsa7UqNoYluukeeBaVJsuYQ0bldCJgOPLPupzXtSNJ6eX+SRvnlvMduYzy7Q==
X-Received: by 2002:a7b:c409:0:b0:3fb:e206:ca5f with SMTP id k9-20020a7bc409000000b003fbe206ca5fmr2349651wmi.31.1688682995269;
        Thu, 06 Jul 2023 15:36:35 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230706183617-mutt-send-email-mst@kernel.org>
References: <20230706212722.97973-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230706212722.97973-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v11 0/3] admin: Access legacy registers using admin
 commands

On Fri, Jul 07, 2023 at 12:27:19AM +0300, Parav Pandit wrote:
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

corneli want to apply 1,2 as editorial?

> Patch summary:
> --------------
> patch-1 split rows of admin opcode tables by a line
> patch-2 fix section numbering
> patch-3 add legacy region access commands
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
> v10->v11:
> - replaced tab with white spaces in read structure
> - included pci fields along side other generic fields to avoid
>   indirection
> - merged pci conformance section
> - avoid using definite in starting introduction
> - replace 'all of the' with 'any of the'
> - changed drivers notification normative to indicate use of
>   NOTIFY_INFO command
> - renamed NOTIFY_QUERY to NOTIFY_INFO name
> - merged 4th patch with 3rd
> - added normative line for notify_info command
> - reworded notification region command description to be more verbose
> - merged flags and owner field to indicate end of list
> v9->v10:
> - added white space at end of line
> - addressed below comments from Cornelia
> - fixed errors related to article
> - hardwire to hardwires
> - replaced various to all
> - added hardwire to zero
> - fixed requirements for administration virtqueue section
> - added missing articles
> - reworded description for notification query command
> - grammar fixes
> - addressed below comments from Michael
> - added description for member group id setting
> - reworded device and driver conformance statements
> - opcode table description updated
> - fixed label for device read command
> - length alignment restriction text added
> - data length described for read write commands
> - notification description added and refined
> - reworded text around command specific result and data field usage
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
> Parav Pandit (3):
>   admin: Split opcode table rows with a line
>   admin: Fix section numbering
>   admin: Add group member legacy register access commands
> 
>  admin-cmds-legacy-interface.tex | 302 ++++++++++++++++++++++++++++++++
>  admin.tex                       |  24 ++-
>  conformance.tex                 |   2 +
>  3 files changed, 323 insertions(+), 5 deletions(-)
>  create mode 100644 admin-cmds-legacy-interface.tex
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

