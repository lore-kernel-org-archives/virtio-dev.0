Return-Path: <mst@redhat.com>
Date: Thu, 24 Nov 2022 03:36:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9 09/10] admin: conformance clauses
Message-ID: <20221124033204-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-10-mst@redhat.com>
 <CACGkMEsDi3+iU3QjQ4Mqp5yQc0epOqLZXnYTnqaoPwtB6pvF7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsDi3+iU3QjQ4Mqp5yQc0epOqLZXnYTnqaoPwtB6pvF7A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24, 2022 at 02:51:21PM +0800, Jason Wang wrote:
> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Add conformance clauses for admin commands and admin virtqueues.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  admin.tex | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >
> > diff --git a/admin.tex b/admin.tex
> > index eec12a9..e83a9f5 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -222,6 +222,107 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >  It is assumed that all members in a group support and are used
> >  with the same list of commands.
> >
> > +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> > +
> > +The device MUST validate \field{opcode}, \field{group_type} and
> > +\field{group_member_id}, set \field{status} to VIRTIO_ADMIN_STATUS_EINVAL and
> > +nd if any of these has an invalid or unsupported value, set
> 
> typo

thanks!

> > +\field{status_qualifier} accordingly.
> > +
> > +If a command completes successfully, the device MUST set
> > +\field{status} to VIRTIO_ADMIN_STATUS_OK.
> > +
> > +If a command fails, the device MUST set
> > +\field{status} to a value different from VIRTIO_ADMIN_STATUS_OK.
> > +
> > +If \field{status} is set to VIRTIO_ADMIN_STATUS_EINVAL, the
> > +device state MUST NOT change, that is the command MUST NOT have
> > +any side effects on the device, in particular the device MUST not
> > +enter an error state as a result of this command.
> > +
> > +If a command fails, the device state generally SHOULD NOT change,
> > +as far as possible.
> > +
> > +The device MAY enforce additional restrictions and dependencies on
> > +opcodes used by the driver and MAY fail the command
> > +VIRTIO_ADMIN_CMD_LIST_USE with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD
> > +if the list of commands used violate internal device dependencies.
> > +
> > +If the device supports multiple group types, commands for each group
> > +type MUST operate independently of each other, in particular,
> > +the device MAY return different results for VIRTIO_ADMIN_CMD_LIST_QUERY
> > +for different group types.
> > +
> > +After reset, and before receiving VIRTIO_ADMIN_CMD_LIST_USE for a given group type
> > +the device MUST assume
> > +that the list of legal commands used by the driver consists of
> > +the two commands VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> > +
> > +After completing VIRTIO_ADMIN_CMD_LIST_USE successfully,
> > +the device MUST set the list of legal commands used by the driver
> > +to the one supplied in \field{command_specific_data}.
> > +
> > +The device MUST set the list of legal commands used by the driver
> > +to the one supplied in VIRTIO_ADMIN_CMD_LIST_USE.
> > +
> > +The device MUST validate commands against the list used by
> > +the driver and MUST fail any commands not in the list with
> > +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +and \field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
> > +
> > +The list of supported commands MUST NOT shrink (but MAY expand):
> > +after reporting a given command as supported through
> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> > +as unsupported.  Further, after a given set of commands has been
> > +used (via a successful VIRTIO_ADMIN_CMD_LIST_USE), then after a
> > +device or system reset the device SHOULD complete successfully
> > +any following calls to VIRTIO_ADMIN_CMD_LIST_USE with the same
> > +list of commands; if this command VIRTIO_ADMIN_CMD_LIST_USE fails
> > +after a device or system reset, the device MUST not fail it
> > +solely because of the command list used.  Failure to do so would
> > +interfere with resuming from suspend and error recovery.
> > +
> > +
> > +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> > +
> > +The driver MAY discover whether device supports a specific group type
> > +by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
> > +\field{group_type}.
> > +
> > +The driver MUST issue VIRTIO_ADMIN_CMD_LIST_USE
> > +and wait for it to be completed with status
> > +VIRTIO_ADMIN_STATUS_OK before issuing any commands
> > +(except for the initial VIRTIO_ADMIN_CMD_LIST_QUERY
> > +and VIRTIO_ADMIN_CMD_LIST_USE).
> > +
> > +The driver SHOULD NOT set bits in device_admin_cmds
> > +if it is not familiar with how the command opcode
> > +is used, as dependencies between command opcodes might exist.
> > +
> > +The driver MUST NOT request (via VIRTIO_ADMIN_CMD_LIST_USE)
> > +the use of any commands not previously reported as
> > +supported for the same group type by VIRTIO_ADMIN_CMD_LIST_QUERY.
> > +
> > +The driver MUST NOT use any commands for a given group type
> > +before sending VIRTIO_ADMIN_CMD_LIST_USE with the correct
> > +list of command opcodes and group type.
> > +
> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
> > +with respective bits cleared in \field{command_specific_data}.
> > +
> > +The driver MUST handle a command error with a reserved \field{status}
> > +value in the same way as \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +(except possibly for different error reporting/diagnostic messages).
> > +
> > +The driver MUST handle a command error with a reserved
> > +\field{status_qualifier} value in the same way as
> > +\field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND (except possibly for
> > +different error reporting/diagnostic messages).
> > +
> >  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> >
> >  An administration virtqueue of an owner device is used to submit
> > @@ -275,3 +376,60 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
> >  new fields can be added to the tail of a structure,
> >  with the driver using the full structure without concern
> >  for versioning.
> > +
> > +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> > +
> > +The device MUST support device-readable and device-writeable buffers
> > +shorter than described in this specification, by
> > +\begin{enumerate}
> > +\item assuming that any data that would be read outside the
> > +device-readable buffers is set to zero, and
> 
> s/"is set"/"are set"

thanks

> > +\item discarding data that would be written outside the
> > +specified device-writeable buffers.
> > +\end{enumerate}
> > +
> > +The device MUST support device-readable and device-writeable buffers
> > +longer than described in this specification, by
> > +\begin{enumerate}
> > +\item ignoring any data in device-readable buffers outside
> > +the expected length, and
> > +\item only writing the expected structure to the device-writeable
> > +buffers, ignoring any extra buffers, and reporting the
> > +actual length of data written, in bytes,
> > +as buffer used length.
> > +\end{enumerate}
> > +
> > +The device SHOULD initialize the device-writeable buffer
> > +up to the length of the structure described by this specification or
> > +the length of the buffer supplied by the driver (even if the buffer is
> > +all set to zero), whichever is shorter.
> > +
> > +The device MUST NOT fail a command solely because the buffers
> > +provided are shorter or longer than described in this
> > +specification.
> 
> I may miss something but how can it work if the buffer is shorter?

driver does not care what's there.

this is mostly for forward compatibility - we'll add more fields and
I don't want to explain separately that old drivers post
short buffers with less fields.


> > +
> > +The device MUST process commands on a given administration virtqueue
> > +in the order in which they are queued.
> 
> Is it better to use "complete" than "process" here?

I am not sure we need to require they complete in order, unless
IN_ORDER is set (unfortunately it is global for all of device).


> Or we can reuse
> part of the in-order description.
> 
> (Or maybe a flush command)


these can be used if offered.

> > +
> > +If multiple administration virtqueues have been configured,
> > +device MAY process commands on distinct virtqueues with
> > +no order constraints.
> > +
> > +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> > +
> > +The driver MAY supply device-readable and device-writeable buffers
> > +longer than described in this specification.
> > +
> > +The driver SHOULD supply device-readable buffers at least as
> > +large as the structure described by this specification
> > +(even if the buffer is all set to zero).
> > +
> > +The driver MUST NOT assume that the device will initialize the whole
> > +structure as described in the specification; instead,
> > +the driver MUST assume that the structure
> > +outside the part of the buffer used by the device
> > +is set to zero.
> 
> Won't this have security implications? E.g information leak.
> 
> Thanks

hmm this is not clear enough. it should ignore the contents
and behave as if it was set to zero. Will fix.


> > +
> > +If multiple administration virtqueues have been configured,
> > +the driver MUST ensure ordering for commands
> > +placed on different administration virtqueues.
> > --
> > MST
> >

