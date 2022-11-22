Return-Path: <virtio-return-3883-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221121012419.317406-9-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-9-mst@redhat.com>
Date: Tue, 22 Nov 2022 16:25:23 +0100
Message-ID: <87wn7ndna4.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v8 8/9] admin: command list discovery
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Add commands to find out which commands does each group support,
> as well as enable their use by driver.
> This will be especially useful once we have multiple group types.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex | 130 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 114 insertions(+), 16 deletions(-)
>
> diff --git a/admin.tex b/admin.tex
> index bfa63a2..589e06a 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -72,13 +72,14 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  
>          /* Device-writable part */
>          le16 status;
> +        le16 status_qualifier;
>          /* unused, reserved for future extensions */
> -        u8 reserved2[6];
> +        u8 reserved2[4];
>          u8 command_specific_result[];
>  };
>  \end{lstlisting}
>  
> -For all commands, \field{opcode}, \field{group_id} and if
> +For all commands, \field{opcode}, \field{group_type} and if

Hm, this change probably belongs to a different patch?

>  necessary \field{group_member_id} and \field{command_specific_data} are
>  set by the driver, and the owner device sets \field{status} and if
>  needed \field{status_qualifier} and
> @@ -93,18 +94,20 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  
>  \begin{tabular}{|l|l|}
>  \hline
> -opcode & Command Description \\
> +opcode & Name & Command Description \\

Maybe use this table heading from the start?

>  \hline \hline
> -0000h - 7FFFh   & Group administration commands    \\
> +0000h & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\

0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Query the device about the list of commands supported for this group type \\

> +0001h & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\

0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Inform the device about the list of commands used for this group type \\

> +0002h - 7FFFh & - &  Group administration commands    \\

0x0002 - 0x7FFF & - & Further group administration commands \\

>  \hline
>  8000h - FFFFh   & Reserved    \\

0x8000 - 0xFFFF & - & Reserved \\

>  \hline
>  \end{tabular}
>  
> -The \field{group_id} specifies the device group.
> -The \field{group_member_id} specifies the member device within the group.
> +The \field{group_type} specifies the group type identifier.
> +The \field{group_member_id} specifies the member identifier within the group.

This likely should go into the patch initially introducing those lines.

>  See section \ref{sec:Introduction / Terminology / Device group}
> -for the definition of the group identifier and group member
> +for the definition of the group type identifier and group member
>  identifier.
>  
>  The following table describes possible \field{status} values,
> @@ -113,22 +116,117 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  
>  \begin{tabular}{|l|l|l|}
>  \hline
> -Status & Name & Description \\
> +Status (decimal) & Name & Description \\

Here as well. Although I think we can simply omit the "(decimal)" when
we drop the "h".

>  \hline \hline
> -00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
>  \hline
> -01h   & VIRTIO_ADMIN_STATUS_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
> -\hline
> -02h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field within command specific data  \\
> -\hline
> -03h   & VIRTIO_ADMIN_STATUS_INVALID_GROUP    & invalid group identifier was set  \\
> -\hline
> -04h   & VIRTIO_ADMIN_STATUS_INVALID_MEM    & invalid group member identifier was set  \\
> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\

This also looks like it is in the wrong patch?

>  \hline
>  other   & -    & group administration command error  \\
>  \hline
>  \end{tabular}
>  
> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}

status_qualifier

> +is reserved and set to zero by the device.
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
> +the following table describes possible \field{status_qialifier} values:
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status & Name & Description \\
> +\hline \hline
> +00h   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additional information  \\

Either 0x00, or decimal (which one is better?)

> +\hline
> +01h   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
> +\hline
> +02h   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
> +\hline
> +03h   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} was set  \\

s/was set//

> +\hline
> +04h   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or invalid \field{group_member_id} was set  \\

s/was set//

> +\hline
> +other   & -    & group administration command error  \\

Again the question whether this is something that can be defined per
group type.

> +\hline
> +\end{tabular}
> +
> +Before sending any administration commands to the device, the
> +commands in question are reported to the device as used by the driver.
> +Initially (after reset), only two commands are assumed to be used:
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Accordingly,
> +before sending any other commands for any member of a specific
> +group to the device, the driver issues the commands
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.

What about

"Before sending any administration commands to the device, the driver
needs to communicate to the device which commands it is going to
use. Initially (after reset), only two commands are assumed to be used:
VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.

Before sending any other commands for any member of a specific group to
the device, the driver queries the supported commands via
VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via
VIRTIO_ADMIN_CMD_LIST_USE."


> +
> +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
> +VIRTIO_ADMIN_CMD_LIST_USE
> +both use the following structure describing the
> +command opcodes:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_list {
> +       /* Indicates which of the below fields were returned
> +       le32 device_admin_cmds[];
> +};
> +\end{lstlisting}
> +
> +This structure is an array of 32 bit values in little-endian byte
> +order, in which a bit is set if the specific command opcode
> +is supported. Thus, \field{device_admin_cmds[0]} refers to the first 32-bit value
> +in this array corresponding to opcodes 0 to 31,
> +\field{device_admin_cmds[1]} is the second 32-bit value
> +corresponding to opcodes 32 to 63, etc.
> +For example, the array of size 2 including
> +the values 0x3 in \field{device_admin_cmds[0]}
> +and 0x1 in \field{device_admin_cmds[1]} indicates that only opcodes 0, 1 and 32
> +are supported.
> +
> +Accordingly, bits 0 and 1 corresponding to opcode 0
> +(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
> +(VIRTIO_ADMIN_CMD_LIST_USE) are
> +always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +This command has no command specific data.
> +The device, upon success, returns a result in
> +\field{command_specific_result} in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands supported for the given group.
> +
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
> +is set to 0x1.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +The \field{command_specific_data} is in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands used by the driver.
> +This command has no command specific result.
> +
> +The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> +query the list of commands valid for this group and before sending
> +any commands for any member of a group.
> +
> +The driver then enables use of some of the opcodes by sending to
> +the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> +of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> +both understood and used by the driver.
> +
> +If the device supports the command list used by the driver, the
> +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
> +If the device does not support the command list, the device
> +completes the command with status
> +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> +
> +Note: drivers are assumed not to set bits in device_admin_cmds
> +if they are not familiar with how the command opcode
> +is used, since devices could have dependencies between
> +command opcodes.
> +
> +It is assumed that all members in a group support and are used
> +with the same list of commands.

Can the driver later change its mind, i.e. use VIRTIO_ADMIN_CMD_LIST_USE
a second time with a different set of commands? If yes, can it add
commands, or only withdraw them?

What happens if a driver tries to send a command that it had not
included in the list?


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

