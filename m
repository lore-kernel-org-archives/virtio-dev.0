Return-Path: <mst@redhat.com>
Date: Mon, 20 Jun 2022 05:45:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 6/7] Introduce MGMT admin commands
Message-ID: <20220620052512-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-7-mgurtovoy@nvidia.com>
 <20220515102628-mutt-send-email-mst@kernel.org>
 <0d841258-1330-084f-57f2-30da7b58ff1b@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <0d841258-1330-084f-57f2-30da7b58ff1b@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 18, 2022 at 06:03:42PM +0300, Max Gurtovoy wrote:
> > > +\section{Device management}\label{sec:Basic Facilities of a Virtio Device / Device management}
> > > +
> > > +A device group might consist of one or more virtio devices. For example, virtio PCI SR-IOV PF and its VFs compose a type 1 device group.
> > > +A capable PCI SR-IOV PF virtio device might act as the management device in this group, and its PCI SR-IOV VFs are the managed devices.
> > > +A management device might have various management capabilities and attributes to manage its managed devices.
> > This makes my eyes glaze over.
> > Please, find all instances which say "manage" more than once and
> > rephrase.
> 
> Can you propose something you like ?
> 
> Each individual has different wording style.
> 
> Just choose whatever fits to your style and I'll add it.


Unfortunately I don't know what you are trying to say here at all. Just
drop this sentence?


> > 
> > > The capabilities exposed
> > > +in the result of VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command (see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
> > > +for more details) and the attributes exposed in the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS command
> > > +(see section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details).
> > > +
> > > +The management device will use the VIRTIO_ADMIN_DEVICE_MGMT admin command to manage its managed devices (see section
> > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more details).
> > > +
> > >   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> > >   We start with an overview of device initialization, then expand on the
> > > @@ -1763,6 +1775,75 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
> > >       \end{itemize}
> > >   \end{itemize}
> > > +\subsection{PCI-specific Admin capabilities}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin capabilities}
> > > +
> > > +This documents the group of admin capabilities for PCI virtio devices. Each capability is
> > > +implemented using one or more Admin commands.
> > > +
> > > +\subsubsection{MSI-X vector management}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / MSI-X vector management}
> > > +
> > > +This capability enables a virtio management device to control the assignment of MSI-X interrupt vectors
> > > +for its managed devices. In PCI, a management device can be the PF device and the managed device can be the VF (for example in a type 1 device group).
> > > +Capable management devices will need to implement VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands, report the MSI-X attributes in the result of
> > > +VIRTIO_ADMIN_DEVICE_MGMT_ATTRS and report that MSI-X vector resource management is supported in the result of VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY admin command.
> > > +See sections \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command} and
> > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
> > > +
> > > +In the result of VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin command, a capable management device will return the total number of
> > > +msix vectors for its VFs in \field{vfs_total_msix_count} field, the number of already assigned msix vectors for its VFs in
> > > +\field{vfs_assigned_msix_count} field and also the maximal number of msix vectors that can be assigned for a single VF in
> > > +\field{per_vf_max_msix_count} field. In addition, bit 0, bit 1 and bit 2 are set to indicate on the validity of the other 3
> > > +fields in the \field{attrs_mask} field of the result buffer.
> > > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more details.
> > > +
> > > +The default assignment of the MSI-X vectors for managed devices is out of the scope of this specification.
> > > +A driver, using VIRTIO_ADMIN_DEVICE_MGMT can update the MSI-X assignment for a specific managed device.
> > > +In the data of VIRTIO_ADMIN_DEVICE_MGMT admin command, a driver set the \field{resource} type to be MSI-X vector and the
> > > +amount of MSI-X interrupt vectors to configure to the designated managed device in \field{resource_val}. The managed device id is set to \field{vdev_id} field.
> > > +
> > > +A successful operation guarantees that the requested amount of MSI-X interrupt vectors was assigned to the designated device.
> > > +This value is also returned in the virtio_admin_device_mgmt_result structure.
> > > +Also, a successful operation guarantees that the MSI-X capability access by the designated PCI device defined by the PCI specification must reflect
> > > +the new configuration in all relevant fields. For example, by default if the PCI VF has been assigned 4 MSI-X vectors, and VIRTIO_ADMIN_DEVICE_MGMT
> > > +increases the MSI-X vectors to 8. On this change, reading Table size field of the MSI-X message control register will reflect a value of 7.
> > > +
> > > +It is beyond the scope of the virtio specification to define
> > > necessary synchronization in system software to ensure that a virtio
> > > PCI VF device +interrupt configuration modification is reflected in
> > > the PCI device.
> > IMHO it is very much in scope of the specification. The scope of the
> > specification is to allow device interoperability and this very much
> > fits the bill.
> 
> each system has its own set of tools and definitions.
> 
> It's not covered in the spec today and should be covered. Otherwise, the
> spec will get inside areas it shouldn't.

Then were is this described?
I suspect we can just drop this text, you are actually
describing this below.



> 
> > 
> > > However, it is expected that any modern system software implementing
> > > virtio +drivers and PCI subsystem will ensure that any changes
> > > occurring in the VF interrupt configuration is either updated in the
> > > PCI VF device or +such configuration fails.
> > OK. Anything more?

What's the answer here? Is this enough or is more needed?

> What exactly does "interrupt configuration" mean here?
> 
> MSI-X configuration.

Meaning msi-x capability and tables?

> 
> > 
> > > For example, one way to
> > > implement that is to make sure that there is no driver bounded to the
> > > virtio PCI SR-IOV VF during +this operation.
> > bounded in what sense?
> in a sense that a pci device driver is bounded and probed the device.

Do you mean bound maybe?

> > 
> > And why do you say VF? Is this command limited to type 1? You only
> > limit it to PCI above.
> 
> Today we support setting MSI-X configuration for VFs.
> 
> This is why I mentioned VFs.
> 
> IIRC, you asked to mentioned VFs in the past - but I'm not sure.
> 
> Is this a problem ? should I remove some sentance ?

I think what you mean is this. "For example, for type 1 groups, ...."

In other words if you mention VFs this is ok as an example,
but let's make sure we can extend to other types of grouping.


> > same elsewhere
> > 
> > > +
> > > +To query amount of MSI-X interrupt vectors that is currently assigned to a managed device, the driver issue VIRTIO_ADMIN_DEVICE_MGMT with \field{operation} set to
> > issues
> > 
> > lots of grammar error like this elsewhere, pls find and correct.
> > 
> > > +"query resource of the designated vdev_id" value (== 2). The driver also set the \field{resource} type to be MSI-X vector and the managed device id is set to \field{vdev_id}
> > > +field. In the result of a successful operation,
> > meaning "in case"?
> yes.
> > > the amount of MSI-X interrupt vectors that is currently assigned to the designated managed device is
> > > +returned by the device in \field{resource_val} field of the virtio_admin_device_mgmt_result structure.
> > > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} for more details.
> > > +
> > > +\paragraph{MSI-X configuration sequence example}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control / MSI-X configuration sequence example }
> > > +
> > > +A typical sequence for configuring MSI-X vectors for PCI VFs using MSI-X vector management mechanism is following:
> > rephrase to simplify
> > 
> > The driver uses the following sequence for configuring MSI-X vectors
> > ....
> 
> But it's not the driver.
> 
> why should I change this if it's not true ?

Then who does this? We have the driver and the device in the spec ...
I'm ok with adding another entity but that's *a lot* more work ...

> > 
> > 
> > > +
> > > +\begin{enumerate}
> > > +\item Ensure that VF driver doesn't run and it is safe to change MSI-X (e.g. disable sriov auto probing)
> > > +
> > > +\item Load the PF driver
> > > +
> > > +\item Enable SR-IOV by following the PCI specification
> > > +
> > > +\item Query the management device capabilities using commands VIRTIO_ADMIN_DEVICE_IDENTIFY and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS
> > > +
> > > +\item Find the managed VF vdev_id (for type 1 device group the vdev_id of PCI VF is equal to vf number)
> > > +
> > > +\item Query the VF MSI-X configuration using command VIRTIO_ADMIN_DEVICE_MGMT (query operation)
> > > +
> > > +\item Assign desired MSI-X configuration for the VF using command VIRTIO_ADMIN_DEVICE_MGMT (assign operation)
> > > +
> > > +\item After successful completion of the assignment, load the VF driver
> > > +
> > > +\item Assign the VF to a VM
> > > +
> > > +\end{enumerate}
> > > +
> > >   \section{Virtio Over MMIO}\label{sec:Virtio Transport Options / Virtio Over MMIO}
> > >   Virtual environments without PCI support (a common situation in
> > > diff --git a/introduction.tex b/introduction.tex
> > > index 4358ab1..bfc5498 100644
> > > --- a/introduction.tex
> > > +++ b/introduction.tex
> > > @@ -164,9 +164,39 @@ \subsection{Device group}\label{sec:Introduction / Terminology / Device group}
> > >   For now, the supported device groups are:
> > >   \begin{enumerate}
> > >   \item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI SR-IOV virtual functions (VFs). For this group type, the PF device has vdev_id that is equal to 0
> > > -and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification).
> > > +and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification). A PCI SR-IOV PF device can act as a management device for
> > > +type 1 group. A PCI SR-IOV VF device can act as a managed device for type 1 group (see \ref{sec:Introduction / Terminology / Virtio management device} and
> > > +\ref{sec:Introduction / Terminology / Virtio managed device} for more information).
> > >   \end{enumerate}
> > > +\subsection{Virtio management device}\label{sec:Introduction / Terminology / Virtio management device}
> > > +
> > > +A virtio device that supports VIRTIO_ADMIN_DEVICE_MGMT and VIRTIO_ADMIN_DEVICE_MGMT_ATTRS admin commands (see
> > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT command} and
> > > +\ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE MGMT ATTRS command} for more information).
> > > +This device can manage a virtio managed device. A device group may contain zero or more management devices.
> > > +
> > > +A PCI SR-IOV Physical Function based virtio device is an example of a possible virtio management device (for type 1 device group).
> > > +
> > > +\subsection{Virtio type 1 management device}\label{sec:Introduction / Terminology / Virtio type 1 management device}
> > > +
> > > +A virtio management device for type 1 device group. This device is a PCI SR-IOV PF that can set \field{dst_type} to 1 (other virtio device in the same device group),
> > > +and set \field{vdev_id} to an id that corresponds with one of its managed virtio devices (PCI SR-IOV VFs) for the VIRTIO_ADMIN_DEVICE_MGMT admin command.
> > > +
> > > +A type 1 device group may contain zero or one management devices.
> > > +
> > > +\subsection{virtio managed device}\label{sec:Introduction / Terminology / Virtio managed device}
> > > +
> > > +A virtio device that can be managed by a virtio management device.
> > > +A device group may contain zero or more managed devices.
> > > +
> > > +A PCI SR-IOV Virtual Function based virtio device is an example of a possible virtio managed device (for type 1 group).
> > > +
> > > +\subsection{virtio type 1 managed device}\label{sec:Introduction / Terminology / Virtio type 1 managed device}
> > > +
> > > +A virtio managed device for type 1 device group. This device is a PCI SR-IOV VF and is managed by a virtio type 1 management device (virtio PCI SR-IOV PF).
> > > +It is implied that all the virtio PCI SR-IOV VFs related to a virtio PCI SR-IOV PF that is virtio type 1 management device are type 1 managed devices.
> > > +
> > >   \section{Structure Specifications}\label{sec:Structure Specifications}
> > >   Many device and driver in-memory structure layouts are documented using
> > > -- 
> > > 2.21.0

