Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <76ebbdcd-fd0f-660e-c2b9-30c6db8c8f2c@nvidia.com>
Date: Wed, 18 May 2022 18:27:50 +0300
Subject: Re: [PATCH v5 6/7] Introduce MGMT admin commands
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-7-mgurtovoy@nvidia.com>
 <20220515102628-mutt-send-email-mst@kernel.org>
 <5d66df52-1ef6-5c27-4946-b0bb43a6578c@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <5d66df52-1ef6-5c27-4946-b0bb43a6578c@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/17/2022 5:28 AM, Jason Wang wrote:
>
> =E5=9C=A8 2022/5/15 22:37, Michael S. Tsirkin =E5=86=99=E9=81=93:
>> On Wed, Apr 27, 2022 at 01:58:23AM +0300, Max Gurtovoy wrote:
>>> Introduce the concept of a management and a managed device and add
>>> example of using this concept to manage resources.
>>>
>>> A management device supports the VIRTIO_ADMIN_DEVICE_MGMT and
>>> VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands to manage some resources
>>> of a managed device.
>>>
>>> A typical cloud provider SR-IOV use case is to create many VFs for use
>>> by guest VMs. The VFs may not be assigned to a VM until a user requests
>>> a VM of a certain size, e.g., number of CPUs. A VF may need MSI-X
>>> vectors proportional to the number of CPUs in the VM, but there is no
>>> standard way today in the spec to change the number of MSI-X vectors
>>> supported by a VF, although there are some operating systems that
>>> support this.
>>>
>>> The new admin mechanism manages the MSI-X interrupt vectors assignments
>>> of a managed PCI device (i.e. VF) by its management devices (i.e. its
>>> parent PF) but can easily extended to any other generic resource
>>> management.
>>>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>> I'd like to see msix and the concept of type 1 group
>> in a separate patch from MSIX.
>>
>> I am not sure MSIX things are ready but the grouping part looks mostly
>> ok to me.
>>
>>> ---
>>> =C2=A0 admin.tex=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 132=20
>>> +++++++++++++++++++++++++++++++++++++++++++++--
>>> =C2=A0 content.tex=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 81 +++++++++++=
++++++++++++++++++
>>> =C2=A0 introduction.tex |=C2=A0 32 +++++++++++-
>>> =C2=A0 3 files changed, 241 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/admin.tex b/admin.tex
>>> index d09683d..5b54743 100644
>>> --- a/admin.tex
>>> +++ b/admin.tex
>>> @@ -79,12 +79,20 @@ \section{Administration command=20
>>> set}\label{sec:Basic Facilities of a Virtio Devi
>>> =C2=A0 \hline
>>> =C2=A0 0001h=C2=A0=C2=A0 & VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT=C2=A0=C2=A0=
=C2=A0 & M=C2=A0 \\
>>> =C2=A0 \hline
>>> -0002h - 7FFFh=C2=A0=C2=A0 & Generic admin cmds=C2=A0=C2=A0=C2=A0 & -=
=C2=A0 \\
>>> +0002h=C2=A0=C2=A0 & VIRTIO_ADMIN_DEVICE_MGMT=C2=A0=C2=A0=C2=A0 & O=C2=
=A0 \\
>>> +\hline
>>> +0003h=C2=A0=C2=A0 & VIRTIO_ADMIN_DEVICE_MGMT_ATTRS=C2=A0=C2=A0=C2=A0 &=
 O=C2=A0 \\
>>> +\hline
>>> +0004h - 7FFFh=C2=A0=C2=A0 & Generic admin cmds=C2=A0=C2=A0=C2=A0 & -=
=C2=A0 \\
>>> =C2=A0 \hline
>>> =C2=A0 8000h - FFFFh=C2=A0=C2=A0 & Reserved=C2=A0=C2=A0=C2=A0 & - \\
>>> =C2=A0 \hline
>>> =C2=A0 \end{tabular}
>>> =C2=A0 +\begin{note}
>>> +{The following commands are mandatory for management devices:=20
>>> VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.}
>>> +\end{note}
>>> +
>>> =C2=A0 \subsection{VIRTIO ADMIN DEVICE CAPS IDENTIFY=20
>>> command}\label{sec:Basic Facilities of a Virtio Device / Admin=20
>>> command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
>>> =C2=A0 =C2=A0 The VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command has no comm=
and=20
>>> specific data set by the driver.
>>> @@ -102,13 +110,20 @@ \subsection{VIRTIO ADMIN DEVICE CAPS IDENTIFY=20
>>> command}\label{sec:Basic Facilitie
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 attrs_mask;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This field indicate=
s which of the below admin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * capabilities a=
re supported by the device:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bits 0 - 63 - reserved fo=
r future capabilities.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 0 - if set, the devic=
e is a management device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 1 - if set, the devic=
e is a type 1 management device=20
>>> that supports
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 MSI-X vector mgmt of its type 1 managed devices
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bits 2 - 63 - reserved fo=
r future capabilities.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 device_admin_caps=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 reserved[112];
>>> =C2=A0 };
>>> =C2=A0 \end{lstlisting}
>>> =C2=A0 +\begin{note}
>>> +{For more details on MSI-X vector management support see section=20
>>> \ref{sec:Virtio Transport Options / Virtio Over PCI Bus /=20
>>> PCI-specific Admin command set / MSI-X vector management}.}
>>> +\end{note}
>>> +
>>> =C2=A0 \subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT=20
>>> command}\label{sec:Basic Facilities of a Virtio Device / Admin=20
>>> command set / VIRTIO ADMIN DEVICE CAPS ACCEPT command}
>>> =C2=A0 =C2=A0 The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by th=
e=20
>>> driver to acknowledge those admin capabilities it understands and=20
>>> wishes to use.
>>> @@ -125,13 +140,124 @@ \subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT=20
>>> command}\label{sec:Basic Facilities
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 attrs_mask;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This field indicate=
s which of the below admin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * capabilities a=
re supported by the driver:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bits 0 - 63 - reserved fo=
r future capabilities.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 0 - if set, the drive=
r accepted the device as a=20
>>> management device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 1 - if set, the drive=
r accepted the device as a type=20
>>> 1 management device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 that supports MSI-X vector mgmt of its type 1=20
>>> managed devices
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bits 2 - 63 - reserved fo=
r future capabilities.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 driver_admin_caps=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 reserved[112];
>>> =C2=A0 };
>>> =C2=A0 \end{lstlisting}
>>> =C2=A0 +\subsection{VIRTIO ADMIN DEVICE MGMT command}\label{sec:Basic=
=20
>>> Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN=20
>>> DEVICE MGMT command}
>>> +
>>> +The VIRTIO_ADMIN_DEVICE_MGMT command is used by a management device=20
>>> to manage resources of managed virtio devices.
>>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT by the driver.
>>> +
>>> +The command specific data set by the driver is of form:
>>> +\begin{lstlisting}
>>> +struct virtio_admin_device_mgmt_data {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 0 - reserved
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1 - assign resource=
 to the designated vdev_id
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 2 - query resource =
of the designated vdev_id
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 3 - 255 are reserve=
d
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 operation;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 0 - MSI-X vector
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1 - 65535 are reser=
ved
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 resource;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The value to the gi=
ven resource:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if resource =3D 0 (=
MSI-X vector), it's a 1-based count.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 resource_val;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 reserved[5];
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The following table describes the command specific error codes codes:
>>> +
>>> +\begin{tabular}{|l|l|l|}
>>> +\hline
>>> +Opcode & Status & Description \\
>>> +\hline \hline
>>> +00h=C2=A0=C2=A0 & VIRTIO_ADMIN_CS_ERR_VDEV_IN_USE=C2=A0=C2=A0=C2=A0 & =
designated device is=20
>>> in use, operation failed=C2=A0=C2=A0 \\
>>> +\hline
>>> +01h=C2=A0=C2=A0 & VIRTIO_ADMIN_CS_RSC_VAL_INVALID=C2=A0=C2=A0=C2=A0 & =
resource value is=20
>>> invalid=C2=A0 \\
>>> +\hline
>>> +02h=C2=A0=C2=A0 & VIRTIO_ADMIN_CS_RSC_UNSUPPORTED=C2=A0=C2=A0=C2=A0 & =
unsupported or invalid=20
>>> resource=C2=A0 \\
>>> +\hline
>>> +03h=C2=A0=C2=A0 & VIRTIO_ADMIN_CS_OP_UNSUPPORTED=C2=A0=C2=A0=C2=A0 & u=
nsupported or invalid=20
>>> operation=C2=A0 \\
>>> +\hline
>>> +04h - FFh=C2=A0=C2=A0 & Reserved=C2=A0=C2=A0=C2=A0 & -=C2=A0 \\
>>> +\hline
>>> +\end{tabular}
>>> +
>>> +The device, upon success, returns a result that describes the=20
>>> information according to the requested operation.
>>> +This result is of form:
>>> +\begin{lstlisting}
>>> +struct virtio_admin_device_mgmt_result {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 resource_val;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 reserved[8];
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +If the requested operation by the driver was "assign resource to=20
>>> the designated vdev_id", the device will return the resource_val of=20
>>> the assigned
>>> +resources to the designated vdev_id. Upon success, this value=20
>>> should be equal to the \field{resource_val} of the=20
>>> virtio_admin_device_mgmt_data
>>> +structure set by the driver. In case of a failure, the value of=20
>>> this field is undefined and will be ignored by the driver.
>>> +
>>> +If the requested operation by the driver was "query resource of the=20
>>> designated vdev_id", the device will return resource_val of the=20
>>> currently assigned
>>> +resources to the designated vdev_id upon success. In case of a=20
>>> failure, the value of this field is undefined and will be ignored by=20
>>> the driver.
>>> +
>>> +\begin{note}
>>> +{MSI-X vector resource type is valid only for PCI devices.=20
>>> VIRTIO_ADMIN_CS_RSC_UNSUPPORTED error is
>>> +returned by the device when the designated vdev_id is not a PCI=20
>>> device.}
>
>
> Note that MSI has been used by various platform devices. It would be=20
> better if we can make it work for non-PCI devices otherwise we may=20
> re-introduce duplicated commands.
>
we can't even agree on PCI existing feature today in Linux so adding=20
more complexity will bring us back to the beginning.
>
>>> +\end{note}
>>> +
>>> +\begin{note}
>>> +{For this command, if driver is setting \field{resource} to MSI-X=20
>>> vector type, the \field{vdev_id} can't be associated with a Virtual=20
>>> Function with
>>> +VF index greater than NumVFs value as defined in the PCI=20
>>> specification or smaller than 1. An error is returned by the device=20
>>> when \field{vdev_id} is out of the range.}
>>> +\end{note}
>>> +
>>> +\subsection{VIRTIO ADMIN DEVICE MGMT ATTRS command}\label{sec:Basic=20
>>> Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN=20
>>> DEVICE MGMT ATTRS command}
>>> +
>>> +The VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command has no command specific=20
>>> data set by the driver.
>>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.
>>> +
>>> +The device, upon success, returns a result that describes the=20
>>> management device attributes.
>>> +This result is of form:
>>> +\begin{lstlisting}
>>> +struct virtio_admin_device_mgmt_attrs_result {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Indicates which of the b=
elow fields were returned
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (1 means that field=
 was returned):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 0 - vfs_total_m=
six_count
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 1 - vfs_assigne=
d_msix_count
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 2 - per_vf_max_=
msix_count
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bits 3 - 63 - reser=
ved for future fields
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 attrs_mask;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Total number of msix vec=
tors for the total number of VFs */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le32 vfs_total_msix_count;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Assigned number of msix =
vectors for the enabled VFs */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le32 vfs_assigned_msix_coun=
t;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Max number of msix vecto=
rs that can be assigned for a=20
>>> single VF */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 per_vf_max_msix_count;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 reserved[110];
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +\begin{note}
>>> +{The \field{vfs_total_msix_count}, \field{vfs_assigned_msix_count}=20
>>> and \field{per_vf_max_msix_count} returned by the device if the
>>> +designated vdev_id is a management device that can=20
>>> allocate/deallocate MSI-X resources for PCI VFs devices. Otherwise,
>>> +the associated bits in \field{attrs_mask} are zeroed by the device.}
>>> +\end{note}
>>> +
>>> =C2=A0 \section{Admin Virtqueues}\label{sec:Basic Facilities of a Virti=
o=20
>>> Device / Admin Virtqueues}
>>> =C2=A0 =C2=A0 An admin virtqueue is a management interface of a device =
that=20
>>> can be used to send administrative
>>> diff --git a/content.tex b/content.tex
>>> index 0c1d44f..81e5850 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -451,6 +451,18 @@ \section{Exporting Objects}\label{sec:Basic=20
>>> Facilities of a Virtio Device / Expo
>>> =C2=A0 =C2=A0 \input{admin.tex}
>>> =C2=A0 +\section{Device management}\label{sec:Basic Facilities of a=20
>>> Virtio Device / Device management}
>>> +
>>> +A device group might consist of one or more virtio devices. For=20
>>> example, virtio PCI SR-IOV PF and its VFs compose a type 1 device=20
>>> group.
>>> +A capable PCI SR-IOV PF virtio device might act as the management=20
>>> device in this group, and its PCI SR-IOV VFs are the managed devices.
>>> +A management device might have various management capabilities and=20
>>> attributes to manage its managed devices.
>> This makes my eyes glaze over.
>> Please, find all instances which say "manage" more than once and
>> rephrase.
>>
>>> The capabilities exposed
>>> +in the result of VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command (see=20
>>> section \ref{sec:Basic Facilities of a Virtio Device / Admin command=20
>>> set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
>>> +for more details) and the attributes exposed in the result of=20
>>> VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command
>>> +(see section \ref{sec:Basic Facilities of a Virtio Device / Admin=20
>>> command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more=20
>>> details).
>>> +
>>> +The management device will use the VIRTIO_ADMIN_DEVICE_MGMT admin=20
>>> command to manage its managed devices (see section
>>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set /=20
>>> VIRTIO ADMIN DEVICE MGMT command} for more details).
>>> +
>>> =C2=A0 \chapter{General Initialization And Device=20
>>> Operation}\label{sec:General Initialization And Device Operation}
>>> =C2=A0 =C2=A0 We start with an overview of device initialization, then =
expand=20
>>> on the
>>> @@ -1763,6 +1775,75 @@ \subsubsection{Driver Handling=20
>>> Interrupts}\label{sec:Virtio Transport Options /
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \end{itemize}
>>> =C2=A0 \end{itemize}
>>> =C2=A0 +\subsection{PCI-specific Admin capabilities}\label{sec:Virtio=
=20
>>> Transport Options / Virtio Over PCI Bus / PCI-specific Admin=20
>>> capabilities}
>>> +
>>> +This documents the group of admin capabilities for PCI virtio=20
>>> devices. Each capability is
>>> +implemented using one or more Admin commands.
>>> +
>>> +\subsubsection{MSI-X vector management}\label{sec:Virtio Transport=20
>>> Options / Virtio Over PCI Bus / PCI-specific Admin command set /=20
>>> MSI-X vector management}
>>> +
>>> +This capability enables a virtio management device to control the=20
>>> assignment of MSI-X interrupt vectors
>>> +for its managed devices.
>
>
> I think we need to clarify whether the Initial VFs belong to the=20
> "managed device".
>
>
>>> =C2=A0 In PCI, a management device can be the PF device and the managed=
=20
>>> device can be the VF (for example in a type 1 device group).
>>> +Capable management devices will need to implement=20
>>> VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin=20
>>> commands, report the MSI-X attributes in the result of
>>> +VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and report that MSI-X vector=20
>>> resource management is supported in the result of=20
>>> VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY admin command.
>>> +See sections \ref{sec:Basic Facilities of a Virtio Device / Admin=20
>>> command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command} and
>>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set /=20
>>> VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
>>> +
>>> +In the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin command, a=20
>>> capable management device will return the total number of
>>> +msix vectors for its VFs in \field{vfs_total_msix_count} field, the=20
>>> number of already assigned msix vectors for its VFs in
>>> +\field{vfs_assigned_msix_count} field and also the maximal number=20
>>> of msix vectors that can be assigned for a single VF in
>>> +\field{per_vf_max_msix_count} field. In addition, bit 0, bit 1 and=20
>>> bit 2 are set to indicate on the validity of the other 3
>>> +fields in the \field{attrs_mask} field of the result buffer.
>>> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin=20
>>> command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
>>> +
>>> +The default assignment of the MSI-X vectors for managed devices is=20
>>> out of the scope of this specification.
>>> +A driver, using VIRTIO_ADMIN_DEVICE_MGMT can update the MSI-X=20
>>> assignment for a specific managed device.
>>> +In the data of VIRTIO_ADMIN_DEVICE_MGMT admin command, a driver set=20
>>> the \field{resource} type to be MSI-X vector and the
>>> +amount of MSI-X interrupt vectors to configure to the designated=20
>>> managed device in \field{resource_val}. The managed device id is set=20
>>> to \field{vdev_id} field.
>>> +
>>> +A successful operation guarantees that the requested amount of=20
>>> MSI-X interrupt vectors was assigned to the designated device.
>>> +This value is also returned in the virtio_admin_device_mgmt_result=20
>>> structure.
>>> +Also, a successful operation guarantees that the MSI-X capability=20
>>> access by the designated PCI device defined by the PCI specification=20
>>> must reflect
>>> +the new configuration in all relevant fields. For example, by=20
>>> default if the PCI VF has been assigned 4 MSI-X vectors, and=20
>>> VIRTIO_ADMIN_DEVICE_MGMT
>>> +increases the MSI-X vectors to 8. On this change, reading Table=20
>>> size field of the MSI-X message control register will reflect a=20
>>> value of 7.
>
>
> This seems odd, what happens if we reduce the number of vectors. Or is=20
> such on-the-fly changes of the semantic of a register allowed by the=20
> PCI specification?
it's done in Linux.
>
> I think the driver must do this before creating the VFs (writing to=20
> the sriov_numvfs or status), and the device will ignore or fail the=20
> request of such changes after the VFs have been provisioned.
>
>
>>> +
>>> +It is beyond the scope of the virtio specification to define
>>> necessary synchronization in system software to ensure that a virtio
>>> PCI VF device +interrupt configuration modification is reflected in
>>> the PCI device.
>> IMHO it is very much in scope of the specification. The scope of the
>> specification is to allow device interoperability and this very much
>> fits the bill.
>
>
> +1, things will be much easier if we only allow the changes before=20
> provisioning VFs.

Do you want to limit the spec to this ?

it will restrict the feature a lot.

>
>
>>
>>> However, it is expected that any modern system software implementing
>>> virtio +drivers and PCI subsystem will ensure that any changes
>>> occurring in the VF interrupt configuration is either updated in the
>>> PCI VF device or +such configuration fails.
>> OK. Anything more? What exactly does "interrupt configuration" mean=20
>> here?
>>
>>> For example, one way to
>>> implement that is to make sure that there is no driver bounded to the
>>> virtio PCI SR-IOV VF during +this operation.
>> bounded in what sense?
>>
>> And why do you say VF? Is this command limited to type 1? You only
>> limit it to PCI above.
>>
>> same elsewhere
>>
>>> +
>>> +To query amount of MSI-X interrupt vectors that is currently=20
>>> assigned to a managed device, the driver issue=20
>>> VIRTIO_ADMIN_DEVICE_MGMT with \field{operation} set to
>> issues
>>
>> lots of grammar error like this elsewhere, pls find and correct.
>>
>>> +"query resource of the designated vdev_id" value (=3D=3D 2). The drive=
r=20
>>> also set the \field{resource} type to be MSI-X vector and the=20
>>> managed device id is set to \field{vdev_id}
>>> +field. In the result of a successful operation,
>> meaning "in case"?
>>
>>> the amount of MSI-X interrupt vectors that is currently assigned to=20
>>> the designated managed device is
>>> +returned by the device in \field{resource_val} field of the=20
>>> virtio_admin_device_mgmt_result structure.
>>> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin=20
>>> command set / VIRTIO ADMIN DEVICE MGMT command} for more details.
>>> +
>>> +\paragraph{MSI-X configuration sequence example}\label{sec:Virtio=20
>>> Transport Options / Virtio Over PCI Bus / PCI-specific Admin command=20
>>> set / VF MSI-X control / MSI-X configuration sequence example }
>>> +
>>> +A typical sequence for configuring MSI-X vectors for PCI VFs using=20
>>> MSI-X vector management mechanism is following:
>> rephrase to simplify
>>
>> The driver uses the following sequence for configuring MSI-X vectors
>> ....
>>
>>
>>
>>> +
>>> +\begin{enumerate}
>>> +\item Ensure that VF driver doesn't run and it is safe to change=20
>>> MSI-X (e.g. disable sriov auto probing)
>
>
> Is "sriov auto probing" a general OS facility instead of Linux=20
> specific? If not, we need clarify what it did here.

is "disable automatic probing mechanism for virtual functions or use=20
some other tools to verify the virtual function is not bound and probed=20
by any device driver"

better ?

>
> Thanks
>
>
>>> +
>>> +\item Load the PF driver
>>> +
>>> +\item Enable SR-IOV by following the PCI specification
>>> +
>>> +\item Query the management device capabilities using commands=20
>>> VIRTIO_ADMIN_DEVICE_IDENTIFY and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS
>>> +
>>> +\item Find the managed VF vdev_id (for type 1 device group the=20
>>> vdev_id of PCI VF is equal to vf number)
>>> +
>>> +\item Query the VF MSI-X configuration using command=20
>>> VIRTIO_ADMIN_DEVICE_MGMT (query operation)
>>> +
>>> +\item Assign desired MSI-X configuration for the VF using command=20
>>> VIRTIO_ADMIN_DEVICE_MGMT (assign operation)
>>> +
>>> +\item After successful completion of the assignment, load the VF=20
>>> driver
>>> +
>>> +\item Assign the VF to a VM
>>> +
>>> +\end{enumerate}
>>> +
>>> =C2=A0 \section{Virtio Over MMIO}\label{sec:Virtio Transport Options /=
=20
>>> Virtio Over MMIO}
>>> =C2=A0 =C2=A0 Virtual environments without PCI support (a common situat=
ion in
>>> diff --git a/introduction.tex b/introduction.tex
>>> index 4358ab1..bfc5498 100644
>>> --- a/introduction.tex
>>> +++ b/introduction.tex
>>> @@ -164,9 +164,39 @@ \subsection{Device=20
>>> group}\label{sec:Introduction / Terminology / Device group}
>>> =C2=A0 For now, the supported device groups are:
>>> =C2=A0 \begin{enumerate}
>>> =C2=A0 \item Type 1 - A virtio PCI SR-IOV physical function (PF) and it=
s=20
>>> PCI SR-IOV virtual functions (VFs). For this group type, the PF=20
>>> device has vdev_id that is equal to 0
>>> -and the VF devices have vdev_id's that are equal to their vf_number=20
>>> (according to the PCI SR-IOV specification).
>>> +and the VF devices have vdev_id's that are equal to their vf_number=20
>>> (according to the PCI SR-IOV specification). A PCI SR-IOV PF device=20
>>> can act as a management device for
>>> +type 1 group. A PCI SR-IOV VF device can act as a managed device=20
>>> for type 1 group (see \ref{sec:Introduction / Terminology / Virtio=20
>>> management device} and
>>> +\ref{sec:Introduction / Terminology / Virtio managed device} for=20
>>> more information).
>>> =C2=A0 \end{enumerate}
>>> =C2=A0 +\subsection{Virtio management device}\label{sec:Introduction /=
=20
>>> Terminology / Virtio management device}
>>> +
>>> +A virtio device that supports VIRTIO_ADMIN_DEVICE_MGMT and=20
>>> VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands (see
>>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set /=20
>>> VIRTIO ADMIN DEVICE MGMT command} and
>>> +\ref{sec:Basic Facilities of a Virtio Device / Admin command set /=20
>>> VIRTIO ADMIN DEVICE MGMT ATTRS command} for more information).
>>> +This device can manage a virtio managed device. A device group may=20
>>> contain zero or more management devices.
>>> +
>>> +A PCI SR-IOV Physical Function based virtio device is an example of=20
>>> a possible virtio management device (for type 1 device group).
>>> +
>>> +\subsection{Virtio type 1 management device}\label{sec:Introduction=20
>>> / Terminology / Virtio type 1 management device}
>>> +
>>> +A virtio management device for type 1 device group. This device is=20
>>> a PCI SR-IOV PF that can set \field{dst_type} to 1 (other virtio=20
>>> device in the same device group),
>>> +and set \field{vdev_id} to an id that corresponds with one of its=20
>>> managed virtio devices (PCI SR-IOV VFs) for the=20
>>> VIRTIO_ADMIN_DEVICE_MGMT admin command.
>>> +
>>> +A type 1 device group may contain zero or one management devices.
>>> +
>>> +\subsection{virtio managed device}\label{sec:Introduction /=20
>>> Terminology / Virtio managed device}
>>> +
>>> +A virtio device that can be managed by a virtio management device.
>>> +A device group may contain zero or more managed devices.
>>> +
>>> +A PCI SR-IOV Virtual Function based virtio device is an example of=20
>>> a possible virtio managed device (for type 1 group).
>>> +
>>> +\subsection{virtio type 1 managed device}\label{sec:Introduction /=20
>>> Terminology / Virtio type 1 managed device}
>>> +
>>> +A virtio managed device for type 1 device group. This device is a=20
>>> PCI SR-IOV VF and is managed by a virtio type 1 management device=20
>>> (virtio PCI SR-IOV PF).
>>> +It is implied that all the virtio PCI SR-IOV VFs related to a=20
>>> virtio PCI SR-IOV PF that is virtio type 1 management device are=20
>>> type 1 managed devices.
>>> +
>>> =C2=A0 \section{Structure Specifications}\label{sec:Structure=20
>>> Specifications}
>>> =C2=A0 =C2=A0 Many device and driver in-memory structure layouts are=20
>>> documented using
>>> --=20
>>> 2.21.0
>

