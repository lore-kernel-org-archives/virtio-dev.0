Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 5/5] Add support for dynamic MSI-X vector mgmt for VFs
Date: Thu, 13 Jan 2022 16:51:03 +0200
Message-ID: <20220113145103.26894-6-mgurtovoy@nvidia.com>
In-Reply-To: <20220113145103.26894-1-mgurtovoy@nvidia.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
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

Introduce new feature bits for generic PCI virtualization management
mechanism and a specific mechanism to manage the MSI-X vector assignment
process of virtual/managed functions by its parent virtio device via its
admin virtqueue. For now, virtio supports only PCI virtual function
virtualization, thus the virt manager device will be the PF and the
managed device will be the VF.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin-virtq.tex | 98 ++++++++++++++++++++++++++++++++++++++++++++++++-
 content.tex     | 29 ++++++++++++++-
 2 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/admin-virtq.tex b/admin-virtq.tex
index ad20f89..4ee8a32 100644
--- a/admin-virtq.tex
+++ b/admin-virtq.tex
@@ -41,9 +41,105 @@ \section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin
 \hline
 Opcode (bits) & Opcode (hex) & Command & M/O \\
 \hline \hline
- -  & 00h - 7Fh   & Generic admin cmds    & -  \\
+ 00000000b  & 00h   & VIRTIO_ADMIN_PCI_VIRT_MGMT_ATTR_IDENTIFY    & O  \\
+\hline
+ 00000001b  & 01h   & VIRTIO_ADMIN_PCI_VIRT_PROPERTY_SET    & O  \\
+\hline
+ 00000010b  & 02h   & VIRTIO_ADMIN_PCI_VIRT_PROPERTY_GET    & O  \\
+\hline
+ -  & 03h - 7Fh   & Generic admin cmds    & -  \\
 \hline
  -  & 80h - FFh   & Reserved    & - \\
 \hline
 \end{tabular}
 
+\subsection{VIRTIO ADMIN PCI VIRT MGMT ATTR IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VIRT MGMT ATTR IDENTIFY command}
+
+The VIRTIO_ADMIN_PCI_VIRT_MGMT_ATTR_IDENTIFY command has no command specific data set by the driver.
+This command upon success, returns a data buffer that describes information about PCI virtualization
+management attributes. This information is of form:
+\begin{lstlisting}
+struct virtio_admin_pci_virt_mgmt_attr_identify_result {
+        /* For compatibility - indicates which of the below fields are valid (1 means valid):
+         * Bit 0x0 - total_free_vfs_msix_count
+         * Bit 0x1 - per_vf_max_msix_count
+         * Bits 0x2 - 0x3F - reserved for future fields
+         */
+        le64 mask;
+        /* Number of free msix in the global msix pool for VFs */
+        le32 total_free_vfs_msix_count;
+        /* Max number of msix vectors that can be assigned for a single VF */
+        le16 per_vf_max_msix_count;
+};
+\end{lstlisting}
+
+\subsection{VIRTIO ADMIN PCI VIRT PROPERTY SET command}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VIRT PROPERTY SET command}
+
+The VIRTIO_ADMIN_PCI_VIRT_PROPERTY_SET command is used to modify the values of VF properties.
+The command specific data set by the driver is of form:
+\begin{lstlisting}
+virtio_admin_pci_virt_property_set_data {
+        /* The virtual function number */
+        le16 vf_number;
+        /* For compatibility - indicates which of the below properties should be
+         * modified (1 means that field should be modified):
+         * Bit 0x0 - msix_count
+         * Bits 0x1 - 0x3F - reserved for future fields
+         */
+        le64 property_mask;
+        /* The amount of MSI-X vectors */
+        le16 msix_count;
+};
+\end{lstlisting}
+
+\begin{note}
+{vf_number can't be greater than NumVFs value as defined in the PCI specification
+or smaller than 1. An error status will be returned otherwise.}
+\end{note}
+
+This command has no command specific result set by the device. Upon success, the device guarantees
+that all the requested properties were modified to the given values. Otherwise, error will be returned.
+
+\begin{note}
+{Before setting msix_count property the virtual/managed device (VF) shall be un-initialized and may not be used by the driver.}
+\end{note}
+
+\subsection{VIRTIO ADMIN PCI VIRT PROPERTY GET command}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VIRT PROPERTY GET command}
+
+The VIRTIO_ADMIN_PCI_VIRT_PROPERTY_GET command is used to obtain the values of VF properties.
+The command specific data set by the driver is of form:
+\begin{lstlisting}
+virtio_admin_pci_virt_property_get_data {
+        /* The virtual function number */
+        le16 vf_number;
+        /* For compatibility - indicates which of the below properties should be
+         * queried (1 means that field should be queried):
+         * Bit 0x0 - msix_count
+         * Bits 0x1 - 0x3F - reserved for future fields
+         */
+        le64 property_mask;
+        /* The amount of MSI-X vectors */
+        le16 msix_count;
+};
+\end{lstlisting}
+
+\begin{note}
+{vf_number can't be greater than NumVFs value as defined in the PCI specification
+or smaller than 1. An error status will be returned otherwise.}
+\end{note}
+
+This command, upon success, returns a data buffer that describes the properties that were requested
+and their values for the subject virtio VF device according to the given vf_number.
+This information is of form:
+\begin{lstlisting}
+struct virtio_admin_pci_virt_property_get_result {
+        /* For compatibility - indicates which of the below fields were returned
+         * (1 means that field was returned):
+         * Bit 0x0 - msix_count
+         * Bits 0x1 - 0x3F - reserved for future fields
+         */
+        le64 property_mask;
+        /* The amount of MSI-X vectors */
+        le16 msix_count;
+};
+\end{lstlisting}
diff --git a/content.tex b/content.tex
index e9c2383..64678f0 100644
--- a/content.tex
+++ b/content.tex
@@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 \begin{description}
 \item[0 to 23] Feature bits for the specific device type
 
-\item[24 to 43] Feature bits reserved for extensions to the queue and
+\item[24 to 45] Feature bits reserved for extensions to the queue and
   feature negotiation mechanisms
 
-\item[44 and above] Feature bits reserved for future extensions.
+\item[46 and above] Feature bits reserved for future extensions.
 \end{description}
 
 \begin{note}
@@ -6878,6 +6878,17 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   that all buffers are used by the admin virtqueue of the device in
   the same order in which they have been made available.
 
+  \item[VIRTIO_F_ADMIN_PCI_VIRT_MANAGER (44)] This feature indicates
+  that the device can manage PCI related capabilities for its managed PCI VF
+  devices and supports VIRTIO_ADMIN_PCI_VIRT_MGMT_ATTR_IDENTIFY,
+  VIRTIO_ADMIN_PCI_VIRT_PROPERTY_SET and VIRTIO_ADMIN_PCI_VIRT_PROPERTY_GET
+  admin commands. This feature can be supported only by PCI devices.
+
+  \item[VIRTIO_F_ADMIN_MSIX_MGMT (45)] This feature indicates
+  that the device supports management of the MSI-X vectors for its
+  managed PCI VF devices using VIRTIO_ADMIN_PCI_VIRT_PROPERTY_SET and
+  VIRTIO_ADMIN_PCI_VIRT_PROPERTY_GET admin commands.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
@@ -6920,6 +6931,14 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 A driver MAY accept VIRTIO_F_ADMIN_VQ_IN_ORDER only if it accepts
 VIRTIO_F_ADMIN_VQ.
 
+A driver MAY accept VIRTIO_F_ADMIN_PCI_VIRT_MANAGER only if it accepts
+VIRTIO_F_ADMIN_VQ.
+
+A driver MAY accept VIRTIO_F_ADMIN_MSIX_MGMT only if it accepts
+VIRTIO_F_ADMIN_VQ and VIRTIO_F_ADMIN_PCI_VIRT_MANAGER. Currently only
+MSI-X management of PCI virtual functions is supported, so the driver
+MUST NOT negotiate VIRTIO_F_ADMIN_MSIX_MGMT if VIRTIO_F_SR_IOV is not negotiated.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
 
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
@@ -6960,6 +6979,12 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 A device MAY offer VIRTIO_F_ADMIN_VQ_IN_ORDER only if it offers
 VIRTIO_F_ADMIN_VQ.
 
+A PCI device MAY offer VIRTIO_F_ADMIN_PCI_VIRT_MANAGER only if it
+offers VIRTIO_F_ADMIN_VQ.
+
+A PCI device MAY offer VIRTIO_F_ADMIN_MSIX_MGMT only if it
+offers VIRTIO_F_ADMIN_VQ, VIRTIO_F_ADMIN_PCI_VIRT_MANAGER and VIRTIO_F_SR_IOV.
+
 \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
 
 Transitional devices MAY offer the following:
-- 
2.21.0

