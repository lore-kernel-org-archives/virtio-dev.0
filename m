Return-Path: <virtio-dev-return-12606-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137C6C77B7D
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:31:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E00A2ACA4
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:31:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50D689866DD
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:31:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4633A9841A9; Sat,  6 May 2023 02:31:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 306549866DA
	for <virtio-dev@lists.oasis-open.org>; Sat,  6 May 2023 02:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VfYOui1XPeSLl6imRPDMjQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683340302; x=1685932302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XFiXxBuGX4yNfhNk92oV5ALtbF0vmGFd6UuNmrd6f8=;
        b=IJ+lxAA7t4DKu5F8CNdCgzRv4yEzeBH4NoCRmGHAS/N6sH15Lsg/xAvoIzS99/CLjd
         rOiMng4XXoCyKi17O9NU4N8xVQrjKFSg69cO0M0nTUPiVqvjzawOZmxc1klYsYwnM+7P
         ZR1+8xGNz9L+iMSlGEvXOgfY0dCWa3FrZaUSi2xqhe4lO+a5qMjLhVN9xV/lJiuW2ryX
         igLo+cLRX9VqfIeNrSRgTvLSIOdlnDdnKZDcL4+VRG0JZRqefIIqbRBJbVPxYaJcoUjo
         9BM2bjsOlLy6CPz/rlJ8u+0WYJrGayA09pL3WTeq6QWPSwbZF8rEwF3R8HZ/my32ZCH9
         5cUg==
X-Gm-Message-State: AC+VfDzb3RK5DSnhDdDselTJb52Nkbgo55T3aW3X4j2eNAyP2SnfkXug
	+ORLn5+NPSjS50D/inMpI417yz/RhpSjW1vRMzZXGQCjNIn5PGq7ml7FdDyoDxle/KH8FqQrQw3
	KPKPrTGh1C5ODhQLo9ZNBQLJ0H50wCxDUhAWwR3K3fnayf4E8/LQNfbPnZQ==
X-Received: by 2002:ac2:53bc:0:b0:4e8:4106:ea93 with SMTP id j28-20020ac253bc000000b004e84106ea93mr1028625lfh.69.1683340302259;
        Fri, 05 May 2023 19:31:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eOpdI6iJ7h4LQiCLMjRbKsBN9ghgGMQUfupnq59mkQA8wxPhg1Bpp00Nd4FvYMoaoWo2N6WYmQ00mZ8FZKyo=
X-Received: by 2002:ac2:53bc:0:b0:4e8:4106:ea93 with SMTP id
 j28-20020ac253bc000000b004e84106ea93mr1028617lfh.69.1683340301925; Fri, 05
 May 2023 19:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com>
In-Reply-To: <20230506000135.628899-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 6 May 2023 10:31:30 +0800
Message-ID: <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	david.edmondson@oracle.com, sburla@marvell.com, yishaih@nvidia.com, 
	maorg@nvidia.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Sat, May 6, 2023 at 8:02=E2=80=AFAM Parav Pandit <parav@nvidia.com> wrot=
e:
>
> This short series introduces legacy registers access commands for the own=
er
> group member PCI PF to access the legacy registers of the member VFs.
>
> If in future any SIOV devices to support legacy registers, they
> can be easily supported using same commands by using the group
> member identifiers of the future SIOV devices.
>
> More details as overview, motivation, use case are further described
> below.
>
> Patch summary:
> --------------
> patch-1 adds administrative virtuqueue commands
> patch-2 adds its conformance section
>
> This short series is on top of latest work [1] from Michael.
> It uses the newly introduced administrative virtqueue facility with 3 new
> commands which uses the existing virtio_admin_cmd.
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00112.=
html
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
> VFs do not support I/O Space and thus VF BARs shall not indicate I/O Spac=
e.
>
> [b] cpu arch citiation:
> Intel 64 and IA-32 Architectures Software Developer=E2=80=99s Manual:
> The processor=E2=80=99s I/O address space is separate and distinct from
> the physical-memory address space. The I/O address space consists
> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH=
.
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
>                 |pci_dev_id =3D 0x100X   |
> +---------------|pci_rev_id =3D 0x0      |-----+
> |vfio device    |BAR0 =3D I/O region     |     |
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
>
> ---
> changelog:
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

So as replied in V1, I think it's not a good idea to invent commands
for a partial transport just for legacy devices. It's better either:

1) rebase or collaborate this work on top of the transport virtqueue

or

2) having a PCI over admin virtqueue transport, since this proposal
has already had BAR access, we can add config space access then it is
self-contained so we don't need to go through every corner case like
inventing dedicated commands to accessing some function that is
duplicated with capabilities. It will become yet another transport and
legacy support is just a good byproduct.

Thanks

>
> v0->v1:
> - addressed comments, suggesetions and ideas from Michael Tsirkin and Jas=
on Wang
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
>  admin.tex                     |   5 +-
>  conformance.tex               |   2 +
>  transport-pci-legacy-regs.tex | 133 ++++++++++++++++++++++++++++++++++
>  transport-pci.tex             |   2 +
>  4 files changed, 141 insertions(+), 1 deletion(-)
>  create mode 100644 transport-pci-legacy-regs.tex
>
> --
> 2.26.2
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

