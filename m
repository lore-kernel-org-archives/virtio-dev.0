Return-Path: <mst@redhat.com>
Date: Wed, 18 May 2022 12:41:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 6/7] Introduce MGMT admin commands
Message-ID: <20220518123528-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-7-mgurtovoy@nvidia.com>
 <20220515102628-mutt-send-email-mst@kernel.org>
 <5d66df52-1ef6-5c27-4946-b0bb43a6578c@redhat.com>
 <76ebbdcd-fd0f-660e-c2b9-30c6db8c8f2c@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <76ebbdcd-fd0f-660e-c2b9-30c6db8c8f2c@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 18, 2022 at 06:27:50PM +0300, Max Gurtovoy wrote:
> > Note that MSI has been used by various platform devices. It would be
> > better if we can make it work for non-PCI devices otherwise we may
> > re-introduce duplicated commands.
> >=20
> we can't even agree on PCI existing feature today in Linux so adding more
> complexity will bring us back to the beginning.

I think I agree with Max here. MMIO and CCW do not support MSI ATM.
Adding this for MMIO has been proposed in the past but the proposal
was too complex resulting in losing the attractive property of MMIO
that is it's simplicity.

> >=20
> > > > +\end{note}
> > > > +
> > > > +\begin{note}
> > > > +{For this command, if driver is setting \field{resource} to
> > > > MSI-X vector type, the \field{vdev_id} can't be associated with
> > > > a Virtual Function with
> > > > +VF index greater than NumVFs value as defined in the PCI
> > > > specification or smaller than 1. An error is returned by the
> > > > device when \field{vdev_id} is out of the range.}
> > > > +\end{note}
> > > > +
> > > > +\subsection{VIRTIO ADMIN DEVICE MGMT ATTRS
> > > > command}\label{sec:Basic Facilities of a Virtio Device / Admin
> > > > command set / VIRTIO ADMIN DEVICE MGMT ATTRS command}
> > > > +
> > > > +The VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command has no command
> > > > specific data set by the driver.
> > > > +The \field{command} is set to VIRTIO_ADMIN_DEVICE_MGMT_ATTRS.
> > > > +
> > > > +The device, upon success, returns a result that describes the
> > > > management device attributes.
> > > > +This result is of form:
> > > > +\begin{lstlisting}
> > > > +struct virtio_admin_device_mgmt_attrs_result {
> > > > +=A0=A0=A0=A0=A0=A0=A0 /* Indicates which of the below fields were =
returned
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * (1 means that field was returned):
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * Bit 0 - vfs_total_msix_count
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * Bit 1 - vfs_assigned_msix_count
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * Bit 2 - per_vf_max_msix_count
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 * Bits 3 - 63 - reserved for future fields
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > +=A0=A0=A0=A0=A0=A0=A0 le64 attrs_mask;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 /* Total number of msix vectors for the tota=
l number of VFs */
> > > > +=A0=A0=A0=A0=A0=A0=A0 le32 vfs_total_msix_count;
> > > > +=A0=A0=A0=A0=A0=A0=A0 /* Assigned number of msix vectors for the e=
nabled VFs */
> > > > +=A0=A0=A0=A0=A0=A0=A0 le32 vfs_assigned_msix_count;
> > > > +=A0=A0=A0=A0=A0=A0=A0 /* Max number of msix vectors that can be as=
signed for
> > > > a single VF */
> > > > +=A0=A0=A0=A0=A0=A0=A0 le16 per_vf_max_msix_count;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 u8 reserved[110];
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +\begin{note}
> > > > +{The \field{vfs_total_msix_count},
> > > > \field{vfs_assigned_msix_count} and
> > > > \field{per_vf_max_msix_count} returned by the device if the
> > > > +designated vdev_id is a management device that can
> > > > allocate/deallocate MSI-X resources for PCI VFs devices.
> > > > Otherwise,
> > > > +the associated bits in \field{attrs_mask} are zeroed by the device=
.}
> > > > +\end{note}
> > > > +
> > > > =A0 \section{Admin Virtqueues}\label{sec:Basic Facilities of a
> > > > Virtio Device / Admin Virtqueues}
> > > > =A0 =A0 An admin virtqueue is a management interface of a device
> > > > that can be used to send administrative
> > > > diff --git a/content.tex b/content.tex
> > > > index 0c1d44f..81e5850 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -451,6 +451,18 @@ \section{Exporting Objects}\label{sec:Basic
> > > > Facilities of a Virtio Device / Expo
> > > > =A0 =A0 \input{admin.tex}
> > > > =A0 +\section{Device management}\label{sec:Basic Facilities of a
> > > > Virtio Device / Device management}
> > > > +
> > > > +A device group might consist of one or more virtio devices. For
> > > > example, virtio PCI SR-IOV PF and its VFs compose a type 1
> > > > device group.
> > > > +A capable PCI SR-IOV PF virtio device might act as the
> > > > management device in this group, and its PCI SR-IOV VFs are the
> > > > managed devices.
> > > > +A management device might have various management capabilities
> > > > and attributes to manage its managed devices.
> > > This makes my eyes glaze over.
> > > Please, find all instances which say "manage" more than once and
> > > rephrase.
> > >=20
> > > > The capabilities exposed
> > > > +in the result of VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command (see
> > > > section \ref{sec:Basic Facilities of a Virtio Device / Admin
> > > > command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
> > > > +for more details) and the attributes exposed in the result of
> > > > VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command
> > > > +(see section \ref{sec:Basic Facilities of a Virtio Device /
> > > > Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for
> > > > more details).
> > > > +
> > > > +The management device will use the VIRTIO_ADMIN_DEVICE_MGMT
> > > > admin command to manage its managed devices (see section
> > > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command
> > > > set / VIRTIO ADMIN DEVICE MGMT command} for more details).
> > > > +
> > > > =A0 \chapter{General Initialization And Device
> > > > Operation}\label{sec:General Initialization And Device
> > > > Operation}
> > > > =A0 =A0 We start with an overview of device initialization, then
> > > > expand on the
> > > > @@ -1763,6 +1775,75 @@ \subsubsection{Driver Handling
> > > > Interrupts}\label{sec:Virtio Transport Options /
> > > > =A0=A0=A0=A0=A0 \end{itemize}
> > > > =A0 \end{itemize}
> > > > =A0 +\subsection{PCI-specific Admin capabilities}\label{sec:Virtio
> > > > Transport Options / Virtio Over PCI Bus / PCI-specific Admin
> > > > capabilities}
> > > > +
> > > > +This documents the group of admin capabilities for PCI virtio
> > > > devices. Each capability is
> > > > +implemented using one or more Admin commands.
> > > > +
> > > > +\subsubsection{MSI-X vector management}\label{sec:Virtio
> > > > Transport Options / Virtio Over PCI Bus / PCI-specific Admin
> > > > command set / MSI-X vector management}
> > > > +
> > > > +This capability enables a virtio management device to control
> > > > the assignment of MSI-X interrupt vectors
> > > > +for its managed devices.
> >=20
> >=20
> > I think we need to clarify whether the Initial VFs belong to the
> > "managed device".
> >=20
> >=20
> > > > =A0 In PCI, a management device can be the PF device and the
> > > > managed device can be the VF (for example in a type 1 device
> > > > group).
> > > > +Capable management devices will need to implement
> > > > VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS
> > > > admin commands, report the MSI-X attributes in the result of
> > > > +VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and report that MSI-X vector
> > > > resource management is supported in the result of
> > > > VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY admin command.
> > > > +See sections \ref{sec:Basic Facilities of a Virtio Device /
> > > > Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
> > > > and
> > > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command
> > > > set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
> > > > +
> > > > +In the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin command,
> > > > a capable management device will return the total number of
> > > > +msix vectors for its VFs in \field{vfs_total_msix_count} field,
> > > > the number of already assigned msix vectors for its VFs in
> > > > +\field{vfs_assigned_msix_count} field and also the maximal
> > > > number of msix vectors that can be assigned for a single VF in
> > > > +\field{per_vf_max_msix_count} field. In addition, bit 0, bit 1
> > > > and bit 2 are set to indicate on the validity of the other 3
> > > > +fields in the \field{attrs_mask} field of the result buffer.
> > > > +See section \ref{sec:Basic Facilities of a Virtio Device /
> > > > Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for
> > > > more details.
> > > > +
> > > > +The default assignment of the MSI-X vectors for managed devices
> > > > is out of the scope of this specification.
> > > > +A driver, using VIRTIO_ADMIN_DEVICE_MGMT can update the MSI-X
> > > > assignment for a specific managed device.
> > > > +In the data of VIRTIO_ADMIN_DEVICE_MGMT admin command, a driver
> > > > set the \field{resource} type to be MSI-X vector and the
> > > > +amount of MSI-X interrupt vectors to configure to the
> > > > designated managed device in \field{resource_val}. The managed
> > > > device id is set to \field{vdev_id} field.
> > > > +
> > > > +A successful operation guarantees that the requested amount of
> > > > MSI-X interrupt vectors was assigned to the designated device.
> > > > +This value is also returned in the
> > > > virtio_admin_device_mgmt_result structure.
> > > > +Also, a successful operation guarantees that the MSI-X
> > > > capability access by the designated PCI device defined by the
> > > > PCI specification must reflect
> > > > +the new configuration in all relevant fields. For example, by
> > > > default if the PCI VF has been assigned 4 MSI-X vectors, and
> > > > VIRTIO_ADMIN_DEVICE_MGMT
> > > > +increases the MSI-X vectors to 8. On this change, reading Table
> > > > size field of the MSI-X message control register will reflect a
> > > > value of 7.
> >=20
> >=20
> > This seems odd, what happens if we reduce the number of vectors. Or is
> > such on-the-fly changes of the semantic of a register allowed by the PCI
> > specification?
> it's done in Linux.
> >=20
> > I think the driver must do this before creating the VFs (writing to the
> > sriov_numvfs or status), and the device will ignore or fail the request
> > of such changes after the VFs have been provisioned.
> >=20
> >=20
> > > > +
> > > > +It is beyond the scope of the virtio specification to define
> > > > necessary synchronization in system software to ensure that a virtio
> > > > PCI VF device +interrupt configuration modification is reflected in
> > > > the PCI device.
> > > IMHO it is very much in scope of the specification. The scope of the
> > > specification is to allow device interoperability and this very much
> > > fits the bill.
> >=20
> >=20
> > +1, things will be much easier if we only allow the changes before
> > provisioning VFs.

I suspect it won't be enough though. VFIO binds to VFs and caches MSIX
before provisioning them to VMs.


>=20
> Do you want to limit the spec to this ?
>=20
> it will restrict the feature a lot.



> >=20
> >=20
> > >=20
> > > > However, it is expected that any modern system software implementing
> > > > virtio +drivers and PCI subsystem will ensure that any changes
> > > > occurring in the VF interrupt configuration is either updated in the
> > > > PCI VF device or +such configuration fails.
> > > OK. Anything more? What exactly does "interrupt configuration" mean
> > > here?
> > >=20
> > > > For example, one way to
> > > > implement that is to make sure that there is no driver bounded to t=
he
> > > > virtio PCI SR-IOV VF during +this operation.
> > > bounded in what sense?
> > >=20
> > > And why do you say VF? Is this command limited to type 1? You only
> > > limit it to PCI above.
> > >=20
> > > same elsewhere
> > >=20
> > > > +
> > > > +To query amount of MSI-X interrupt vectors that is currently
> > > > assigned to a managed device, the driver issue
> > > > VIRTIO_ADMIN_DEVICE_MGMT with \field{operation} set to
> > > issues
> > >=20
> > > lots of grammar error like this elsewhere, pls find and correct.
> > >=20
> > > > +"query resource of the designated vdev_id" value (=3D=3D 2). The
> > > > driver also set the \field{resource} type to be MSI-X vector and
> > > > the managed device id is set to \field{vdev_id}
> > > > +field. In the result of a successful operation,
> > > meaning "in case"?
> > >=20
> > > > the amount of MSI-X interrupt vectors that is currently assigned
> > > > to the designated managed device is
> > > > +returned by the device in \field{resource_val} field of the
> > > > virtio_admin_device_mgmt_result structure.
> > > > +See section \ref{sec:Basic Facilities of a Virtio Device /
> > > > Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more
> > > > details.
> > > > +
> > > > +\paragraph{MSI-X configuration sequence
> > > > example}\label{sec:Virtio Transport Options / Virtio Over PCI
> > > > Bus / PCI-specific Admin command set / VF MSI-X control / MSI-X
> > > > configuration sequence example }
> > > > +
> > > > +A typical sequence for configuring MSI-X vectors for PCI VFs
> > > > using MSI-X vector management mechanism is following:
> > > rephrase to simplify
> > >=20
> > > The driver uses the following sequence for configuring MSI-X vectors
> > > ....
> > >=20
> > >=20
> > >=20
> > > > +
> > > > +\begin{enumerate}
> > > > +\item Ensure that VF driver doesn't run and it is safe to
> > > > change MSI-X (e.g. disable sriov auto probing)
> >=20
> >=20
> > Is "sriov auto probing" a general OS facility instead of Linux specific?
> > If not, we need clarify what it did here.
>=20
> is "disable automatic probing mechanism for virtual functions or use some
> other tools to verify the virtual function is not bound and probed by any
> device driver"
>=20
> better ?

That may be enough, but I suspect not practical for management reasons
(e.g. management might expect to be able to bind to VFs and keep the VFIO fd
open, passing it on to non privileged daemons).
I feel that it's better to be very specific about what should
not happen though. which fields should not be accessed.



> >=20
> > Thanks
> >=20
> >=20
> > > > +
> > > > +\item Load the PF driver
> > > > +
> > > > +\item Enable SR-IOV by following the PCI specification
> > > > +
> > > > +\item Query the management device capabilities using commands
> > > > VIRTIO_ADMIN_DEVICE_IDENTIFY and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS
> > > > +
> > > > +\item Find the managed VF vdev_id (for type 1 device group the
> > > > vdev_id of PCI VF is equal to vf number)
> > > > +
> > > > +\item Query the VF MSI-X configuration using command
> > > > VIRTIO_ADMIN_DEVICE_MGMT (query operation)
> > > > +
> > > > +\item Assign desired MSI-X configuration for the VF using
> > > > command VIRTIO_ADMIN_DEVICE_MGMT (assign operation)
> > > > +
> > > > +\item After successful completion of the assignment, load the
> > > > VF driver
> > > > +
> > > > +\item Assign the VF to a VM
> > > > +
> > > > +\end{enumerate}
> > > > +
> > > > =A0 \section{Virtio Over MMIO}\label{sec:Virtio Transport Options
> > > > / Virtio Over MMIO}
> > > > =A0 =A0 Virtual environments without PCI support (a common situatio=
n in
> > > > diff --git a/introduction.tex b/introduction.tex
> > > > index 4358ab1..bfc5498 100644
> > > > --- a/introduction.tex
> > > > +++ b/introduction.tex
> > > > @@ -164,9 +164,39 @@ \subsection{Device
> > > > group}\label{sec:Introduction / Terminology / Device group}
> > > > =A0 For now, the supported device groups are:
> > > > =A0 \begin{enumerate}
> > > > =A0 \item Type 1 - A virtio PCI SR-IOV physical function (PF) and
> > > > its PCI SR-IOV virtual functions (VFs). For this group type, the
> > > > PF device has vdev_id that is equal to 0
> > > > -and the VF devices have vdev_id's that are equal to their
> > > > vf_number (according to the PCI SR-IOV specification).
> > > > +and the VF devices have vdev_id's that are equal to their
> > > > vf_number (according to the PCI SR-IOV specification). A PCI
> > > > SR-IOV PF device can act as a management device for
> > > > +type 1 group. A PCI SR-IOV VF device can act as a managed
> > > > device for type 1 group (see \ref{sec:Introduction / Terminology
> > > > / Virtio management device} and
> > > > +\ref{sec:Introduction / Terminology / Virtio managed device}
> > > > for more information).
> > > > =A0 \end{enumerate}
> > > > =A0 +\subsection{Virtio management device}\label{sec:Introduction
> > > > / Terminology / Virtio management device}
> > > > +
> > > > +A virtio device that supports VIRTIO_ADMIN_DEVICE_MGMT and
> > > > VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands (see
> > > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command
> > > > set / VIRTIO ADMIN DEVICE MGMT command} and
> > > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command
> > > > set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more
> > > > information).
> > > > +This device can manage a virtio managed device. A device group
> > > > may contain zero or more management devices.
> > > > +
> > > > +A PCI SR-IOV Physical Function based virtio device is an
> > > > example of a possible virtio management device (for type 1
> > > > device group).
> > > > +
> > > > +\subsection{Virtio type 1 management
> > > > device}\label{sec:Introduction / Terminology / Virtio type 1
> > > > management device}
> > > > +
> > > > +A virtio management device for type 1 device group. This device
> > > > is a PCI SR-IOV PF that can set \field{dst_type} to 1 (other
> > > > virtio device in the same device group),
> > > > +and set \field{vdev_id} to an id that corresponds with one of
> > > > its managed virtio devices (PCI SR-IOV VFs) for the
> > > > VIRTIO_ADMIN_DEVICE_MGMT admin command.
> > > > +
> > > > +A type 1 device group may contain zero or one management devices.
> > > > +
> > > > +\subsection{virtio managed device}\label{sec:Introduction /
> > > > Terminology / Virtio managed device}
> > > > +
> > > > +A virtio device that can be managed by a virtio management device.
> > > > +A device group may contain zero or more managed devices.
> > > > +
> > > > +A PCI SR-IOV Virtual Function based virtio device is an example
> > > > of a possible virtio managed device (for type 1 group).
> > > > +
> > > > +\subsection{virtio type 1 managed
> > > > device}\label{sec:Introduction / Terminology / Virtio type 1
> > > > managed device}
> > > > +
> > > > +A virtio managed device for type 1 device group. This device is
> > > > a PCI SR-IOV VF and is managed by a virtio type 1 management
> > > > device (virtio PCI SR-IOV PF).
> > > > +It is implied that all the virtio PCI SR-IOV VFs related to a
> > > > virtio PCI SR-IOV PF that is virtio type 1 management device are
> > > > type 1 managed devices.
> > > > +
> > > > =A0 \section{Structure Specifications}\label{sec:Structure
> > > > Specifications}
> > > > =A0 =A0 Many device and driver in-memory structure layouts are
> > > > documented using
> > > > --=20
> > > > 2.21.0
> >=20

