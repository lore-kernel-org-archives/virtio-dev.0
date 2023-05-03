Return-Path: <virtio-dev-return-12505-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC7AC7EE26
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:16:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92887FD57F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:16:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 424749866C4
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:16:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2FCD1986586; Wed,  3 May 2023 10:16:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E774986734
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 10:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ib4eqJR3PfWElHGAHdOY2Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108979; x=1685700979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnUuOWxd50wNIr2us72kSXUu3mOWQAJOG9u8MSlfqZo=;
        b=LAOvDUsLHb2z5nqmom1kQqfpo4m1Qe1JssdRlCl7X2AxcTWTakr+VYuS8+05BZ1CaH
         UtbxBEYbFJKBnWJkonLer3Vixz+wyhEOSOkFV2gHWROBXRI4bXnMcpAMsMXEMelieXJg
         a/IcXslAMlZ7fLNeVF1HmMJ+cYHKV7E6WMYmpmqgpqJwFEzcqPNNP20mvDTgIU7uD1Os
         KUYp2PokH6bf19gZ4IOX+QnzdOFpMw6doUZYuUjwIeK4iBHpIVo6M299zOjwD8n3CxJj
         tAHLCmViDIzpZ9YLRUZPEnXZzGKafkKepw7NQizmuSi47zJSN5L7zFcXy1y44qDy90KH
         5n0A==
X-Gm-Message-State: AC+VfDzSeknUf3Xfaq0j0JDKG4bQ2qybEDOATn/QXffuU7nN3QYHEM/0
	wX1rkam8GAE9qfanQOw1nlAx1TeLp5LDzrb+5MD67hBY5Gj1Ogd5xXLeUDLjj46DLqfhCpenaxp
	gM6ZxmNcElcrRVy7SdpeE9KpCmjxt
X-Received: by 2002:a1c:f717:0:b0:3f1:7972:429d with SMTP id v23-20020a1cf717000000b003f17972429dmr13715802wmh.18.1683108978888;
        Wed, 03 May 2023 03:16:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5S2OBAxG7FhqVzhhIF1RvVUpTGul3G8zAUz5Z7yfpsEqVPLtkIeNbgkx6R+JsMGiFdZzjQXg==
X-Received: by 2002:a1c:f717:0:b0:3f1:7972:429d with SMTP id v23-20020a1cf717000000b003f17972429dmr13715786wmh.18.1683108978551;
        Wed, 03 May 2023 03:16:18 -0700 (PDT)
Date: Wed, 3 May 2023 06:16:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230503060538-mutt-send-email-mst@kernel.org>
References: <20230503032659.530330-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230503032659.530330-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v1 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Wed, May 03, 2023 at 06:26:57AM +0300, Parav Pandit wrote:
> This patch introduces legacy registers access commands for the owner
> group member PCI PF to access the legacy registers of the member VFs.
> 
> If in future any SIOV devices to support legacy registers, they
> can be easily supported using same commands by using the group
> member identifiers of the future SIOV devices.

Absolutely, but maybe we should not create work for this
case by repeating PF/VF terminology everywhere?

> More details as overview, motivation, use case are further described
> below.
> 
> Patch summary:
> --------------
> patch-1 adds administrative virtuqueue commands
> patch-2 adds its conformance section
> 
> This short series is on top of [1].
> It uses the newly introduced administrative virtqueue facility with 3 new
> opcodes and uses the existing virtio_admin_cmd.
> 
> It is expected to go another rebase once v13 for [1] is rolled out and merged.
> 
> [1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t
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
> Above usecase requirements can be solved by PCI PF group owner enabling
> the access to its group member PCI VFs legacy registers using an admin
> virtqueue of the group owner PCI PF.
> 
> Software usage example:
> -----------------------
> The most common way to use and map to the guest VM is by
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
> |   |I/O BAR to AQ |     | Other vfio      | |
> |   |rd/wr mapper  |     | functionalities | |
> |   +--------------+     +-----------------+ |
> |                                            |
> +------+-------------------------+-----------+
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
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> Signed-off-by: Parav Pandit <parav@nvidia.com>

I don't see an overview here though.


> ---
> changelog:
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
> Parav Pandit (2):
>   transport-pci: Introduce legacy registers access commands
>   transport-pci: Add legacy register access conformance section
> 
>  admin.tex                 |   5 +-
>  conformance.tex           |   2 +
>  transport-pci-vf-regs.tex | 115 ++++++++++++++++++++++++++++++++++++++
>  transport-pci.tex         |   2 +
>  4 files changed, 123 insertions(+), 1 deletion(-)
>  create mode 100644 transport-pci-vf-regs.tex
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

