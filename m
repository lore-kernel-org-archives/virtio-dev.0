Return-Path: <virtio-comment-return-4122-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <8718bc3b-a251-652c-5a8d-f93b1b66ba3f@linux.intel.com>
Date: Fri, 10 Feb 2023 16:24:14 +0800
MIME-Version: 1.0
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
In-Reply-To: <20230209121221.15118-4-mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH v10 03/10] admin: introduce group
 administration commands
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 2/9/2023 8:13 PM, Michael S. Tsirkin wrote:
> This introduces a general structure for group administration commands,
> used to control device groups through their owner.
>
> Following patches will introduce specific commands and an interface for
> submitting these commands to the owner.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   admin.tex | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 101 insertions(+)
>
> diff --git a/admin.tex b/admin.tex
> index 2bc7322..46240f8 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -46,4 +46,105 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
>   PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>   \end{description}
>   
> +\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>   
> +Group administration commands can be issued through an owner
> +device to control member devices of a group.  This mechanism can
> +be used, for example, to configure a member device before it is
> +initialized by its driver.
> +\footnote{The term "administration" is intended to be interpreted
> +widely to include any kind of control. See specific commands
> +for detail.}
> +
> +All the group administration commands are of the following form:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd {
> +        /* Device-readable part */
> +        le16 opcode;
> +        /*
> +         * 1 - SR-IOV
> +         * 2 - 65535 reserved
> +         */
> +        le16 group_type;
> +        /* unused, reserved for future extensions */
> +        u8 reserved1[12];
> +        le64 group_member_id;
> +        u8 command_specific_data[];
> +
> +        /* Device-writable part */
> +        le16 status;
> +        le16 status_qualifier;
> +        /* unused, reserved for future extensions */
> +        u8 reserved2[4];
> +        u8 command_specific_result[];
> +};
> +\end{lstlisting}
> +
> +For all commands, \field{opcode}, \field{group_type} and if
> +necessary \field{group_member_id} and \field{command_specific_data} are
> +set by the driver, and the owner device sets \field{status} and if
> +needed \field{status_qualifier} and
> +\field{command_specific_result}.
> +
> +As a rule, any unused device-readable fields are set to zero by the driver
> +and ignored by the device.  Any unused device-writeable fields are set to zero
> +by the device and ignored by the driver.
> +
> +\field{opcode} specifies the command. The valid
> +values for \field{opcode} can be found in the following table:
> +
> +\begin{tabular}{|l|l|}
> +\hline
> +opcode & Name & Command Description \\
> +\hline \hline
> +0x0000 - 0x7FFF & - &  Group administration commands    \\
> +\hline
> +0x8000 - 0xFFFF & - & Reserved    \\
> +\hline
> +\end{tabular}
> +
> +The \field{group_type} specifies the group type identifier.
Hi,

group_type here is used to address a device group, and we don't have a
group_id, so this implies each type of devices belong to only one group,
like there can be only one SRIOV group. Shall we add such description in
patch 2 explicitly?

And there is another concern, if we use this type of command to create a 
SRIOV
VF, do we need to sync with native PCI SRIOV?

Thanks
> +The \field{group_member_id} specifies the member identifier within the group.
> +See section \ref{sec:Introduction / Terminology / Device group}
> +for the definition of the group type identifier and group member
> +identifier.
> +
> +The following table describes possible \field{status} values;
> +to simplify common implementations, they are intentionally
> +matching common Linux names and error numbers:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status (decimal) & Name & Description \\
> +\hline \hline
> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> +\hline
> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
> +\hline
> +other   & -    & group administration command error  \\
> +\hline
> +\end{tabular}
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
> +is reserved and set to zero by the device.
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
> +the following table describes possible \field{status_qialifier} values:
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status & Name & Description \\
> +\hline \hline
> +0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additional information  \\
> +\hline
> +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
> +\hline
> +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
> +\hline
> +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} \\
> +\hline
> +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or invalid \field{group_member_id} \\
> +\hline
> +0x05-0xFFFF   & -    & reserved for future use \\
> +\hline
> +\end{tabular}


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

