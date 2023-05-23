Return-Path: <virtio-dev-return-12785-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DE8C7EE26
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 06:39:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1DA91157F06
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 06:39:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0ECB8986402
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 06:39:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0371A9863BA; Tue, 23 May 2023 06:39:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E59A29863C0
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 May 2023 06:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4UGBs21IMq2eRALtDdaQiA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684823943; x=1687415943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ8wqrvnoBbegGcvMao/RzAb82jj7I5ueKeSukCK1xQ=;
        b=UfV3zAHMI2b5m7ryrUrhYKLL3hoLtA5xvtSAIGB4vPo3BfBz9R3jekQp44dv+ZzphR
         rixM+ybCe7NWdS0N08mAKy8VLtzRp2RUm02ixFzB22ZVnneNRl0H7z+pC14pQolta4/W
         KjvwXTUOaviOUU80J3Kv5V72q4UcBNBAr9L69JgCJcEnOjtu05z3tw8a80R/yoTnWKmd
         nmYYn8Jj87CiCYONmKGyAc0KRAgrR76+UHLhAx+VRqIL9SYtucl28qKneMbMWpApCg7w
         oMlDykOJqVYuA22Lq9Pi9WD+oeFHBuMxvd2ZgWRwxNZe2L9MXxFjtlxsEThMR1RgZJnj
         qyEg==
X-Gm-Message-State: AC+VfDxFcU8Q2u9hfucL7cz57tvyyU1CtBr9nPBnvXiKXX8JiXaK9oIL
	VnpumQrVBjLtLA26nHKH+oEGrThwN0BFp+/cuXUZvvXooj4QpST7wcUWEmz9bOf04paSTQfIKcF
	axhkHNbfNPMfFEa78bJsc+arsxPKu
X-Received: by 2002:adf:da45:0:b0:309:5acf:91e6 with SMTP id r5-20020adfda45000000b003095acf91e6mr8080774wrl.29.1684823942915;
        Mon, 22 May 2023 23:39:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5k2P/K027iS21XE6NHXaaQIfxIxFeK7DQYtOq1XuzdGBf5LIHaUxn79i+lXhHXOKHzjGMCEw==
X-Received: by 2002:adf:da45:0:b0:309:5acf:91e6 with SMTP id r5-20020adfda45000000b003095acf91e6mr8080753wrl.29.1684823942475;
        Mon, 22 May 2023 23:39:02 -0700 (PDT)
Date: Tue, 23 May 2023 02:38:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230523022226-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230506000135.628899-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Sat, May 06, 2023 at 03:01:33AM +0300, Parav Pandit wrote:
> This short series introduces legacy registers access commands for the owner
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


Just thought of an issue: one use-case this can't address is SVQ.
Specifically, legacy has:

/* A 32-bit r/w PFN for the currently selected queue */
#define VIRTIO_PCI_QUEUE_PFN            8


this can only address up to 40 bits which might be ok for legacy guests,
but if instead we want the queue to live in host memory (this is what
SVQ does) then this does not work as host is likely to have more than
2^40 byte memory.

Further, one of advantages of modern is that used ring can live
in host memory with aliasing when available is passed through directly
(only with split, not packed). Again, does not work if we mirror
legacy.

All this does not mean this specific effort has to die, but I would
like us to better document how and when does device switch to
and from legacy mode, and for the switch to be somehow
reusable for solutions that are closer to vdpa.

Does enabling legacy commands cause the switch?  Or should we
add a LEGACY_PCI command to enable/disable? I kind of like
the second option ...


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

