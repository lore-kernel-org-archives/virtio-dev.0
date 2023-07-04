Return-Path: <virtio-dev-return-13219-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0C7EB64D9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:00:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E9A3157EE7
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:00:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC80E986717
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:00:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CFC8898408C; Tue,  4 Jul 2023 22:00:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6551986680
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Jul 2023 22:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 98AAnI1FPgy_FgOg-II6iQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688508044; x=1691100044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdQn63CbDtuW5olZJx0MYPAiA9kv8t/BPABT25wb8SE=;
        b=SSjGpZ4iwSMuLrKfxYlP7/uOng3AxqqhqtddcmEpobxNd0W6lDB9nKIjX3FMt3ujWi
         RNQTG9ltha1QPQuknkk9Fzm3JyjM1MLO2MQ/bbApMLlhxoqLLLEgrnKVKOdQkutD9zK5
         RhYtq8qnmuLe7vQMwconnP4/OUH2Gza5FrSPq+NMZgZganrLOnA+NxpgJ/e1M1ssBAG1
         zBVYfhf0btlz7CCY7FQkux6Qfi9wGXkvih9+HQivDyuX4a2IPj/GZzSIRDsRAx12FOK7
         p1eZeSgpLosyw+/o6V2f5qqTuYuuavHTaqOFhT50+KfuozF2DFBMqds+3Pm3NZS5zckV
         r3SA==
X-Gm-Message-State: AC+VfDwQXzOWo14foyFX5lxOkPKDuwpVxspNIatQ7/Wdw0ZaLol6RwaG
	MkghQil2n2of1pTsjZNwlw8F7wd6xDCLep7+pkzUe1/dGl6HS3RuM6IJ0Uxu5r/N+AzNZwVWGWj
	ItNYSMGXH1a5rdJTzFgfQSLGzWCzy
X-Received: by 2002:a7b:cbd0:0:b0:3fa:8db4:91ec with SMTP id n16-20020a7bcbd0000000b003fa8db491ecmr11115297wmi.10.1688508044413;
        Tue, 04 Jul 2023 15:00:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LIIGmX1DZzdZdg+QsGsv6j0lo4dwNrUOr1YQlbD8Wmg6c5d0SJMd+TK1LfLoyDol0fFRXTw==
X-Received: by 2002:a7b:cbd0:0:b0:3fa:8db4:91ec with SMTP id n16-20020a7bcbd0000000b003fa8db491ecmr11115277wmi.10.1688508043945;
        Tue, 04 Jul 2023 15:00:43 -0700 (PDT)
Date: Tue, 4 Jul 2023 18:00:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230704171700-mutt-send-email-mst@kernel.org>
References: <20230630042006.1569920-1-parav@nvidia.com>
 <20230630042006.1569920-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230630042006.1569920-4-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v8 3/4] admin: Add group member legacy register access
 commands

On Fri, Jun 30, 2023 at 07:20:05AM +0300, Parav Pandit wrote:
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
> its group member PCI VFs legacy registers using the administration
> commands of the group owner PCI PF.
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
> v7->v8:
> - remove empty line at the end of file
> - removed white space at the end
> - addressed comments from Michael add link to pci
> - renamed region to region_data
> - made region_data width to be 16 bytes to cover for 8 bytes offset
> - moved generic notification region related normative from pci to
>   generic section
> v6->v7:
> - changed administrative to administration
> - renamed admin-access.tex to admin-interface.tex
> - large rewrite ad generic admin commands instead of pci
> - added theory of operation section
> - added driver notification region query command
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
>  admin-cmds-legacy-interface.tex | 206 ++++++++++++++++++++++++++++++++
>  admin.tex                       |  14 ++-
>  conformance.tex                 |   2 +
>  3 files changed, 221 insertions(+), 1 deletion(-)
>  create mode 100644 admin-cmds-legacy-interface.tex
> 
> diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
> new file mode 100644
> index 0000000..8036a0b
> --- /dev/null
> +++ b/admin-cmds-legacy-interface.tex
> @@ -0,0 +1,206 @@
> +\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interface}
> +
> +When the member device cannot support certain transport specific
> +functionality of a legacy interface, it is difficult to compose a
> +transitional group member device. In such scenario, a owner device
> +can provide the legacy interface functionality.
> With such support,
> +the member device driver can utilize the group owner device driver legacy
> +interface functionality, thereby it can supply either a transitional device
> +or a legacy device for the guest virtual machine.

In some systems, there's need to support utilizing legacy drivers
with devices that do not directly support the legacy interface.
In such scenarios, an owner device of a group
can provide the legacy interface functionality for group members.
The driver of an owner device can then access the legacy
interface of a member device on behalf of the legacy member
device driver.



> For example a PCI VF
> +group member device
> do not support I/O BAR region functionality. For such
> +limitation, a PCI PF group owner device support accessing member device's legacy
> +configuration region using the administration commands. These administration
> +commands are executed by the driver of the owner device when requested by the
> +driver of the member device. For example, the member device driver
> +intercepts configuration accesses done by the legacy driver and forwards
> +such access request to the owner device driver; the owner device driver fulfil
> +such requests by executing administration commands on the group owner device.

For example, with the SR-IOV group type, group members (VFs) can not
present a legacy interface in an I/O BAR in BAR0 as expected by the
legacy pci driver. If the legacy driver is running inside a virtual
machine, the hypervisor executing the virtual machine can
present a virtual device with an I/O BAR in BAR0,
intercept the legacy driver accesses to this I/O BAR and forward them
to the driver of the group owner device (PF) using group
administration commands.




> +The group owner device support following administration commands for legacy
> +commong configuration and device configuration region access:

The following commands support such legacy interface functionality:


> +
> +\begin{enumerate}
> +\item Legacy Common Configuration Region Write Command
> +\item Legacy Common Configuration Region Read Command
> +\item Legacy Device Configuration Region Write Command
> +\item Legacy Device Configuration Region Read Command
> +\end{enumerate}


\begin{enumerate}
\item Legacy Interface Common Configuration Write Command
\item Legacy Interface Common Configuration Read Command
\item Legacy Interface Device Configuration Write Command
\item Legacy Interface Device Configuration Read Command
\end{enumerate}


> +
> +Accessing the member device legacy regions using these commands has the same
> +effect as accessing it using the the legacy interface defined by the transport
> +of the member device.

These commands are currently only defined for the SR-IOV group type
and have, generally, the same effect as member device
accesses through a legacy interface.
See sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout


> +
> +\paragraph{Legacy Common Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interface / Common Configuration Region Write Command}

Legacy Interface Common Configuration Write Command

and fix the label accordingly.


> +
> +This command writes in a legacy common configuration region of a group member device.

This command has the same effect as writing into
the virtio common configuration structure (excluding
the device-specific configuration)
through the legacy interface.


> +This command follows \field{struct virtio_admin_cmd}.

drop this.

> +This command uses following structure for \field{command_specific_data}:

\field{command_specific_data} has the following structure:

> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_wr_data {
> +        u8 offset; /* Starting byte offset of the common configuration region to write */
> +        u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +The driver sets valid \field{offset} and associated \field{region_data} bytes to
> +write to the common configuration region.

The command has the same effect as writing \field{region_data}
at offset \field{offset} the virtio common configuration structure
when using the legacy interface. The length of \field{region_data}
is simply the length of \field{struct
virtio_admin_cmd_legacy_common_cfg_wr_data}, minus 1
(for \field{offset}).



> +
> +This command does not have any command specific result.

This command does not use \field{command_specific_result}.



---------------------------------



Got up to this point. Can you try changing the rest to match?


> +
> +\paragraph{Legacy Common Configuration Region Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Common Configuration Region Read Command}
> +
> +This command reads from a legacy common configuration region of a group member device.
> +This command follows \field{struct virtio_admin_cmd}.
> +This command uses following structure for \field{command_specific_data}:
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
> +uses following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_rd_result {
> +        u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +\paragraph{Legacy Device Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Region Write Command}
> +
> +This command writes in a legacy device configuration region of a group member device.
> +This command follows \field{struct virtio_admin_cmd}.
> +This command uses following structure for \field{command_specific_data}:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_reg_wr_data {
> +        u8 offset; /* Starting byte offset of the device configuration region to write */

let's add some padding? Maybe 7 bytes? Will help align region_data too.

> +        u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_WRITE.
> +The driver sets valid \field{offset} and associated \field{region_data} bytes to
> +the device configuration region.
> +
> +This command does not have any command specific result.
> +
> +\paragraph{Legacy Device Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Region Read Command}
> +
> +This command reads from a legacy device configuration region of a group member device.
> +This command follows \field{struct virtio_admin_cmd}.
> +
> +This command uses following structure for \field{command_specific_data}:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
> +        u8 offset; /* Starting byte offset of the device configuration region to read */
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_READ.
> +The driver sets valid \field{offset} of the device configurationi region from
> +where to read \field{region_data}.
> +
> +When command completes successfully, \field{command_specific_result}
> +uses following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_reg_rd_result {
> +        u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +\paragraph{Legacy Driver Notification Region Query}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications Region Query}
> +
> +Even though the driver notifications can be communicated through the
> +administration command, if the group owner device or group member device
> +supports such notifications using a memory-mapped operation or I/O operation,
> +they are sent to the device by accessing this notification region using memory
> +or I/O operation.
> +
> +A group owner device optionally support querying driver notifications region
> +using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
> +This command does not have any command specific data.
> +
> +When command completes successfully, \field{command_specific_result}
> +uses following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_notify_query_entry {
> +        u8 region_data[16];
> +};
> +
> +struct virtio_admin_cmd_legacy_notify_query_result {
> +	struct virtio_virtio_admin_cmd_legacy_notify_query_entry entries[];
> +};
> +\end{lstlisting}
> +
> +The driver should pick the suitable entry when multiple entries are supplied
> +by the device.
> +
> +Refer to the specific transport section for the definition of the
> +\field{region_data}.
> +
> +\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
> +
> +If the group owner device supports legacy region access for its group member
> +devices, the device MUST set all corresponding bits for commands
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
> +which is outside the legacy common configuration region's address range.
> +
> +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands for the invalid offset
> +which is outside the legacy device specific region's address range.
> +
> +The device SHOULD support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command for
> +driver notifications. If the group owner device supports driver
> +notifications region for its group member devices, the device MUST set
> +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY in the command result of
> +VIRTIO_ADMIN_CMD_LIST_QUERY in \field{device_admin_cmd_opcodes}.
> +
> +When the driver accesses the legacy region of the member device using
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ
> +commands, device MUST function as if they are accessed by the legacy interface
> +defined by the transport of the member device.
> +
> +\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
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
> +
> +The group member driver SHOULD use the notification region supplied by the group
> +owner device.
> diff --git a/admin.tex b/admin.tex
> index fd3b97d..0de26a9 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -117,7 +117,17 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
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
> +0x0006 & VIRTIO_ADMIN_CMD_LEGACY_DEV_NOTIFY_QUERY & Query notification region for a member device \\
> +\hline
> +0x0007 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>  \hline
> @@ -286,6 +296,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  supporting multiple group types, the list of supported commands
>  might differ between different group types.
>  
> +\input{admin-cmds-legacy-interface.tex}
> +
>  \devicenormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>  
>  The device MUST validate \field{opcode}, \field{group_type} and
> diff --git a/conformance.tex b/conformance.tex
> index 01ccd69..dc00e84 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -260,6 +260,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Endianness}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
> +\item Section \ref{devicenormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
> +\item Section \ref{drivernormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
>  \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

