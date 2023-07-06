Return-Path: <virtio-dev-return-13295-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89CCEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 22:36:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F18072B024
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 22:36:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7C9B986810
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 22:36:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7FD24983B4A; Thu,  6 Jul 2023 22:36:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B1B99867B6
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 22:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4a4SohWQOM2gybInjBiCOw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682969; x=1691274969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRkltMmWDHJ1zEMY91TxkTLtrZMpe6BJZGeREBgiQy4=;
        b=Y5MbO1fTt/joAXM+7B5ZPZZtwT38U/I6a2Sfm0ACnL/vC2ZOxFg2rbldlfXWFlKNEI
         kJZVMH3BL8sEqv6/9U0FqkWqgfrZGcLxVR/A31r3Minm39+HJxUsmW3le/txkWuHpUM4
         UP7Hf6UeYH/ZASv3DrODinelSgIk62VfCM3DtUosaU7uGELYuZeu9iN/J6ELfhutYuFe
         vclPHO4gY+rLf1T9khgLSuyL9styBv6PAksyqvXuMJGE8sQ3ZhMCo0s3rxc41Mu3TgQp
         9mihasmD76gLlAaX71XZpW63f18YOUPWyEvfqcPC7YVuDfLSTB2Tes0CVKq8eOVZ5ue4
         Wsbw==
X-Gm-Message-State: ABy/qLYjrp15rKOx+PXfXlvUQGQaoDm6u4VXyIHmDY1Rw54d7UbeKcKr
	VHL4GtT4LZylUz/Zb6F4PqyyQlltQNWgvX1l1W1V44Xm338mgO82AZSsY0uh4VRdFjdgcWNul8+
	lHjUy85CfJChOlRFl2BhtwiZxNpzK
X-Received: by 2002:a7b:cd8c:0:b0:3fa:991c:2af9 with SMTP id y12-20020a7bcd8c000000b003fa991c2af9mr2347575wmj.16.1688682968972;
        Thu, 06 Jul 2023 15:36:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1xPraD8kOBbnNYkrksgd8dRSsgT+MFoOhKntSIYpcLnNmymOmZMHU39OBht0yA3ePMOHXVQ==
X-Received: by 2002:a7b:cd8c:0:b0:3fa:991c:2af9 with SMTP id y12-20020a7bcd8c000000b003fa991c2af9mr2347557wmj.16.1688682968438;
        Thu, 06 Jul 2023 15:36:08 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:36:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230706174904-mutt-send-email-mst@kernel.org>
References: <20230706212722.97973-1-parav@nvidia.com>
 <20230706212722.97973-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230706212722.97973-4-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v11 3/3] admin: Add group member legacy register access
 commands

On Fri, Jul 07, 2023 at 12:27:22AM +0300, Parav Pandit wrote:
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

Some more comments.


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
>  admin-cmds-legacy-interface.tex | 302 ++++++++++++++++++++++++++++++++
>  admin.tex                       |  14 +-
>  conformance.tex                 |   2 +
>  3 files changed, 317 insertions(+), 1 deletion(-)
>  create mode 100644 admin-cmds-legacy-interface.tex
> 
> diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
> new file mode 100644
> index 0000000..1ecb5af
> --- /dev/null
> +++ b/admin-cmds-legacy-interface.tex
> @@ -0,0 +1,302 @@
> +\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interface}
> +
> +In some systems, there is a need to support utilizing a legacy driver with
> +a device that does not directly support the legacy interface. In such scenarios,
> +a group owner device can provide the legacy interface functionality for the
> +group member devices. The driver of an owner device

the owner device


there could be more of these "the" missing, I think we need to go
over the proposal and add them more or less everywhere.
I'm yet to do this, let's get rest of wording right first.


> can then access the legacy
> +interface of a member device on behalf of the legacy member device driver.
> +
> +For example, with the SR-IOV group type, group members (VFs) can not present
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
> +These commands are currently only defined for the SR-IOV group type and
> +have, generally, the same effect as member device accesses through a legacy
> +interface listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout} except that little endian format is assumed unconditionally.
> +
> +\paragraph{Legacy Common Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interface / Legacy Common Configuration Write Command}
> +
> +This command has the same effect as writing into the virtio common configuration
> +structure through the legacy interface. The \field{command_specific_data} is in
> +the format \field{struct virtio_admin_cmd_legacy_common_cfg_wr_data} describing
> +the access to be performed.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_wr_data {
> +        u8 offset; /* Starting byte offset within the common configuration structure to write */
> +        u8 reserved[7];
> +        u8 data[];
> +};
> +\end{lstlisting}
> +
> +For the command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE the driver sets
> +\field{opcode} to 0x2.
> +The driver sets \field{group_member_id} which refers to the member device to be
> +accessed. The driver sets \field{offset} which refers to the offset to write within the
> +virtio common configuration structure, and excluding the device-specific configuration.

*the value written* refers to the member not the field itself, very repetetive
and long winded and if you start saying the value there's more
repetetive noise than actual content in this sentence.

I think the way I wrote this:

The \field{group_member_id} refers to the member device to be accessed.

is cleaner and shorter.

I suggest you go back and apply such a change throughout.


> +The length of the data to write is simply the length of \field{data}.
> +
> +No length or alignment restrictions are placed on the value of the
> +\field{offset} and the length of the \field{data}, except that the resulting
> +access refers to a single field and is completely within the virtio common
> +configuration structure, excluding the device-specific configuration.
> +
> +This command has no command specific result.
> +
> +\paragraph{Legacy Common Configuration Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Common Configuration Read Command}
> +
> +This command has the same effect as reading from the virtio common configuration
> +structure through the legacy interface. The \field{command_specific_data} is in
> +the format \field{struct virtio_admin_cmd_legacy_common_cfg_rd_data} describing
> +the access to be performed.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_rd_data {
> +        u8 offset; /* Starting byte offset within the common configuration structure to read */
> +};
> +\end{lstlisting}
> +
> +For the command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ the driver sets
> +\field{opcode} to 0x3.
> +The driver sets \field{offset} which refers to the offset to read from the
> +virtio common configuration structure, and excluding the device-specific
> +configuration.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_common_cfg_rd_result {
> +        u8 data[];
> +};
> +\end{lstlisting}
> +
> +When the command completes successfully, \field{command_specific_result}
> +is in the format of \field{struct virtio_admin_cmd_legacy_common_cfg_rd_result}
> +returned by the device. The length of the data read is simply the length of
> +\field{data}.

copy the alignment and length paragraph here too.

> +
> +\paragraph{Legacy Device Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Device Configuration Write Command}
> +
> +This command has the same effect as writing into the virtio device-specific
> +configuration through the legacy interface. The \field{command_specific_data} is in
> +the format \field{struct virtio_admin_cmd_legacy_dev_reg_wr_data} describing
> +the access to be performed.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_reg_wr_data {
> +        u8 offset; /* Starting byte offset within the device-specific configuration to write */
> +        u8 reserved[7];
> +        u8 data[];
> +};
> +\end{lstlisting}
> +
> +For the command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE the driver sets
> +\field{opcode} to 0x4.
> +The driver sets \field{group_member_id} which refers to the member device to be
> +accessed. The driver sets \field{offset} which refers to the offset to write
> +within the virtio device-specific configuration. The length of the data to write
> +is simply the length of \field{data}.
> +
> +No length or alignment restrictions are placed on the value of the
> +\field{offset} and the length of the \field{data}, except that the resulting
> +access refers to a single field and is completely within the device-specific
> +configuration.
> +
> +This command has no command specific result.
> +
> +\paragraph{Legacy Device Configuration Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Device Configuration Read Command}
> +
> +This command has the same effect as reading from the virtio device-specific
> +configuration through the legacy interface. The \field{command_specific_data} is in
> +the format \field{struct virtio_admin_cmd_legacy_common_cfg_rd_data} describing
> +the access to be performed.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
> +        u8 offset; /* Starting byte offset within the device-specific configuration to read */
> +};
> +\end{lstlisting}
> +
> +For the command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE the driver sets
> +\field{opcode} to 0x5.
> +The driver sets \field{group_member_id} which refers to the member device to be
> +accessed. The driver sets \field{offset} which refers to the offset to read from
> +the virtio device-specific configuration.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_legacy_dev_reg_rd_result {
> +        u8 data[];
> +};
> +\end{lstlisting}
> +
> +When the command completes successfully, \field{command_specific_result} is in
> +the format of \field{struct virtio_admin_cmd_legacy_dev_reg_rd_result}
> +returned by the device.
> +
> +The length of the data read is simply the length of \field{data}.

copy alignment here too.

> +
> +\paragraph{Legacy Driver Notification}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications}
> +
> +The driver of the owner device can send a driver notification to the member
> +device

operated using the legacy interface

> by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the
> +\field{offset} matching \field{Queue Notify} and the \field{data} containing
> +the virtqueue index to be notified.
> +
> +However, as many administration commands are used for slow path configuration,

However, as VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE is also used for
slow path configuration,

> +a separate fast path mechanism for such notifications is desired.

a separate dedicated mechanism for sending such driver notifications
to the member device can be made available by the owner device

> For the
> +SR-IOV group type, the optional command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> +addresses this need by returning to the driver one or more addresses which to
> +be used

which can be used

> to send such driver notifications.


> The member driver in the hypervisor
> +uses the notification location supplied in
> +the VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO result. The member driver in the
> +hypervisor which intercepts I/O BAR writes, for the \field{Queue Notify} writes,
> +the member driver performs memory or I/O access directly in the supplied
> +notification location instead of executing slow administration command.

This is just messed up. In the introduction we explained:
	The driver of an owner device can then access the legacy
	interface of a member device on behalf of the legacy member device driver.
and let us stick to that and not invent even more terminology.
Also all the hypervisor stuff we inroduce once as
an example. I think that is enough but if not sure, give a
generic explanation then add an example.


If you are inclined to repeat yourself, the following should be enough
I feel.

	the driver of the owner device can then send driver notifications
	on behalf of the legacy member device driver.





> +
> +For the command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO the driver sets
> +\field{opcode} to 0x6.
> +The driver sets \field{group_member_id} which refers to the member device to be
> +accessed. This command does not use \field{command_specific_data}.
> +
> +This command is currently only defined for the SR-IOV group type.

make this a separate paragraph and drop "currently".
Also move up - maybe 1st sentence, maybe right after eneral description.


> When the
> +device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command, the group owner
> +device hardwires VF BAR0 to zero in the SR-IOV Extended capability and the
> +group member device does not use PCI BAR0 in any of the Virtio PCI capabilities
> +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.

either drop this second part or make it detailed. the way it's written
reader goes "so there's this extra requirement what is it" only to
then realize "wait there's no BAR0 at all".

If you want to, I suggest we work separately on a bugfix patch that
documents that capabilities MUST NOT refer to bar which is hardwired
to 0.



> +
> +\begin{lstlisting}
> +struct virtio_pci_legacy_notify_info {
> +        u8 flags;  /* 0 = end of list, 1 = owner device, 2 = member device */
> +        u8 bar;    /* BAR of the member or owner device */

the owner.


> +        u8 padding[7];
> +        le64 offset; /* Offset within bar. */
> +};
> +\end{lstlisting}
> +
> +\field{flags} value of 0x1 indicates that the notification region is of owner
> +device, value of 0x2 indicates that the notification region is of member
> +device, the value of 0 indicates that all the entries starting from that entry
> +are invalid entries in \field{entries}. All other values in \field{flags} are
> +reserved.

and now we have "notification region".
you said above "address" and sometimes. Please stick to that.
Also move the description to after both listings.
document each field not just flags. properly please,
and i hope you look up sriov and pci spec and use
official terminology from there please.

document that driver skips reserved values.

> +
> +\begin{lstlisting}
> +union virtio_admin_cmd_legacy_notify_info {
> +        u8 data[16];
> +	struct virtio_pci_legacy_notify_info pci_info;
> +};

what is doing even?  it's never mentioned anywhere.

> +
> +struct virtio_admin_cmd_legacy_notify_info_result {
> +	struct virtio_virtio_admin_cmd_legacy_notify_info entries[4];

and this?

> +};
> +\end{lstlisting}

just do:
struct virtio_admin_cmd_legacy_notify_info_result {
	struct virtio_pci_legacy_notify_info entries[4];
};

and be done with it.

> +
> +When the command completes successfully, \field{command_specific_result} is in
> +the format of \field{struct virtio_admin_cmd_legacy_notify_info_result}.


>The
> +driver can use any entry when multiple entries are supplied by the device.

The device can supply up to 4 entries each with a different
notification address. In this case, any of the entries
can be used by the driver. The order of the entries serves as
a preference hint - all other things being equal the driver
is expected to perfer utilizing the entries placed
earlier in the array to the later ones.


I notice you decided to silently ignore my suggestion to document how
are notifications performed. Repeating myself like this is despiriting
for me.
Pls re-add especially since you already document it for the
cfg_Write access method anyway.


also in a conformance section, document the effect of notification being
the same as notification through legacy interface.


> +
> +\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
> +
> +A device MUST either support all of, or none of
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the device MUST decode and
> +encode (respectively) the value of the \field{data} using the little-endian
> +format.
> +
> +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands where the value of the
> +\field{offset} and the length of the \field{data} does not refer to a
> +single field or is not completely within the virtio common configuration
> +structure excluding the device-specific configuration.
> +
> +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands where the value of the
> +\field{offset} and the length of the \field{data} does not refer to a
> +single field or is not completely within the device-specific configuration.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE MUST have the same effect
> +as writing into the virtio common configuration structure through the legacy
> +interface.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ MUST have the same effect as
> +reading from the virtio common configuration structure through the legacy
> +interface.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE MUST have the same effect as
> +writing into the virtio device configuration structure through the legacy
> +interface.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ MUST have the same effect as
> +reading from the virtio device configuration structure through the legacy
> +interface.
> +
> +If the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO it MUST
> +also support all of VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
> +
> +The device MAY support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO with entries
> +of the owner device or the member device or both of them.
> +
> +For the SR-IOV group type, when the owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command, the group owner device MUST
> +hardwire VF BAR0 to zero in the SR-IOV Extended capability.
> +
> +For the SR-IOV group type, when the owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> +commands, the owner device and the group member device SHOULD follow the rules
> +for the PCI Revision ID and Subsystem Device ID of the non-transitional devices
> +documented in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
> +
> +For the SR-IOV group type, when the owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> +commands, the owner device SHOULD follow the rules for the PCI Device ID of the non-transitional
> +devices documented in section
> +\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
> +
> +\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the driver MUST encode and
> +decode (respectively) the value of the \field{data} using the little-endian
> +format.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands the driver SHOULD set
> +\field{offset} and the length of the \field{data} to refer to a single
> +field within the virtio common configuration structure excluding
> +the device-specific configuration.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the driver SHOULD set
> +\field{offset} and the length of the \field{data} to refer to a single
> +field within the virtio device-specific configuration.
> +
> +If VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command is supported, the group member
> +driver SHOULD use the notification region to send a driver notification to the
> +device.
> +
> +When the device reports zero in \field{flags} in
> +\field{struct virtio_pci_legacy_notify_info} for the entry, the driver must
> +ignore all other fields of \field{struct virtio_pci_legacy_notify_info}.
> diff --git a/admin.tex b/admin.tex
> index b0a1a91..0803c26 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -117,7 +117,17 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \hline
>  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
>  \hline
> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +0x0002 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE & Writes into the legacy common configuration structure \\
> +\hline
> +0x0003 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ & Reads from the legacy common configuration structure  \\
> +\hline
> +0x0004 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE & Writes into the legacy device configuration structure \\
> +\hline
> +0x0005 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ & Reads into the legacy device configuration structure \\
> +\hline
> +0x0006 & VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO & Query the notification region information \\
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

