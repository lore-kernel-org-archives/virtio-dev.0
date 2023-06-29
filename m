Return-Path: <virtio-dev-return-13161-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252F4EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 19:57:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 867EB2B04D
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 19:57:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 544E19866EF
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 19:57:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 35C3A9865B5; Thu, 29 Jun 2023 19:57:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 221B998667F
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 19:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: CFYZkhWnODqN4ndpCsvuYQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068669; x=1690660669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXcmJG+JJXal8IJ5HeDxyhb2NM1/Z41eI3ho7cA2iw0=;
        b=VMwk15wAbkmp8BVd1b7IqdmtYv4hkzbWX70WGMDb2BqjCEGd8A/HpLUVcPiLohZQ4P
         x+3MQRRU9a2XwqQT4PByJeNBEYpnp01GOaZAMeUbQRcI1Ah2MNsia0p3bnvBwgdkG+xd
         D7c1MPQczvLc2Ju+jncVaakCzdqVpK0xdVgBW+rRPKb6b9SlWGwQyVvVJAnCJ+T/WW2k
         0mkFjZpNwY+gLtxjFFsqf961U6NRMSA1xab8bX5lziO9JWtn0njcQM+9+POnvn0O+7tW
         SPzFII2xzrM+ux56ByuiWA4+XlNK/tvasyzg1DITAwM8kViOGx2mszKcaKf2vZHW3tBY
         KUXA==
X-Gm-Message-State: ABy/qLZ6L9zeofVykFUBKkHGUKj6uEx+dgbwOylqH4+WYSHf/lqt4ha4
	YTWb+LYPUWMO2/piIXFI1nOuUtkdQOuJmD3V22vsOzF77Euj9AkcWCb8AO3oksbLsMgKLr9d1kK
	8JDsUPKNEhE3fp/Rc2XWZlbvhWUVI
X-Received: by 2002:adf:f049:0:b0:309:1532:8287 with SMTP id t9-20020adff049000000b0030915328287mr478317wro.19.1688068669502;
        Thu, 29 Jun 2023 12:57:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGN+kZBf4fe+c7eQh+qyzfiqbphgzPpQV0F1nBwyM2UMTyXlivO5F9r+FTqHDm6MDlz3r0WkA==
X-Received: by 2002:adf:f049:0:b0:309:1532:8287 with SMTP id t9-20020adff049000000b0030915328287mr478303wro.19.1688068669157;
        Thu, 29 Jun 2023 12:57:49 -0700 (PDT)
Date: Thu, 29 Jun 2023 15:57:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230629155403-mutt-send-email-mst@kernel.org>
References: <20230627211050.1527507-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230627211050.1527507-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v7 0/4] admin: Introduce legacy registers access using AQ

On Wed, Jun 28, 2023 at 12:10:46AM +0300, Parav Pandit wrote:
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
> 
> Patch summary:
> --------------
> patch-1 split rows of admin opcode tables by a line
> patch-2 fix section numbering
> patch-3 add generic legacy region access commands
> patch-4 add pci specific definition
> 
> Iadministation t uses the newly introduced administration command facility with 4 new
> commands which uses the existing virtio_admin_cmd and a new command to
> query the legacy notification region.
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

OK I went over it. Still some comments on the ABI.
If you can address that by next week, I will try to find
the way to fix up the wording next week.
Problem is, when things are finally ready is when people
start review in earnest and while I hope at least ABI wise
we will not need to make changes it's likely that
there will be comments on wording.

If we are super lucky we can finish until end of next week
but my problem is I can't work on this 100% of my time.


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
> 
> Parav Pandit (4):
>   admin: Split opcode table rows with a line
>   admin: Fix section numbering
>   admin: Add group member legacy register access commands
>   transport-pci: Introduce group legacy group member config region
>     access
> 
>  admin-cmds-legacy-interface.tex | 204 ++++++++++++++++++++++++++++++++
>  admin.tex                       |  20 +++-
>  conformance.tex                 |   3 +
>  transport-pci-legacy-regs.tex   |  43 +++++++
>  transport-pci.tex               |   2 +
>  5 files changed, 269 insertions(+), 3 deletions(-)
>  create mode 100644 admin-cmds-legacy-interface.tex
>  create mode 100644 transport-pci-legacy-regs.tex
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

