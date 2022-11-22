Return-Path: <virtio-return-3884-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221121012419.317406-10-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-10-mst@redhat.com>
Date: Tue, 22 Nov 2022 17:06:04 +0100
Message-ID: <87tu2rdleb.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v8 9/9] admin: conformance clauses
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Add conformance clauses for admin commands and admin virtqueues.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/admin.tex b/admin.tex
> index 589e06a..290cbbc 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -227,6 +227,71 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  It is assumed that all members in a group support and are used
>  with the same list of commands.
>  
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> +
> +Device MUST validate \field{opcode}, \field{group_type} and

s/Device/The device/

> +\field{group_member_id}, set \field{status} to VIRTIO_ADMIN_STATUS_EINVAL and
> +set \field{status_qualifier} accordingly if any of these has an
> +invalid or unsupported value.

"...and if any of these has an invalid or unsupported value, set ..." ?

> +
> +If \field{status} is set to VIRTIO_ADMIN_STATUS_EINVAL, the
> +command MUST NOT have any side effects, in particular the device
> +MUST not enter an error state as a result of this command.
> +
> +Device MAY enforce additional restrictions and dependencies on

s/Device/The device/

> +opcodes used by the driver and MAY fail the command
> +VIRTIO_ADMIN_CMD_LIST_USE with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD
> +if the list of commands used violate internal device dependencies.
> +
> +If the device supports multiple group types, commands for each group
> +type MUST operate independently of each other, in particular,
> +device MAY return different results for VIRTIO_ADMIN_CMD_LIST_QUERY

s/device/the device/

> +for different group types.
> +
> +Before receiving VIRTIO_ADMIN_CMD_LIST_USE for a given group type
> +device MUST assume

s/device/, the device/

> +that the list of legal commands used by driver consists of two commands

s/driver/the driver/
s/two/the two/

> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Device MUST set the list of legal commands used by driver

s/Device/The device/
s/driver/the driver/

> +with the one supplied in VIRTIO_ADMIN_CMD_LIST_USE.

s/with/to/

> +
> +Device MUST validate commands against the list used by

s/Device/The device/

> +driver and MUST fail any commands not in the list with

s/driver/the driver/

> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +and \field{status_qualifier} set to
> +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
> +
> +List of supported commands MUST NOT change: after reporting a

s/List/The list/

> +given command as supported through VIRTIO_ADMIN_CMD_LIST_QUERY
> +device MUST NOT later report it as unsupported.

s/device/the device/

Is that for multiple queries while the device is alive? Is the device
allowed to report a different list of commands after it has been reset?
And is it allowed to _add_ commands?

> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> +
> +Driver MAY discover whether device supports a specific group type

s/Driver/The driver/
s/Device/the device/

> +by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
> +\field{group_type}.
> +
> +Driver MUST issue VIRTIO_ADMIN_CMD_LIST_USE

s/Driver/The driver/

> +and wait for it to be completed with status
> +VIRTIO_ADMIN_STATUS_OK before issuing any commands
> +(except for the initial VIRTIO_ADMIN_CMD_LIST_QUERY
> +and VIRTIO_ADMIN_CMD_LIST_USE).
> +
> +Driver SHOULD NOT set bits in device_admin_cmds

s/Driver/The driver/

> +if it is not familiar with how the command opcode
> +is used, since there could exist dependencies between
> +command opcodes.

", as dependencies between command opcodes might exist."

> +
> +Driver MUST NOT request (by VIRTIO_ADMIN_CMD_LIST_USE)

s/Driver/The driver/
s/by/via/

> +the use of any commands not previously reported as
> +supported for the same group type by VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +Driver MUST NOT use any commands for a given group type

s/Driver/The driver/

> +before sending VIRTIO_ADMIN_CMD_LIST_USE with the correct
> +list of command opcodes and group type.
> +
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>  
>  An administration virtqueue of an owner device is used to submit
> @@ -279,3 +344,60 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
>  new fields can be added to the tail of a structure,
>  with driver using the full structure without concern
>  for versioning.
> +
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> +
> +Device MUST support device-readable and device-writeable buffers

s/Device/The device/

> +shorter than described in this specification, by
> +\begin{enumerate}
> +\item assuming that any data that would be read outside the
> +device-readable buffers is set to zero, and
> +\item discarding data that would be written outside the
> +specified device-writeable buffers.
> +\end{enumerate}
> +
> +Device MUST support device-readable and device-writeable buffers

s/Device/The device/

> +longer than described in this specification, by
> +\begin{enumerate}
> +\item ignoring any data in device-readable buffers outside
> +the expected length, and
> +\item only writing the expected structure to the device-writeable
> +buffers, ignoring any extra buffers, and reporting the
> +actual length of data written, in bytes,
> +as buffer used length.
> +\end{enumerate}
> +
> +Device SHOULD initialize the device-writeable buffer

s/Device/The device/

> +up to the smaller of the structure described by
> +this specification and the length of the buffer supplied by the
> +driver (even if the buffer is all set to zero).

I had to read this one several times... maybe

"up to the length of the structure described by this specification or
the length of the buffer supplied by the driver (even if the buffer is
all set to zero), whichever is shorter."

> +
> +Device MUST NOT fail a command solely because the buffers

s/Device/The device/

> +provided are shorter or longer than described in this
> +specification.
> +
> +Device MUST process commands on a given administration virtqueues

s/Device/The device/
s/virtqueues/virtqueue/

> +in the order in which they are queued.
> +
> +If multiple administration virtqueues have been configured,
> +device MAY process commands on distinct virtqueues with
> +no order constraints.
> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> +
> +Driver MAY supply device-readable and device-writeable buffers

s/Driver/The driver/

> +longer than described in this specification.
> +
> +Driver SHOULD supply device-readable buffers at least as

s/Driver/The driver/

> +large as the structure described by this specification
> +(even if the buffer is all set to zero).
> +
> +Driver MUST NOT assume that device will initialize the whole

s/Driver/The driver/
s/device/the device/

> +structure as described in the specification, instead,

s/,/;/

> +the driver MUST assume that the structure
> +outside the part of the buffer used by the device
> +is set to zero.
> +
> +If multiple administration virtqueues have been configured,
> +driver MUST ensure ordering for commands

s/driver/the driver/

> +placed on different administration virtqueues.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

