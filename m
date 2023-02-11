Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 03/10] admin: introduce group administration commands
Date: Sat, 11 Feb 2023 18:50:37 +0000
Message-ID: <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
In-Reply-To: <20230209121221.15118-4-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:14 AM

[..]

> +Group administration commands can be issued through an owner device to
> +control member devices of a group. =20
can be issued by the owner device to control ...

> This mechanism can be used, for
> +example, to configure a member device before it is initialized by its
> +driver.
> +\footnote{The term "administration" is intended to be interpreted
> +widely to include any kind of control. See specific commands for
> +detail.}
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
> +For all commands, \field{opcode}, \field{group_type} and if necessary
> +\field{group_member_id} and \field{command_specific_data} are set by
> +the driver, and the owner device sets \field{status} and if needed
> +\field{status_qualifier} and \field{command_specific_result}.
> +
> +As a rule, any unused device-readable fields are set to zero by the
> +driver and ignored by the device.  Any unused device-writeable fields
> +are set to zero by the device and ignored by the driver.
> +
General spec structure is describing the "rules" as device and driver side =
requirements.
Can you please move above rule paragraph belongs to device and driver requi=
rements section?

> +\field{opcode} specifies the command. The valid values for
> +\field{opcode} can be found in the following table:
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
> +The \field{group_member_id} specifies the member identifier within the
> group.
> +See section \ref{sec:Introduction / Terminology / Device group} for the
> +definition of the group type identifier and group member identifier.
> +
> +The following table describes possible \field{status} values; to
> +simplify common implementations, they are intentionally matching common
> +Linux names and error numbers:
> +
I am not sure it should be intentional and mention of Linux.
Any OS would need multiple error values to know the error cause.
Linux doesn't have name "OK" either for well-known value of 0.

For example
$ errno 22
EINVAL 22 Invalid argument

$ errno 0
This has not output for it and doesn't exist in errno.h.

Description is already good enough to describe what they are.
Can we please drop Linux wording?

> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status (decimal) & Name & Description \\ \hline \hline
> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> +\hline
> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
> +\hline
> +other   & -    & group administration command error  \\
> +\hline
> +\end{tabular}
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
s/status_qialifier/status_qualifier

> +is reserved and set to zero by the device.
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
> +describes possible \field{status_qialifier} values:
s/status_qialifier/status_qualifier

