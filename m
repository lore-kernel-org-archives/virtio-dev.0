Return-Path: <virtio-comment-return-4187-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <ae43955b-cf66-6553-c0a8-4427fd3f4b05@linux.intel.com>
Date: Mon, 13 Feb 2023 14:43:30 +0800
MIME-Version: 1.0
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-10-mst@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
In-Reply-To: <20230209121221.15118-10-mst@redhat.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v10 09/10] admin: conformance clauses
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 2/9/2023 8:14 PM, Michael S. Tsirkin wrote:
> Add conformance clauses for admin commands and admin virtqueues.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   admin.tex | 190 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 190 insertions(+)
>
> diff --git a/admin.tex b/admin.tex
> index 4de606a..f9b1b68 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -237,6 +237,119 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   supporting multiple group types, the list of supported commands
>   might differ between different group types.
>   
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> +
> +The device MUST validate \field{opcode}, \field{group_type} and
> +\field{group_member_id}, and if any of these has an invalid or
> +unsupported value, set \field{status} to
> +VIRTIO_ADMIN_STATUS_EINVAL and set \field{status_qualifier}
> +accordingly:
> +\begin{itemize}
> +\item if \field{group_type} is invalid, \field{status_qualifier}
> +	MUST be set to VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP;
> +\item otherwise, if \field{opcode} is invalid,
> +	\field{status_qualifier} MUST be set to
> +	VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE;
> +\item otherwise, if \field{group_member_id} is used by the
> +	specific command and is invalid, \field{status_qualifier} MUST be
> +	set to VIRTIO_ADMIN_STATUS_Q_INVALID_MEM.
> +\end{itemize}
> +
> +If a command completes successfully, the device MUST set
> +\field{status} to VIRTIO_ADMIN_STATUS_OK.
> +
> +If a command fails, the device MUST set
> +\field{status} to a value different from VIRTIO_ADMIN_STATUS_OK.
> +
> +If \field{status} is set to VIRTIO_ADMIN_STATUS_EINVAL, the
> +device state MUST NOT change, that is the command MUST NOT have
> +any side effects on the device, in particular the device MUST not
> +enter an error state as a result of this command.
> +
> +If a command fails, the device state generally SHOULD NOT change,
> +as far as possible.
> +
> +The device MAY enforce additional restrictions and dependencies on
> +opcodes used by the driver and MAY fail the command
> +VIRTIO_ADMIN_CMD_LIST_USE with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD
> +if the list of commands used violate internal device dependencies.
> +
> +If the device supports multiple group types, commands for each group
> +type MUST operate independently of each other, in particular,
> +the device MAY return different results for VIRTIO_ADMIN_CMD_LIST_QUERY
> +for different group types.
> +
> +After reset, if the device supports a given group type
> +and before receiving VIRTIO_ADMIN_CMD_LIST_USE for this group type
> +the device MUST assume
> +that the list of legal commands used by the driver consists of
> +the two commands VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +After completing VIRTIO_ADMIN_CMD_LIST_USE successfully,
> +the device MUST set the list of legal commands used by the driver
> +to the one supplied in \field{command_specific_data}.
> +
> +The device MUST set the list of legal commands used by the driver
> +to the one supplied in VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +The device MUST validate commands against the list used by
> +the driver and MUST fail any commands not in the list with
> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +and \field{status_qualifier} set to
> +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
> +
> +The list of supported commands MUST NOT shrink (but MAY expand):
> +after reporting a given command as supported through
> +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> +as unsupported.  Further, after a given set of commands has been
> +used (via a successful VIRTIO_ADMIN_CMD_LIST_USE), then after a
> +device or system reset the device SHOULD complete successfully
> +any following calls to VIRTIO_ADMIN_CMD_LIST_USE with the same
> +list of commands; if this command VIRTIO_ADMIN_CMD_LIST_USE fails
> +after a device or system reset, the device MUST not fail it
> +solely because of the command list used.  Failure to do so would
> +interfere with resuming from suspend and error recovery.
> +
> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> +
> +The driver MAY discover whether device supports a specific group type
> +by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
> +\field{group_type}.
> +
> +The driver MUST issue VIRTIO_ADMIN_CMD_LIST_USE
> +and wait for it to be completed with status
> +VIRTIO_ADMIN_STATUS_OK before issuing any commands
> +(except for the initial VIRTIO_ADMIN_CMD_LIST_QUERY
> +and VIRTIO_ADMIN_CMD_LIST_USE).
> +
> +The driver SHOULD NOT set bits in device_admin_cmds
> +if it is not familiar with how the command opcode
> +is used, as dependencies between command opcodes might exist.
> +
> +The driver MUST NOT request (via VIRTIO_ADMIN_CMD_LIST_USE)
> +the use of any commands not previously reported as
> +supported for the same group type by VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +The driver MUST NOT use any commands for a given group type
> +before sending VIRTIO_ADMIN_CMD_LIST_USE with the correct
> +list of command opcodes and group type.
> +
> +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
> +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
> +with respective bits cleared in \field{command_specific_data}.
> +
> +The driver MUST handle a command error with a reserved \field{status}
> +value in the same way as \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +(except possibly for different error reporting/diagnostic messages).
> +
> +The driver MUST handle a command error with a reserved
> +\field{status_qualifier} value in the same way as
> +\field{status_qualifier} set to
> +VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND (except possibly for
> +different error reporting/diagnostic messages).
> +
>   \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>   
>   An administration virtqueue of an owner device is used to submit
> @@ -309,3 +422,80 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
>   of the specification are designed, new fields can be added to the
>   tail of a structure, with the driver/device using the full
>   structure without concern for versioning.
> +
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> +
> +The device MUST support device-readable and device-writeable buffers
> +shorter than described in this specification, by
> +\begin{enumerate}
> +\item acting as if any data that would be read outside the
> +device-readable buffers is set to zero, and
> +\item discarding data that would be written outside the
> +specified device-writeable buffers.
> +\end{enumerate}
> +
> +The device MUST support device-readable and device-writeable buffers
> +longer than described in this specification, by
maybe I missed it, where defines the length? Does it refer to the 
descriptor length?
> +\begin{enumerate}
> +\item ignoring any data in device-readable buffers outside
> +the expected length, and
> +\item only writing the expected structure to the device-writeable
> +buffers, ignoring any extra buffers, and reporting the
> +actual length of data written, in bytes,
> +as buffer used length.
> +\end{enumerate}
> +
> +The device SHOULD initialize the device-writeable buffer
> +up to the length of the structure described by this specification or
also this length of the structure
> +the length of the buffer supplied by the driver (even if the buffer is
> +all set to zero), whichever is shorter.
> +
> +The device MUST NOT fail a command solely because the buffers
> +provided are shorter or longer than described in this
> +specification.
> +
> +The device MUST initialize the device-writeable part of
> +\field{struct virtio_admin_cmd} that is a multiple of 64 bit in
> +size.
> +
> +The device MUST initialize \field{status} in \field{struct
> +virtio_admin_cmd}.
> +
> +The device MUST process commands on a given administration virtqueue
> +in the order in which they are queued.
> +
> +If multiple administration virtqueues have been configured,
> +device MAY process commands on distinct virtqueues with
> +no order constraints.
> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> +
> +The driver MAY supply device-readable or device-writeable parts
> +of \field{struct virtio_admin_cmd} that are longer than described in
> +this specification.
> +
> +The driver SHOULD supply device-readable part of
> +\field{struct virtio_admin_cmd} that is at least as
> +large as the structure described by this specification
> +(even if the structure is all set to zero).
> +
> +The driver MUST supply both device-readable or device-writeable parts
> +of \field{struct virtio_admin_cmd} that are a multiple of 64 bit
> +in length.
> +
> +The device MUST supply both device-readable or device-writeable parts
> +of \field{struct virtio_admin_cmd} that are larger than zero in
> +length. However, \field{command_specific_data} and
> +\field{command_specific_result} MAY be zero in length, unless
> +specified otherwise for the command.
> +
> +The driver MUST NOT assume that the device will initialize the whole
> +device-writeable part of \field{struct virtio_admin_cmd} as described in the specification; instead,
> +the driver MUST act as if the structure
> +outside the part of the buffer used by the device
> +is set to zero.
> +
> +If multiple administration virtqueues have been configured,
> +the driver MUST ensure ordering for commands
> +placed on different administration virtqueues.
> +>>>>>>> 29f6525... admin: conformance clauses


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

