Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <0d841258-1330-084f-57f2-30da7b58ff1b@nvidia.com>
Date: Wed, 18 May 2022 18:03:42 +0300
Subject: Re: [PATCH v5 6/7] Introduce MGMT admin commands
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-7-mgurtovoy@nvidia.com>
 <20220515102628-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220515102628-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/15/2022 5:37 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 27, 2022 at 01:58:23AM +0300, Max Gurtovoy wrote:
>> Introduce the concept of a management and a managed device and add
>> example of using this concept to manage resources.
>>
>> A management device supports the VIRTIO_ADMIN_DEVICE_MGMT and
>> VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands to manage some resources
>> of a managed device.
>>
>> A typical cloud provider SR-IOV use case is to create many VFs for use
>> by guest VMs. The VFs may not be assigned to a VM until a user requests
>> a VM of a certain size, e.g., number of CPUs. A VF may need MSI-X
>> vectors proportional to the number of CPUs in the VM, but there is no
>> standard way today in the spec to change the number of MSI-X vectors
>> supported by a VF, although there are some operating systems that
>> support this.
>>
>> The new admin mechanism manages the MSI-X interrupt vectors assignments
>> of a managed PCI device (i.e. VF) by its management devices (i.e. its
>> parent PF) but can easily extended to any other generic resource
>> management.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> I'd like to see msix and the concept of type 1 group
> in a separate patch from MSIX.
ok.
>
> I am not sure MSIX things are ready but the grouping part looks mostly
> ok to me.
>
>> ---
>>   admin.tex        | 132 +++++++++++++++++++++++++++++++++++++++++++++--
>>   content.tex      |  81 +++++++++++++++++++++++++++++
>>   introduction.tex |  32 +++++++++++-
>>   3 files changed, 241 insertions(+), 4 deletions(-)
>>
>> diff --git a/admin.tex b/admin.tex
>> index d09683d..5b54743 100644
>> --- a/admin.tex
>> +++ b/admin.tex
>> @@ -79,12 +79,20 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
>>   \hline
>>   0001h   & VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT    & M  \\
>>   \hline
>> -0002h - 7FFFh   & Generic admin cmds    & -  \\
>> +0002h   & VIRTIO_ADMIN_DEVICE_MGMT    & O  \\
>> +\hline
>> +0003h   & VIRTIO_ADMIN_DEVICE_MGMT_ATTRS    & O  \\
>> +\hline
>> +0004h - 7FFFh   & Generic admin cmds    & -  \\
>>   \hline
>>   8000h - FFFFh   & Reserved    & - \\
>>   \hline
>>   \end{tabular}
>>   
>> +\begin{note}
>> +{The following commands are mandatory for management devices: VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.}
>> +\end{note}
>> +
>>   \subsection{VIRTIO ADMIN DEVICE CAPS IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
>>   
>>   The VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command has no command specific data set by the driver.
>> @@ -102,13 +110,20 @@ \subsection{VIRTIO ADMIN DEVICE CAPS IDENTIFY command}\label{sec:Basic Facilitie
>>          le64 attrs_mask;
>>          /* This field indicates which of the below admin
>>           * capabilities are supported by the device:
>> -        * Bits 0 - 63 - reserved for future capabilities.
>> +        * Bit 0 - if set, the device is a management device
>> +        * Bit 1 - if set, the device is a type 1 management device that supports
>> +        *         MSI-X vector mgmt of its type 1 managed devices
>> +        * Bits 2 - 63 - reserved for future capabilities.
>>           */
>>          le64 device_admin_caps;
>>          u8 reserved[112];
>>   };
>>   \end{lstlisting}
>>   
>> +\begin{note}
>> +{For more details on MSI-X vector management support see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / MSI-X vector management}.}
>> +\end{note}
>> +
>>   \subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS ACCEPT command}
>>   
>>   The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the driver to acknowledge those admin capabilities it understands and wishes to use.
>> @@ -125,13 +140,124 @@ \subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT command}\label{sec:Basic Facilities
>>          le64 attrs_mask;
>>          /* This field indicates which of the below admin
>>           * capabilities are supported by the driver:
>> -        * Bits 0 - 63 - reserved for future capabilities.
>> +        * Bit 0 - if set, the driver accepted the device as a management device
>> +        * Bit 1 - if set, the driver accepted the device as a type 1 management device
>> +        *         that supports MSI-X vector mgmt of its type 1 managed devices
>> +        * Bits 2 - 63 - reserved for future capabilities.
>>           */
>>          le64 driver_admin_caps;
>>          u8 reserved[112];
>>   };
>>   \end{lstlisting}
>>   
>> +\subsection{VIRTIO ADMIN DEVICE MGMT command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command}
>> +
>> +The VIRTIO_ADMIN_DEVICE_MGMT command is used by a management device to manage resources of managed virtio devices.
>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT by the driver.
>> +
>> +The command specific data set by the driver is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_mgmt_data {
>> +        /*
>> +         * 0 - reserved
>> +         * 1 - assign resource to the designated vdev_id
>> +         * 2 - query resource of the designated vdev_id
>> +         * 3 - 255 are reserved
>> +         */
>> +        u8 operation;
>> +        /*
>> +         * 0 - MSI-X vector
>> +         * 1 - 65535 are reserved
>> +         */
>> +        le16 resource;
>> +        /*
>> +         * The value to the given resource:
>> +         * if resource = 0 (MSI-X vector), it's a 1-based count.
>> +         */
>> +        le64 resource_val;
>> +        u8 reserved[5];
>> +};
>> +\end{lstlisting}
>> +
>> +The following table describes the command specific error codes codes:
>> +
>> +\begin{tabular}{|l|l|l|}
>> +\hline
>> +Opcode & Status & Description \\
>> +\hline \hline
>> +00h   & VIRTIO_ADMIN_CS_ERR_VDEV_IN_USE    & designated device is in use, operation failed   \\
>> +\hline
>> +01h   & VIRTIO_ADMIN_CS_RSC_VAL_INVALID    & resource value is invalid  \\
>> +\hline
>> +02h   & VIRTIO_ADMIN_CS_RSC_UNSUPPORTED    & unsupported or invalid resource  \\
>> +\hline
>> +03h   & VIRTIO_ADMIN_CS_OP_UNSUPPORTED    & unsupported or invalid operation  \\
>> +\hline
>> +04h - FFh   & Reserved    & -  \\
>> +\hline
>> +\end{tabular}
>> +
>> +The device, upon success, returns a result that describes the information according to the requested operation.
>> +This result is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_mgmt_result {
>> +        le64 resource_val;
>> +        u8 reserved[8];
>> +};
>> +\end{lstlisting}
>> +
>> +If the requested operation by the driver was "assign resource to the designated vdev_id", the device will return the resource_val of the assigned
>> +resources to the designated vdev_id. Upon success, this value should be equal to the \field{resource_val} of the virtio_admin_device_mgmt_data
>> +structure set by the driver. In case of a failure, the value of this field is undefined and will be ignored by the driver.
>> +
>> +If the requested operation by the driver was "query resource of the designated vdev_id", the device will return resource_val of the currently assigned
>> +resources to the designated vdev_id upon success. In case of a failure, the value of this field is undefined and will be ignored by the driver.
>> +
>> +\begin{note}
>> +{MSI-X vector resource type is valid only for PCI devices. VIRTIO_ADMIN_CS_RSC_UNSUPPORTED error is
>> +returned by the device when the designated vdev_id is not a PCI device.}
>> +\end{note}
>> +
>> +\begin{note}
>> +{For this command, if driver is setting \field{resource} to MSI-X vector type, the \field{vdev_id} can't be associated with a Virtual Function with
>> +VF index greater than NumVFs value as defined in the PCI specification or smaller than 1. An error is returned by the device when \field{vdev_id} is out of the range.}
>> +\end{note}
>> +
>> +\subsection{VIRTIO ADMIN DEVICE MGMT ATTRS command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command}
>> +
>> +The VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command has no command specific data set by the driver.
>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.
>> +
>> +The device, upon success, returns a result that describes the management device attributes.
>> +This result is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_mgmt_attrs_result {
>> +        /* Indicates which of the below fields were returned
>> +         * (1 means that field was returned):
>> +         * Bit 0 - vfs_total_msix_count
>> +         * Bit 1 - vfs_assigned_msix_count
>> +         * Bit 2 - per_vf_max_msix_count
>> +         * Bits 3 - 63 - reserved for future fields
>> +         */
>> +        le64 attrs_mask;
>> +
>> +        /* Total number of msix vectors for the total number of VFs */
>> +        le32 vfs_total_msix_count;
>> +        /* Assigned number of msix vectors for the enabled VFs */
>> +        le32 vfs_assigned_msix_count;
>> +        /* Max number of msix vectors that can be assigned for a single VF */
>> +        le16 per_vf_max_msix_count;
>> +
>> +        u8 reserved[110];
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{note}
>> +{The \field{vfs_total_msix_count}, \field{vfs_assigned_msix_count} and \field{per_vf_max_msix_count} returned by the device if the
>> +designated vdev_id is a management device that can allocate/deallocate MSI-X resources for PCI VFs devices. Otherwise,
>> +the associated bits in \field{attrs_mask} are zeroed by the device.}
>> +\end{note}
>> +
>>   \section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
>>   
>>   An admin virtqueue is a management interface of a device that can be used to send administrative
>> diff --git a/content.tex b/content.tex
>> index 0c1d44f..81e5850 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -451,6 +451,18 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>   
>>   \input{admin.tex}
>>   
>> +\section{Device management}\label{sec:Basic Facilities of a Virtio Device / Device management}
>> +
>> +A device group might consist of one or more virtio devices. For example, virtio PCI SR-IOV PF and its VFs compose a type 1 device group.
>> +A capable PCI SR-IOV PF virtio device might act as the management device in this group, and its PCI SR-IOV VFs are the managed devices.
>> +A management device might have various management capabilities and attributes to manage its managed devices.
> This makes my eyes glaze over.
> Please, find all instances which say "manage" more than once and
> rephrase.

Can you propose something you like ?

Each individual has different wording style.

Just choose whatever fits to your style and I'll add it.

>
>> The capabilities exposed
>> +in the result of VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command (see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
>> +for more details) and the attributes exposed in the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command
>> +(see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details).
>> +
>> +The management device will use the VIRTIO_ADMIN_DEVICE_MGMT admin command to manage its managed devices (see section
>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more details).
>> +
>>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>   
>>   We start with an overview of device initialization, then expand on the
>> @@ -1763,6 +1775,75 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>>       \end{itemize}
>>   \end{itemize}
>>   
>> +\subsection{PCI-specific Admin capabilities}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin capabilities}
>> +
>> +This documents the group of admin capabilities for PCI virtio devices. Each capability is
>> +implemented using one or more Admin commands.
>> +
>> +\subsubsection{MSI-X vector management}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / MSI-X vector management}
>> +
>> +This capability enables a virtio management device to control the assignment of MSI-X interrupt vectors
>> +for its managed devices. In PCI, a management device can be the PF device and the managed device can be the VF (for example in a type 1 device group).
>> +Capable management devices will need to implement VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands, report the MSI-X attributes in the result of
>> +VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and report that MSI-X vector resource management is supported in the result of VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY admin command.
>> +See sections \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command} and
>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
>> +
>> +In the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin command, a capable management device will return the total number of
>> +msix vectors for its VFs in \field{vfs_total_msix_count} field, the number of already assigned msix vectors for its VFs in
>> +\field{vfs_assigned_msix_count} field and also the maximal number of msix vectors that can be assigned for a single VF in
>> +\field{per_vf_max_msix_count} field. In addition, bit 0, bit 1 and bit 2 are set to indicate on the validity of the other 3
>> +fields in the \field{attrs_mask} field of the result buffer.
>> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
>> +
>> +The default assignment of the MSI-X vectors for managed devices is out of the scope of this specification.
>> +A driver, using VIRTIO_ADMIN_DEVICE_MGMT can update the MSI-X assignment for a specific managed device.
>> +In the data of VIRTIO_ADMIN_DEVICE_MGMT admin command, a driver set the \field{resource} type to be MSI-X vector and the
>> +amount of MSI-X interrupt vectors to configure to the designated managed device in \field{resource_val}. The managed device id is set to \field{vdev_id} field.
>> +
>> +A successful operation guarantees that the requested amount of MSI-X interrupt vectors was assigned to the designated device.
>> +This value is also returned in the virtio_admin_device_mgmt_result structure.
>> +Also, a successful operation guarantees that the MSI-X capability access by the designated PCI device defined by the PCI specification must reflect
>> +the new configuration in all relevant fields. For example, by default if the PCI VF has been assigned 4 MSI-X vectors, and VIRTIO_ADMIN_DEVICE_MGMT
>> +increases the MSI-X vectors to 8. On this change, reading Table size field of the MSI-X message control register will reflect a value of 7.
>> +
>> +It is beyond the scope of the virtio specification to define
>> necessary synchronization in system software to ensure that a virtio
>> PCI VF device +interrupt configuration modification is reflected in
>> the PCI device.
> IMHO it is very much in scope of the specification. The scope of the
> specification is to allow device interoperability and this very much
> fits the bill.

each system has its own set of tools and definitions.

It's not covered in the spec today and should be covered. Otherwise, the 
spec will get inside areas it shouldn't.


>
>> However, it is expected that any modern system software implementing
>> virtio +drivers and PCI subsystem will ensure that any changes
>> occurring in the VF interrupt configuration is either updated in the
>> PCI VF device or +such configuration fails.
> OK. Anything more? What exactly does "interrupt configuration" mean here?

MSI-X configuration.


>
>> For example, one way to
>> implement that is to make sure that there is no driver bounded to the
>> virtio PCI SR-IOV VF during +this operation.
> bounded in what sense?
in a sense that a pci device driver is bounded and probed the device.
>
> And why do you say VF? Is this command limited to type 1? You only
> limit it to PCI above.

Today we support setting MSI-X configuration for VFs.

This is why I mentioned VFs.

IIRC, you asked to mentioned VFs in the past - but I'm not sure.

Is this a problem ? should I remove some sentance ?

> same elsewhere
>
>> +
>> +To query amount of MSI-X interrupt vectors that is currently assigned to a managed device, the driver issue VIRTIO_ADMIN_DEVICE_MGMT with \field{operation} set to
> issues
>
> lots of grammar error like this elsewhere, pls find and correct.
>
>> +"query resource of the designated vdev_id" value (== 2). The driver also set the \field{resource} type to be MSI-X vector and the managed device id is set to \field{vdev_id}
>> +field. In the result of a successful operation,
> meaning "in case"?
yes.
>> the amount of MSI-X interrupt vectors that is currently assigned to the designated managed device is
>> +returned by the device in \field{resource_val} field of the virtio_admin_device_mgmt_result structure.
>> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more details.
>> +
>> +\paragraph{MSI-X configuration sequence example}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control / MSI-X configuration sequence example }
>> +
>> +A typical sequence for configuring MSI-X vectors for PCI VFs using MSI-X vector management mechanism is following:
> rephrase to simplify
>
> The driver uses the following sequence for configuring MSI-X vectors
> ....

But it's not the driver.

why should I change this if it's not true ?

>
>
>> +
>> +\begin{enumerate}
>> +\item Ensure that VF driver doesn't run and it is safe to change MSI-X (e.g. disable sriov auto probing)
>> +
>> +\item Load the PF driver
>> +
>> +\item Enable SR-IOV by following the PCI specification
>> +
>> +\item Query the management device capabilities using commands VIRTIO_ADMIN_DEVICE_IDENTIFY and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS
>> +
>> +\item Find the managed VF vdev_id (for type 1 device group the vdev_id of PCI VF is equal to vf number)
>> +
>> +\item Query the VF MSI-X configuration using command VIRTIO_ADMIN_DEVICE_MGMT (query operation)
>> +
>> +\item Assign desired MSI-X configuration for the VF using command VIRTIO_ADMIN_DEVICE_MGMT (assign operation)
>> +
>> +\item After successful completion of the assignment, load the VF driver
>> +
>> +\item Assign the VF to a VM
>> +
>> +\end{enumerate}
>> +
>>   \section{Virtio Over MMIO}\label{sec:Virtio Transport Options / Virtio Over MMIO}
>>   
>>   Virtual environments without PCI support (a common situation in
>> diff --git a/introduction.tex b/introduction.tex
>> index 4358ab1..bfc5498 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -164,9 +164,39 @@ \subsection{Device group}\label{sec:Introduction / Terminology / Device group}
>>   For now, the supported device groups are:
>>   \begin{enumerate}
>>   \item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI SR-IOV virtual functions (VFs). For this group type, the PF device has vdev_id that is equal to 0
>> -and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification).
>> +and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification). A PCI SR-IOV PF device can act as a management device for
>> +type 1 group. A PCI SR-IOV VF device can act as a managed device for type 1 group (see \ref{sec:Introduction / Terminology / Virtio management device} and
>> +\ref{sec:Introduction / Terminology / Virtio managed device} for more information).
>>   \end{enumerate}
>>   
>> +\subsection{Virtio management device}\label{sec:Introduction / Terminology / Virtio management device}
>> +
>> +A virtio device that supports VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands (see
>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} and
>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more information).
>> +This device can manage a virtio managed device. A device group may contain zero or more management devices.
>> +
>> +A PCI SR-IOV Physical Function based virtio device is an example of a possible virtio management device (for type 1 device group).
>> +
>> +\subsection{Virtio type 1 management device}\label{sec:Introduction / Terminology / Virtio type 1 management device}
>> +
>> +A virtio management device for type 1 device group. This device is a PCI SR-IOV PF that can set \field{dst_type} to 1 (other virtio device in the same device group),
>> +and set \field{vdev_id} to an id that corresponds with one of its managed virtio devices (PCI SR-IOV VFs) for the VIRTIO_ADMIN_DEVICE_MGMT admin command.
>> +
>> +A type 1 device group may contain zero or one management devices.
>> +
>> +\subsection{virtio managed device}\label{sec:Introduction / Terminology / Virtio managed device}
>> +
>> +A virtio device that can be managed by a virtio management device.
>> +A device group may contain zero or more managed devices.
>> +
>> +A PCI SR-IOV Virtual Function based virtio device is an example of a possible virtio managed device (for type 1 group).
>> +
>> +\subsection{virtio type 1 managed device}\label{sec:Introduction / Terminology / Virtio type 1 managed device}
>> +
>> +A virtio managed device for type 1 device group. This device is a PCI SR-IOV VF and is managed by a virtio type 1 management device (virtio PCI SR-IOV PF).
>> +It is implied that all the virtio PCI SR-IOV VFs related to a virtio PCI SR-IOV PF that is virtio type 1 management device are type 1 managed devices.
>> +
>>   \section{Structure Specifications}\label{sec:Structure Specifications}
>>   
>>   Many device and driver in-memory structure layouts are documented using
>> -- 
>> 2.21.0

