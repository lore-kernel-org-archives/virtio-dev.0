Return-Path: <mst@redhat.com>
Date: Sun, 15 May 2022 11:23:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 2/7] Introduce admin command set
Message-ID: <20220515111056-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220426225824.5918-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 27, 2022 at 01:58:19AM +0300, Max Gurtovoy wrote:
> This command set is used for essential administrative and management
> operations.
> 
> Admin commands should be submitted to a well defined management
> interface.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  admin.tex   | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |   2 +
>  2 files changed, 125 insertions(+)
>  create mode 100644 admin.tex
> 
> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..6725daa
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,123 @@
> +\section{Administration command set}\label{sec:Basic Facilities of a Virtio Device / Administration command set}
> +
> +The Administration command set (also known as Admin command set) defines the commands that can be issued using a management interface.
> +This mechanism, for example, can be used by a system administrator that wants to configure a device before it is initialized by its driver.
> +
> +All the Admin commands are of the following form:
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
> +The \field{dst_type} defines the designated virtio device for the command. This value should be set to 0 (self).
> +
> +The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
> +VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
> +holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
> +\field{command_specific_error} value is undefined and should be ignored by the driver.
> +
> +The following table describes the Admin command set:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Opcode & Command & M/O \\
> +\hline \hline
> +0000h   & VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY    & M  \\
> +\hline
> +0001h   & VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT    & M  \\
> +\hline
> +0002h - 7FFFh   & Generic admin cmds    & -  \\
> +\hline
> +8000h - FFFFh   & Reserved    & - \\
> +\hline
> +\end{tabular}
> +
> +\subsection{VIRTIO ADMIN DEVICE CAPS IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}

why without _ here?

> +
> +The VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command has no command specific data set by the driver.
> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY by the driver.
> +
> +The device, upon success, returns a result that describes information about the designated virtio device.

result really just means a result structure right? let's say so.

> +This result is of form:
> +\begin{lstlisting}
> +struct virtio_admin_device_caps_identify_result {
> +       /* Indicates which of the below fields were returned
> +        * (1 means that field was returned):

what does this mean "field is returned"? above restult is returned.

> +        * Bit 0 - device_admin_caps
> +        * Bits 1 - 63 - reserved for future fields
> +        */
> +       le64 attrs_mask;
> +       /* This field indicates which of the below admin
> +        * capabilities are supported by the device:
> +        * Bits 0 - 63 - reserved for future capabilities.
> +        */
> +       le64 device_admin_caps;


so all of the field is reserved?

> +       u8 reserved[112];
> +};
> +\end{lstlisting}
> +
> +\subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS ACCEPT command}
> +
> +The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the driver to acknowledge those admin capabilities it understands and wishes to use.


ok so we have a protocol here, kind of like feature negotiation. Please write its description.
e.g. is it ok to change accepted caps? when? can device change its caps
etc etc etc.

Avoiding this kind of spec work is exactly why me and jason keep telling
you to consider just using features instead. Add a 64 bit admin features
field to the PCI transport and be done with it. CCW and MMIO already
have feature selector so it's trivial to add feature bits.


> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT by the driver.
> +
> +The command specific data set by the driver is of form:
> +\begin{lstlisting}
> +struct virtio_admin_device_caps_accept_data {
> +       /* Indicates which of the below fields were set
> +        * (1 means that field is set):


yes we all know that 1 means set.

do you really mean field is valid maybe?


> +        * Bit 0 - driver_admin_caps
> +        * Bits 1 - 63 - reserved for future fields
> +        */
> +       le64 attrs_mask;

looks like going overboard. just send 64 caps bits and be done with it.
and rename accept_data to accept_caps.

> +       /* This field indicates which of the below admin
> +        * capabilities are supported by the driver:
> +        * Bits 0 - 63 - reserved for future capabilities.
> +        */
> +       le64 driver_admin_caps;
> +       u8 reserved[112];


I just noticed this. Please do not add this huge amount of padding
everywhere. instead, explain that device must be ready to accept
a smaller or larger buffer depending on feature bits.

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
> -- 
> 2.21.0

