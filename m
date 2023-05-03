Return-Path: <virtio-dev-return-12504-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F2C7EE22
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 05:50:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18CF929FFA
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 05:50:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 083DB9866B2
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 05:50:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF3BB986585; Wed,  3 May 2023 05:50:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4F35986572
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 05:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OTts62KUMEmGMOIfR465IQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683093011; x=1685685011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnvjK1LLcqLcdp4vfRpf0RwbffHmzFN8LLdZwbjKtws=;
        b=Fs2hDsiUWGAkm8kgIZf3adoZRG2kxcAv2JVFJgT8bnCt2x3R2jjuwc0H12pP0/bJ7a
         JA6Y3dFLusTZNvyQAE/At5DBZOJeXVMgiOLvI+eQ2eYchugdqd6ZQ45UaejFKLDi6cOy
         ui7sF2rUhGHvssoriYfRIVWDo991eV1gOMiOQh05vKvZKxYy6EiUGp+oWTyCenObgbhM
         wB2yQqDmgaUias51ySLGM+TEQVebUG5fVA00WuwervAsekn/SztA7YrcBLRiuh2ltfYV
         DAUOyA4jN3QqvgcZDZARjUZ2iCeDWeUYALw+NBs/dMp1V41N+5PxhNAd4Oayx6c+sHec
         FR/A==
X-Gm-Message-State: AC+VfDzVZPFNb6jHPAcxbmRqjT5a3B/s4b6ZJXbaNGqF2V7jsNzAdt3r
	ATOFvG/U59ljHWR+kKWHI5ubu7mlS1bPDs+zUqtU11JPvNLszUZ3WJq6WyhMhgLxF+x2JW0NKie
	DGd8oz6UzOiPI+JjH3SAF+hKXuFdf
X-Received: by 2002:a5d:4e41:0:b0:306:2db9:a33a with SMTP id r1-20020a5d4e41000000b003062db9a33amr5762411wrt.33.1683093010922;
        Tue, 02 May 2023 22:50:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cJAc+FXJIXmE1yObfNqShfR3f7FRHC7XNty7mRzRkNRVnOJTKnosweolIPWrXzo9Ur+3Cnw==
X-Received: by 2002:a5d:4e41:0:b0:306:2db9:a33a with SMTP id r1-20020a5d4e41000000b003062db9a33amr5762398wrt.33.1683093010554;
        Tue, 02 May 2023 22:50:10 -0700 (PDT)
Date: Wed, 3 May 2023 01:50:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230503014838-mutt-send-email-mst@kernel.org>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230503032659.530330-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands

On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:
> This patch introduces legacy registers access commands for the owner
> group member PCI PF to access the legacy registers of the member VFs.
> 
> If in future any SIOV devices to support legacy registers, they
> can be easily supported using same commands by using the group
> member identifiers of the future SIOV devices.
> 
> More details as overview, motivation, use case are further described
> below.
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
> 
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
> ---
>  admin.tex                 |  5 ++-
>  transport-pci-vf-regs.tex | 84 +++++++++++++++++++++++++++++++++++++++
>  transport-pci.tex         |  2 +
>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 transport-pci-vf-regs.tex
> 
> diff --git a/admin.tex b/admin.tex
> index 648253c..852ee04 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -115,7 +115,10 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \hline \hline
>  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
>  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +0x0002 & VIRTIO_ADMIN_CMD_LREG_WRITE & Write legacy registers of a member device    \\
> +0x0003 & VIRTIO_ADMIN_CMD_LREG_READ & Read legacy registers of a member device    \\
> +0x0004 & VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY & Read the queue notification offset for legacy interface \\
> +0x0005 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>  \hline
> diff --git a/transport-pci-vf-regs.tex b/transport-pci-vf-regs.tex
> new file mode 100644
> index 0000000..16ced32
> --- /dev/null
> +++ b/transport-pci-vf-regs.tex
> @@ -0,0 +1,84 @@
> +\subsection{SR-IOV VFs Legacy Registers Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
> +
> +As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]} PCI VFs
> +do not support IOBAR. A PCI PF device can optionally enable driver to access
> +its member PCI VFs devices legacy common configuration and device configuration
> +registers using an administration virtqueue. A PCI PF group owner device that
> +supports its member VFs legacy registers access via the administration
> +virtqueue should supports following commands.
> +
> +\begin{enumerate}
> +\item Legacy Registers Write
> +\item Legacy Registers Read
> +\item Legacy Queue Notify Offset Query
> +\end{enumerate}
> +
> +\subsubsection{Legacy Registers Write}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access / Legacy Registers Write}
> +
> +Legacy registers write admin command follows \field{struct virtio_admin_cmd}.
> +This command writes legacy registers of a member VF device. Driver should write
> +appropriate register \field{size} depending on the width of the legacy
> +common registers or device specific registers.
> +Driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_WRITE.
> +Driver sets \field{group_type} to 1 for VFs.
> +Driver sets \field{group_member_id} to a valid VF number.
> +
> +The \field{command_specific_data} has following listed structure format:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_lreg_wr_data {
> +	u8 offset; /* Starting byte offset of the register(s) to write */
> +	u8 size; /* Number of bytes to write into the register. */
> +	u8 register[];

And maybe add
	u8 reserved[]; /* structure padding to multiple of 8 bytes */

> +};
> +\end{lstlisting}
> +
> +This command does not have any command specific result.
> +
> +\subsubsection{Legacy Registers Read}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access / Legacy Registers Read}
> +
> +Legacy registers read admin command follows \field{struct virtio_admin_cmd}.
> +This command reads legacy registers of a member VF device. Driver should write
> +appropriate register \field{size} depending on the width of the legacy
> +common configuration registers or device specific registers.
> +Driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_READ.
> +Driver sets \field{group_type} to 1 for VFs.
> +Driver sets \field{group_member_id} to a valid VF number.
> +
> +The \field{command_specific_data} has following listed structure format:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_lreg_rd_data {
> +	u8 offset; /* Starting byte offset of the register to read */
> +	u8 size; /* Number of bytes to read from the registers */
> +};
> +\end{lstlisting}
> +
> +When command completes successfully, command result contains following
> +listed content:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_lreg_rd_result {
> +	u8 registers[];
> +};
> +\end{lstlisting}
> +
> +\subsubsection{Legacy Queue Notify Offset Query}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access / Legacy Queue Notify Offset Query}
> +
> +This command returns the notify offset of the member VF for queue
> +notifications. This command follows \field{struct virtio_admin_cmd}.
> +Driver sets command opcode \field{opcode} to VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY.
> +There is no command specific data for this command.
> +Driver sets \field{group_type} to 1.
> +Driver sets \field{group_member_id} to a valid VF number.
> +
> +When command completes successfully, command result contains the queue
> +notification address in the listed format:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_lq_notify_query_result {
> +	u8 bar; /* PCI BAR number of the member VF */
> +	u8 reserved[7];
> +	le64 offset; /* Byte offset within the BAR */
> +};
> +\end{lstlisting}
> diff --git a/transport-pci.tex b/transport-pci.tex
> index ff889d3..b187576 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -1179,3 +1179,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>          re-examine the configuration space to see what changed.
>      \end{itemize}
>  \end{itemize}
> +
> +\input{transport-pci-vf-regs.tex}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

