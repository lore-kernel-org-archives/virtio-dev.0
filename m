Return-Path: <mst@redhat.com>
Date: Sun, 12 Feb 2023 04:49:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 03/10] admin: introduce group administration commands
Message-ID: <20230212044245-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 11, 2023 at 06:50:37PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, February 9, 2023 7:14 AM
> 
> [..]
> 
> > +Group administration commands can be issued through an owner device to
> > +control member devices of a group.  
> can be issued by the owner device to control ...

Well it's clearly the driver that issues the commands. Don't see how
can a device issue them. If instead of "through an owner device"
you prefer a more verbose "the driver of an owner device" then
I can live with that. Let me know.

> > This mechanism can be used, for
> > +example, to configure a member device before it is initialized by its
> > +driver.
> > +\footnote{The term "administration" is intended to be interpreted
> > +widely to include any kind of control. See specific commands for
> > +detail.}
> > +
> > +All the group administration commands are of the following form:
> > +
> > +\begin{lstlisting}
> > +struct virtio_admin_cmd {
> > +        /* Device-readable part */
> > +        le16 opcode;
> > +        /*
> > +         * 1 - SR-IOV
> > +         * 2 - 65535 reserved
> > +         */
> > +        le16 group_type;
> > +        /* unused, reserved for future extensions */
> > +        u8 reserved1[12];
> > +        le64 group_member_id;
> > +        u8 command_specific_data[];
> > +
> > +        /* Device-writable part */
> > +        le16 status;
> > +        le16 status_qualifier;
> > +        /* unused, reserved for future extensions */
> > +        u8 reserved2[4];
> > +        u8 command_specific_result[];
> > +};
> > +\end{lstlisting}
> > +
> > +For all commands, \field{opcode}, \field{group_type} and if necessary
> > +\field{group_member_id} and \field{command_specific_data} are set by
> > +the driver, and the owner device sets \field{status} and if needed
> > +\field{status_qualifier} and \field{command_specific_result}.
> > +
> > +As a rule, any unused device-readable fields are set to zero by the
> > +driver and ignored by the device.  Any unused device-writeable fields
> > +are set to zero by the device and ignored by the driver.
> > +
> General spec structure is describing the "rules" as device and driver side requirements.
> Can you please move above rule paragraph belongs to device and driver requirements section?

Generally we have a bit of duplication. A high level description
showing how things work together. Then per-device/driver conforumance
statements. So I think this should stay but I will look at adding
conformance clauses too.

> > +\field{opcode} specifies the command. The valid values for
> > +\field{opcode} can be found in the following table:
> > +
> > +\begin{tabular}{|l|l|}
> > +\hline
> > +opcode & Name & Command Description \\
> > +\hline \hline
> > +0x0000 - 0x7FFF & - &  Group administration commands    \\
> > +\hline
> > +0x8000 - 0xFFFF & - & Reserved    \\
> > +\hline
> > +\end{tabular}
> > +
> > +The \field{group_type} specifies the group type identifier.
> > +The \field{group_member_id} specifies the member identifier within the
> > group.
> > +See section \ref{sec:Introduction / Terminology / Device group} for the
> > +definition of the group type identifier and group member identifier.
> > +
> > +The following table describes possible \field{status} values; to
> > +simplify common implementations, they are intentionally matching common
> > +Linux names and error numbers:
> > +
> I am not sure it should be intentional and mention of Linux.
> Any OS would need multiple error values to know the error cause.
> Linux doesn't have name "OK" either for well-known value of 0.
> 
> For example
> $ errno 22
> EINVAL 22 Invalid argument
> 
> $ errno 0
> This has not output for it and doesn't exist in errno.h.

No name OK true, but it does use 0 to signal success sometimes:

https://man7.org/linux/man-pages/man3/errno.3.html

For some system calls and library functions (e.g.,
       getpriority(2)), -1 is a valid return on success.  In such cases,
       a successful return can be distinguished from an error return by
       setting errno to zero before the call, and then, if the call
       returns a status that indicates that an error may have occurred,
       checking to see if errno has a nonzero value.



> Description is already good enough to describe what they are.
> Can we please drop Linux wording?

But why should we? It's where 22 comes from so this way people are not
wondering about the value, and it's somewhat helpful for Linux
developers.


> > +\begin{tabular}{|l|l|l|}
> > +\hline
> > +Status (decimal) & Name & Description \\ \hline \hline
> > +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> > +\hline
> > +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
> > +\hline
> > +other   & -    & group administration command error  \\
> > +\hline
> > +\end{tabular}
> > +
> > +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
> s/status_qialifier/status_qualifier
> 
> > +is reserved and set to zero by the device.
> > +
> > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
> > +describes possible \field{status_qialifier} values:
> s/status_qialifier/status_qualifier


Thanks!

