Return-Path: <mst@redhat.com>
Date: Fri, 12 Aug 2022 13:19:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 2/8] Introduce group administration commands
Message-ID: <20220812171841.12183-3-mst@redhat.com>
References: <20220812171841.12183-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220812171841.12183-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Max Gurtovoy <mgurtovoy@nvidia.com>

These commands are used for essential administrative and management
operations.

Following patches will introduce an interface for submitting these
commands to the device.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 5 deletions(-)

diff --git a/admin.tex b/admin.tex
index 6e9434a..4840dd4 100644
--- a/admin.tex
+++ b/admin.tex
@@ -9,8 +9,10 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
 \item[Parent device]
         or parent, the device controlling the group.
 \item[Member device]
-        a device within a group. Parent device itself may, or may
-	not be a member of the group.
+        a device within a group. Parent device itself is not
+	a member of the group. In the future it is envisoned that
+	new group types may be introduced where the parent
+	device is a member of the group.
 \item[Member identifier]
         each member has this indentifier, unique within the group
 	and used to address it through the parent device.
@@ -20,9 +22,10 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
 	and what kind of control does the parent have.
 \item[Group identifier]
 	each group has this identifier, unique within the parent device.
-	this specifies the group type and possibly selects the
-	group if multiple groups of the same type can be controlled by the same
-	parent device.
+	This specifies the group type. In the future it is
+	envisoned that new group types will be introduced where the group
+	identifier also selects the group if multiple groups of the same
+	type can be controlled by the same parent device.
 \end{description}
 
 A single group type is currently specified:
@@ -46,4 +49,90 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
 PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
 \end{description}
 
+\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Group administration commands}
+
+Group administration commands can be issued through a parent
+device to control member devices of a group.  This mechanism can
+be used, for example, to configure a member device before it is
+initialized by its driver.
+
+All the group administration commands are of the following form:
+
+\begin{lstlisting}
+struct virtio_admin_cmd {
+        /* Device-readable part */
+        le16 opcode;
+        /*
+         * 1 - SR-IOV
+         * 2 - 65535 reserved
+         */
+        le16 group_id;
+        /* unused, reserved for future extensions */
+        u8 reserved1[12];
+        le64 group_member_id;
+        u8 command_specific_data[];
+
+        /* Device-writable part */
+        u8 status;
+        u8 command_specific_error;
+        /* unused, reserved for future extensions */
+        u8 reserved2[6];
+        u8 command_specific_result[];
+};
+\end{lstlisting}
+
+For all commands, \field{opcode}, \field{group_id} and if
+necessary \field{group_member_id} and \field{command_specific_data} are
+set by the driver, and the parent device sets \field{status} and if
+needed \field{command_specific_error} and
+\field{command_specific_result}.
+
+As a rule, any unused device-readable fields are set to zero by the driver
+and ignored by the device.  Any unused device-writeable fields are set to zero
+by the device and ignored by the driver.
+
+\field{opcode} specifies the command. The valid
+values for \field{opcode} can be found in the following table:
+
+\begin{tabular}{|l|l|}
+\hline
+opcode & Command Description \\
+\hline \hline
+0000h - 7FFFh   & Group administration commands    \\
+\hline
+8000h - FFFFh   & Reserved    \\
+\hline
+\end{tabular}
+
+The \field{group_id} specifies the device group.
+The \field{group_member_id} specifies the member device within the group.
+See section \ref{sec:Introduction / Terminology / Device group}
+for the definition of the group identifier and group member
+identifier.
+
+The following table describes possible \field{status} values:
+
+\begin{tabular}{|l|l|l|}
+\hline
+Status & Name & Description \\
+\hline \hline
+00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
+\hline
+01h   & VIRTIO_ADMIN_STATUS_CS_ERR    & command specific error  \\
+\hline
+02h   & VIRTIO_ADMIN_STATUS_OPCODE_UNSUPPORTED    & unsupported or invalid \field{opcode}  \\
+\hline
+03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field within command specific data  \\
+\hline
+04h   & VIRTIO_ADMIN_STATUS_INVALID_GROUP    & invalid group identifier was set  \\
+\hline
+05h   & VIRTIO_ADMIN_STATUS_INVALID_MEM    & invalid group member identifier was set  \\
+\hline
+\end{tabular}
+
+The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
+VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the
+contents of \field{command_specific_error}
+holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
+\field{command_specific_error} value is undefined and should be ignored by the driver.
 
-- 
MST

