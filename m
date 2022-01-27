Return-Path: <jasowang@redhat.com>
Message-ID: <e0726651-4534-26e9-3368-abee12ed13c0@redhat.com>
Date: Thu, 27 Jan 2022 11:36:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] Add support for MSI-X vectors configuration for
 PCI VFs
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-5-mgurtovoy@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220124093918.34371-5-mgurtovoy@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/1/24 下午5:39, Max Gurtovoy 写道:
> A typical cloud provider SR-IOV use case is to create many VFs for
> use by guest VMs. The VFs may not be assigned to a VM until a user
> requests a VM of a certain size, e.g., number of CPUs. A VF may need
> MSI-X vectors proportional to the number of CPUs in the VM, but there is
> no standard way today in the spec to change the number of MSI-X vectors
> supported by a VF, although there are some operating systems that
> support this.
>
> Introduce new admin commands for a generic interrupt vector management
> for PCI VFs. For now, this mechanism will manage the MSI-X interrupt
> vectors assignments of a VF by its parent PF.
>
> These admin commands will be easily extended, if needed, for other types
> of interrupt vectors in the future with backward compatibility to old
> drivers and devices.
>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   admin-virtq.tex | 150 +++++++++++++++++++++++++++++++++++++++++++++++-
>   content.tex     |  44 ++++++++++++++
>   2 files changed, 192 insertions(+), 2 deletions(-)
>
> diff --git a/admin-virtq.tex b/admin-virtq.tex
> index 1a41c22..b57b57d 100644
> --- a/admin-virtq.tex
> +++ b/admin-virtq.tex
> @@ -64,7 +64,13 @@ \section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin
>   \hline \hline
>   0000h   & VIRTIO_ADMIN_CAPS_IDENTIFY    & M  \\
>   \hline
> -0001h - 7FFFh   & Generic admin cmds    & -  \\
> +0001h   & VIRTIO_ADMIN_PCI_SRIOV_ATTRS    & O  \\
> +\hline
> +0002h   & VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET    & O  \\
> +\hline
> +0003h   & VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET    & O  \\
> +\hline
> +0004h - 7FFFh   & Generic admin cmds    & -  \\
>   \hline
>   8000h - FFFFh   & Reserved    & - \\
>   \hline
> @@ -78,7 +84,8 @@ \subsection{VIRTIO ADMIN CAPS IDENTIFY command}\label{sec:Basic Facilities of a
>   \begin{lstlisting}
>   struct virtio_admin_caps_identify_result {
>          /*
> -        * caps[0] - Bit 0x0 - Bit 0x7 are reserved
> +        * caps[0] - Bit 0x0 - if set, VF MSI-X control supported
> +        *           Bit 0x1 - Bit 0x7 are reserved
>           * caps[1] - Bit 0x0 - Bit 0x7 are reserved
>           * caps[2] - Bit 0x0 - Bit 0x7 are reserved
>           * ....
> @@ -87,3 +94,142 @@ \subsection{VIRTIO ADMIN CAPS IDENTIFY command}\label{sec:Basic Facilities of a
>          u8 caps[8192];
>   };
>   \end{lstlisting}
> +
> +For more details on VF MSI-X configuration support see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control}.
> +
> +\subsection{VIRTIO ADMIN PCI SRIOV ATTRS command}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI SRIOV ATTRS command}
> +


So this is all for PCI transport, do we need to

1) move this to PCI transport

or

2) use non PCI specific termiology (PF/VF) here

?


> +The VIRTIO_ADMIN_PCI_SRIOV_ATTRS command has no command specific data set by the driver.
> +This command upon success, returns a data buffer that describes information about PCI SRIOV
> +related capabilities and attributes for the device. This command can be supported only by
> +PCI devices that supports Single Root I/O Virtualization.
> +This information is of form:
> +\begin{lstlisting}
> +struct virtio_admin_pci_sriov_attrs_result {
> +        /* For compatibility - indicates which of the below fields are valid (1 means valid):
> +         * Bit 0x0 - vfs_free_msix_count
> +         * Bit 0x1 - per_vf_max_msix_count
> +         * Bits 0x2 - 0x3F - reserved for future fields
> +         */


So we have several layers of compatibilities:

1) feature bits
2) cap bitmap / identifiy
3) attrs_mask (no negotiation so it's unclear that how the compatibility 
can work here).

This looks like a burden for the management.

Is it really helpful to have a device that can only return 
free_msix_count but not per_vf_max_msix_count?

And I think it's better to explicit split the commands then we can have 
dedicated commands for MSI instead of trying to mix all SRIOV related 
attributes into the same command.


> +        le64 attrs_mask;
> +        /* Number of free msix vectors in the global msix pool for VFs */
> +        le32 vfs_free_msix_count;
> +        /* Max number of msix vectors that can be assigned for a single VF */
> +        le16 per_vf_max_msix_count;
> +};
> +\end{lstlisting}
> +
> +\subsection{VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command}
> +
> +The VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET command is used to modify the interrupt vectors
> +count for a PCI virtual function. The command specific data set by the driver is of form:
> +\begin{lstlisting}
> +struct virtio_admin_pci_vf_interrupt_config_set_data {
> +        /* The virtual function number */
> +        le16 vf_number;
> +        /* For compatibility - indicates which of the below properties should be
> +         * modified (1 means that field should be modified):
> +         * Bit 0x0 - msix_count
> +         * Bits 0x1 - 0x3F - reserved for future fields
> +         */
> +        le64 attrs_mask;
> +        /* The amount of MSI-X interrupt vectors */
> +        le16 msix_count;
> +};
> +\end{lstlisting}


I think it's better to have a dedicated command to set the msix_vectors, 
then there's no need for the attrs_mask.


> +
> +The following table describes the command specific error codes codes:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Opcode & Status & Description \\
> +\hline \hline
> +00h   & VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID    & invalid VF number  \\


Does it mean it exceeds the totalVFs? We need an accurate definition on 
"invalid" here.


> +\hline
> +01h   & VIRTIO_ADMIN_CS_ERR_PCI_MSIX_COUNT_EXCEED    & MSI-X count exceed the max value per VF  \\


I guess it's actually per_vf_max_msix_count? What if the device doesn't give us per_vf_max_msix_count (it's odd but it's allowed in this propsal if I was not wrong).


> +\hline
> +02h   & VIRTIO_ADMIN_CS_ERR_PCI_MSIX_POOL_NO_RSC    & MSI-X count exceed the free pool resources   \\
> +\hline


Do we need to define "pool" here?


> +03h   & VIRTIO_ADMIN_CS_ERR_PCI_VF_IN_USE    & VF is already in use, operation failed   \\


How do you define "VF is already in use"? Is this command only 
applicable when sriov_numvfs in the capability is zero? How about the 
initial associated VF via initial_vfs?


> +\hline
> +04h - FFh   & Reserved    & -  \\
> +\hline
> +\end{tabular}
> +
> +\begin{note}
> +{vf_number can't be greater than NumVFs value as defined in the PCI specification
> +or smaller than 1. A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID
> +is returned when vf_number is out of the range.}


Should be TotalVFs in the SR-IOV extended capability.


> +\end{note}
> +
> +\begin{note}
> +{A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_MSIX_COUNT_EXCEED
> +is returned when the amount of MSI-X to assign exceed the maximum value that can be
> +assigned to a single VF.}
> +\end{note}
> +
> +\begin{note}
> +{A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_MSIX_POOL_NO_RSC
> +is returned when the amount of MSI-X to assign exceed the amount of free MSI-X
> +vectors in the global pool.}
> +\end{note}
> +
> +This command has no command specific result set by the device. Upon success, the device guarantees
> +that all the requested properties were modified to the given values. Otherwise, error will be returned.
> +
> +\begin{note}
> +{Before setting msix_count property the virtual/managed device (VF) shall be un-initialized and may not be used by the driver.
> +Otherwise, a command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_VF_IN_USE will be returned.}


How did the device know whether or not VF is not used by any driver?


> +\end{note}
> +
> +\subsection{VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command}
> +
> +The VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET command is used to obtain the values of the VFs
> +interrupt vectors configuration.
> +The command specific data set by the driver is of form:
> +\begin{lstlisting}
> +struct virtio_admin_pci_vf_interrupt_config_get_data {
> +        /* The virtual function number */
> +        le16 vf_number;
> +        /* For compatibility - indicates which of the below properties should be
> +         * queried (1 means that field should be queried):
> +         * Bit 0x0 - msix_count (The amount of MSI-X interrupt vectors)
> +         * Bits 0x1 - 0x3F - reserved for future fields
> +         */
> +        le64 attrs_mask;
> +};
> +\end{lstlisting}
> +
> +The following table describes the command specific error codes codes:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Opcode & Status & Description \\
> +\hline \hline
> +00h   & VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID    & invalid VF number  \\
> +\hline
> +01h - FFh   & Reserved    & -  \\
> +\hline
> +\end{tabular}
> +
> +\begin{note}
> +{vf_number can't be greater than NumVFs value as defined in the PCI specification


I guess for NumVFs you meant the TotalVFs in SR-IOV extended capability.


> +or smaller than 1. A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID
> +is returned when vf_number is out of the range.}
> +\end{note}
> +
> +This command, upon success, returns a data buffer that describes the properties that were requested
> +and their values for the subject virtio VF device according to the given vf_number.
> +This information is of form:
> +\begin{lstlisting}
> +struct virtio_admin_pci_vf_interrupt_config_get_result {
> +        /* For compatibility - indicates which of the below fields were returned
> +         * (1 means that field was returned):
> +         * Bit 0x0 - msix_count
> +         * Bits 0x1 - 0x3F - reserved for future fields
> +         */
> +        le64 attrs_mask;
> +        /* The amount of MSI-X interrupt vectors currently assigned to the VF */
> +        le16 msix_count;
> +};
> +\end{lstlisting}
> diff --git a/content.tex b/content.tex
> index 18a5c66..2dd1d46 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1734,6 +1734,50 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>       \end{itemize}
>   \end{itemize}
>   
> +\subsection{PCI-specific Admin capabilities}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin capabilities}
> +
> +This documents the group of Admin capabilities for PCI virtio devices. Each capability is
> +implemented using one or more Admin queue commands.
> +
> +\subsubsection{VF MSI-X control}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control}
> +
> +This capability enables a virtio PCI PF device to control the assignment of MSI-X interrupt vectors
> +for its managed VFs. Capable devices will need to set bit 0x0 of caps[0] in the result of VIRTIO_ADMIN_CAPS_IDENTIFY
> +admin command. See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN CAPS IDENTIFY command}
> +for more details.
> +
> +Capable devices will also need to implement VIRTIO_ADMIN_PCI_SRIOV_ATTRS, VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET and
> +VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET admin commands.
> +
> +In the result of VIRTIO_ADMIN_PCI_SRIOV_ATTRS admin command, a capable device should return the number of free msix vectors
> +in the global msix pool for its VFs in \field{vfs_free_msix_count} field and also the maximal number of msix vectors that
> +can be assigned for a single VF in \field{per_vf_max_msix_count} field. In addition, bit 0x0 and bit 0x1 should be set
> +to indicate on the validity of the other 2 fields in the \field{attrs_mask} field of the result buffer.
> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI SRIOV ATTRS command} for more
> +details.
> +
> +A PCI PF device may assign default number of MSI-X vectors to the enabled PCI VFs. Also, using VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET
> +it is possible to update the default MSI-X assignment for a specific VF.
> +In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET admin command, a driver set the virtual function number in
> +\field{vf_number} and the amount of MSI-X interrupt vectors to configure to the subject virtual function in \field{msix_count}.
> +In addition, bit 0x0 in the \field{attrs_mask} field should be set. A successful operation guarantees that the requested
> +amount of MSI-X interrupt vectors was assigned to the subject virtual function.
> +Also, a successful operation guarantees that the MSI-X capability access by the subject PCI VF defined by the PCI specification must reflect
> +the new configuration in all relevant fields. For example, by default if the PCI VF has been assigned 4 MSI-X vectors, and VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET increases the MSI-X vectors to 8; on this change, reading Table size field of the MSI-X message control
> +register should reflect a value of 7.
> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command} for more details.
> +
> +It is beyond the scope of the virtio specification to define necessary synchronization in system software to ensure that a virtio PCI VF device
> +interrupt configuration modification is reflected in the PCI device. However, it is expected that any modern system software implementing virtio
> +drivers and PCI subsystem should ensure that any changes occurring in the VF interrupt configuration is either updated in the PCI VF device or
> +such configuration fails.
> +
> +In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET admin command, a driver should set the virtual function number in
> +\field{vf_number}. In addition, bit 0x0 in the \field{attrs_mask} field should be set to indicate requested output fields in
> +the result from the device. In the result of a successful operation, the amount of MSI-X interrupt vectors that is currently
> +assigned to the subject virtual function is returned by the device in \field{msix_count} field. In addition, bit 0x0 in the \field{attrs_mask} field should be set by the device to indicate on the validity of \field{msix_count} field.
> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command} for more details.
> +


I think we should have a guidance on how to provision #msix_vectors step 
by step. E.g:

1) Do we need to do that before or after the VF provisioning
2) Can the value survive when 0 is wrote to sriov_numvfs

etc.

Thanks


>   \section{Virtio Over MMIO}\label{sec:Virtio Transport Options / Virtio Over MMIO}
>   
>   Virtual environments without PCI support (a common situation in

