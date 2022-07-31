Return-Path: <mst@redhat.com>
Date: Sun, 31 Jul 2022 17:16:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 5/5] Introduce MGMT admin commands
Message-ID: <20220731170322-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-6-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220731154354.15698-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jul 31, 2022 at 06:43:54PM +0300, Max Gurtovoy wrote:
> Introduce the concept of a management and a managed device and add
> example of using this concept to manage resources.
> 
> A management device (from any type) supports the
> VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin
> commands to manage some resources of a managed device.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Actually this does two things:
- more SRIOV group definitions
- new MGMT commands


> ---
>  admin.tex        | 96 +++++++++++++++++++++++++++++++++++++++++++++++-
>  content.tex      | 50 +++++++++++++++++++++++++
>  introduction.tex | 30 +++++++++++++++
>  3 files changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/admin.tex b/admin.tex
> index 26ac60e..73bc411 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -75,12 +75,106 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
>  \hline
>  Opcode & Command \\
>  \hline \hline
> -0000h - 7FFFh   & Generic admin cmds    \\
> +0000h   & VIRTIO_ADMIN_DEVICE_MGMT    \\
> +\hline
> +0001h   & VIRTIO_ADMIN_DEVICE_MGMT_ATTRS    \\
> +\hline
> +0002h - 7FFFh   & Generic admin cmds    \\
>  \hline
>  8000h - FFFFh   & Reserved    \\
>  \hline
>  \end{tabular}
>  
> +\begin{note}
> +{The following commands are mandatory for management devices: VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.}
> +\end{note}

this is the first time we mention management devices. We should not use
terms before they are defined.

> +
> +\subsection{VIRTIO ADMIN DEVICE MGMT command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command}
> +
> +The VIRTIO_ADMIN_DEVICE_MGMT command is used by a management device to manage resources of managed virtio devices.

Please rephrase and change terminology to avoid saying manage 3 times in
a single sentence :)
In this case we have concepts of a group already.


Can these commands ever work for the self type?
I don't think they can, right?









> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT by the driver.
> +
> +The command specific data set by the driver is of form:
> +\begin{lstlisting}
> +struct virtio_admin_device_mgmt_data {
> +        /*
> +         * 0 - reserved
> +         * 1 - assign resource to the designated device
> +         * 2 - query resource of the designated device
> +         * 3 - 255 are reserved for future operations
> +         */
> +        u8 operation;
> +        /*
> +         * 0 - Device feature bits 0 to 63
> +         * 1 - 65535 are reserved
> +         */
> +        le16 resource;

I think we need to move padding around here to align the next field.

> +        /*
> +         * The value to the given resource.
> +         * Valid only if operation == 1 (assign).
> +         * resource = 0 indicates device feature bits 0 to 63.
> +         */
> +        le64 resource_val;
> +        u8 reserved[5];
> +};
> +\end{lstlisting}
> +
> +The following table describes the command specific error codes codes:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Opcode & Status & Description \\
> +\hline \hline
> +00h   & VIRTIO_ADMIN_CS_ERR_DEV_IN_USE    & designated device is in use, operation failed   \\
> +\hline
> +01h   & VIRTIO_ADMIN_CS_RSC_VAL_INVALID    & resource value is invalid  \\
> +\hline
> +02h   & VIRTIO_ADMIN_CS_RSC_UNSUPPORTED    & unsupported or invalid resource  \\
> +\hline
> +03h   & VIRTIO_ADMIN_CS_OP_UNSUPPORTED    & unsupported or invalid operation  \\
> +\hline
> +04h - FFh   & Reserved    & -  \\
> +\hline
> +\end{tabular}
> +
> +The device, upon success, returns a result that describes the information according to the requested operation.
> +This result is of form:
> +\begin{lstlisting}
> +struct virtio_admin_device_mgmt_result {
> +        le64 resource_val;
> +        u8 reserved[8];
> +};
> +\end{lstlisting}
> +
> +If the \field{operation} was set to 1 ("assign resource to the designated device") and the command succeeded, the device successfully assigned
> +resources to the designated device. Also, upon success, the assigned value should returned in the \field{resource_val} of the virtio_admin_device_mgmt_result
> +structure and should be equal to the \field{resource_val} of the virtio_admin_device_mgmt_data structure set by the driver.
> +In case of a failure, the value of this field is undefined and will be ignored by the driver.
> +
> +If the \field{operation} was set to 2 ("query resource of the designated device") and the command succeeded, the device will return the requested
> +value in the \field{resource_val} of the virtio_admin_device_mgmt_result structure.
> +In case of a failure, the value of this field is undefined and will be ignored by the driver.
> +
> +\subsection{VIRTIO ADMIN DEVICE MGMT ATTRS command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command}
> +
> +The VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command has no command specific data set by the driver.
> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.
> +
> +The device, upon success, returns a result that describes the management device attributes.
> +This result is of form:
> +\begin{lstlisting}
> +struct virtio_admin_device_mgmt_attrs_result {
> +        /* Indicates which of the below fields are valid.
> +         * Bits 0 - managed_device_features_63_0
> +         * Bits 1 - 63 - reserved for future fields
> +         */
> +        le64 attrs_mask;
> +
> +        le64 managed_device_features_63_0;
> +        u8 reserved[48];

why are we reserving these?

> +};
> +\end{lstlisting}
> +
>  \section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
>  
>  An admin virtqueue is a management interface of a device that can be used to send administrative
> diff --git a/content.tex b/content.tex
> index 5fda1a0..b15a887 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -451,6 +451,48 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>  
>  \input{admin.tex}
>  
> +\section{Device management}\label{sec:Basic Facilities of a Virtio Device / Device management}
> +
> +A device group might consist of one or more virtio devices. For example, virtio PCI SR-IOV PF and its VFs compose a SR-IOV type device group.
> +A capable PCI SR-IOV PF virtio device might act as the management device in this group, and its PCI SR-IOV VFs are the managed devices.
> +A management device might have various management capabilities and attributes to manage its managed devices. These capabilities and attributes exposed
> +via feature bits and in the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command (see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details).
> +
> +The management device will use the VIRTIO_ADMIN_DEVICE_MGMT admin command to manage its managed devices (see section
> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more details).
> +
> +\subsection{Device features management}\label{sec:Basic Facilities of a Virtio Device / Device management / Device features management}
> +
> +A virtio management device that negotiated VIRTIO_F_FEATURE_63_0_MGMT can control the values of the first 64 feature bits for its managed devices.
> +In the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin command, a capable management device will return the feature bits that can be enabled for its managed devices in \field{managed_device_features_63_0}
> +(see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details).
> +A management device driver, using VIRTIO_ADMIN_DEVICE_MGMT can update the feature bits assignment for a specific managed device.
> +A management device driver can only assign a subset of the bits returned in \field{managed_device_features_63_0}.
> +A management device driver can update the managed device feature bits only before the managed device driver set the ACKNOWLEDGE status bit.
> +
> +\begin{note}
> +{It's recommended to manipulate the managed device feature bits before loading the managed device driver.}
> +\end{note}
> +
> +A typical sequence for configuring feature bits is following:
> +
> +\begin{enumerate}
> +\item Ensure that the driver of the managed device doesn't run on the device
> +
> +\item Load the driver of the management device
> +
> +\item Query the management device capabilities using commands VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and look for \field{managed_device_features_63_0}
> +
> +\item Find the managed device group_id and group_member_id
> +
> +\item Query the current feature bits configuration using command VIRTIO_ADMIN_DEVICE_MGMT (query operation)
> +
> +\item Assign desired feature bits for the managed device using command VIRTIO_ADMIN_DEVICE_MGMT (assign operation)
> +
> +\item After successful completion of the assignment, load the managed device driver
> +
> +\end{enumerate}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>  
>  We start with an overview of device initialization, then expand on the
> @@ -6853,6 +6895,14 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  
>    \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
>  
> +  \item[VIRTIO_F_SR_IOV_MGMT_DEVICE (42)] This feature indicates that the device is a SR-IOV management device.
> +  SR-IOV management device is a device that can manage other devices within the SR-IOV device group.
> +  For more details see \ref{sec:Introduction / Terminology / Virtio SR-IOV type management device}.
> +
> +  \item[VIRTIO_F_FEATURE_63_0_MGMT (43)] This feature indicates that the device is a management device that supports
> +  feature mgmt of bits 0 to 63 for its managed devices.

eschew abbreviation in text please.

why limit this to bits 0 to 63? why not make the command cover any number of bits?


> +  For more details see \ref{sec:Basic Facilities of a Virtio Device / Device management / Device features management}.
> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> diff --git a/introduction.tex b/introduction.tex
> index e8bde45..e20df24 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -173,6 +173,9 @@ \subsection{Device group}\label{sec:Introduction / Terminology / Device group}
>  \item SR-IOV type (group identifier = 1) - this group includes a virtio PCI SR-IOV physical function (PF) and all its virtual functions (VFs).
>  For this group type, the PF device has group member identifier of 0. Each VF group member identifier equals the PCI VF number according to the PCI Express Base Specification
>  (Single Root I/O Virtualization and Sharing chapter). Devices that are members in this group use the Virtio PCI transport (for more details see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> +A PCI SR-IOV PF device can act as a management device for SR-IOV type device group. A PCI SR-IOV VF device can act as a managed device for SR-IOV type device group
> +(see \ref{sec:Introduction / Terminology / Virtio management device} and \ref{sec:Introduction / Terminology / Virtio managed device} for more information).
> +SR-IOV type device group may contain zero or one management devices.
>  \end{enumerate}
>  
>  \begin{note}
> @@ -180,6 +183,33 @@ \subsection{Device group}\label{sec:Introduction / Terminology / Device group}
>    member identifier equals to 0 within Self type group and a group member identifier equals to VF number (e.g 4) within SR-IOV type group.
>  \end{note}
>  
> +\subsection{Virtio management device}\label{sec:Introduction / Terminology / Virtio management device}
> +
> +A virtio device that supports VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands (see
> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} and
> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more information).
> +This device can manage a virtio managed device. A device group may contain zero or more management devices.
> +
> +A PCI SR-IOV Physical Function based virtio device is an example of a possible virtio management device (for SR-IOV type device group).
> +
> +\subsection{Virtio SR-IOV type management device}\label{sec:Introduction / Terminology / Virtio SR-IOV type management device}
> +
> +A virtio management device for SR-IOV type device group. A driver can issue the management admin commands to this device with \field{group_id} set to 1
> +and \field{group_member_id} set to an identifier that corresponds with one of its managed virtio devices (PCI SR-IOV VFs).
> +A Virtio SR-IOV type management device must expose VIRTIO_F_SR_IOV_MGMT_DEVICE feature bit.
> +
> +\subsection{virtio managed device}\label{sec:Introduction / Terminology / Virtio managed device}
> +
> +A virtio device that can be managed by a virtio management device.
> +A device group may contain zero or more managed devices.
> +
> +A PCI SR-IOV Virtual Function based virtio device is an example of a possible virtio managed device (for SR-IOV type device group).
> +
> +\subsection{virtio SR-IOV type managed device}\label{sec:Introduction / Terminology / Virtio SR-IOV type managed device}
> +
> +A virtio managed device for SR-IOV type device group. This device is a PCI SR-IOV VF and is managed by a virtio SR-IOV type management device (virtio PCI SR-IOV PF).
> +It is implied that all the virtio PCI SR-IOV VFs related to a virtio PCI SR-IOV PF that is virtio SR-IOV type management device are SR-IOV type managed devices.
> +
>  \section{Structure Specifications}\label{sec:Structure Specifications}
>  
>  Many device and driver in-memory structure layouts are documented using
> -- 
> 2.21.0

