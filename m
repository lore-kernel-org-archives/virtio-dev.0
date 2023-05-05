Return-Path: <virtio-dev-return-12568-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02CBC77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 03:27:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 184AE23D5E
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 03:27:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF5E99866BC
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 03:27:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3351986654; Fri,  5 May 2023 03:27:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A413798665E
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 03:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: I-ziNLmfP9223LcVpuxvjQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683257219; x=1685849219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDOMtYXa43dUG35QRHmxRw/LEflNB/GzfKDuFDFhHe0=;
        b=mDjdia4JwEqCOGHoIf1sNLygxv7PowhuSaOXt699Si1wnwtfkiklNccNc6OEJVcF6A
         xVklzV4epM3YPeJT44NNohJvG85Z2v1Dsstnmsx+VqgD/0Ala4hJmLaw+Xs4qa4kdZKq
         cee2skEQ+XJk8rM+8FJmVtuGwUrXnCPzQmwB9jSGC8eWeKkVaXCKf00mujNjN55niL51
         tjjTzC3u9XmNC8w0Ph4JQ+1RI4KkJDjL2kIYsq3ZMTebGKVn88oJcd6liuLHG8IUvznz
         KpCXObM9n5k4tqd0lzrwc2SKA6Yf94EpE7Z+6sBDxjEaCfPCTtB4yWHiWYeAypv8pO8O
         7gCw==
X-Gm-Message-State: AC+VfDxdYGczBzzBrpJBhMUxj/ENjiHtMQ7J0g4iEMiHyH2edaoReNDJ
	RvVTMEdDnW2Vo4TxP+kZff45PArzMvjRjma8LPswvZZxZK55RsiViTCXjgACbMkLmBGsc232RF/
	iiB8J2wLm/uEIwewfaRNppyQpKzfC
X-Received: by 2002:a05:6a00:24d4:b0:635:c8e4:ed0f with SMTP id d20-20020a056a0024d400b00635c8e4ed0fmr594968pfv.11.1683257219547;
        Thu, 04 May 2023 20:26:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zj1ClVY4m5EOgJmLN0HJ7fkbNjjyj4Tzjnn7mPVHpdeiacqc5b/kvJFkhmrW+Zz915HWc0g==
X-Received: by 2002:a05:6a00:24d4:b0:635:c8e4:ed0f with SMTP id d20-20020a056a0024d400b00635c8e4ed0fmr594947pfv.11.1683257219087;
        Thu, 04 May 2023 20:26:59 -0700 (PDT)
Message-ID: <dba64a65-0538-a060-47a1-24d30f42ca49@redhat.com>
Date: Fri, 5 May 2023 11:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com
Cc: sburla@marvell.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230503032659.530330-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands


在 2023/5/3 11:26, Parav Pandit 写道:
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
>     virtio devices to the guest VM at scale of thousands,
>     typically, one to eight devices per VM.
>
> 2. A hypervisor/system needs to provide such devices using a
>     vendor agnostic driver in the hypervisor system.
>
> 3. A hypervisor system prefers to have single stack regardless of


So the "single stack" is kind of misleading, you need a dedicated virtio 
mediation layer which has different code path than a simpler vfio-pci 
which is completely duplicated with vDPA subsystem. And you lose all the 
advantages of vDPA in this way. The device should not be designed for a 
single type of software stack , it need to leave the decision to the 
hypervisor/cloud vendors.


>     virtio device type (net/blk) and be future compatible with a
>     single vfio stack using SR-IOV or other scalable device
>     virtualization technology to map PCI devices to the guest VM.
>     (as transitional or otherwise)
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
>                  +----------------------+
>                  |pci_dev_id = 0x100X   |
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
>         |                         |


So the mapper here is actually the control path mediation layer which 
duplicates with vDPA.


>    +----+------------+       +----+------------+
>    | +-----+         |       | PCI VF device A |
>    | | AQ  |-------------+---->+-------------+ |
>    | +-----+         |   |   | | legacy regs | |
>    | PCI PF device   |   |   | +-------------+ |
>    +-----------------+   |   +-----------------+
>                          |
>                          |   +----+------------+
>                          |   | PCI VF device N |
>                          +---->+-------------+ |
>                              | | legacy regs | |
>                              | +-------------+ |
>                              +-----------------+
>
> 2. Virtio pci driver to bind to the listed device id and
>     use it as native device in the host.


How this can be done now?


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
>    added, a pci device still needs to have existing capabilities
>    in the legacy configuration space and hypervisor driver do not
>    need to access them
> ---
>   admin.tex                 |  5 ++-
>   transport-pci-vf-regs.tex | 84 +++++++++++++++++++++++++++++++++++++++
>   transport-pci.tex         |  2 +
>   3 files changed, 90 insertions(+), 1 deletion(-)
>   create mode 100644 transport-pci-vf-regs.tex
>
> diff --git a/admin.tex b/admin.tex
> index 648253c..852ee04 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -115,7 +115,10 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   \hline \hline
>   0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
>   0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +0x0002 & VIRTIO_ADMIN_CMD_LREG_WRITE & Write legacy registers of a member device    \\
> +0x0003 & VIRTIO_ADMIN_CMD_LREG_READ & Read legacy registers of a member device    \\
> +0x0004 & VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY & Read the queue notification offset for legacy interface \\
> +0x0005 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
>   \hline
>   0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>   \hline
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
> +};
> +\end{lstlisting}


So this actually implements a transport, I wonder if it would be better 
(and simpler) to do it on top of the transport vq proposal:

https://lists.oasis-open.org/archives/virtio-comment/202208/msg00003.html

Then it aligns with SIOV natively.

Or to make it more general like PCI over admin virtqueue.

Thanks


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
>           re-examine the configuration space to see what changed.
>       \end{itemize}
>   \end{itemize}
> +
> +\input{transport-pci-vf-regs.tex}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

