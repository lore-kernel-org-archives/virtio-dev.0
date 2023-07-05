Return-Path: <virtio-dev-return-13234-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394E6C0015E
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 11:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 940D3120D6F
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 11:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED81E98687A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 11:05:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5638B98671A; Wed,  5 Jul 2023 11:05:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1BC0986718
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Jul 2023 11:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: P4u2U-h_M9GHuWigDOEZrA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688555088; x=1691147088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xEE3+kaj0EV/UFNJwSXvnZnVlbU1x9gnI+JgtakQNI=;
        b=T1wCUwzUOonrddS4k972+96SCM+W7jdMgwEL3fZhtQkdDVJ5G2KijGao/ZvGBK9uLX
         rRw6T80XxucjJ8I+VOxwEXSBEM9MsXZ/fl4t6Tw5YFLEZpHUJ6DJwqpuvveEeCxAx+Rb
         U/ua6AW3E1ebHJM3CKUNPT4aPL9wouk5PpfUquw4XTztK2oWX/JNcZQa9hNdG689QLMb
         ecFpumHOQDM0MoQKfkLtROVDwyJh+ksAee1/0On8nSOkE/fro9oGehXmCa9e3o1nqe5h
         j0in0ZHJdAanAObiI18bw6hJkvMBjIcwOdz5cPNwjKTt3RWgEQv5eBmcYfasykInJBQB
         h9Dg==
X-Gm-Message-State: AC+VfDyT4I2V/OpP6EdEj8jXmCFjwS7uD7v0QBN5/asSM6ei/mGfa4A9
	Xj5bmfKf/EzaLRlEFiohj+Wwvc56riN30aqzIZ1LDJc/DCDvBxpzH9R9kyXzn4AkZjZDsJQCLRs
	7hcem27L5UyWKmeMJ4hEI6ru8rEEk
X-Received: by 2002:a05:600c:2299:b0:3fb:b2a5:aeac with SMTP id 25-20020a05600c229900b003fbb2a5aeacmr13844802wmf.20.1688555087975;
        Wed, 05 Jul 2023 04:04:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+4/mL0CSo5u2zg4XUg8f2gfs6xXcfCFk1OBc6QQEhMoM78fLereUU8C1nwbkldjNs4UdO2w==
X-Received: by 2002:a05:600c:2299:b0:3fb:b2a5:aeac with SMTP id 25-20020a05600c229900b003fbb2a5aeacmr13844782wmf.20.1688555087432;
        Wed, 05 Jul 2023 04:04:47 -0700 (PDT)
Date: Wed, 5 Jul 2023 07:04:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230705044626-mutt-send-email-mst@kernel.org>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230704233724.22394-4-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v9 3/4] admin: Add group member legacy
 register access commands

On Wed, Jul 05, 2023 at 02:37:23AM +0300, Parav Pandit wrote:
> Introduce group member legacy common configuration and legacy device
> configuration access read/write commands.
> 
> Group member legacy configuration structure access commands enable group
> owner driver software to access legacy configuration structure on behalf
> of the guest virtual machine.
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

Ok we are making progress.
Unfortunately in the below I'm repeating some comments from v8. take
care.


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
>  admin-cmds-legacy-interface.tex | 205 ++++++++++++++++++++++++++++++++
>  admin.tex                       |  14 ++-
>  conformance.tex                 |   2 +
>  3 files changed, 220 insertions(+), 1 deletion(-)
>  create mode 100644 admin-cmds-legacy-interface.tex
> 
> diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
> new file mode 100644
> index 0000000..09001d5
> --- /dev/null
> +++ b/admin-cmds-legacy-interface.tex
> @@ -0,0 +1,205 @@
> +\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interface}
> +
> +In some systems, there is a need to support utilizing the legacy driver with
> +the device that do not directly support the legacy interface. In such scenarios,
> +a group owner device can provide the legacy interface functionality for the
> +group member devices. The driver of an owner device can then access the legacy
> +interface of a member device on behalf of the legacy member device driver.
> +
> +For example, with the PCI SR-IOV group type, group members (VFs) can not present
> +the legacy interface in an I/O BAR in BAR0 as expected by the legacy pci driver.
> +If the legacy driver is running inside a virtual machine, the hypervisor
> +executing the virtual machine can present a virtual device with an I/O BAR in
> +BAR0. The hypervisor intercepts the legacy driver accesses to this I/O BAR and
> +forwards them to the group owner device (PF) using group administration commands.
> +
> +The following commands support such legacy interface functionality:
> +
> +\begin{enumerate}
> +\item Legacy Common Configuration Write Command
> +\item Legacy Common Configuration Read Command
> +\item Legacy Device Configuration Write Command
> +\item Legacy Device Configuration Read Command
> +\end{enumerate}
> +
> +These commands are currently only defined for the PCI SR-IOV group type and

We call it SR-IOV group type not PCI SR-IOV group type. Please be
consistent.

> +have, generally, the same effect as member device accesses through a legacy
> +interface listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}.
> +
> +\paragraph{Legacy Common Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interface / Common Configuration Write Command}

Fix label.

> +
> +This command has the same effect as writing into the virtio common configuration
> +structure through the legacy interface. \field{command_specific_data} has the
> +following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_wr_data {
> +        u8 offset; /* Starting byte offset within the common configuration structure to write */
> +        u8 reserved[7];
> +        u8 region_data[];

I am all for something more specific than offset/data but region seems
pointless. And why apply just to data not offset?
How about legacy_offset/legacy_data?

> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE.
> +The driver sets valid \field{offset} and associated \field{region_data} bytes to
> +write to the common configuration region.
> +
> +This command does not use \field{command_specific_result}.
> +

Let's make this consistent with other commands, even if it means we
repeat ourselves a bit. And length is not documented and has to be:


>>>

For the command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE \field{opcode}
is set to 0x2.
The \field{group_member_id} refers to the member device to be accessed.
The \field{command_specific_data} is in the format
\field{struct virtio_admin_cmd_legacy_common_cfg_wr_data} describing the
access to be performed.

Within \field{struct virtio_admin_cmd_legacy_common_cfg_wr_data}:
The \field{offset} refers to the offset to write within the virtio common configuration
structure, and excluding the device-specific configuration. For the
SR-IOV group type, the layout used refers to the one used for the legacy interface
as listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}, except that little endian format is assumed unconditionally.
The length of the data to write is simply the length of \field{region_data}.

No length or alignment restrictions are placed on the value
of the \field{offset} and the length of the \field{region_data}, except that the resulting access
refers to a single field and is completely within the virtio common configuration structure,
excluding the device-specific configuration.

This command has no command specific result.


Try to apply this to other commands please.

> +\paragraph{Legacy Common Configuration Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Common Configuration Read Command}
> +
> +This command has the same effect as reading from the virtio common configuration
> +structure through the legacy interface. \field{command_specific_data} has the
> +following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_rd_data {
> +	u8 offset; /* Starting byte offset within the common configuration structure to read */
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
> +\paragraph{Legacy Device Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Write Command}
> +
> +This command has the same effect as writing into the virtio device configuration
> +structure through the legacy interface. \field{command_specific_data} has the
> +following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_reg_wr_data {
> +        u8 offset; /* Starting byte offset within the device configuration structure to write */
> +        u8 reserved[7];
> +        u8 region_data[];
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_WRITE.
> +The driver sets valid \field{offset} and associated \field{region_data} bytes to
> +the device configuration region.
> +
> +This command does not use \field{command_specific_result}.
> +
> +\paragraph{Legacy Device Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Read Command}
> +
> +This command has the same effect as reading from the virtio device configuration
> +structure through the legacy interface. \field{command_specific_data} has the
> +following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
> +        u8 offset; /* Starting byte offset within the device configuration structure to read */
> +};
> +\end{lstlisting}
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_READ.
> +The driver sets valid \field{offset} within the device configuration structure from
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
> +\paragraph{Legacy Driver Notification Query}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications Query}

Drop "Query", this talks about notifications generally.

> +
> +Even though the driver notifications can be communicated through the
> +administration command, if the group owner device or group member device
> +supports such notifications using a memory-mapped operation or I/O operation,
> +they are sent to the device by accessing such a notification region using 
> +a memory or an I/O operation.

> +
> +A group owner device optionally support querying driver notifications region
> +using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.

The driver of the owner device can send a driver notification to the member
device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
with the \field{offset} matching \fielf{Queue Notify} and the
\field{region_data} containing the virtqueue index to be notified.

However, as many administration commands are used for slow path
configuration, a separate fast path mechanism for such notifications is
desired. For the SR-IOV group type, the optional command
VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY addresses this need by returning to
the driver one or more addresses which to be used to send
such driver notifications.


> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
> +This command does not use \field{command_specific_data}.
> +
> +When command completes successfully, \field{command_specific_result}
> +uses following structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_notify_query_entry {
> +        u8 region_data[16];

So everything is pci specific but this one we for some reason decided
to keep generic. I'd just make it pci specific, keep things simple.
We'll generalize if and when other transports want this. Which I doubt.


> +};
> +
> +struct virtio_admin_cmd_legacy_notify_query_result {
> +	struct virtio_virtio_admin_cmd_legacy_notify_query_entry entries[];
> +};
> +\end{lstlisting}

here I'm not going to repeat myself. same comments as other commands.

> +
> +The driver picks the suitable entry when multiple entries are supplied
> +by the device.

How does driver know how much to allocate?
I think it allocates an extra entry, inits it to 0, then after the
command checks whether it was modified. If yes makes the buffer
larger. Makes sense? Complex though ...
Can we place an upper limit on # of entries? 4 seems sufficient no?
And what is "suitable"? I am guessing it just picks the
*first* entry that it is able to utilize.
And devices list them in the order of preference.

> +
> +Refer to the specific transport section for the definition of the
> +\field{region_data}.

Transport sections are huge. Links please do not make the reader guess.

> +
> +This command is currently only defined for the PCI SR-IOV group type.
> +\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
> +
> +If the group owner device supports legacy region access for its group member
> +devices, the device MUST set all corresponding bits for commands
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ in
> +the command result
> of VIRTIO_ADMIN_CMD_LIST_QUERY in
> +\field{device_admin_cmd_opcodes}.


It's enough to just say what is supported:

A device MUST either support all of, or none of 
VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ.



> +
> +The device MUST encode and decode legacy device specific registers using
> +little-endian format.

For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
the device MUST decode and encode (respectively) the value of
the \field{region_data} using the little-endian format.



> +
> +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands for the invalid offset
> +which is outside the legacy common configuration region's address range.

The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands where the value of the
\field{offset} and the length of the \field{region_data} does not refer
to a single field or is not completely within the virtio common
configuration structure, excluding the device-specific configuration.


> +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands for the invalid offset
> +which is outside the legacy device specific region's address range.

The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ and
VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands where the value of the
\field{offset} and the length of the \field{region_data} does not refer
to a single field or is not completely within the device-specific
configuration.



> +
> +The device SHOULD support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command for
> +driver notifications. If the group owner device supports driver
> +notifications region for its group member devices, the device MUST set
> +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY in the command result of
> +VIRTIO_ADMIN_CMD_LIST_QUERY in \field{device_admin_cmd_opcodes}.

I don't get what does all this mean. Seems to say if you support
VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY then set it. Reader should know
that anyway.

Should we say:

If the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY it MUST
also support all of
VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ.


> +
> +When the driver accesses the legacy region of the member device using
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ
> +commands, device MUST function as if they are accessed by the legacy interface
> +defined by the transport of the member device.

The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE MUST
have the same effect as writing into the virtio common configuration
structure through the legacy interface.

repeat for the other commands.


Also, explain about notification: is it true that writing
at this address has the same effect as writing into Queue Notify?


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

Use how? More specific please. Also, only if the command is supported.


Document how is notification thingy used.



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


Grammar fix + drop "region":

 VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ & Writes into the legacy common configuration structure



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

