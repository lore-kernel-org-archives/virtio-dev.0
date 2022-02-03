Return-Path: <virtio-comment-return-2712-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Thu, 3 Feb 2022 09:57:16 +0200
Message-ID: <20220203075716.11684-5-mgurtovoy@nvidia.com>
In-Reply-To: <20220203075716.11684-1-mgurtovoy@nvidia.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v3 4/4] Add support for MSI-X vectors configuration for PCI VFs
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

A typical cloud provider SR-IOV use case is to create many VFs for
use by guest VMs. The VFs may not be assigned to a VM until a user
requests a VM of a certain size, e.g., number of CPUs. A VF may need
MSI-X vectors proportional to the number of CPUs in the VM, but there is
no standard way today in the spec to change the number of MSI-X vectors
supported by a VF, although there are some operating systems that
support this.

Introduce new admin commands for a generic interrupt vector management
for PCI VFs. For now, this mechanism will manage the MSI-X interrupt
vectors assignments of a VF by its parent PF.

These admin commands will be easily extended, if needed, for other types
of interrupt vectors in the future with backward compatibility to old
drivers and devices.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin.tex       | 162 +++++++++++++++++++++++++++++++++++++++++++++++-
 conformance.tex |   1 +
 content.tex     |  72 +++++++++++++++++++++
 3 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index fa9c993..f3263bb 100644
--- a/admin.tex
+++ b/admin.tex
@@ -63,17 +63,33 @@ \section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admi
 \hline \hline
 0000h   & VIRTIO_ADMIN_CAPS_IDENTIFY    & M  \\
 \hline
-0001h - 7FFFh   & Generic admin cmds    & -  \\
+0001h   & VIRTIO_ADMIN_PCI_SRIOV_ATTRS    & O  \\
+\hline
+0002h   & VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET    & O  \\
+\hline
+0003h   & VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET    & O  \\
+\hline
+0004h - 7FFFh   & Generic admin cmds    & -  \\
 \hline
 8000h - FFFFh   & Reserved    & - \\
 \hline
 \end{tabular}
 
+\drivernormative{\subsection}{Admin command set}{Basic Facilities of a Virtio Device / Admin command set}
+A driver SHOULD NOT issue VIRTIO_ADMIN_PCI_SRIOV_ATTRS command when VIRTIO_F_SR_IOV is not negotiated.
+
+A driver SHOULD NOT issue VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET and VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET
+commands when VIRTIO_F_SR_IOV is not negotiated or when PCI Single Root I/O Virtualization is disabled.
+
 \devicenormative{\subsection}{Admin command set}{Basic Facilities of a Virtio Device / Admin command set}
 A device that advertises VIRTIO_F_ADMIN_VQ capability MUST support all the mandatory admin commands.
 
 A device that advertises VIRTIO_F_ADMIN_VQ capability MAY support one or more optional admin commands.
 
+A device MUST fail VIRTIO_ADMIN_PCI_SRIOV_ATTRS command when VIRTIO_F_SR_IOV is not negotiated.
+
+A device MUST fail VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET and VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET
+commands when VIRTIO_F_SR_IOV is not negotiated or when PCI Single Root I/O Virtualization is disabled.
 
 \subsection{VIRTIO ADMIN CAPS IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN CAPS IDENTIFY command}
 
@@ -83,7 +99,8 @@ \subsection{VIRTIO ADMIN CAPS IDENTIFY command}\label{sec:Basic Facilities of a
 \begin{lstlisting}
 struct virtio_admin_caps_identify_result {
        /*
-        * caps[0] - Bit 0 - Bit 7 are reserved
+        * caps[0] - Bit 0 - if set, VF MSI-X control supported
+        *           Bit 1 - Bit 7 are reserved
         * caps[1] - Bit 0 - Bit 7 are reserved
         * caps[2] - Bit 0 - Bit 7 are reserved
         * ....
@@ -92,3 +109,144 @@ \subsection{VIRTIO ADMIN CAPS IDENTIFY command}\label{sec:Basic Facilities of a
        u8 caps[8192];
 };
 \end{lstlisting}
+
+For more details on VF MSI-X configuration support see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control}.
+
+\subsection{VIRTIO ADMIN PCI SRIOV ATTRS command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN PCI SRIOV ATTRS command}
+
+The VIRTIO_ADMIN_PCI_SRIOV_ATTRS command has no command specific data set by the driver.
+This command upon success, returns a data buffer that describes information about PCI SRIOV
+related capabilities and attributes for the device. This command can be supported only by
+PCI devices that supports Single Root I/O Virtualization.
+This information is of form:
+\begin{lstlisting}
+struct virtio_admin_pci_sriov_attrs_result {
+        /* For compatibility - indicates which of the below fields are valid (1 means valid):
+         * Bit 0 - vfs_total_msix_count
+         * Bit 1 - vfs_assigned_msix_count
+         * Bit 2 - per_vf_max_msix_count
+         * Bits 3 - 63 - reserved for future fields
+         */
+        le64 attrs_mask;
+        /* Total number of msix vectors for the total number of VFs */
+        le32 vfs_total_msix_count;
+        /* Assigned number of msix vectors for the enabled VFs */
+        le32 vfs_assigned_msix_count;
+        /* Max number of msix vectors that can be assigned for a single VF */
+        le16 per_vf_max_msix_count;
+};
+\end{lstlisting}
+
+\subsection{VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command}
+
+The VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET command is used to modify the interrupt vectors
+count for a PCI virtual function. The command specific data set by the driver is of form:
+\begin{lstlisting}
+struct virtio_admin_pci_vf_interrupt_config_set_data {
+        /* The virtual function number */
+        le16 vf_number;
+        /* For compatibility - indicates which of the below properties should be
+         * modified (1 means that field should be modified):
+         * Bit 0 - msix_count
+         * Bits 1 - 63 - reserved for future fields
+         */
+        le64 attrs_mask;
+        /* The amount of MSI-X interrupt vectors */
+        le16 msix_count;
+};
+\end{lstlisting}
+
+The following table describes the command specific error codes codes:
+
+\begin{tabular}{|l|l|l|}
+\hline
+Opcode & Status & Description \\
+\hline \hline
+00h   & VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID    & invalid VF number  \\
+\hline
+01h   & VIRTIO_ADMIN_CS_ERR_PCI_MSIX_COUNT_EXCEED    & MSI-X count exceed the max value per VF  \\
+\hline
+02h   & VIRTIO_ADMIN_CS_ERR_PCI_MSIX_NO_RSC    & Device don't have requested MSI-X count   \\
+\hline
+03h   & VIRTIO_ADMIN_CS_ERR_PCI_VF_IN_USE    & VF is already in use, operation failed   \\
+\hline
+04h - FFh   & Reserved    & -  \\
+\hline
+\end{tabular}
+
+\begin{note}
+{vf_number can't be greater than NumVFs value as defined in the PCI specification
+or smaller than 1. A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID
+is returned when vf_number is out of the range.}
+\end{note}
+
+\begin{note}
+{A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_MSIX_COUNT_EXCEED
+is returned when the amount of MSI-X to assign exceed the maximum value that can be
+assigned to a single VF.}
+\end{note}
+
+\begin{note}
+{A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_MSIX_NO_RSC
+is returned when the device doesn't have requested number of MSI-X vectors free.}
+\end{note}
+
+This command has no command specific result set by the device. Upon success, the device guarantees
+that all the requested properties were modified to the given values. Otherwise, error will be returned.
+
+\begin{note}
+{Before setting msix_count property the virtual/managed device (VF) shall be un-initialized and MUST not be used by the driver.
+Otherwise, a command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_VF_IN_USE will be returned.}
+\end{note}
+
+\subsection{VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command}
+
+The VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET command is used to obtain the values of the VFs
+interrupt vectors configuration.
+The command specific data set by the driver is of form:
+\begin{lstlisting}
+struct virtio_admin_pci_vf_interrupt_config_get_data {
+        /* The virtual function number */
+        le16 vf_number;
+        /* For compatibility - indicates which of the below properties should be
+         * queried (1 means that field should be queried):
+         * Bit 0 - msix_count (The amount of MSI-X interrupt vectors)
+         * Bits 1 - 63 - reserved for future fields
+         */
+        le64 attrs_mask;
+};
+\end{lstlisting}
+
+The following table describes the command specific error codes codes:
+
+\begin{tabular}{|l|l|l|}
+\hline
+Opcode & Status & Description \\
+\hline \hline
+00h   & VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID    & invalid VF number  \\
+\hline
+01h - FFh   & Reserved    & -  \\
+\hline
+\end{tabular}
+
+\begin{note}
+{vf_number can't be greater than NumVFs value as defined in the PCI specification
+or smaller than 1. A command specific error status code VIRTIO_ADMIN_CS_ERR_PCI_VF_NUM_INVALID
+is returned when vf_number is out of the range.}
+\end{note}
+
+This command, upon success, returns a data buffer that describes the properties that were requested
+and their values for the subject virtio VF device according to the given vf_number.
+This information is of form:
+\begin{lstlisting}
+struct virtio_admin_pci_vf_interrupt_config_get_result {
+        /* For compatibility - indicates which of the below fields were returned
+         * (1 means that field was returned):
+         * Bit 0 - msix_count
+         * Bits 1 - 63 - reserved for future fields
+         */
+        le64 attrs_mask;
+        /* The amount of MSI-X interrupt vectors currently assigned to the VF */
+        le16 msix_count;
+};
+\end{lstlisting}
diff --git a/conformance.tex b/conformance.tex
index 6ba4d94..e438b27 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -87,6 +87,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Cleanup}
 \item \ref{drivernormative:Reserved Feature Bits}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Admin command set}
 \end{itemize}
 
 \conformance{\subsection}{PCI Driver Conformance}\label{sec:Conformance / Driver Conformance / PCI Driver Conformance}
diff --git a/content.tex b/content.tex
index 276a29f..a5e2035 100644
--- a/content.tex
+++ b/content.tex
@@ -1773,6 +1773,78 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
     \end{itemize}
 \end{itemize}
 
+\subsection{PCI-specific Admin capabilities}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin capabilities}
+
+This documents the group of Admin capabilities for PCI virtio devices. Each capability is
+implemented using one or more Admin queue commands.
+
+\subsubsection{VF MSI-X control}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control}
+
+This capability enables a virtio PCI PF device to control the assignment of MSI-X interrupt vectors
+for its managed VFs. Capable devices will need to set bit 0 of caps[0] in the result of VIRTIO_ADMIN_CAPS_IDENTIFY
+admin command. See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN CAPS IDENTIFY command}
+for more details.
+
+Capable devices will also need to implement VIRTIO_ADMIN_PCI_SRIOV_ATTRS, VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET and
+VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET admin commands.
+
+In the result of VIRTIO_ADMIN_PCI_SRIOV_ATTRS admin command, a capable device will return the total number of
+msix vectors for its VFs in \field{vfs_total_msix_count} field, the number of already assigned msix vectors for its VFs in
+\field{vfs_assigned_msix_count} field and also the maximal number of msix vectors that can be assigned for a single VF in
+\field{per_vf_max_msix_count} field. In addition, bit 0, bit 1 and bit 2 are set to indicate on the validity of the other 3
+fields in the \field{attrs_mask} field of the result buffer.
+See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN PCI SRIOV ATTRS command} for more
+details.
+
+A PCI PF device that supports VF MSI-X control capability will always allocate MSI-X vectors for its VFs from the device resources.
+The default assignment of the MSI-X vectors for the PCI VFs is out of the scope of this specification.
+A driver, using VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET can update the MSI-X assignment for a specific VF.
+In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET admin command, a driver set the virtual function number in
+\field{vf_number} and the amount of MSI-X interrupt vectors to configure to the subject virtual function in \field{msix_count}.
+In addition, bit 0 in the \field{attrs_mask} field is set. A successful operation guarantees that the requested
+amount of MSI-X interrupt vectors was assigned to the subject virtual function.
+Also, a successful operation guarantees that the MSI-X capability access by the subject PCI VF defined by the PCI specification must reflect
+the new configuration in all relevant fields. For example, by default if the PCI VF has been assigned 4 MSI-X vectors, and VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET
+increases the MSI-X vectors to 8; on this change, reading Table size field of the MSI-X message control register will reflect a value of 7.
+See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command} for more details.
+
+It is beyond the scope of the virtio specification to define necessary synchronization in system software to ensure that a virtio PCI VF device
+interrupt configuration modification is reflected in the PCI device. However, it is expected that any modern system software implementing virtio
+drivers and PCI subsystem will ensure that any changes occurring in the VF interrupt configuration is either updated in the PCI VF device or
+such configuration fails.
+
+In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET admin command, a driver will set the virtual function number in
+\field{vf_number}. In addition, bit 0 in the \field{attrs_mask} field is set to indicate requested output fields in
+the result from the device. In the result of a successful operation, the amount of MSI-X interrupt vectors that is currently
+assigned to the subject virtual function is returned by the device in \field{msix_count} field. In addition, bit 0 in the \field{attrs_mask} field is set by the device
+to indicate on the validity of \field{msix_count} field.
+See section \ref{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command} for more details.
+
+\paragraph{MSI-X configuration sequence example}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Admin command set / VF MSI-X control / MSI-X configuration sequence example }
+
+A typical sequence for configuring MSI-X vectors for PCI VFs using VF MSI-X control mechanism is following:
+
+\begin{enumerate}
+\item Ensure that driver doesn't run and it is safe to change MSI-X (e.g. disable sriov auto probing)
+
+\item Load the PF driver
+
+\item Enable SR-IOV by following the PCI specification
+
+\item Query the SR-IOV attributes using command VIRTIO_ADMIN_PCI_SRIOV_ATTRS
+
+\item Query the VF MSI-X configuration using command VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET
+
+\item Assign desired MSI-X configuration for the VF using command VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET
+
+\item After successful completion of the assignment, load the VF driver
+
+\item Assign the VF to a VM
+
+\item After VM/VF use is completed, user assigns different MSI-X value and repeats the steps of 6 onwards
+
+\end{enumerate}
+
 \section{Virtio Over MMIO}\label{sec:Virtio Transport Options / Virtio Over MMIO}
 
 Virtual environments without PCI support (a common situation in
-- 
2.21.0


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

