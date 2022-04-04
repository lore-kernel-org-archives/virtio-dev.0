Return-Path: <mst@redhat.com>
Date: Mon, 4 Apr 2022 08:50:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/5] Introduce Admin Command Set
Message-ID: <20220404080607-mutt-send-email-mst@kernel.org>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-3-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220302155608.24189-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 02, 2022 at 05:56:05PM +0200, Max Gurtovoy wrote:
> This command set is used for essential administrative and management
> operations such as identify and resource management.
> 
> Admin commands should be submitted to a well defined management
> interface.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  admin.tex        | 129 +++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex      |   2 +
>  introduction.tex |   2 +
>  3 files changed, 133 insertions(+)
>  create mode 100644 admin.tex
> 
> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..1e30e01
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,129 @@
> +\section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admin command set}

> +
> +The Admin command set defines the commands that can be issued to a well defined management
> +interface.

This is shorthand for what? Administration commands?
Let's eschew abbreviation pls.
Also, management is a bit oblique, and only the reader can judge how well it's defined :)


I would rephrase this along the lines of

" For security and ease of management reasons, devices can expose an additional interface
  to access the device besides the ones specified in the
  transports section. For example, a host management system
  might want to access the device while in use by driver,
  or to configure the device before it is initialized by
  the driver.
  This access is facilitated through a set of administration commands.

"


speaking of this, are we still going to use the "driver"
terminology for uses of this?


> All the Admin commands are of the following form:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd {
> +        /* Device-readable part */
> +        le16 command;
> +        /*
> +         * 0 - self
> +         * 1 - 65535 are reserved
> +         */
> +        le16 dst_type;

I think we want to add the vdev id here in the generic command
and just have a special id that means "self".


> +        /* reserved for common cmd fields */
> +        u8 reserved[20];
> +        u8 command_specific_data[];
> +
> +        /* Device-writable part */
> +        u8 status;
> +        u8 command_specific_error;
> +        u8 command_specific_result[];
> +};
> +\end{lstlisting}
> +
> +The following table describes the generic Admin status codes:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Opcode & Status & Description \\
> +\hline \hline
> +00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> +\hline
> +01h   & VIRTIO_ADMIN_STATUS_CS_ERR    & command specific error  \\
> +\hline
> +02h   & VIRTIO_ADMIN_STATUS_COMMAND_UNSUPPORTED    & unsupported or invalid opcode  \\
> +\hline
> +03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
> +\hline
> +\end{tabular}
> +
> +The \field{command}, \field{dst_type} and \field{command_specific_data} are
> +set by the driver, and the device sets the \field{status}, the
> +\field{command_specific_error} and the \field{command_specific_result},
> +if needed.
> +
> +Reserved common fields are ignored by the device and to be zeroed by the driver.
> +
> +The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
> +
> +The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
> +
> +The \field{dst_type} defines the target virtio device for the command. This value should be set to 0 (self).
> +
> +The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
> +VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
> +holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
> +\field{command_specific_error} value is undefined.
> +
> +The following table describes the Admin command set:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Opcode & Command & M/O \\
> +\hline \hline
> +0000h   & VIRTIO_ADMIN_DEVICE_IDENTIFY    & M  \\
> +\hline
> +0001h   & VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY    & O  \\
> +\hline
> +0002h - 7FFFh   & Generic admin cmds    & -  \\
> +\hline
> +8000h - FFFFh   & Reserved    & - \\
> +\hline
> +\end{tabular}
> +
> +\subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE IDENTIFY command}
> +
> +The VIRTIO_ADMIN_DEVICE_IDENTIFY command has no command specific data set by the driver.
> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_IDENTIFY.
> +Other common fields are reserved for this command and zeroed.
> +
> +This command upon success, returns a data buffer

let's avoid using buffer since we want to allow non-DMA uses
IIUC. just "result" is ok, right?

> that describes information about the target virtio device.

target being what? destination?

> +This returned data buffer is of form:
> +\begin{lstlisting}
> +struct virtio_admin_device_identify_result {
> +       /* For compatibility - indicates which of the below fields were returned

compatibility with what?

> +        * (1 means that field was returned):
> +        * Bit 0 - vdev_id
> +        * Bit 1 - optional_caps_support
> +        * Bits 2 - 63 - reserved for future fields
> +        */
> +       le64 attrs_mask;

this seems to be some kind of thing listing supported commands, except
it's one way as opposed to negotiated like feature bits.  From
experience this kind of one way capability might be problematic since
you never know what will be used.  How about just using feature bits
instead? How many of these do you expect to be there?

If not, please add a description of this.
E.g. along the lines of

	Field \field{attrs_mask} contains a bitmask of valid ?? as defined in ??



> +       le64 vdev_id;

So this is a way to query the id of device itself? Since the only dst
type is self ...


> +       /* This field indicates which of the below optional admin
> +        * capabilities are supported by the device:
> +        * Bit 0 - if set, VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY supported
> +        * Bits 1 - 63 - reserved for future capabilities.
> +        */
> +       le64 optional_caps_support;
> +       u8 reserved[4072];

What exactly is this reserved thing? Does this mean the structure is
always exactly 4k?

> +};
> +\end{lstlisting}
> +
> +\subsection{VIRTIO ADMIN SUBSYSTEM IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN SUBSYSTEM IDENTIFY command}
> +
> +The VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY command has no command specific data set by the driver.
> +The \field{command} is set to VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY.
> +Other common fields are reserved for this command and zeroed.

zeroed by driver?

> +
> +This command upon success, returns a data buffer that describes information about the target virtio device subsystem.
> +This returned data buffer is of form:
> +\begin{lstlisting}
> +struct virtio_admin_subsystem_identify_result {
> +       /* For compatibility - indicates which of the below fields were returned
> +        * (1 means that field was returned):
> +        * Bit 0 - vqn
> +        * Bit 1 - num_supported_vdevs
> +        * Bit 2 - max_vdev_id
> +        * Bits 3 - 63 - reserved for future fields
> +        */
> +       le64 attrs_mask;

add description here.

> +       u8 vqn[16];
> +       /* Number of supported virtio devices by the subsystem */
> +       le64 num_supported_vdevs;
> +       /* Maximum value of a valid vdev_id for the subsystem */
> +       le64 max_vdev_id;
> +       u8 reserved[4056];
> +};
> +\end{lstlisting}
> diff --git a/content.tex b/content.tex
> index c6f116c..2e1df84 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>  types. It is RECOMMENDED that devices generate version 4
>  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>  
> +\input{admin.tex}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>  
>  We start with an overview of device initialization, then expand on the
> diff --git a/introduction.tex b/introduction.tex
> index 8e6611e..94dd7a2 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -258,5 +258,7 @@ \subsection{virtio subsystem}\label{sec:Introduction / Definitions / virtio subs
>  
>  The vdev_id value when combined with the VQN forms a globally unique value that identifies the virtio device.
>  
> +VQN and vdev_id are exposed via Admin Command Set.
> +
>  \newpage
>  
> -- 
> 2.21.0

