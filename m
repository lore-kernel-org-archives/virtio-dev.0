Return-Path: <virtio-dev-return-12963-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1828FEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:20:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E6D760085
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:20:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5938698641D
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:20:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 451799863A9; Mon, 19 Jun 2023 16:20:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 311CD9863B0
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 16:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6_eeaRe_P9m6DZrUmJgDpA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191653; x=1689783653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plfr/ziNpyqL0Gib3L3p2plgqih+sibKhxA1J7cWXIU=;
        b=QfHWyDpWxbB2TwrC3BTJ+w/xJX6HsCI6KD4euSkjwOJuF22JgvlcJI5a+sf5tfxuSZ
         rhUpz9HeXIjTJKystPbMJa5MhzTSdCydSGMIQw6ZDF36pI6WGtJiDqAX+x8DnT+fqErj
         36IsGDTizSaEEjU80pGj1GfZFbs1/8eY1vP6Z/RfSm6ipHV5y+s7geyjovAkeGQ/TJ/O
         vFtj9pPF3MMOrt862Rjx7Z/sSiG6iCkBnrKZWnWCdhbs4/GYR2ytjAXLVJhFPGLd/eCf
         +oCmin0z0nz4s1O6t113x6CT05qm3XGo5Hu5pzorXSILaBSZTN46uIz/O6DXMhQbvLvQ
         jxvQ==
X-Gm-Message-State: AC+VfDwQZmVuZI6X8r7IjFSFxGSCLWuZk8ig+0tML2c06YmT3ezHoh+x
	VakXEYbpMAnqsTIgAmaulpjhyylTH0B4oQlE4GltleD36uAmUzd5p8OeL+GOoRFznzsuJ5UVIGL
	SV8ZjPXLpVcfQKXVkWnLeFCyCu4Tl
X-Received: by 2002:a5d:58f6:0:b0:30f:b9e7:478 with SMTP id f22-20020a5d58f6000000b0030fb9e70478mr6467290wrd.6.1687191653251;
        Mon, 19 Jun 2023 09:20:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52E0CUNV4Nrk67bibGcDLdGF0ZiYI3KDeDcDBBeTPsviVy0O2s4ZzZrSYESnJqwz/i3SQ9Hg==
X-Received: by 2002:a5d:58f6:0:b0:30f:b9e7:478 with SMTP id f22-20020a5d58f6000000b0030fb9e70478mr6467266wrd.6.1687191652830;
        Mon, 19 Jun 2023 09:20:52 -0700 (PDT)
Date: Mon, 19 Jun 2023 12:20:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230619121724-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230613173015.1244486-4-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v6 3/4] admin: Add group member legacy register access
 commands

On Tue, Jun 13, 2023 at 08:30:14PM +0300, Parav Pandit wrote:
> Introduce group member legacy common configuration and legacy device
> configuration access read/write commands.
> 
> Group member legacy registers access commands enable group owner driver
> software to access legacy registers on behalf of the guest virtual
> machine.
> 
> Usecase:
> ========
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
> =====================
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
> =========
> Above usecase requirements is solved by PCI PF group owner accessing
> its group member PCI VFs legacy registers using an admin virtqueue of
> the group owner PCI PF.
> 
> Two types of administration commands are added which read/write PCI VF
> registers.
> 
> Software usage example:
> =======================
> 
> 1. One way to use and map to the guest VM is by using vfio driver
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
> |   |rd/wr mapper& |     | functionalities | |
> |   | forwarder    |     |                 | |
> |   +--------------+     +-----------------+ |
> |                                            |
> +------+-------------------------+-----------+
>        |                         |
>    Config region                 |
>      access                Driver notifications
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
> 2. Continue to use the virtio pci driver to bind to the
>    listed device id and use it as in the host.
> 
> 3. Use it in a light weight hypervisor to run bare-metal OS.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v5->v6:
> - fixed previous missed abbreviation of LCC and LD
> v4->v5:
> - split from pci transport specific patch
> - split conformance to transport and generic sections
> - written the description of the command as generic with member
>   and group device terminology
> - reflected many section names to remove VF
> - rename fields from register to region
> - avoided abbreviation for legacy, device and config
> ---
>  admin-cmds-legacy-access.tex | 138 +++++++++++++++++++++++++++++++++++
>  admin.tex                    |  12 ++-
>  conformance.tex              |   2 +
>  3 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 admin-cmds-legacy-access.tex
> 
> diff --git a/admin-cmds-legacy-access.tex b/admin-cmds-legacy-access.tex
> new file mode 100644
> index 0000000..89a4f49
> --- /dev/null
> +++ b/admin-cmds-legacy-access.tex
> @@ -0,0 +1,138 @@
> +\subsubsection{Legacy Interfaces: legacy configuration access commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interfaces: legacy configuration access commands}

I think this is where all the theory of operation text should go.

> +
> +The group owner device can optionally enable the driver to access its member devices legacy common
> +configuration and device configuration region

we can just say "the legacy interface of member
devices"

> using following listed

using the following

> +administrative commands:

administration not administrative

> +
> +\begin{enumerate}
> +\item Legacy Common Configuration Region Write Command
> +\item Legacy common Configuration Region Read Command
> +\item Legacy Device Configuration Region Write Command
> +\item Legacy Device Configuration Region Read Command
> +\end{enumerate}
> +







> +\paragraph{Legacy Common Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Common Configuration Region Write Command}
> +
> +This command writes in a legacy common configuration region of a group member device.
> +This command follows \field{struct virtio_admin_cmd}.
> +This command uses following structure for \field{command_specific_data}:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_wr_data {
> +	u8 offset; /* Starting byte offset of the common configuration region to write */
> +	u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE.
> +The driver sets valid \field{offset} and associated \field{region_data} bytes to
> +write to the common configuration region.
> +
> +This command does not have any command specific result.
> +
> +\paragraph{Legacy Common Configuration Region Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Common Configuration Region Read Command}
> +
> +This command reads from a legacy common configuration region of a group member device.
> +This command follows \field{struct virtio_admin_cmd}.
> +This command uses following listed structure for \field{command_specific_data}:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_rd_data {
> +	u8 offset; /* Starting byte offset of the common configuration region to read */
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ.
> +
> +The driver sets valid \field{offset} of the region from where to read
> +\field{region_data}.
> +
> +When command completes successfully, \field{command_specific_result}
> +uses following listed structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_rd_result {
> +	u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +\paragraph{Legacy Device Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Device Configuration Region Write Command}
> +
> +This command writes in a legacy device configuration registers of a group member device.
> +This command follows \field{struct virtio_admin_cmd}.
> +This command uses following structure for \field{command_specific_data}:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_ld_reg_wr_data {
> +	u8 offset; /* Starting byte offset of the device configuration region to write */
> +	u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_WRITE.
> +The driver sets valid \field{offset} and associated \field{region_data} bytes to
> +the device configuration region.
> +
> +This command does not have any command specific result.
> +
> +\paragraph{Legacy Device Registers Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Device Configuration Region Read Command}
> +
> +This command reads from a legacy device configuration region of a group member device.
> +This command follows \field{struct virtio_admin_cmd}.
> +
> +This command uses following listed structure for \field{command_specific_data}:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
> +	u8 offset; /* Starting byte offset of the device configuration region to read */
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_READ.
> +The driver sets valid \field{offset} of the device configurationi region from
> +where to read \field{region_data}.
> +
> +When command completes successfully, \field{command_specific_result}
> +uses following listed structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_ld_reg_rd_result {
> +	u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\paragraph}{Legacy Interfaces: legacy configuration access commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
> +
> +If the group owner device supports legacy registers access for its group members,
> +the device MUST set all corresponding bits for commands
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ in
> +the command result of VIRTIO_ADMIN_CMD_LIST_QUERY in
> +\field{device_admin_cmd_opcodes}.
> +
> +The device MUST encode and decode legacy device specific registers using
> +little-endian format.
> +
> +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands for the invalid offset
> +which is outside the legacy common configuration register's address range.
> +
> +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands for the invalid offset
> +which is outside the legacy device specific register's address range.
> +
> +\drivernormative{\paragraph}{Legacy Interfaces: legacy configuration access commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
> +
> +The driver MUST encode and decode legacy device specific registers using
> +little-endian format.
> +
> +The driver SHOULD send VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands with a valid offset which
> +is in the legacy common configuration region address range.
> +
> +The driver SHOULD send commands VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ with a valid offset which is in the legacy
> +device specific configuration region address range.
> diff --git a/admin.tex b/admin.tex
> index fd3b97d..49a0b6f 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -117,7 +117,15 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \hline
>  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
>  \hline
> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +0x0002 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE & Write legacy common configuration region of a member device \\
> +\hline
> +0x0003 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ & Read legacy common configuration region of a member device \\
> +\hline
> +0x0004 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE & Write legacy device configuration region of a member device \\
> +\hline
> +0x0005 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ & Read legacy device configuration region of a member device \\
> +\hline
> +0x0006 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>  \hline
> @@ -286,6 +294,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  supporting multiple group types, the list of supported commands
>  might differ between different group types.
>  
> +\input{admin-cmds-legacy-access.tex}
> +
>  \devicenormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>  
>  The device MUST validate \field{opcode}, \field{group_type} and
> diff --git a/conformance.tex b/conformance.tex
> index 01ccd69..6bac4b0 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -260,6 +260,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Endianness}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
> +\item Section \ref{devicenormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
> +\item Section \ref{drivernormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
>  \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

