Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <91e01313-aa75-20ed-066c-8884b773d3ef@nvidia.com>
Date: Mon, 4 Apr 2022 20:08:54 +0300
Subject: Re: [PATCH v4 1/1] Introduce MGMT Admin commands
References: <20220302160237.26742-1-mgurtovoy@nvidia.com>
 <20220302160237.26742-2-mgurtovoy@nvidia.com>
 <20220404090515-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220404090515-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/4/2022 4:58 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 02, 2022 at 06:02:37PM +0200, Max Gurtovoy wrote:
>> Introduce the concept of a management and a managed device. A
>> management device supports the VIRTIO_ADMIN_DEVICE_MGMT,
>> VIRTIO_ADMIN_DEVICE_MGMT_CAPS, VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and
>> VIRTIO_ADMIN_MANAGED_DEVICE_LIST commands to manage some resources of
>> the managed device.
>>
>> Also introduce a new mechanism to issue commands with dst_type field
>> that is not "self". With the new mechanism, driver can set dst_type to 1
>> and use the the vdev_id common field to describe the target vdev_id.
>>
>> This mechanism is useful for virtio subsystems with multiple devices
>> with various different capabilities. For example, a virtio subsystem
>> that contains a PCI PF and its VF. For this subsystem, a clever system
>> administrator can use admin commands to map between a vdev_id and a VF
>> number and use it to manipulate the VF resources.
>>
>> As we know, a typical cloud provider SR-IOV use case is to create many
>> VFs for use by guest VMs. The VFs may not be assigned to a VM until a
>> user requests a VM of a certain size, e.g., number of CPUs. A VF may
>> need MSI-X vectors proportional to the number of CPUs in the VM, but
>> there is no standard way today in the spec to change the number of MSI-X
>> vectors supported by a VF, although there are some operating systems
>> that support this.
>>
>> The new admin mechanism manages the MSI-X interrupt vectors assignments
>> of a managed PCI device (i.e. VF) by its management devices (i.e. its
>> parent PF) but can easily extended to any other generic resource
>> management.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   admin.tex        | 205 +++++++++++++++++++++++++++++++++++++++++++++--
>>   content.tex      |  88 ++++++++++++++++++++
>>   introduction.tex |  25 ++++++
>>   3 files changed, 310 insertions(+), 8 deletions(-)
>>
>> diff --git a/admin.tex b/admin.tex
>> index ed9f6bd..f069dd5 100644
>> --- a/admin.tex
>> +++ b/admin.tex
>> @@ -9,11 +9,13 @@ \section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admi
>>           le16 command;
>>           /*
>>            * 0 - self
>> -         * 1 - 65535 are reserved
>> +         * 1 - other virtio device in the same subsystem (described by vdev_id)
>> +         * 2 - 65535 are reserved
>>            */
>>           le16 dst_type;
>> +        le64 vdev_id;
> alignment issues here. Also can we rename dst_type and vdev_id so they
> are consistent? dst_id maybe?

what alignment ?

maybe dest_vdev_id ?

>>           /* reserved for common cmd fields */
>> -        u8 reserved[20];
>> +        u8 reserved[12];
>>           u8 command_specific_data[];
>>   
>>           /* Device-writable part */
> Oh ok, so this is in there as I suggested in the other email.  Good.
right.
>
> The way it's split makes review a bit hard ... maybe the aspects
> dealing with vdev_id can be moved to a previous patch in the
> next version.
>
> not critical.

But nobody used it before this series.

For me it doesn't matter, I can move it to earlier commit.

>
>> @@ -37,9 +39,12 @@ \section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admi
>>   \hline
>>   03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
>>   \hline
>> +04h   & VIRTIO_ADMIN_STATUS_INVALID_VDEV_ID    & invalid vdev_id was set  \\
>> +\hline
>> +
>>   \end{tabular}
>>   
>> -The \field{command}, \field{dst_type} and \field{command_specific_data} are
>> +The \field{command}, \field{dst_type}, \field{vdev_id} and \field{command_specific_data} are
>>   set by the driver, and the device sets the \field{status}, the
>>   \field{command_specific_error} and the \field{command_specific_result},
>>   if needed.
>> @@ -48,9 +53,12 @@ \section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admi
>>   
>>   The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
>>   
>> +The optional unused fields to be zeroed by the driver.
>> +
> it's not clear what does this refer to.

to fields that are not used/applicable to some command.


>
>>   The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
>>   
>> -The \field{dst_type} defines the target virtio device for the command. This value should be set to 0 (self).
>> +The \field{dst_type} defines the target virtio device for the command. This value can be set to 0 (self) or 1 (other virtio device in the same subsystem).
> other -> anothere
*another
>> +If \field{dst_type} is set to 1, the \field{vdev_id} is valid and used to describe the vdev_id of the target virtio device.
>>   
>>   The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
>>   VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
>> @@ -69,12 +77,25 @@ \section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admi
>>   \hline
>>   0002h   & VIRTIO_ADMIN_DEVICE_INFO    & O  \\
>>   \hline
>> -0003h - 7FFFh   & Generic admin cmds    & -  \\
>> +0003h   & VIRTIO_ADMIN_DEVICE_MGMT    & O  \\
>> +\hline
>> +0004h   & VIRTIO_ADMIN_DEVICE_MGMT_CAPS    & O  \\
>> +\hline
>> +0005h   & VIRTIO_ADMIN_DEVICE_MGMT_ATTRS    & O  \\
>> +\hline
>> +0006h   & VIRTIO_ADMIN_MANAGED_DEVICE_LIST    & O  \\
>> +\hline
>> +0007h - 7FFFh   & Generic admin cmds    & -  \\
>>   \hline
>>   8000h - FFFFh   & Reserved    & - \\
>>   \hline
>>   \end{tabular}
>>   
>> +\begin{note}
>> +{The following commands are mandatory for management devices:
> pls start with an explanation of what is a management device.

I added this explanation to the Basic Facilities chapter.

>
>
>> VIRTIO_ADMIN_DEVICE_IDENTIFY, VIRTIO_ADMIN_DEVICE_INFO,
>> +VIRTIO_ADMIN_DEVICE_MGMT, VIRTIO_ADMIN_DEVICE_MGMT_CAPS, VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and VIRTIO_ADMIN_MANAGED_DEVICE_LIST.}
>> +\end{note}
>> +
>>   \subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE IDENTIFY command}
>>   
>>   The VIRTIO_ADMIN_DEVICE_IDENTIFY command has no command specific data set by the driver.
>> @@ -89,7 +110,9 @@ \subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of
>>           * (1 means that field was returned):
>>           * Bit 0 - vdev_id
>>           * Bit 1 - optional_caps_support
>> -        * Bits 2 - 63 - reserved for future fields
>> +        * Bit 2 - num_supported_managed_vdevs
>> +        * Bit 3 - max_managed_vdev_id
>> +        * Bits 4 - 63 - reserved for future fields
>>           */
>>          le64 attrs_mask;
>>          le64 vdev_id;
>> @@ -97,10 +120,16 @@ \subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of
>>           * capabilities are supported by the device:
>>           * Bit 0 - if set, VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY supported
>>           * Bit 1 - if set, VIRTIO_ADMIN_DEVICE_INFO supported
>> -        * Bits 2 - 63 - reserved for future capabilities.
>> +        * Bit 2 - if set, the device is a direct management device
>> +        * Bits 3 - 63 - reserved for future capabilities.
>>           */
>>          le64 optional_caps_support;
>> -       u8 reserved[4072];
>> +       /* Number of supported managed virtio devices by the target virtio device */
>> +       le64 num_supported_managed_vdevs;
>> +       /* Maximum value of a valid managed vdev_id for the target virtio device */
>> +       le64 max_managed_vdev_id;
>
> I thought there's another command in another patchset that gives the max
> vdev id.

This is the max_managed_vdev_id. It is different.

>
>> +
>> +       u8 reserved[4056];
>>   };
>>   \end{lstlisting}
>>   
>> @@ -158,6 +187,166 @@ \subsection{VIRTIO ADMIN DEVICE INFO command}\label{sec:Basic Facilities of a Vi
>>   specification and can't be equal to zero. If bit 0 is not set, the driver will ignore \field{vf_number}.}
>>   \end{note}
>>   
>> +\subsection{VIRTIO ADMIN DEVICE MGMT command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command}
>> +
>> +The VIRTIO_ADMIN_DEVICE_MGMT command is used by a management device to manage resources of other virtio devices within
>> +the virtio subsystem.
> "manage" used too many times here, pls find another synonim.

ok. I'll change it to "to control".

>
>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT.
> This seems to just repeat VIRTIO_ADMIN_DEVICE_MGMT 3 times in a raw.
> I think we need a bit more structure, e.g. chapters refer to
> functionality not specific commands. E.g. look at how control vq
> is defined for net.
>
>> +
>> +The command specific data set by the driver is of form:
> of the form
>
>> +\begin{lstlisting}
>> +struct virtio_admin_device_mgmt_data {
>> +        /*
>> +         * 0 - reserved
>> +         * 1 - assign resource to the subject vdev_id
>> +         * 2 - query resource of the subject vdev_id
> subject? same as target? same as destination?

yes. I'll use destination naming.


>
>> +         * 3 - 255 are reserved
>> +         */
>> +        u8 operation;
>> +        /*
>> +         * 0 - MSI-X vector
>> +         * 1 - 65535 are reserved
>> +         */
>> +        le16 resource;
>> +        /* The amount of elements for the operation to the given resource */
>> +        le32 resource_count;
>> +        u8 reserved[57];
>> +};
>> +\end{lstlisting}
>> +
>> +The following table describes the command specific error codes codes:
>> +
>> +\begin{tabular}{|l|l|l|}
>> +\hline
>> +Opcode & Status & Description \\
>> +\hline \hline
>> +00h   & VIRTIO_ADMIN_CS_ERR_VDEV_IN_USE    & target device is in use, operation failed   \\
>> +\hline
>> +01h   & VIRTIO_ADMIN_CS_ERR_RSC_COUNT_EXCEED    & resource count exceed the max possible value  \\
>> +\hline
>> +02h   & VIRTIO_ADMIN_CS_ERR_NO_RSC    & Mgmt device don't have requested resource count   \\
>> +\hline
>> +03h   & VIRTIO_ADMIN_CS_RSC_UNSUPPORTED    & unsupported or invalid resource  \\
>> +\hline
>> +04h   & VIRTIO_ADMIN_CS_OP_UNSUPPORTED    & unsupported or invalid operation  \\
>> +\hline
>> +05h - FFh   & Reserved    & -  \\
>> +\hline
>> +\end{tabular}
>> +
>> +This command, upon success, returns a data buffer that describes the information according to the requested operation.
>> +This information is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_mgmt_result {
>> +        le32 resource_count;
>> +        u8 reserved[12];
>> +};
>> +\end{lstlisting}
>> +
>> +If the requested operation was "assign resource to the subject vdev_id", the resource_count will return the count of the assigned
>> +resources to the subject vdev_id. Upon success, this value should be equal to the \field{resource_count} of the virtio_admin_device_mgmt_data
>> +structure. In case of a failure, the value of this field is undefined.
>> +
>> +If the requested operation was "query resource of the subject vdev_id", the resource_count will return the count of the currently assigned
>> +resources to the subject vdev_id upon success. In case of a failure, the value of this field is undefined.
>> +
>> +\begin{note}
>> +{MSI-X vector resource type is valid only for PCI devices. VIRTIO_ADMIN_CS_RSC_UNSUPPORTED error is
>> +returned when the destination device is not a PCI device.}
>> +\end{note}
>> +
>> +\begin{note}
>> +{For this command, if setting \field{resource} to MSI-X vector type, the \field{vdev_id} can't be associated to a Virtual Function with
>> +VF index greater than NumVFs value as defined in the PCI specification or smaller than 1. An error is returned when \field{vdev_id} is out of the range.}
>> +\end{note}
>> +
>> +\subsection{VIRTIO ADMIN DEVICE MGMT CAPS command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT CAPS command}
>> +
>> +The VIRTIO_ADMIN_DEVICE_MGMT_CAPS upon success, returns a data buffer that describes the management device capabilities.
>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT_CAPS.
>> +
>> +Upon success, the returned data buffer is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_mgmt_caps_result {
>> +        /*
>> +         * caps[0] - Bit 0, if set, MSI-X vector resource mgmt is supported
>> +         *           Bit 1 - Bit 7 are reserved
>> +         * caps[1] - Bit 0 - Bit 7 are reserved
>> +         * caps[2] - Bit 0 - Bit 7 are reserved
>> +         * ....
>> +         * caps[8191] - Bit 0 - Bit 7 are reserved
>> +         */
>> +        u8 caps[8191];
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{note}
>> +{MSI-X vector resource management is applicable only for PCI devices. Thus, MSI-X vector resource
>> +capability bit can be set to 1 only if the subject vdev_id is a management device that can manage PCI devices (e.g. PCI Physical Function virtio device).
>> +For more details on MSI-X vector management support see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / MSI-X vector management}.}
>> +\end{note}
>> +
>> +\subsection{VIRTIO ADMIN DEVICE MGMT ATTRS command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command}
>> +
>> +The VIRTIO_ADMIN_DEVICE_MGMT_ATTRS upon success, returns a data buffer that describes the management device attributes.
>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.
>> +
>> +Upon success, the returned data buffer is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_mgmt_attrs_result {
>> +        /* For compatibility - indicates which of the below fields were returned
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
>> +        u8 reserved[4078];
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{note}
>> +{The \field{vfs_total_msix_count}, \field{vfs_assigned_msix_count} and \field{per_vf_max_msix_count} returned if the
>> +subject vdev_id is a management device that can allocate/deallocate MSI-X resources for PCI VFs devices.
>> +Otherwise, the associated bits in \field{attrs_mask} are zeroed.}
>> +\end{note}
>> +
>> +\subsection{VIRTIO ADMIN MANAGED DEVICE LIST command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN MANAGED DEVICE LIST command}
>> +
>> +The VIRTIO_ADMIN_MANAGED_DEVICE_LIST upon success, returns a data buffer that describes an ordered list of up to 510 managed
>> +virtio devices, in ascending order, that can be managed by the target management virtio device.
> So 510 might be quite limited. Do we really need such a degree of
> flexibility? Why not just have all numbers 0 to X?

Result buffer I defined is 4KB in size.

We can increase it.

>
>> +The returned list contain device identifiers with vdev_id greater than or equal to the value of \field{first_vdev_id} in the command specific data.
>> +The \field{command} is set to VIRTIO_ADMIN_MANAGED_DEVICE_LIST.
>> +
>> +The command specific data set by the driver is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_managed_device_list_data {
>> +        le64 first_vdev_id;
>> +};
>> +\end{lstlisting}
> So this is a way to iterate over devices in groups of 510.
> It's not terrible but why not just allow a bigger buffer?

How big ?

64KB is better than 4KB ?

if so, I'll change to 64KB.

>
>> +
>> +Upon success, the returned data buffer is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_managed_device_list_result {
>> +        /* Number of entries in the vdev_ids list */
>> +        le16 num_identifiers;
>> +       /* Number of currently valid managed virtio devices by the target virtio device */
>> +       le64 num_managed_vdevs;
> alignment issues here.

I added reserved bytes. where is the issue ?

>
>> +        u8 reserved[6];
>> +        /* List of managed vdev_ids. Only first num_identifiers are valid. */
>> +        le64 vdev_ids[510];
>> +};
>> +\end{lstlisting}
>> +
>>   \section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
>>   
>>   An admin virtqueue is a management interface of a device that can be used to send administrative
>> diff --git a/content.tex b/content.tex
>> index bf46192..27353ba 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -451,6 +451,19 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>   
>>   \input{admin.tex}
>>   
>> +\section{Device management}\label{sec:Basic Facilities of a Virtio Device / Device management}
>> +
>> +A virtio subsystem might be consist
> might consist?
>
>> of one or more virtio devices.
> what does might imply here? when does it and when does it not?A virtio subsystem might be consist of one or more virtio devices.

"A virtio subsystem consist of one or more virtio devices."

>
>> For example,  virtio PCI PF and its VFS compose a virtio subsystem.
> it's not just an example, is it? it's actually described in the
> following text.

It's an example of one possible virtio subsystem.


>
>> +A capable PCI PF device might act as the management device in the subsystem, and its PCI VFs are the managed devices.
>> +A management device might have various management capabilities and attributes to manage its managed devices. The capabilities exposed
>> +in the result of VIRTIO_ADMIN_DEVICE_MGMT_CAPS command (see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT CAPS command}
>> +for more details) and the attributes in the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command (see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command}
>> +for more details). The list of the managed devices returned in the result of VIRTIO_ADMIN_MANAGED_DEVICE_LIST command
>> +(see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN MANAGED DEVICE LIST command})
>> +
>> +The management device will use the VIRTIO_ADMIN_DEVICE_MGMT admin command to manage its managed devices (see section
>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more details).
>> +
> Please find a way not to rephrase above section so as not to repeat "manage" more than
> once in a sentence.

rephrase ? or not to rephrase ?

>>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>   
>>   We start with an overview of device initialization, then expand on the
>> @@ -1759,6 +1772,81 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>>       \end{itemize}
>>   \end{itemize}
>>   
>> +\subsection{PCI-specific Admin capabilities}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin capabilities}
>> +
>> +This documents the group of Admin capabilities for PCI virtio devices.
> what does "this" refer to?
> what documents?

The section/chapter.

I can remove the sentence.

>
>> Each capability is
>> +implemented using one or more Admin queue commands.
>> +
>> +\subsubsection{MSI-X vector management}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / MSI-X vector management}
>> +
>> +This capability enables a virtio management device to control the assignment of MSI-X interrupt vectors
>> +for its managed devices. In PCI, a management device can be the PF device and the managed device can be the VF.
> .. or? can they be something else?

We don't want to limit the specification.

In general, A subsystem may include more than 1 PF. E.g. 10 PFs with 16 
VFs each and 1 Management Device to manage the entire subsystem.

>
>> +Capable management devices will need to implement VIRTIO_ADMIN_DEVICE_MGMT, VIRTIO_ADMIN_DEVICE_MGMT_CAPS, VIRTIO_ADMIN_DEVICE_MGMT_ATTRS
>> +and VIRTIO_ADMIN_MANAGED_DEVICE_LIST admin commands, report the MSI-X attributes
> what are these attributes?

They can be found at virtio_admin_device_mgmt_attrs_result structure.

>
>> in the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and report that MSI-X
>> +vector resource management is supported by setting bit 1 of caps[0] in the result of VIRTIO_ADMIN_DEVICE_MGMT_CAPS admin command.
>> +See sections \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT CAPS command} and
>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
>> +
>> +In the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin command, a capable management device will return the total number of
>> +msix vectors for its VFs in \field{vfs_total_msix_count} field,
> are these always VFs then? does this include the PF itself?

In this patch we introduced MSIX configuration of VFs.

should we add also the possibility to configure other PFs in the 
subsystem in this stage ?

maybe the bellow is better:

         /* Total number of msix vectors that can be controlled by the dst device */
         le32 total_msix_count;
         /* Assigned number of msix vectors by the dst device */
         le32 assigned_msix_count;
         /* Max number of msix vectors that can be assigned by the dst device for a single VF */
         le16 per_vf_max_msix_count;

>
>> the number of already assigned msix vectors for its VFs in
>> +\field{vfs_assigned_msix_count} field and also the maximal number of msix vectors that can be assigned for a single VF in
>> +\field{per_vf_max_msix_count} field. In addition, bit 0, bit 1 and bit 2 are set to indicate on the validity
> indicate is transitive.
>
> indicate the validity
thanks.
>
>> of the other 3
>> +fields in the \field{attrs_mask} field of the result buffer.
>> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
>> +
>> +In the result of VIRTIO_ADMIN_MANAGED_DEVICE_LIST admin command, a capable management device will return a list of associated managed virtio devices.
>> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN MANAGED DEVICE LIST command} for more details.
>> +
>> +A management device that supports VFs MSI-X vector management capability
>
> "VF" since you have reduced relative here
ok.
>
> Is this then MSI-X vector management capability or a VF MSI-X vector
> management capability?

For now it's defined to VFs but we can extend it in the future.

>
>
>> , will allocate MSI-X resources provided by the parent PF of the SR-IOV VFs.
>> +The default assignment of the MSI-X vectors for managed devices is out of the scope of this specification.
> I don't see why it's out of scope. Maybe it's up to the device.

OK. I'll mention that it's device specific.


> But please don't declare whatever is not spefified out of scope
> automatically.
> And, I think it's relevant to be able to query what has been set
> or what the default was. add a command for that?

you can query the values using the VIRTIO_ADMIN_DEVICE_MGMT command


>
>
>> +A driver, using VIRTIO_ADMIN_DEVICE_MGMT can update the MSI-X assignment for a specific managed device.
>> +In the data of VIRTIO_ADMIN_DEVICE_MGMT admin command, a driver set
> sets?

thanks.


>
>> the \field{resource} type to be MSI-X vector and the
>> +amount of MSI-X interrupt vectors to configure to the subject managed device in \field{resource_count}. The managed device id is set to \field{vdev_id} field.
>> +
>> +A successful operation guarantees that the requested amount of MSI-X interrupt vectors was assigned to the subject management device.
>> +This value is also returned in the virtio_admin_device_mgmt_result structure.
>> +Also, a successful operation guarantees that the MSI-X capability access by the subject PCI device defined by the PCI specification must reflect
>> +the new configuration in all relevant fields. For example, by default if the PCI VF has been assigned 4 MSI-X vectors, and VIRTIO_ADMIN_DEVICE_MGMT
>> +increases the MSI-X vectors to 8; on this change, reading Table size field of the MSI-X message control register will reflect a value of 7.
>> +
>> +It is beyond the scope of the virtio specification
> Let's leave the question of scope aside.
> Instead, please explain that system software needs to use system
> specific means to do that.

Ok something like:

"System software to ensure the necessary synchronization (using system specific means) that a virtio PCI VF device
interrupt configuration modification is reflected in the PCI device. It is expected that any modern system software that implements virtio
drivers and PCI subsystem will ensure that any changes occurring in the VF interrupt configuration is either updated in the PCI VF device or
such configuration fails."

?


>
>> to define
>> necessary synchronization in system software to ensure that a virtio
>> PCI VF device
>> +interrupt configuration modification is reflected in the PCI device. However, it is expected that any modern system software implementing virtio
>> +drivers and PCI subsystem will ensure that any changes occurring in the VF interrupt configuration is either updated in the PCI VF device or
>> +such configuration fails.
>> +
>> +To query amount of MSI-X interrupt vectors that is currently assigned to a managed device, the driver issue
>
> issues

thanks.


>> VIRTIO_ADMIN_DEVICE_MGMT with \field{operation} set to
>> +"query resource of the subject vdev_id" value (== 2). The driver also set the \field{resource} type to be MSI-X vector and the managed device id is set to \field{vdev_id}
>> +field. In the result of a successful operation, the amount of MSI-X interrupt vectors that is currently assigned to the subject managed device is
>> +returned by the device in \field{resource_count} field of the virtio_admin_device_mgmt_result structure.
>> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more details.
>> +
>> +\paragraph{MSI-X configuration sequence example}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control / MSI-X configuration sequence example }
>> +
>> +A typical sequence for configuring MSI-X vectors for PCI VFs using MSI-X vector management mechanism is following:
> as follows

ok.


>
>> +
>> +\begin{enumerate}
>> +\item Ensure that driver doesn't run and it is safe to change MSI-X (e.g. disable sriov auto probing)
>> +
>> +\item Load the PF driver
>> +
>> +\item Enable SR-IOV by following the PCI specification
>> +
>> +\item Query the management device capabilities using commands VIRTIO_ADMIN_DEVICE_IDENTIFY, VIRTIO_ADMIN_DEVICE_MGMT_CAPS and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS
>> +
>> +\item Find the managed VF vdev_id using commands VIRTIO_ADMIN_MANAGED_DEVICE_LIST and VIRTIO_ADMIN_DEVICE_INFO
>> +
>> +\item Query the VF MSI-X configuration using command VIRTIO_ADMIN_DEVICE_MGMT (query operation)
>> +
>> +\item Assign desired MSI-X configuration for the VF using command VIRTIO_ADMIN_DEVICE_MGMT (assign operation)
>> +
>> +\item After successful completion of the assignment, load the VF driver
>> +
>> +\item Assign the VF to a VM
>> +
>> +\item After VM/VF use is completed, user assigns different MSI-X value and repeats the steps of 7 onwards
>> +
>> +\end{enumerate}
>> +
> explain who does which steps above

well I can't guess it.

it can be done manually by some sys admin or by automatic orchestration SW.


>
>>   \section{Virtio Over MMIO}\label{sec:Virtio Transport Options / Virtio Over MMIO}
>>   
>>   Virtual environments without PCI support (a common situation in
>> diff --git a/introduction.tex b/introduction.tex
>> index 94dd7a2..b5906c8 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -260,5 +260,30 @@ \subsection{virtio subsystem}\label{sec:Introduction / Definitions / virtio subs
>>   
>>   VQN and vdev_id are exposed via Admin Command Set.
>>   
>> +\subsection{virtio management device}\label{sec:Introduction / Definitions / virtio management device}
>> +
>> +A virtio device that supports VIRTIO_ADMIN_DEVICE_MGMT, VIRTIO_ADMIN_DEVICE_MGMT_CAPS, VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and
>> +VIRTIO_ADMIN_MANAGED_DEVICE_LIST Admin commands and can manage a virtio managed device.
>> +A virtio subsystem may contain zero or more management devices.
>> +
>> +A PCI SR-IOV Physical Function based virtio device is an example of a possible virtio management device.
>> +
>> +\subsection{virtio direct management device}\label{sec:Introduction / Definitions / virtio direct management device}
>> +
>> +A virtio management device that can set \field{dst_type} to 0 (self) and to 1 (other virtio device in the same subsystem), and set \field{vdev_id} to an id that corresponds with
>> +one of its managed virtio devices for the following admin commands (if these fields are applicable):  VIRTIO_ADMIN_DEVICE_IDENTIFY, VIRTIO_ADMIN_DEVICE_INFO
>> +and VIRTIO_ADMIN_DEVICE_MGMT.
>> +
>> +The managed device list can be queried using VIRTIO_ADMIN_MANAGED_DEVICE_LIST.
>> +
>> +A virtio subsystem may contain zero or more direct management devices.
>
> this does not explain what *is* a direct management device. are there
> non direct management devices?

what do you mean it doesn't explain ?

There is an exact definition.

For now I didn't define indirection of mgmt devices.

>
>> +
>> +\subsection{virtio managed device}\label{sec:Introduction / Definitions / virtio managed device}
>> +
>> +A virtio device that can be managed by a virtio management device.
>> +A virtio subsystem may contain zero or more managed devices.
> is it still useful without managed devices?
> does management device belong to same subsystem and does it always count as
> a managed device managed by itself?

Yes, it's useful.

The whole point of the subsystem is to group devices. So yes, the mgmt 
device and the managed device are in the same subsystem.

A device can configure itself.

We still haven't described commands for it but we can imagine some: 
change a virtio block backend device format from 512B sector to 4KB sector.

>
>> +
>> +A PCI SR-IOV Virtual Function based virtio device is an example of a possible virtio managed device.
>> +
>>   \newpage
>
>
> This kind of thing does not belong in the introduction IMHO.

Where is the right place to put it ?


>
>> -- 
>> 2.21.0

